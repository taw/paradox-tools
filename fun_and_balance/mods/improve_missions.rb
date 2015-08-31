require_relative "base"

# This gives tag-specific missions alternative conditions
# and improves rewards for really awful missions (much less applicable since 1.12)

class ImproveMissionsGameModification < EU4GameModification
  def tag_requirements_for_mission(mission)
    allow = mission["allow"]
    return [allow["tag"]] if allow["tag"]
    [allow["tag"], allow["OR"] && allow["OR"].find_all("tag")].flatten.compact
  end

  def nation_tag?(key)
    # Horrible hack...
    key.is_a?(String) and key =~ /\A[A-Z]{3}\z/ and !%W[AND NOT MIL DIP ADM].include?(key)
  end

  def change_tag_references_to_root_references_in_node!(node, tags)
    tags_seen = Set[]
    node.map! do |key, val|
      if nation_tag?(key)
        if tags.include?(key)
          key = "ROOT"
        else
          tags_seen << key
        end
      end
      if nation_tag?(val)
        if tags.include?(val)
          val = "ROOT"
        else
          tags_seen << val
        end
      end

      if val.is_a?(PropertyList)
        tags_seen += change_tag_references_to_root_references_in_node!(val, tags)
        if key == "OR"
          val.uniq!
          key, val = *val.each.to_a[0] if val.size == 1
        end
      end

      [key, val]
    end
    tags_seen
  end

  def change_tag_references_to_root_references_in_allow_node!(node, tags)
    tags_seen = Set[]
    node.map! do |key, val|
      next [key, val] if key == "tag"

      if nation_tag?(key)
        if tags.include?(key)
          key = "ROOT"
        else
          tags_seen << key
        end
      end
      if nation_tag?(val)
        if tags.include?(val)
          val = "ROOT"
        else
          tags_seen << val
        end
      end

      if val.is_a?(PropertyList)
        if key == "OR"
          tags_seen += change_tag_references_to_root_references_in_allow_node!(val, tags)
          val.uniq!
          key, val = *val.each.to_a[0] if val.size == 1
        else
          tags_seen += change_tag_references_to_root_references_in_node!(val, tags)
        end
      end

      [key, val]
    end
    tags_seen
  end

  def change_tag_references_to_root_references!(mission, tags)
    tags_seen = Set[]
    mission.each do |key, node|
      next if key == "type" or key == "category" or key == "ai_mission"
      if %W[abort success chance immediate abort_effect effect target_provinces].include?(key)
        tags_seen += change_tag_references_to_root_references_in_node!(node, tags)
      elsif key == "allow"
        tags_seen += change_tag_references_to_root_references_in_allow_node!(node, tags)
      else
        require 'pry'; binding.pry
      end
    end
    tags_seen
  end

  # For some mission, ROOT is country getting it
  # For others, FROM is country getting it, ROOT is the target
  # We only really care about country getting it, so we simplify things here
  def mission_type(mission)
    case mission["type"]
    when /\A(neighbor|our|empty)_provinces\z/, /\A(threat|rival|neighbor|elector)_countries\z/, /\A(rivals|threats)_rivals\z/
      "FROM"
    when "country"
      "ROOT"
    else
      raise "Unknown mission type #{mission["type"]}"
    end
  end

  def make_mission_not_tag_specific!(mission, tags, *alt)
    type = mission_type(mission)
    raise "That's not going to work" unless type == "ROOT"

    tags_seen = change_tag_references_to_root_references!(mission, tags)
    alt += tags_seen.map{|seen| Property::NOT["tag", seen]}
    alt << Property::NOT["has_global_flag", "fun_and_balance_config.disable_extra_missions"]

    if alt.size == 1
      alt_cond = alt[0]
    else
      alt_cond = Property::AND[*alt]
    end

    if tags.size == 1
      not_orig_tags = Property::NOT["tag", tags[0]]
    else
      not_orig_tags = Property::AND[*tags.map{|t| Property::NOT["tag", t]}]
    end

    mission["allow"].map! do |key, val|
      if key == "tag" or (key == "OR" and val["tag"])
        ["OR", PropertyList[
          *tags.map{|t| Property["tag", t]},
          alt_cond,
        ]]
      else
        [key, val]
      end
    end

    # Lower chance if not original tag
    mission["chance"].add! "modifier", PropertyList["factor", 0.5, not_orig_tags]
  end

  def mission_rewards_totally_awful?(mission)
    good_rewards = %W[
      add_mil_power add_adm_power add_dip_power
      add_army_tradition add_navy_tradition
      add_base_tax add_province_manpower
      add_country_modifier
      add_stability
      add_inflation
      add_legitimacy
      add_years_of_income
      add_papal_influence
      add_mercantilism
      add_treasury
      every_owned_province
      add_ruler_modifier
    ]
    # The problem with add_legitimacy is that republics won't benefit from it at all, but it's useful for most countries
    # The problem with add_papal_influence is that it only matters for catholic countries
    type = mission_type(mission)
    immediate = mission["immediate"].to_h
    effect    = mission["effect"].to_h

    # Unlike CK2 this is just label, real deal is in hidden_effect
    effect.delete("custom_tooltip")
    effect.merge!(effect.delete("hidden_effect").to_h)

    # I'm extremely confused by this. Maybe missions have bugs here?
    # Is neighbor_countries scoped FROM or ROOT as I've seen both?
    effect.merge!(effect.delete("FROM").to_h)
    effect.merge!(effect.delete("ROOT").to_h)

    effect.merge!(effect.delete("owner").to_h) if mission["type"] == "our_provinces"
    effect.delete("if").each do |cond|
      effect.merge!(cond.to_h)
    end if effect["if"]
    effect.delete("limit")
    # Getting points of good kind
    return false if !(effect.keys & good_rewards).empty?
    # Getting free CBs
    return false if immediate["add_claim"] or immediate.values.map(&:to_h).inject({}, &:merge)["add_claim"]
    # These are used mostly to ensure mission can't be taken too many times in a row
    effect.delete("set_country_flag")
    # This is legitimately awful
    return true if immediate.empty? and effect.keys == ["add_prestige"]
    return true if immediate.empty? and effect.keys == ["define_advisor"]
    # Check manually
    require 'pry'; binding.pry
  end

  # Vanilla made rewards less shitty in 1.12, at least that's what they say
  def fix_mission_rewards!(name, mission)
    case name
    when "view_the_hanami"
      # Daimyo only mission
      mission["effect"]["add_legitimacy"] = 10
    when "improve_reputation_mission"
      mission["effect"]["add_stability"] = 1
      mission["effect"]["add_legitimacy"] = 10
      mission["effect"]["add_republican_tradition"] = 0.1
    when "get_minor_cash_reserve"
      mission["effect"]["add_adm_power"] = 10
    when "recover_negative_stability"
      mission["effect"]["add_prestige"] = 10
      mission["effect"]["add_legitimacy"] = 10
      mission["effect"]["add_republican_tradition"] = 0.1
    when "defeat_rebels_mission"
      mission["effect"]["add_prestige"] = 10
      mission["effect"]["add_legitimacy"] = 10
      mission["effect"]["add_republican_tradition"] = 0.1
    else
      require 'pry'; binding.pry
    end
  end

  def apply!
    patch_mod_files!("missions/*.txt") do |node|
      node.each do |name, mission|
        allow = mission["allow"]
        tags = tag_requirements_for_mission(mission)

        case tags
        when ["VEN"]
          make_mission_not_tag_specific!(mission, tags, Property["owns_core_province", 112])
        when ["GEN"]
          # Most of them require you to be merchant republic as well
          make_mission_not_tag_specific!(mission, tags, Property["owns_core_province", 101])
        when ["USA"]
          next if name == "defend_the_american_colonies" # alt condition is impossible with this prereq
          make_mission_not_tag_specific!(mission, tags, Property["the_thirteen_colonies", PropertyList["type", "all", "owned_by", "ROOT"]])
        when ["BYZ"]
          # Pretty much all these missions make sense only as Byzantine missions, form Byzantium if you want them
          # However, we allow them if you're HLR and own Rome and Constantinople!
          make_mission_not_tag_specific!(mission, tags, Property["owns_core_province", 118], Property["owns_core_province", 151], Property["tag", "HLR"])
        when ["ARA"]
          next if name == "become_king_of_gonder" or name == "defeat_saruhan" # joke missions should stay a joke
          # Barcelona and Valencia
          make_mission_not_tag_specific!(mission, tags, Property["owns_core_province", 213], Property["owns_core_province", 220])
        when ["LIT"]
          make_mission_not_tag_specific!(mission, tags, Property["owns_core_province", 272])
        when ["KOR"]
          make_mission_not_tag_specific!(mission, tags, Property["owns_core_province", 735])
        when ["BOH"]
          make_mission_not_tag_specific!(mission, tags, Property["owns_core_province", 266])
        when ["BAV"]
          make_mission_not_tag_specific!(mission, tags, Property["owns_core_province", 65])
        when ["HAB"]
          make_mission_not_tag_specific!(mission, tags, Property["owns_core_province", 134])
        when ["POL"], ["POL", "PLC"]
          # Krakow and Warsaw
          make_mission_not_tag_specific!(mission, tags, Property["owns_core_province", 262], Property["owns_core_province", 257])
        when ["PAP"]
          # It is impossible if you have academy elsewhere
          next if name == "academy_in_rome"
          make_mission_not_tag_specific!(mission, tags, Property["owns_core_province", 118], Property["religion", "catholic"], Property["is_papal_controller", true])
        when ["SCO"]
          make_mission_not_tag_specific!(mission, tags, Property["owns_core_province", 248])
        when ["NED"]
          make_mission_not_tag_specific!(mission, tags, Property["owns_core_province", 97])
        when ["SWE"]
          make_mission_not_tag_specific!(mission, tags, Property["owns_core_province", 1])
        when ["DAN"]
          make_mission_not_tag_specific!(mission, tags, Property["owns_core_province", 12])
        when ["POR"]
          make_mission_not_tag_specific!(mission, tags, Property["owns_core_province", 227])
        when ["HSA"]
          if name == "end_sound_toll"
            # You have to be merchant republic for this as well
            make_mission_not_tag_specific!(mission, tags, Property["owns_core_province", 45], Property::NOT["tag", "DAN"])
          else
            warn "Unknown HSA mission"
          end
        when ["HUN"]
          # Pressburg and Buda
          make_mission_not_tag_specific!(mission, tags, Property["owns_core_province", 153], Property["owns_core_province", 154])
        when ["TUR", "AYD", "CND", "DUL", "KAR", "SRU", "MEN", "RAM", "ERE", "GRM"]
          if name == "muslim_asia_minor"
            make_mission_not_tag_specific!(mission, tags, Property["owns_core_province", 149], Property["owns_core_province", 151], Property["num_of_cities", 20], Property["religion_group", "muslim"])
          end
        when ["TUR", "AYD", "MEN"]
          # Defeat the Knights
          # OK
        when ["TUR"]
          # Edirne and Constantinople and 20 cities as these are very geographically ambitious goals
          make_mission_not_tag_specific!(mission, tags, Property["owns_core_province", 149], Property["owns_core_province", 151], Property["num_of_cities", 20])
        when ["ENG", "GBR"]
          make_mission_not_tag_specific!(mission, tags, Property["owns_core_province", 236], Property["num_of_cities", 20])
        when ["ENG"]
          # All missions here are specific to Hundred Years War, everything that's geographically meaningful is tagged ENG or GBR, not ENG only
          # OK
        when ["CAS", "SPA"], ["SPA"]
          # Valladolid, Castilla La Vieja, Madrid, and Toledo are all historical capitals
          # Is Castile excluded from SPA-only missions on purpose, or just out of silliness?
          make_mission_not_tag_specific!(mission, tags, Property["owns_core_province", 214], Property["owns_core_province", 215], Property["owns_core_province", 217], Property["owns_core_province", 219], Property["num_of_cities", 20])
        when ["FRA", "RFR"], ["FRA"]
          make_mission_not_tag_specific!(mission, tags, Property["owns_core_province", 183], Property["num_of_cities", 20])
        when ["MOS", "RUS"], ["RUS"]
          # Moskva and Novgorod
          make_mission_not_tag_specific!(mission, tags, Property["owns_core_province", 295], Property["owns_core_province", 310],  Property["num_of_cities", 20])
        when ["JAP"]
          make_mission_not_tag_specific!(mission, tags, Property["owns_core_province", 1020], Property["num_of_cities", 20], Property::NOT["exists", "JAP"])
        when ["BUR"]
          # This definition is not specific enough, as France can easily trigger it, but missions Burgundy gets (conquer / vassalize various HRE minors)
          # make sense for France as well, so it's fine
          make_mission_not_tag_specific!(mission, tags, Property["owns_core_province", 192], Property["owns_core_province", 193], Property["num_of_cities", 20], Property::NOT["exists", "BUR"])
        when ["MNG", "MCH"]
          raise "Unknown Ming/Manchu missions" unless name == "colonize_taiwan" or name == "colonize_deren"
          # This makes sense only for these missions, not in general
          make_mission_not_tag_specific!(mission, tags, Property["chinese_coast", PropertyList["owned_by", "root"]])
        when ["MNG"], ["MNG", "QNG"]
          if name == "china_discovers_india"
            make_mission_not_tag_specific!(mission, tags, Property["chinese_coast", PropertyList["owned_by", "root"]])
          else
            # This is a huge region, unlikely to trigger ever
            make_mission_not_tag_specific!(mission, tags, Property["chinese_region", PropertyList["type", "all", "owned_by", "ROOT"]])
          end
        when ["MCH"]
          # This includes 2 originally uncolonized provinces, so it's maybe not super useful
          make_mission_not_tag_specific!(mission, tags, Property["manchuria", PropertyList["type", "all", "owned_by", "ROOT"]])
        when ["TIM"], ["MUG"], ["TIM", "MUG"]
          # Samarkand and Kabul
          # Punjab
          # Kabul and Delhi
          make_mission_not_tag_specific!(mission, tags, Property["owns_core_province", 454], Property["owns_core_province", 451], Property["owns_core_province", 522], Property["num_of_cities", 30], Property::NOT["exists", "TIM"], Property::NOT["exists", "MUG"])
        when ["BRA"]
          next if name == "brandenburg_breaks_free_from_poland" # Far too specific for one scenario
          raise "Unknown Brandenburg mission" unless name == "annex_prussia" or name == "vassalize_prussia" or name == "brandenburg_prussia_relations" or name == "connect_brandenburg_and_prussia"
          # Berlin
          make_mission_not_tag_specific!(mission, tags, Property["owns_core_province", 50], Property::NOT["exists", "BRA"])
        when ["PRU"]
          next if name == "prussia_breaks_free_from_poland" # Far too specific for one scenario
          if name == "subjugate_westphalia" or name == "prussia_partitions_poland"
            # Berlin, Konigsberg
            make_mission_not_tag_specific!(mission, tags, Property["owns_core_province", 50], Property["owns_core_province", 41], Property::NOT["exists", "PRU"], Property::NOT["exists", "BRA"])
          elsif name == "prussia_brandenburg_relations" or name == "conquer_warmia_pru"
            # Konigsberg
            make_mission_not_tag_specific!(mission, tags, Property["owns_core_province", 41], Property::NOT["exists", "PRU"])
          else
            raise "Unknown Prussia mission"
          end
        when ["PRU", "BRA"], ["BRA", "PRU"]
          # Berlin
          raise "Unknown Prussia/Brandenburg mission" unless name == "conquer_ratibor" or name == "conquer_silesia" or name == "conquer_hinterpommern" or name == "conquer_swedish_pomerania"
          make_mission_not_tag_specific!(mission, tags, Property["owns_core_province", 50], Property::NOT["exists", "PRU"], Property::NOT["exists", "BRA"])
        when ["GUJ"], ["VIJ"], ["CSU"]
          # TODO
        when []
          # fortify_the_eastern_border is Sweden-specific, but it's not a big deal it's out of the set
          if mission_rewards_totally_awful?(mission)
            fix_mission_rewards!(name, mission)
          end
        when ["MJZ", "MHX", "MYR"]
          # Unite Manchu, fine to just let Manchu tribes do it
        # Shattered Europe Scenario - we don't want to change these
        when  ["GRA", "ALU", "BDJ"], ["GRA", "ALU", "SEV"], ["GRA", "ALU", "BDJ", "SEV"], ["ALU"]
          # OK
        else
          p [name, tags, change_tag_references_to_root_references!(mission, "XXXXXX").to_a]
          puts name, mission, ""
        end
      end
    end
  end
end

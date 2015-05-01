module FunAndBalanceCommon
  def modify_node!(node, *modifications)
    modifications.each do |*path, expected, modified|
      actual = path.inject(node){|n,p| n ? n[p] : nil}
      raise "Node[#{path.join('/')}] expected `#{expected}', got `#{actual}'" unless actual == expected
      path[0..-2].inject(node){|n,p| n[p]}[path[-1]] = modified
    end
  end

  def eu3_style_elections!(node)
    node.delete("change_adm")
    node.delete("change_dip")
    node.delete("change_mil")
    node["add_scaled_republican_tradition"] *= 0.3 if node["add_scaled_republican_tradition"]
    node["define_ruler"].delete("fixed") if node["define_ruler"]
    eu3_style_elections! node["FROM"] if node["FROM"]
    eu3_style_elections! node["tooltip"] if node["tooltip"]
  end

  def change_elections_to_eu3_style!
    patch_mod_file!("events/Elections.txt") do |node|
      node.find_all("country_event").each do |event|
        event.find_all("option").each do |option|
          eu3_option = option.deep_copy
          eu3_style_elections!(eu3_option)

          next if option == eu3_option

          eu3_option.add! "trigger", PropertyList[Property::NOT["has_global_flag", "fun_and_balance_config.disable_eu3_style_elections"]]
          event.add! "option", eu3_option

          option.add! "trigger", PropertyList["has_global_flag", "fun_and_balance_config.disable_eu3_style_elections"]
        end
      end
    end
  end

  def province_id(province_name)
    matches = @game.glob("history/provinces/*.txt").select{|n|
      n.basename(".txt").to_s.sub(/\A\d+[ -]*/, "").downcase == province_name.downcase
    }
    raise "No match for #{province_name}" unless matches.size == 1
    matches[0].basename.to_s.to_i
  end

  def no_naval_attrition!
    patch_mod_file!("common/technologies/dip.txt") do |node|
      node.find_all("technology").each_with_index do |tech,i|
        if i == 0
          tech["reduced_naval_attrition"] = true
        else
          tech.delete("reduced_naval_attrition")
        end
      end
    end
  end

  def smooth_oe_scaling!
    patch_mod_file!("events/PurelyNasty.txt") do |node|
      node.find_all("province_event").each do |event|
        mtth = event["mean_time_to_happen"]
        mtth["months"] *= 4
        mtth.add! "modifier", PropertyList["factor", 0.5, "owner", PropertyList["overextension_percentage", 3.0]]
        mtth.add! "modifier", PropertyList["factor", 0.5, "owner", PropertyList["overextension_percentage", 4.0]]
        mtth.add! "modifier", PropertyList["factor", 0.5, "owner", PropertyList["overextension_percentage", 5.0]]
      end
    end
  end

  def double_diplo_rel_limit_from_ideas!
    patch_mod_files!("common/ideas/*.txt") do |node|
      node.each do |group_name, idea_group|
        idea_group.each do |name, idea|
          next if %W[category trigger ai_will_do important free].include?(name)
          next if idea == [] # Empty idea
          if idea["diplomatic_upkeep"] == 1
            idea["diplomatic_upkeep"] = 2
          end
        end
      end
    end
  end

  def dont_destroy_buildings_on_conquest!
    patch_mod_files!("common/buildings/*.txt") do |node|
      node.each_value do |building|
        if building["spare_on_core"] == true
          building.delete "spare_on_core"
          building["destroy_on_conquest"] = false
        end
      end
    end
  end

  def reduce_religious_center_penalty!
    patch_mod_file!("common/event_modifiers/00_event_modifiers.txt") do |node|
      unless node["religious_center"]["local_missionary_strength"] == -0.05
        raise "Expected important missionary center to have -5% missionary strength"
      end
      node["religious_center"]["local_missionary_strength"] = -0.02
    end
  end

  def disable_burgundy_inheritance!
    patch_mod_file!("events/FlavorBUR.txt") do |node|
      node.each do |key, val|
        # Events: flavor_bur.(3|4|5|6|19)
        # are part of the chain but trigger from other events within it so they don't need the fix
        next unless key == "country_event" and val["id"] =~ /\Aflavor_bur\.(1|2|7)\z/
        val["trigger"].add! Property["has_global_flag", "fun_and_balance_config.enable_burgundian_succession_crisis"]
      end
    end
  end

  def move_burgundy_capital_to_hre!
    patch_mod_file!("history/countries/BUR - Burgundy.txt") do |node|
      node["capital"] = 193
    end
  end

  def fix_opinions!
    patch_mod_file!("common/opinion_modifiers/00_opinion_modifiers.txt") do |node|
      modify_node! node,
        ["opinion_annex_vassal", "min", nil, -100],
        ["broke_march", "opinion", -200, -100],
        ["broke_march", "years", nil, 10]
    end
  end

  def fix_wargoals!
    patch_mod_file!("common/wargoal_types/00_wargoal_types.txt") do |node|
      modify_node! node,
        ["take_province_ban", "badboy_factor", 1.0, 0.1]
    end
  end

  def site_information(site)
    province, name, id = site.split(/\s*\/\s*/)
    id ||= province_id(province)
    short_name = name || province
    name = name ? "#{name} (#{province})" : "#{province}"
    {province: province, name: name, short_name: short_name, id: id}
  end

  def add_holy_site!(religion, site, n)
    trigger_name = "holy_sites_#{religion}_#{n}"
    localization! "holy_sites",
      trigger_name => "#{site[:short_name]} is #{@game.localization(religion)}",
      "desc_#{trigger_name}" => "#{religion.to_s.capitalize} rulers control holy site #{site[:name]}"
    Property[
      trigger_name, PropertyList[
        "potential", PropertyList[
          "religion", religion,
          Property::NOT["has_global_flag", "fun_and_balance_config.disable_holy_sites"],
        ],
        "trigger", PropertyList[site[:id], PropertyList["owner", PropertyList["religion", religion]]],
        "global_missionary_strength", 0.002,
      ]
    ]
  end

  def add_holy_sites_all!(religion, sites)
    # For sake of balance keep it at 0 or 5
    raise "Expected 0 or 5 sites, not #{sites.size}" unless sites.size == 5
    trigger_name = "holy_sites_#{religion}"
    localization! "holy_sites",
      trigger_name           => "All #{@game.localization(religion)} holy sites",
      "desc_#{trigger_name}" => "#{@game.localization(religion)} controls all its holy sites #{ sites.map{|x| x[:name]}.join(", ") }."
    Property[trigger_name, PropertyList[
      "potential", PropertyList[
        "religion", religion,
        Property::NOT["has_global_flag", "fun_and_balance_config.disable_holy_sites"],
      ],
      "trigger", PropertyList[
        *sites.map{|site| Property[site[:id], PropertyList["owner", PropertyList["religion", religion]]] }
      ],
      "global_missionary_strength", 0.010,
      "prestige", 1,
    ]]
  end

  def add_holy_site_mission!(religion, site, n)
    id = site[:id]
    mission_name = "conquest_#{religion}_holy_site_#{n}"
    localization! "holy_sites",
      "#{mission_name}_title" => "Conquer Holy Site #{site[:short_name]}",
      "#{mission_name}_desc" => "We must not allow infidels to hold our holy site #{site[:name]}!"
    Property[mission_name, PropertyList[
      "type", "country",
      "category", "MIL",
      "ai_mission", true,
      "allow", PropertyList[
        "religion", religion,
        Property::NOT["has_global_flag", "fun_and_balance_config.disable_holy_sites"],
        Property::OR[
          id, PropertyList["owner", PropertyList["is_neighbor_of", "ROOT"]],
          "has_idea", "deus_vult",
        ],
        "is_subject", false,
        id, PropertyList[
          "owner", PropertyList[Property::NOT["religion", religion]],
          "has_discovered", "ROOT",
        ],
      ],
      "success", PropertyList[
        id, PropertyList["owned_by", "ROOT"],
      ],
      "abort", PropertyList[
        Property::OR[
          "is_subject", true,
          id, PropertyList["owner" , PropertyList["religion", religion]],
          Property::NOT["religion", religion],
        ]
      ],
      "immediate", PropertyList["add_claim", id],
      "abort_effect", PropertyList["remove_claim", id],
      "chance", PropertyList[
        "factor", 1000,
        "modifier", PropertyList["factor", 2, "is_neighbor_of", "ROOT"],
        "modifier", PropertyList["factor", 2, "has_idea", "deus_vult"]
      ],
      "effect", PropertyList["add_adm_power", 200, "add_prestige", 40],
    ]]
  end

  def feature_holy_sites!
    missions = []
    triggers = []
    holy_sites_by_religion.each do |religion, sites|
      next if sites.empty?
      sites = sites.map{|s| site_information(s)}
      sites.each_with_index do |s,i|
        triggers << add_holy_site!(religion, s, i+1)
        missions << add_holy_site_mission!(religion, s, i+1)
      end
      triggers << add_holy_sites_all!(religion, sites)
    end

    create_mod_file! "common/triggered_modifiers/holy_sites.txt", PropertyList[*triggers]
    create_mod_file! "missions/Holy_Sites_Missions.txt", PropertyList[*missions]
  end

  def each_country_primary_culture
    @game.glob("common/cultures/*.txt").each do |path|
      @game.parse(path).each do |group_name, group|
        group = group.to_h
        group.delete "graphical_culture"
        group.delete "dynasty_names"
        group.each do |culture_name, details|
          next if details.is_a?(Array)
          details = details.to_h
          next unless details["primary"]
          yield culture_name, details["primary"]
        end
      end
    end
  end

  def feature_extra_formable_countries!
    already_formable = %W[
      ALG ARB BRZ BUK BYZ CAM CAN CHL COL EGY ENG FRA GBR GER GRE HAB HAN
      HAT HIN HLR INC IRE ITA JAP KOJ KUR LAP LOU MCH MEX MOR MSA MUG NED
      PER PEU PLC PRG PRU QNG QUE RMN RUS SCA SPA SPI TIB TRP TUN UKR USA
      VNZ WES
      AUS CRO MAY POL SOK SST
    ]
    cant_by_formed_by = %W[HLR PAP HIN MUG SPA FRA GER BYZ BUK ITA RUS SCA PER GBR PLC EGY VIJ]

    decisions = []
    each_country_primary_culture do |culture, tag|
      next if already_formable.include?(tag)
      next if tag == "MOS" # Form Russia instead

      decisions << "country_decisions"
      decisions << PropertyList[
        "extra_formable_form_#{tag}", PropertyList[
          "major", true,
          "potential", PropertyList[
            Property::NOT["has_global_flag", "fun_and_balance_config.disable_extra_formable_countries"],
            Property::NOT["exists", tag],
            *cant_by_formed_by.map{|ct| Property::NOT["tag", ct] },
            "primary_culture", culture,
          ],
          "allow", PropertyList[
            "adm_tech", 10,
            "num_of_cities", 3,
            "is_subject", false,
            "is_at_war", false,
            "is_tribal", false,
            Property::NOT["any_province", PropertyList[
              "culture", culture,
              Property::NOT["owned_by", "ROOT"],
              Property::NOT["is_core", "ROOT"],
            ]],
          ],
          "effect", PropertyList[
            "change_tag", tag,
            "add_country_modifier", PropertyList[
              "name", "centralization_modifier",
              "duration", 7300,
            ],
            "add_prestige", 25,
            "swap_free_idea_group", true,
          ],
          "ai_will_do", PropertyList["factor", 1],
        ],
      ]

      loc_tag = @game.localization(tag)
      loc_culture = @game.localization(culture)
      localization! "extra_formable_countries",
        "extra_formable_form_#{tag}_title" => "Form #{loc_tag}",
        "extra_formable_form_#{tag}_desc"  => "Our country is one true home of #{loc_culture} people, let's call it #{loc_tag}!"
    end
    create_mod_file! "decisions/extra_formable_countries.txt", PropertyList[
      *decisions
    ]
  end

  def always_display_policies!
    patch_mod_files!("common/policies/*.txt") do |node|
      node.each_value do |policy|
        policy["potential"].delete("has_idea_group")
      end
    end
  end

  def reverse_horde_nerfs!
    patch_mod_file!("decisions/MughalNation.txt") do |node|
      node["country_decisions"]["mughal_nation"]["allow"].delete("is_tribal")
      node["country_decisions"]["mughal_nation"]["effect"]["if"]["change_government"] = "despotic_monarchy"
    end

    patch_mod_file!("decisions/PersianNation.txt") do |node|
      node["country_decisions"]["persian_nation"]["allow"].delete("is_tribal")
      node["country_decisions"]["persian_nation"]["effect"]["if"]["change_government"] = "despotic_monarchy"
    end

    patch_mod_file!("decisions/ManchuDecisions.txt") do |node|
      node["country_decisions"]["form_manchu_dynasty"]["allow"].delete("is_tribal")
      node["country_decisions"]["form_manchu_dynasty"]["effect"].add! "if", PropertyList[
        "limit", PropertyList["technology_group", "nomad_group"],
        "change_technology_group",  "chinese",
        "change_unit_type", "chinese",
      ]
      node["country_decisions"]["form_manchu_dynasty"]["effect"].add! "if", PropertyList[
        "limit", PropertyList["government", "steppe_horde"],
        "change_government", "despotic_monarchy",
      ]
    end

    patch_mod_file!("decisions/Tribal.txt") do |node|
      node["country_decisions"].each_value do |decision|
        decision["allow"]["stability"] = 2
        decision["allow"].add! Property::OR["stability", 3, "adm_tech", 8]
        decision["allow"].delete_if do |*kv|
          kv == ["OR", PropertyList["full_idea_group", "economic_ideas", "full_idea_group", "innovativeness_ideas", "full_idea_group", "administrative_ideas"]]
        end
        decision["potential"].delete_if do |*kv|
          kv == ["OR", PropertyList["ai", false, "full_idea_group", "economic_ideas", "full_idea_group", "innovativeness_ideas", "full_idea_group", "administrative_ideas"]]
        end
      end
    end

    patch_mod_file!("common/governments/00_governments.txt") do |node|
      node["steppe_horde"]["global_manpower_modifier"] = 0.75
      node["steppe_horde"]["land_forcelimit_modifier"] = 0.75
      node["steppe_horde"]["land_maintenance_modifier"] = -0.4
    end
  end

  def anyone_can_form_byzantium!
    patch_mod_file!("decisions/RestoreByzantineEmpire.txt") do |node|
      node["country_decisions"]["restore_byzantine_empire"]["potential"].delete_if do |k,v|
        k == "NOT" and (v == PropertyList["tag", "HLR"] or v == PropertyList["tag", "TUR"])
      end
    end
  end

  def patch_religion!
    patch_mod_file!("common/religions/00_religion.txt") do |node|
      node.each do |group_name, group|
        group.each do |name, religion|
          next if ["crusade_name", "defender_of_faith", "can_form_personal_unions", "center_of_religion", "flags_with_emblem_percentage", "flag_emblem_index_range"].include?(name)
          if group_name == "pagan"
            religion["province"]["local_missionary_strength"] = 0.03
          else
            religion["province"].delete("local_missionary_strength") if religion["province"]
          end
        end
      end

    localization! "religious_shift",
      "religious_shift_title" => "Accept Religious Shift",
      "religious_shift_desc"  => "Religious beliefs of the ruling elite are shifting, as our $COUNTRY_RELIGION$ heritage is gradually losing ground to the religion of $CAPITAL$."
    end

    create_mod_file! "decisions/ReligiousShift.txt", PropertyList[
      "country_decisions", PropertyList[
        "religious_shift", PropertyList[
          "potential", PropertyList[
            "capital_scope", PropertyList[
              "NOT", PropertyList["religion", "ROOT"],
            ],
            "NOT", PropertyList["tag", "PAP"],
          ],
          "allow", PropertyList[
            "stability", 1,
            "is_at_war", false,
            "is_subject", false,
          ],
          "effect", PropertyList[
            "change_religion", "capital",
            "add_stability", -2,
            "add_country_modifier", PropertyList["name", "conversion_zeal", "duration", 3650],
          ],
          "ai_will_do", PropertyList["factor", 0],
        ]
      ]
    ]

    # Because Orthodox Ottomans are a thing now
    patch_mod_file!("decisions/Ottoman.txt") do |node|
      constantinople_decision = node["country_decisions"]["make_constantinople_capital"]
      constantinople_decision["allow"].delete("primary_culture")
      constantinople_decision["allow"].delete("religion")
      constantinople_decision["effect"][151]["change_culture"] = "ROOT"
      constantinople_decision["effect"][151]["change_religion"] = "ROOT"
    end
  end

  def holy_sites_by_religion
    {
      catholic:     ["Roma", "Jerusalem", "Thrace / Constantinople", "Galicia / Santiago de Compostela", "Kent / Cantenbury"],
      protestant:   ["Roma", "Jerusalem", "Thrace / Constantinople", "Galicia / Santiago de Compostela", "Kent / Cantenbury"],
      reformed:     ["Roma", "Jerusalem", "Thrace / Constantinople", "Galicia / Santiago de Compostela", "Kent / Cantenbury"],
      orthodox:     ["Roma", "Jerusalem", "Thrace / Constantinople", "Macedonia / Mount Athos", "Kiev"],
      coptic:       ["Roma", "Jerusalem", "Thrace / Constantinople", "Alexandria", "Tigre / Ark of the Covenant"],

      sunni:        ["Mecca", "Jerusalem", "Thrace / Constantinople", "Cordoba", "Hillah / Karbala"],
      shiite:       ["Mecca", "Jerusalem", "Thrace / Constantinople", "Cordoba", "Hillah / Karbala"],
      ibadi:        ["Mecca", "Jerusalem", "Thrace / Constantinople", "Cordoba", "Hillah / Karbala"],

      # Varanasi, Chidambaram, Angkor Wat - Hindu
      # Palitana - Jain
      # Harmandir Sahib - Sikh
      hinduism:     ["Jaunpur / Varanasi", "Coromandel / Chidambaram", "Baroda / Palitana", "Angkor / Angkor Wat", "Lahore / Harmandir Sahib"],
      sikhism:      ["Jaunpur / Varanasi", "Coromandel / Chidambaram", "Baroda / Palitana", "Angkor / Angkor Wat", "Lahore / Harmandir Sahib"],

      # TODO:
      buddhism:     ["Bihar / Bodhgaya / 558", "Angkor / Angkor Wat", "Qingzhou / Qufu", "Owari / Ise Jingu", "West Gyeongsang / Bulguksa"],
      confucianism: ["Bihar / Bodhgaya / 558", "Angkor / Angkor Wat", "Qingzhou / Qufu", "Owari / Ise Jingu", "West Gyeongsang / Bulguksa"],
      shinto:       ["Bihar / Bodhgaya / 558", "Angkor / Angkor Wat", "Qingzhou / Qufu", "Owari / Ise Jingu", "West Gyeongsang / Bulguksa"],

      # Adapted from CK2
      norse_pagan_reformed:   ["Zeeland", "Hannover / Paderborn / 1758", "Sjaelland", "Trondelag", "Uppland / Uppsala"],
      jewish:                 ["Jerusalem", "Sinai", "Damascus", "Hamadan", "Dhofar / Salahah"],


      # Not getting any ever, these are generic groupings not real religions
      shamanism:    [],
      animism:      [],
      totemism:     [],

      # Maybe someday
      inti:                  [],
      nahuatl:               [],
      mesoamerican_religion: [],
    }
  end

  def feature_partial_westernization!
    localization! "partial_westernization",
      "partial_westernization_title" => "Reform The Government",
      "partial_westernization_desc"  => "Reform the government as much along Western lines as you currently can."
    create_mod_file! "decisions/PartialWesternization.txt", PropertyList[
      "country_decisions", PropertyList[
        "partial_westernization", PropertyList[
          "major", true,
          "potential", PropertyList[
            Property::NOT["has_global_flag", "fun_and_balance_config.disable_partial_westernization"],
            Property::OR[
              "technology_group", "south_american",
              "technology_group", "mesoamerican",
              "technology_group", "north_american",
              "technology_group", "sub_saharan",
              "technology_group", "chinese",
              "technology_group", "indian",
            ],
            "is_subject", false,
          ],
          "allow", PropertyList[
            "stability", 2,
            Property::OR[
              "stability", 3,
              "adm_tech", 8,
            ],
            "is_at_war", false,
            Property::NOT["num_of_revolts", 1],
            "adm_power", 250,
            "dip_power", 250,
            "mil_power", 250,
            "any_neighbor_country", PropertyList[
              Property::OR[
                "technology_group", "muslim",
                "technology_group", "eastern",
                "technology_group", "ottoman",
                "technology_group", "western",
              ],
            ],
          ],
          "effect", PropertyList[
            "change_technology_group", "muslim",
            "add_stability", -5,
            "add_adm_power", -250,
            "add_dip_power", -250,
            "add_mil_power", -250,
            "add_country_modifier", PropertyList[
              "name", "western_influences",
              "duration", 3650,
            ],
          ],
          "ai_will_do", PropertyList["factor", 1],
        ]
      ]
    ]
  end

  ### Missions feature ###
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
    ]
    # The problem with add_legitimacy is that republics won't benefit from it at all, but it's useful for most countries
    # The problem with add_papal_influence is that it only matters for catholic countries
    type = mission_type(mission)
    immediate = mission["immediate"].to_h
    effect    = mission["effect"].to_h
    # I'm extremely confused by this. Maybe missions have bugs here?
    # Is neighbor_countries scoped FROM or ROOT as I've seen both?
    effect.merge!(effect.delete("FROM").to_h)
    effect.merge!(effect.delete("ROOT").to_h)
    effect.merge!(effect.delete("owner").to_h) if mission["type"] == "our_provinces"
    # Getting points of good kind
    return false if !(effect.keys & good_rewards).empty?
    # Getting free CBs
    return false if immediate["add_claim"] or immediate.values.map(&:to_h).inject({}, &:merge)["add_claim"]
    # This is legitimately awful
    return true if immediate.empty? and effect.keys == ["add_prestige"]
    return true if immediate.empty? and effect.keys == ["define_advisor"]
    # Check manually
    require 'pry'; binding.pry
  end

  def fix_mission_rewards!(name, mission)
    case name
    when "make_base_on_spice_islands"
      mission["effect"]["add_country_modifier"] = PropertyList["name", "colonial_enthusiasm", "duration", 1875]
    when "conquer_core"
      mission["effect"]["FROM"]["add_prestige"] = 20
      mission["effect"]["FROM"]["add_legitimacy"] = 10
      mission["effect"]["FROM"]["add_republican_tradition"] = 0.1
    when "keep_rival_out_of_italy"
      mission["effect"]["FROM"]["add_prestige"] = 10
      mission["effect"]["FROM"]["add_mil_power"] = 25
    when "attack_prestigous_rival"
      mission["effect"]["FROM"]["add_prestige"] = 10
      mission["effect"]["FROM"]["add_mil_power"] = 25
    when "attack_weaker_rival"
      mission["effect"]["FROM"]["add_mil_power"] = 25
    when "italian_ambition"
      mission["effect"]["add_adm_power"] = 25
    when "build_refinery", "build_wharf"
      mission["effect"]["owner"]["add_dip_power"] = 25
      mission["effect"]["add_base_tax"] = 1
    when "build_weapons"
      mission["effect"]["owner"]["add_mil_power"] = 25
      mission["effect"]["add_province_manpower"] = 1
    when "build_textile"
      mission["effect"]["owner"]["add_adm_power"] = 25
      mission["effect"]["add_base_tax"] = 1
    when "build_fine_arts_academy"
      mission["effect"]["owner"]["add_base_tax"] = 1
      mission["effect"]["add_stability"] = 1
    when "build_university"
      mission["effect"]["owner"]["add_adm_power"] = 25
      mission["effect"]["owner"]["add_dip_power"] = 25
      mission["effect"]["owner"]["add_mil_power"] = 25
      mission["effect"]["add_stability"] = 1
    when "view_the_hanami"
      # Daimyo only mission
      mission["effect"]["add_legitimacy"] = 10
    when "improve_relations_mission"
      mission["effect"]["FROM"]["add_prestige"] = 10
      mission["effect"]["FROM"]["add_dip_power"] = 25
    when "improve_reputation_mission"
      mission["effect"]["add_stability"] = 1
      mission["effect"]["add_legitimacy"] = 10
      mission["effect"]["add_republican_tradition"] = 10
    when "get_minor_cash_reserve"
      mission["effect"]["add_adm_power"] = 10
    when "recover_negative_stability"
      mission["effect"]["add_prestige"] = 10
      mission["effect"]["add_legitimacy"] = 10
      mission["effect"]["add_republican_tradition"] = 0.1
    when "recover_from_warexhaustion"
      mission["effect"]["add_dip_power"] = 25
    when "convert_province_mission"
      mission["effect"]["owner"]["add_adm_power"] = 25
    when "solidify_our_papal_relations"
      mission["effect"]["add_prestige"] = 10
      mission["effect"]["add_dip_power"] = 25
    when "control_the_pope"
      mission["effect"]["add_prestige"] = 10
      mission["effect"]["add_dip_power"] = 25
    when "defeat_rebels_mission"
      mission["effect"]["add_prestige"] = 10
      mission["effect"]["add_legitimacy"] = 10
      mission["effect"]["add_republican_tradition"] = 0.1
    when "force_convert_mission"
      mission["effect"]["add_dip_power"] = 100
    else
      require 'pry'; binding.pry
    end
  end

  def make_missions_not_tag_specific!
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
        when ["POL"]
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

  def rescale(val, range_a, range_b)
    position_in_range = (val-range_a.begin).to_f /  range_a.size
    (range_b.begin + position_in_range * range_b.size).round
  end

  def rescale_tech_times_to_1399_1820_timeframe!
    patch_mod_files!("common/technologies/*.txt") do |node|
      node.find_all("technology").each_with_index do |tech,i|
        # p [tech["year"], rescale(tech["year"], 1444..1820, 1399..1820)]
        tech["year"] = rescale(tech["year"], 1444..1820, 1399..1820)
      end
    end
  end

  def easier_change_government_decisions!
    not_20_cities = proc{|k,v| k == "NOT" and v == PropertyList["num_of_cities", 20]}

    patch_mod_file!("decisions/Governments.txt") do |node|
      node["country_decisions"].each do |key, decision|
        case key
        when "plutocratic_administration_rep",
             "plutocratic_administration",
             "aristocratic_administration"
          decision["potential"].delete_if(&not_20_cities)
          decision["allow"].delete_if(&not_20_cities)
        end
      end
    end

    create_mod_file! "decisions/GovernmentsTheocracy.txt", PropertyList[
      "country_decisions", PropertyList[
        "theocratic_administration", PropertyList[
          "major", true,
          "potential", PropertyList[
            "government", "monarchy",
            Property::OR[
              "technology_group", "western",
              "technology_group", "eastern",
              "technology_group", "ottoman",
              "technology_group", "muslim",
            ],
          ],
          "allow", PropertyList[
            "stability", 1,
            "religious_unity", 1,
            "full_idea_group", "religious_ideas",
            "is_at_war", false,
            "is_subject", false,
          ],
          "effect", PropertyList[
            "change_government", "theocratic_government",
            "add_stability", -4,
          ],
          "ai_will_do", PropertyList["factor", 0],
        ]
      ]
    ]

    localization! "governments_theocracy",
      "theocratic_administration_title" => "Adopt Theocratic Administration",
      "theocratic_administration_desc"  => "Kings only rule by divine right, so why not skip the middleman and put priests directly in control?"
  end

  def fix_custom_idea_extra_governments!
    extra_government_costs = {
      # Generally sensible:
      "administrative_monarchy" => 20,
      "absolute_monarchy" => 30,
      "constitutional_monarchy" => 30,
      "enlightened_despotism" => 50,
      "revolutionary_empire" => 50,
      "administrative_republic" => 20,
      "republican_dictatorship" => 30,
      "constitutional_republic" => 40,
      "bureaucratic_despotism" => 50,
      "revolutionary_republic" => 50,
      "archduchy" => 10,
      # Use at your own risk:
      "siberian_native_council" => 20,
      "colonial_government" => 20,
      "american_republic" => 50,
      "federal_republic" => 50,
      # Not available:
      # "papal_government",
      # "celestial_empire",
    }
    patch_mod_file!("common/governments/00_governments.txt") do |node|
      extra_government_costs.each do |gov, cost|
        node[gov]["valid_for_nation_designer"] = true
        node[gov]["nation_designer_cost"] = cost
      end
    end
  end

  def fix_custom_idea_extra_ideas!
    extra_custom_ideas = {
      "adm_tech_cost_modifier"             => [-0.05,  "adm", loc: "Innovative Administration"],
      "global_heretic_missionary_strength" => [ 0.01,  "adm", loc: "Witch Burning"],
      "migration_cooldown"                 => [-0.2,   "adm", loc: "Restless Tribe", max_level: 3],
      "monthly_fervor_increase"            => [ 0.25,  "adm", loc: "Religious Fervor"],

      "dip_tech_cost_modifier"             => [-0.05,  "dip", loc: "Innovative Diplomacy"],
      "global_ship_cost"                   => [-0.05,  "dip", loc: "Navy Provisioning"],
      "global_trade_goods_size"            => [ 0.05,  "dip", loc: "Craftsmen Guild"],
      "envoy_travel_time"                  => [-0.25,  "dip", loc: "Fast Envoys", max_level: 2],
      "caravan_power"                      => [ 0.1,   "dip", loc: "Trade Caravans"],
      "global_trade_income_modifier"       => [ 0.05,  "dip", loc: "Luxury Trade"],
      "improve_relation_modifier"          => [ 0.1,   "dip", loc: "Charming Diplomats"],
      "fabricate_claims_time"              => [-0.1,   "dip", loc: "Forgers Guild", max_level: 6],
      "imperial_authority"                 => [ 0.05,  "dip", loc: "Imperial Ambitions"],
      "naval_attrition"                    => [-0.05,  "dip", loc: "Naval Thriftiness"],
      "relations_decay_of_me"              => [ 0.1,   "dip", loc: "Let Bygones Be Bygones"],
      "papal_influence"                    => [ 0.1,   "dip", loc: "Papal Influence"],
      "rebel_support_efficiency"           => [ 0.2,   "dip", loc: "Rebel Relations"],
      "trade_range_modifier"               => [ 0.1,   "dip", loc: "Merchant Explorers"],
      "justify_trade_conflict_time"        => [-0.1,   "dip", loc: "Querrelsome Merchants", max_level: 6],
      "global_own_trade_power"             => [ 0.1,   "dip", loc: "Home Merchant Guild"],
      "global_foreign_trade_power"         => [ 0.1,   "dip", loc: "Foreign Merchant Guild"],
      "unjustified_demands"                => [-0.1,   "dip", loc: "Diplomatic Justifications", max_level: 6],
      "recover_navy_morale_speed"          => [ 0.025, "dip", loc: "Naval Enthusiasm"],
      "discovered_relations_impact"        => [-0.2,   "dip", loc: "Diplomatic Excuses", max_level: 3],
      "province_warscore_cost"             => [-0.025, "dip", loc: "Persuasive Diplomats"],
      "global_ship_repair"                 => [ 0.1,   "dip", loc: "Efficient Drydocks"],

      "mil_tech_cost_modifier"             => [-0.05,  "mil", loc: "Innovative Military"],
      "global_regiment_cost"               => [-0.05,  "mil", loc: "Army Provisioning"],
      "global_garrison_growth"             => [ 0.1,   "mil", loc: "Draft for Garrison Duty"],
      "land_attrition"                     => [-0.05,  "mil", loc: "Efficient Foraging"],
      "recover_army_morale_speed"          => [ 0.025, "mil", loc: "Military Enthusiasm"],
      "free_leader_pool"                   => [ 1,     "mil", loc: "Lower Class Officers", levels: [15, 50]],
    }

    ["adm", "dip", "mil"].each do |category|
      patch_mod_file!("common/custom_ideas/00_#{category}_custom_ideas.txt") do |node|
        ideas = node.values[0]

        # Support more more levels
        ideas.each do |idea_name, idea|
          next if idea_name == "category"
          level_costs = idea.keys.grep(/\Alevel_cost_\d+\z/).sort.map{|k| [k[/\d+/].to_i, idea[k]] }
          max_level   = idea["max_level"]
          case [max_level, *level_costs]
          when [nil]
            # OK, scale up to 10 for greater good
          when [nil, [2, 3], [3, 9], [4, 18]]
            # 60% cost ideas, scole up to level 10
            idea.add! "level_cost_5", 30
            idea.add! "level_cost_6", 45
            idea.add! "level_cost_7", 63
            idea.add! "level_cost_8", 84
            idea.add! "level_cost_9", 108
            idea.add! "level_cost_10", 135
          when [2, [1, 15], [2, 50]]
            idea.add! "level_cost_3", 105
            idea.add! "level_cost_4", 180
            idea["max_level"] = 4
          when [2, [1, 5], [2, 30]]
            idea.add! "level_cost_3", 75
            idea.add! "level_cost_4", 140
            idea.add! "level_cost_5", 225
            idea["max_level"] = 5
          when [2, [1, 3], [2, 18]]
            # 2n+1 * 60%, well, jusn following the formula
            idea.add! "level_cost_3", 45
            idea.add! "level_cost_4", 84
            idea.add! "level_cost_5", 135
            idea["max_level"] = 5
          when [2, [2, 15]]
            idea.add! "level_cost_3", 50
            idea.add! "level_cost_4", 105
            idea.add! "level_cost_5", 180
            idea["max_level"] = 5
          when [2, [1, 30], [2, 140]]
            # Extrapolating it level 3 would cost at level 12 which is out of scale
            # It's another issue if such high costs are really justified
          else
            idea.add! "max_level", 4 unless max_level
            p [idea_name, max_level, *level_costs]
          end
        end

        # New ideas
        extra_custom_ideas.each do |key, (val, cat, options)|
          next unless cat == category
          options ||= {}
          idea = PropertyList[key, val]
          if options[:max_level]
            idea.add! "max_level", options[:max_level]
          end
          if options[:levels]
            idea.add! "max_level", options[:levels].size
            options[:levels].each_with_index do |cost, i|
              idea.add! "level_cost_#{i+1}", cost
            end
          end
          ideas.add! "custom_idea_#{key}", idea
          if options[:loc]
            localization! "custom_ideas", "custom_idea_#{key}" => options[:loc], "custom_idea_#{key}_desc" => ""
          end
        end
      end
    end
  end

  def fix_custom_ideas!
    fix_custom_idea_extra_governments!
    fix_custom_idea_extra_ideas!
  end

  def power_projection_tweaks!
    patch_mod_file!("common/powerprojection/00_static.txt") do |node|
      modify_node! node,
        ["eclipsed_rival",            "power",          5,  30],
        ["eclipsed_rival",            "max",           30, 100],
        ["declared_war_at_rival",     "yearly_decay",   1, 0.5],
        ["joined_war_against_rival",  "yearly_decay",   1, 0.5],
        ["refused_war_against_rival", "yearly_decay",   1, 0.5],
        ["vassalized_rival",          "yearly_decay",   1, 0.5],
        ["took_province_from_rival",  "yearly_decay",   1, 0.5],
        ["rival_lost_province",       "yearly_decay",   1, 0.5]
    end
  end

def build_mod_config_menu!(*options)
    create_mod_file! "decisions/fun_and_balance_menu.txt", PropertyList[
      "country_decisions", PropertyList[
        "fun_and_balance_display_menu", PropertyList[
          "potential", PropertyList["ai", false],
          "allow", PropertyList["ai", false],
          "effect", PropertyList[
            "country_event", PropertyList["id", "fun_and_balance_menu.show_menu"],
          ],
        ],
      ],
    ]
    localization! "fun_and_balance_menu",
      "fun_and_balance_display_menu_title"   => "Change Fun and Balance configuration",
      "fun_and_balance_display_menu_desc"    => "Display menu to change various features",
      "fun_and_balance_menu.show_menu_title" => "Fun and Balance configuration",
      "fun_and_balance_menu.show_menu_desc"  => "These settings should generally be changed at start of campaign."

    create_mod_file! "events/fun_and_balance_menu.txt", PropertyList[
      "namespace", "fun_and_balance_menu",
      "country_event", PropertyList[
        "id", "fun_and_balance_menu.show_menu",
        "title", "fun_and_balance_menu.show_menu_title",
        "desc", "fun_and_balance_menu.show_menu_desc",
        "picture", "BIG_BOOK_eventPicture",
        "is_triggered_only", true,
        "trigger", PropertyList["ai", false],
        *options.map{|option|
          Property["option", option]
        },
      ],
    ]
  end

  def menu_set_flag_option(flag, localization)
    localization! "fun_and_balance_menu", "fun_and_balance_menu.set_#{flag}" => localization
    PropertyList[
      "name", "fun_and_balance_menu.set_#{flag}",
      "trigger", PropertyList["NOT", PropertyList["has_global_flag", "fun_and_balance_config.#{flag}"]],
      "set_global_flag", "fun_and_balance_config.#{flag}",
    ]
  end

  def menu_clr_flag_option(flag, localization)
    localization! "fun_and_balance_menu", "fun_and_balance_menu.clr_#{flag}" => localization
    PropertyList[
      "name", "fun_and_balance_menu.clr_#{flag}",
      "trigger", PropertyList["has_global_flag", "fun_and_balance_config.#{flag}"],
      "clr_global_flag", "fun_and_balance_config.#{flag}",
    ]
  end

   def build_mod_config_menu_for_vanilla!
    build_mod_config_menu!(
      menu_set_flag_option("disable_holy_sites", "Disable Holy Sites"),
      menu_clr_flag_option("disable_holy_sites", "Enable Holy Sites"),
      menu_set_flag_option("disable_extra_missions", "Disable extra missions"),
      menu_clr_flag_option("disable_extra_missions", "Enable extra missions"),
      menu_set_flag_option("disable_extra_formable_countries", "Disable extra formable countries"),
      menu_clr_flag_option("disable_extra_formable_countries", "Enable extra formable countries"),
      menu_set_flag_option("disable_partial_westernization", "Disable partial westernization"),
      menu_clr_flag_option("disable_partial_westernization", "Enable partial westernization"),
      menu_set_flag_option("disable_eu3_style_elections", "Disable EU3 style elections"),
      menu_clr_flag_option("disable_eu3_style_elections", "Enable EU3 style elections"),
      menu_set_flag_option("enable_burgundian_succession_crisis", "Enable Burgundian Successian Crisis"),
      menu_clr_flag_option("enable_burgundian_succession_crisis", "Disable Burgundian Successian Crisis"),
      PropertyList[
        "name", "fun_and_balance_menu.done",
      ],
    )
    localization! "fun_and_balance_menu",
      "fun_and_balance_menu.done" => "Done"
  end

   def build_mod_config_menu_for_et!
    build_mod_config_menu!(
      menu_set_flag_option("disable_eu3_style_elections", "Disable EU3 style elections"),
      menu_clr_flag_option("disable_eu3_style_elections", "Enable EU3 style elections"),
      menu_set_flag_option("enable_burgundian_succession_crisis", "Enable Burgundian Successian Crisis"),
      menu_clr_flag_option("enable_burgundian_succession_crisis", "Disable Burgundian Successian Crisis"),
      PropertyList[
        "name", "fun_and_balance_menu.done",
      ],
    )
    localization! "fun_and_balance_menu",
      "fun_and_balance_menu.done" => "Done"
  end

  # Event numbers:
  # 10x - x emperor won
  # 20x - x diet
  # 3xy - victory in x-vs-y war
  # 40x - x league starts

  def more_options_for_religious_leagues!
    patch_mod_file! "common/triggered_modifiers/00_triggered_modifiers.txt" do |node|
      node["hre_dominant_catholic"]["potential"].delete("OR")
      node["hre_dominant_catholic"]["potential"].add! "religion_group", "christian"
      node["hre_dominant_protestant"]["potential"].delete("OR")
      node["hre_dominant_protestant"]["potential"].add! "religion_group", "christian"
      ["reformed", "orthodox", "coptic"].each do |religion|
        node.add! "hre_dominant_#{religion}", PropertyList[
          "potential", PropertyList[
            "capital_scope", PropertyList["continent", "europe"],
            "religion_group", "christian",
          ],
          "trigger", PropertyList[
            "religion", religion,
            "hre_religion", religion,
            "hre_religion_locked", true,
          ],
          "legitimacy", 0.25,
          "tolerance_own", 1,
          "global_missionary_strength", 0.01,
          "imperial_authority", 0.25,
        ]
      end
    end
    patch_mod_file!("events/ReligiousLeagues.txt") do |node|
      ["reformed", "orthodox", "coptic"].each_with_index do |religion, i|
        node.add! "country_event", PropertyList[
          "id", "religious_leagues.10#{i+3}",
          "title", "religious_leagues.1.t",
          "desc", "religious_leagues.1.d.#{religion}",
          "picture", "RELIGIOUS_WARS_eventPicture",
          "major", true,
          "is_triggered_only", true,
          "trigger", PropertyList[
            "has_dlc", "Art of War",
            "hre_religion", religion,
          ],
          "immediate", PropertyList["hidden_effect", PropertyList["set_hre_religion_locked", true]],
          "option", PropertyList[
            "name", "religious_leagues.1.a",
            "tooltip", PropertyList["set_hre_religion_locked", true],
          ],
        ]
        node.add! "country_event", PropertyList[
          "id", "religious_leagues.20#{i+3}",
          "title", "religious_leagues.6.t",
          "desc", "religious_leagues.diet.#{religion}",
          "picture", "RELIGIOUS_WARS_eventPicture",
          "major", true,
          "fire_only_once", true,
          "trigger", PropertyList[
            "has_dlc", "Art of War",
            "is_emperor", true,
            "is_at_war", false,
            "NOT", PropertyList["any_known_country", PropertyList["is_in_league_war", true]],
            "has_regency", false,
            "hre_religion_locked", false,
            "hre_religion_treaty", false,
            "religion", religion,
            "OR", PropertyList[
              "AND", PropertyList[
                "hre_leagues_enabled", true,
                "had_global_flag", PropertyList[
                  "flag", "evangelical_union_happened",
                  "days", 10950,
                ],
                "NOT", PropertyList["any_known_country", PropertyList[
                  "is_elector", true,
                  "is_league_enemy", "ROOT",
                  "truce_with", "ROOT",
                  "NOT", PropertyList["religion", religion],
                ]],
              ],
              "AND", PropertyList[
                "NOT", PropertyList["has_global_flag", "evangelical_union_happened"],
                "is_year", 1625,
              ],
            ],
          ],
          "mean_time_to_happen", PropertyList["months", 60],
          "option", PropertyList[
            "name", "religious_leagues.6.a",
            "set_hre_religion_locked", true,
          ],
        ]

        node.delete_if{|k,v| k == "country_event" and v["id"] == "religious_leagues.2"}
        node.delete_if{|k,v| k == "country_event" and v["id"] == "religious_leagues.3"}

        ["catholic", "protestant", "reformed", "orthodox", "coptic"].each_with_index do |hre_religion,i|
          ["catholic", "protestant", "reformed", "orthodox", "coptic"].each_with_index do |heretic_religion,j|
            next if hre_religion == heretic_religion

            node.add! "country_event", PropertyList[
              "id", "religious_leagues.3#{i+1}#{j+1}",
              "title", "religious_leagues.warwon.t.#{hre_religion}",
              "desc", "religious_leagues.warwon.d.#{hre_religion}",
              "picture", "RELIGIOUS_WARS_eventPicture",
              "major", true,
              "is_triggered_only", true,
              "trigger", PropertyList[
                "has_dlc", "Art of War",
                "hre_religion", heretic_religion,
                "hre_heretic_religion", hre_religion,
                "OR", PropertyList[
                  "NOT", PropertyList["has_country_flag", "hre_religion_changed"],
                  "had_country_flag", PropertyList[
                    "flag", "hre_religion_changed",
                    "days", 30,
                  ],
                ],
              ],
              "immediate", PropertyList[
                "set_country_flag", "hre_religion_changed",
                "hidden_effect", PropertyList[
                  "set_hre_heretic_religion", heretic_religion,
                  "set_hre_religion", hre_religion,
                ],
              ],
              "option", PropertyList[
                "name", "religious_leagues.2.a",
                "tooltip", PropertyList[
                  "set_hre_heretic_religion", heretic_religion,
                  "set_hre_religion", hre_religion,
                ],
              ],
            ]
          end
        end

        protestant_league = node.find_all("country_event").find{|v| v["id"] == "religious_leagues.5"}
        protestant_league["option"].add! "set_hre_heretic_religion", "protestant"

        node.add! "country_event", PropertyList[
          "id", "religious_leagues.403",
          "title", "religious_leagues.403.t",
          "desc", "religious_leagues.403.d",
          "picture", "RELIGIOUS_WARS_eventPicture",
          "major", true,
          "fire_only_once", true,
          "trigger", PropertyList[
            "has_dlc", "Art of War",
            "NOT", PropertyList["has_global_flag", "evangelical_union_happened"],
            "hre_leagues_enabled", false,
            "hre_religion_locked", false,
            "hre_religion_treaty", false,
            "is_emperor", true,
            "is_year", 1550,
            "religion", "catholic",
            "has_global_flag", "counter_reformation",
            "any_known_country", PropertyList[
              "is_elector", true,
              "religion", "reformed",
              "is_subject", false,
            ],
            "NOT", PropertyList["hre_reform_level", 6],
          ],
          "mean_time_to_happen", PropertyList[
            "months", 120,
            "modifier", PropertyList[
              "factor", 0.5,
              "is_year", 1575,
            ],
            "modifier", PropertyList[
              "factor", 0.1,
              "is_year", 1600,
            ],
          ],
          "option", PropertyList[
            "name", "religious_leagues.5.a",
            "enable_hre_leagues", true,
            "set_global_flag", "evangelical_union_happened",
            "set_hre_heretic_religion", "reformed",
          ],
        ]
        [["orthodox", 404], ["coptic", 405]].each do |religion, id|
          # Does not depend on 1550 and counterreformation
          node.add! "country_event", PropertyList[
            "id", "religious_leagues.#{id}",
            "title", "religious_leagues.#{id}.t",
            "desc", "religious_leagues.#{id}.d",
            "picture", "RELIGIOUS_WARS_eventPicture",
            "major", true,
            "fire_only_once", true,
            "trigger", PropertyList[
              "has_dlc", "Art of War",
              "NOT", PropertyList["has_global_flag", "evangelical_union_happened"],
              "hre_leagues_enabled", false,
              "hre_religion_locked", false,
              "hre_religion_treaty", false,
              "is_emperor", true,
              "religion", "catholic",
              "any_known_country", PropertyList[
                "is_elector", true,
                "religion", religion,
                "is_subject", false,
              ],
              "NOT", PropertyList["hre_reform_level", 6],
            ],
            "mean_time_to_happen", PropertyList[
              "months", 120,
              "modifier", PropertyList[
                "factor", 0.5,
                "is_year", 1575,
              ],
              "modifier", PropertyList[
                "factor", 0.1,
                "is_year", 1600,
              ],
            ],
            "option", PropertyList[
              "name", "religious_leagues.5.a",
              "enable_hre_leagues", true,
              "set_global_flag", "evangelical_union_happened",
              "set_hre_heretic_religion", religion,
            ],
          ]
        end
      end

      # This code is seriously dumb and fragile
      catholic_diet = node.find_all("country_event").find{|v| v["id"] == "religious_leagues.7"}
      catholic_diet["trigger"]["OR"]["AND"]["NOT"]["any_known_country"].delete "religion"
      catholic_diet["trigger"]["OR"]["AND"]["NOT"]["any_known_country"].add! "NOT", PropertyList["religion", "catholic"]
      catholic_diet["desc"] = "religious_leagues.diet.catholic"
      protestant_diet = node.find_all("country_event").find{|v| v["id"] == "religious_leagues.7"}
      protestant_diet["trigger"]["OR"]["AND"]["NOT"]["any_known_country"].delete "religion"
      protestant_diet["trigger"]["OR"]["AND"]["NOT"]["any_known_country"].add! "NOT", PropertyList["religion", "protestant"]
      protestant_diet["desc"] = "religious_leagues.diet.protestant"
    end

    patch_mod_file!("common/on_actions/00_on_actions.txt") do |node|
      node["on_lock_hre_religion"]["events"] += ["religious_leagues.103", "religious_leagues.104", "religious_leagues.105"]

      node["on_change_hre_religion"]["events"] = (1..5).map do |i|
        (1..5).map do |j|
          "religious_leagues.3#{i}#{j}" unless i == j
        end
      end.flatten.compact
    end

    localization!("fun_and_balance_religious_leagues",
      "hre_dominant_reformed" => "Reformed Empire",
      "hre_dominant_orthodox" => "Orthodox Empire",
      "hre_dominant_coptic" => "Coptic Empire",
      "desc_hre_dominant_reformed" => "The Reformed faith is the official religion of the Holy Roman Empire. Following this faith grants our nation a certain moral legitimacy.",
      "desc_hre_dominant_orthodox" => "The Orthodox faith is the official religion of the Holy Roman Empire. Following this faith grants our nation a certain moral legitimacy.",
      "desc_hre_dominant_coptic" => "The Coptic faith is the official religion of the Holy Roman Empire. Following this faith grants our nation a certain moral legitimacy.",
      "religious_leagues.1.d.reformed" => "The War of Religion in the Empire has ended in total victory for the Emperor and the Imperial Parliament has convened in a Diet to proclaim Reformed as the sole confessional faith of the Holy Roman Empire. Electors who follow a different confession will be stripped of their privileges, and the Emperor is given broad authority to enforce Reformed unity within the Empire.",
      "religious_leagues.1.d.orthodox" => "The War of Religion in the Empire has ended in total victory for the Emperor and the Imperial Parliament has convened in a Diet to proclaim Orthodoxy as the sole confessional faith of the Holy Roman Empire. Electors who follow a different confession will be stripped of their privileges, and the Emperor is given broad authority to enforce Orthodox unity within the Empire.",
      "religious_leagues.1.d.coptic" => "The War of Religion in the Empire has ended in total victory for the Emperor and the Imperial Parliament has convened in a Diet to proclaim Coptic as the sole confessional faith of the Holy Roman Empire. Electors who follow a different confession will be stripped of their privileges, and the Emperor is given broad authority to enforce Coptic unity within the Empire.",
      "religious_leagues.diet.catholic" => "With the failure of the heretic league to successfully challenge the Emperor, the Imperial Parliament has convened in a Diet to proclaim Catholicism as the sole confessional faith of the Holy Roman Empire. Electors who follow a different confession will be stripped of their privileges, and the Emperor is given broad authority to enforce Catholic unity within the Empire.",
      "religious_leagues.diet.protestant" => "With the failure of the heretic league to successfully challenge the Emperor, the Imperial Parliament has convened in a Diet to proclaim Protestantism as the sole confessional faith of the Holy Roman Empire. Electors who follow a different confession will be stripped of their privileges, and the Emperor is given broad authority to enforce Protestant unity within the Empire.",
      "religious_leagues.diet.reformed" => "With the failure of the heretic league to successfully challenge the Emperor, the Imperial Parliament has convened in a Diet to proclaim Reformed as the sole confessional faith of the Holy Roman Empire. Electors who follow a different confession will be stripped of their privileges, and the Emperor is given broad authority to enforce Reformed unity within the Empire.",
      "religious_leagues.diet.orthodox" => "With the failure of the heretic league to successfully challenge the Emperor, the Imperial Parliament has convened in a Diet to proclaim Orthodoxy as the sole confessional faith of the Holy Roman Empire. Electors who follow a different confession will be stripped of their privileges, and the Emperor is given broad authority to enforce Orthodox unity within the Empire.",
      "religious_leagues.diet.coptic" => "With the failure of the heretic league to successfully challenge the Emperor, the Imperial Parliament has convened in a Diet to proclaim Coptic as the sole confessional faith of the Holy Roman Empire. Electors who follow a different confession will be stripped of their privileges, and the Emperor is given broad authority to enforce Coptic unity within the Empire.",
      "religious_leagues.warwon.t.reformed" => "The Reformed League is Victorious",
      "religious_leagues.warwon.t.orthodox" => "The Orthodox League is Victorious",
      "religious_leagues.warwon.t.coptic"   => "The Coptic League is Victorious",
      "religious_leagues.warwon.d.reformed" => "The War of Religion in the Empire has ended in victory for the Reformed Union. The Emperor has been forced to abdicate and Reformed is now the dominant faith in the Empire.",
      "religious_leagues.warwon.d.orthodox" => "The War of Religion in the Empire has ended in victory for the Orthodox Union. The Emperor has been forced to abdicate and Orthodoxy is now the dominant faith in the Empire.",
      "religious_leagues.warwon.d.coptic"   => "The War of Religion in the Empire has ended in victory for the Coptic Union. The Emperor has been forced to abdicate and Coptic is now the dominant faith in the Empire.",
      "religious_leagues.403.t" => "The Reformed Union",
      "religious_leagues.404.t" => "The Orthodox Union",
      "religious_leagues.405.t" => "The Coptic Union",
      "religious_leagues.403.d" => "After Emperor $MONARCH$ rejected the Reformed confessional positions at the Imperial Parliament, the Reformed Imperial estates formed the League of Schmalkalden, with a joint army and treasury and seeking ties abroad. The German Catholic states, feeling threatened by this new alliance, have regrouped into a Catholic League. The stage is set for religious conflict in the Empire.",
      "religious_leagues.404.d" => "After Emperor $MONARCH$ rejected the Orthodox confessional positions at the Imperial Parliament, the Orthodox Imperial estates formed the League of Schmalkalden, with a joint army and treasury and seeking ties abroad. The German Catholic states, feeling threatened by this new alliance, have regrouped into a Catholic League. The stage is set for religious conflict in the Empire.",
      "religious_leagues.405.d" => "After Emperor $MONARCH$ rejected the Coptic confessional positions at the Imperial Parliament, the Coptic Imperial estates formed the League of Schmalkalden, with a joint army and treasury and seeking ties abroad. The German Catholic states, feeling threatened by this new alliance, have regrouped into a Catholic League. The stage is set for religious conflict in the Empire.",
     )
   end
end

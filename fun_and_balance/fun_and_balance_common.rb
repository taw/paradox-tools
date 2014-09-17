module FunAndBalanceCommon
  def feature_return_vassal_cores!
    localization! "return_vassal_cores",
      "return_vassal_cores"            => "Return Subject's Core",
      "return_vassal_cores_desc"       => "These provinces rightfully belong to your subject. Wargoal is to liberate them.",
      "war_goal_take_vassal_core"      =>  "Take subject core $PROV$",
      "war_goal_take_vassal_core_desc" => "War goal is to take subject's core $PROV$."
    create_mod_file! "common/cb_types/return_vassal_cores_cb.txt", PropertyList[
      "return_vassal_cores", PropertyList[
        "prerequisites", PropertyList[
          "FROM", PropertyList[
            Property::NOT["is_subject_of", "ROOT"],
            "any_owned_province", PropertyList[
              "any_country", PropertyList[
                "is_subject_of", "ROOT",
                "is_core", "PREV",
              ],
            ],
          ],
        ],
        "war_goal", "take_vassal_core",
      ]
    ]
    create_mod_file! "common/wargoal_types/return_vassal_cores_wargoal.txt", PropertyList[
      "take_vassal_core", PropertyList[
        "type", "take_province",
        "po_release_vassals", true,
        "po_release_annexed", true,
        "po_return_cores", true,
        "po_revoke_cores", true,
        "po_gold", true,
        "po_concede_defeat", true,
        "badboy_factor", 1,
        "prestige_factor", 1,
        "peace_cost_factor", 1,
        "po_annex", true,
        "allowed_provinces", PropertyList[
          "any_country", PropertyList[
            "is_subject_of", "ROOT",
            "is_core", "PREV",
          ],
        ],
        "allow_leader_change", true,
        "war_name", "LIBERATION_WAR_NAME",
      ]
    ]
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

  def province_id(province_name)
    matches = @game.glob("history/provinces/* - #{province_name}.txt")
    raise "No match for #{province_name}" unless matches.size == 1
    matches[0].basename.to_s.to_i
  end

  def restore_hre_ia_on_prince_religion_change!
    patch_mod_file!("common/on_actions/00_on_actions.txt") do |node|
      node["on_hre_member_true_religion"]["events"] = [903]
    end
  end

  def make_improve_relations_mission_relevant!
    patch_mod_file!("missions/Diplomatic_Missions.txt") do |node|
      node["improve_relations_mission"]["effect"]["FROM"]["add_prestige"] = 10
    end
    patch_mod_file!("missions/Diplomatic_Missions.txt") do |node|
      node["improve_relations_mission"]["effect"]["FROM"]["add_dip_power"] = 25
    end
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

  def fix_peasant_war!
    patch_mod_file!("events/PeasantsWar.txt") do |node|
      node.find_all("country_event").each do |event|
        next unless event["id"] == "peasants_war.1"

        cond = event["trigger"].find_all("OR")[0]
        cond["war_exhaustion"] = 5
        cond["overextension_percentage"] = 1.01
        cond["num_of_loans"] = 5
        cond["NOT"]["legitimacy"] = 40 # This is really weird...
        cond.add! Property::NOT["stability", 0]

        event["mean_time_to_happen"].find_all("modifier").each do |mod|
          mod["factor"] = 1.5 if mod["stability"]
          mod["factor"] = 0.7 if mod["NOT"] && mod["NOT"]["stability"] # weirdness again
        end
      end
    end
  end

  def change_elections_to_eu3_style!
    patch_mod_file!("events/Elections.txt") do |node|
      node.find_all("country_event").each do |event|
        event.find_all("option").each do |option|
          eu3_style_elections!(option)
        end
      end
    end

    patch_mod_file!("events/GenericOnActionEvents.txt") do |node|
      node.find_all("country_event").each do |event|
        if event["option"]["add_republican_tradition"]
          event["option"]["add_republican_tradition"] = -0.03
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
          if name == "siberian_frontier"
            idea.delete "colonists"
          end
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

  def remove_burgundy_inheritance!
    patch_mod_file!("events/FlavorBUR.txt") do |node|
      node.delete_if do |key, val|
        key == "country_event" and val["id"] =~ /\Aflavor_bur\.(1|2|3|4|5|6|7|19)\z/
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
      node["aggressive_expansion"]["yearly_decay"] = 4
      node["opinion_annex_vassal"]["min"] = -100
    end
  end

  def fix_wargoals!
    patch_mod_file!("common/wargoal_types/00_wargoal_types.txt") do |node|
      node["take_province_ban"]["badboy_factor"] = 0.1
      node["superiority_heretic"].delete("allowed_provinces")
      node["superiority_heretic"]["peace_cost_factor"] = 0.25
      node["superiority_heretic"].delete("po_demand_provinces")
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
      trigger_name => "#{site[:short_name]} is #{religion.to_s.capitalize}",
      "desc_#{trigger_name}" => "#{religion.to_s.capitalize} rulers control holy site #{site[:name]}"
    Property[trigger_name, PropertyList[
      "potential", PropertyList["religion", religion],
      "trigger", PropertyList[site[:id], PropertyList["owner", PropertyList["religion", religion]]],
      "global_missionary_strength", 0.002,
    ]]
  end

  def add_holy_sites_all!(religion, sites)
    # For sake of balance keep it at 0 or 5
    raise "Expected 0 or 5 sites, not #{sites.size}" unless sites.size == 5
    trigger_name = "holy_sites_#{religion}"
    localization! "holy_sites",
      trigger_name           => "All #{religion.to_s.capitalize} holy sites",
      "desc_#{trigger_name}" => "#{religion.to_s.capitalize} controls all its holy sites #{ sites.map{|x| x[:name]}.join(", ") }."
    Property[trigger_name, PropertyList[
      "potential", PropertyList["religion", religion],
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
      "#{mission_name}_title" => "Conquer Holy Sity #{site[:short_name]}",
      "#{mission_name}_desc" => "We must not allow infidels to hold our holy site #{site[:name]}!"
    Property[mission_name, PropertyList[
      "type", "country",
      "category", "MIL",
      "ai_mission", true,
      "allow", PropertyList[
        "religion", religion,
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
        id, PropertyList["owner" , PropertyList["religion", religion]],
      ],
      "abort", PropertyList[
        Property::OR[
          "is_subject", true,
          Property::NOT["religion", religion],
        ]
      ],
      "immediate", PropertyList["add_claim", id],
      "abort_effect", PropertyList["remove_claim", id],
      "chance", PropertyList[
        "factor", 1000,
        "modifier", PropertyList["factor", 10, "is_neighbor_of", "ROOT"],
        "modifier", PropertyList["factor", 2, "has_idea", "deus_vult"]
      ],
      "effect", PropertyList["add_adm_power", 200],
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
          details.delete "dynasty_names"
          yield culture_name, details["primary"]
        end
      end
    end
  end

  def feature_extra_formable_countries!
    already_formable = %W[
      BRZ BUK BYZ CAM CAN CHL COL EGY ENG FRA GBR GER GRE HAB HAN HAT HIN
      IRE ITA JAP KUR LAP LOU MEX MSA MUG NED PER PEU PLC PRG PRU QNG QUE
      RMN RUS SCA SPA SPI USA VNZ WES]
    cant_by_formed_by = %W[HLR PAP HIN MUG SPA FRA GER BYZ BUK ITA RUS SCA PER GBR PLC EGY VIJ]

    decisions = []
    each_country_primary_culture do |culture, tag|
      next if already_formable.include?(tag)
      next if tag == "MOS" # Form Russia instead
      next if tag == "CZH" or tag == "CSH" # Chinese minors can't be formed
      decisions << "country_decisions"
      decisions << PropertyList[
        "extra_formable_form_#{tag}", PropertyList[
          "major", true,
          "potential", PropertyList[
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
    patch_mod_file!("decisions/ManchuDecisions.txt") do |node|
      node["country_decisions"]["form_manchu_dynasty"]["allow"].delete("is_tribal")
      node["country_decisions"]["form_manchu_dynasty"]["effect"]["if"]["change_government"] = "despotic_monarchy"
    end

    patch_mod_file!("decisions/MughalNation.txt") do |node|
      node["country_decisions"]["mughal_nation"]["allow"].delete("is_tribal")
      node["country_decisions"]["mughal_nation"]["effect"]["if"]["change_government"] = "despotic_monarchy"
    end

    patch_mod_file!("decisions/PersianNation.txt") do |node|
      node["country_decisions"]["persian_nation"]["allow"].delete("is_tribal")
      node["country_decisions"]["persian_nation"]["effect"]["if"]["change_government"] = "despotic_monarchy"
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
      node["steppe_horde"]["global_manpower_modifier"] = 1.0
      node["steppe_horde"]["land_forcelimit_modifier"] = 1.0
      node["steppe_horde"]["land_maintenance_modifier"] = -0.5
    end
  end

  def anyone_can_form_byzantium!
    patch_mod_file!("decisions/RestoreByzantineEmpire.txt") do |node|
      node["country_decisions"]["restore_byzantine_empire"]["potential"].delete_if do |k,v|
        k == "NOT" and (v == PropertyList["tag", "HLR"] or v == PropertyList["tag", "TUR"])
      end
    end
  end

  def allowed_conversions(group_name, name)
    if group_name == "christian"
      ["protestant", "catholic",  "reformed", "orthodox", "coptic"] - [name]
    elsif group_name == "muslim"
      ["sunni", "shiite", "ibadi"] - [name]
    elsif name == "buddhism"
       ["hinduism", "confucianism", "shinto"]
    elsif name == "hinduism"
      ["sikhism", "buddhism"]
    elsif group_name == "eastern"
       ["buddhism", "confucianism", "shinto"] - [name]
    elsif group_name == "dharmic"
      ["hinduism", "sikhism"] - [name]
    else
      nil
    end
  end

  def on_convert(religion, *extras)
    PropertyList[
      "change_religion", religion,
      *extras,
      "add_country_modifier", PropertyList["name", "conversion_zeal", "duration", 3650],
    ]
  end

  def patch_religion!
    patch_mod_file!("common/religions/00_religion.txt") do |node|
      node.each do |group_name, group|
        group.each do |name, religion|
          next if name == "crusade_name" or name == "defender_of_faith"
          if conversions = allowed_conversions(group_name, name)
            religion["allowed_conversion"] = conversions
          end

          if group_name == "muslim"
            religion["on_convert"] = on_convert(
              name,
              "add_stability", -2,
              "add_piety", -1,
            )
          end

          if name == "shinto"
            religion["on_convert"] = on_convert(
              name,
              "add_prestige", -100,
              "remove_country_modifier", "monastic_education_system",
              "remove_country_modifier", "neo_confucianism",
              "remove_country_modifier", "denounce_taoism",
            )
          end

          if name == "buddhism"
            religion["on_convert"] = on_convert(
              name,
              "add_prestige", -100,
              "remove_country_modifier", "the_haridasa_movement",
              "remove_country_modifier", "the_advaita_movement",
              "remove_country_modifier", "religious_sect_tolerance",
              "remove_country_modifier", "neo_confucianism",
              "remove_country_modifier", "denounce_taoism",
            )
          end

          if name == "confucianism"
            religion["on_convert"] = on_convert(
              name,
              "add_prestige", -100,
              "remove_country_modifier", "monastic_education_system",
            )
          end

          if name == "hinduism"
            religion["on_convert"].add! "remove_country_modifier", "monastic_education_system"
          end

          if name == "orthodox" or name == "coptic"
            religion["on_convert"] = on_convert(
              name,
              "add_prestige", -100,
              "remove_country_modifier", "the_test_act",
              "remove_country_modifier", "superintendent_office",
              "remove_country_modifier", "the_popery_act",
              "remove_country_modifier", "counter_reformation",
              "remove_country_modifier", "the_statue_in_restraint_of_appeals",
              "remove_country_modifier", "bavarian_jesuits",
              "remove_country_modifier", "the_societas_jesu",
              "remove_country_modifier", "the_declaration_of_indulgence",
              "remove_country_modifier", "de_heretico_comburendo",
              "remove_country_modifier", "the_conventicle_act",
            )
          end

          if group_name == "pagan"
            religion["country"]["enemy_core_creation"] = -0.5
            religion["province"]["local_missionary_strength"] = 0.03
          else
            religion["province"].delete("local_missionary_strength") if religion["province"]
          end
        end
      end
    end
  end

  def holy_sites_by_religion
    {
      catholic:     ["Roma", "Judea / Jerusalem", "Thrace / Constantinople", "Galicia / Santiago de Compostela", "Kent / Cantenbury"],
      protestant:   ["Roma", "Judea / Jerusalem", "Thrace / Constantinople", "Galicia / Santiago de Compostela", "Kent / Cantenbury"],
      reformed:     ["Roma", "Judea / Jerusalem", "Thrace / Constantinople", "Galicia / Santiago de Compostela", "Kent / Cantenbury"],
      orthodox:     ["Roma", "Judea / Jerusalem", "Thrace / Constantinople", "Macedonia / Mount Athos", "Kiev"],
      coptic:       ["Roma", "Judea / Jerusalem", "Thrace / Constantinople", "Alexandria", "Tigre / Ark of the Covenant"],

      sunni:        ["Mecca", "Judea / Jerusalem", "Thrace / Constantinople", "Cordoba", "Karbala"],
      shiite:       ["Mecca", "Judea / Jerusalem", "Thrace / Constantinople", "Cordoba", "Karbala"],
      ibadi:        ["Mecca", "Judea / Jerusalem", "Thrace / Constantinople", "Cordoba", "Karbala"],

      # Varanasi, Chidambaram, Angkor Wat - Hindu
      # Palitana - Jain
      # Harmandir Sahib - Sikh
      hinduism:     ["Jaunpur / Varanasi", "Coromandel / Chidambaram", "Gujarat / Palitana", "Siem Reap / Angkor Wat", "Punjab / Harmandir Sahib"],
      sikhism:      ["Jaunpur / Varanasi", "Coromandel / Chidambaram", "Gujarat / Palitana", "Siem Reap / Angkor Wat", "Punjab / Harmandir Sahib"],

      # TODO:
      buddhism:     ["Bihar / Bodhgaya / 558", "Siem Reap / Angkor Wat", "Shandong / Qufu", "Owari / Ise Jingu", "Gyeongsang / Bulguksa"],
      confucianism: ["Bihar / Bodhgaya / 558", "Siem Reap / Angkor Wat", "Shandong / Qufu", "Owari / Ise Jingu", "Gyeongsang / Bulguksa"],
      shinto:       ["Bihar / Bodhgaya / 558", "Siem Reap / Angkor Wat", "Shandong / Qufu", "Owari / Ise Jingu", "Gyeongsang / Bulguksa"],

      # Not getting any ever
      shamanism:    [],
      animism:      [],
      totemism:     [],
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

    if alt.size == 1
      alt_cond = alt[0]
    else
      alt_cond = Property::AND[*alt]
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
  end

  def make_missions_not_tag_specific!
    patch_mod_files!("missions/*.txt") do |node|
      node.each do |name, mission|
        allow = mission["allow"]
        tags = tag_requirements_for_mission(mission)

        case tags
        when ["VEN"]
          make_mission_not_tag_specific!(mission, tags, Property["owns", 112])
        when ["GEN"]
          # Most of them require you to be merchant republic as well
          make_mission_not_tag_specific!(mission, tags, Property["owns", 101])
        when ["USA"]
          next if name == "defend_the_american_colonies" # alt condition is impossible with this prereq
          make_mission_not_tag_specific!(mission, tags, Property["the_thirteen_colonies", PropertyList["type", "all", "owned_by", "ROOT"]])
        when ["BYZ"]
          # Pretty much all these missions make sense only as Byzantine missions, form Byzantium if you want them
          # However, we allow them if you're HLR and own Rome and Constantinople!
          make_mission_not_tag_specific!(mission, tags, Property["owns", 118], Property["owns", 151], Property["tag", "HLR"])
        when ["ARA"]
          next if name == "become_king_of_gonder" or name == "defeat_saruhan" # joke missions should stay a joke
          # Barcelona and Valencia
          make_mission_not_tag_specific!(mission, tags, Property["owns", 213], Property["owns", 220])
        when ["LIT"]
          make_mission_not_tag_specific!(mission, tags, Property["owns", 272])
        when ["KOR"]
          make_mission_not_tag_specific!(mission, tags, Property["owns", 735])
        when ["BOH"]
          make_mission_not_tag_specific!(mission, tags, Property["owns", 266])
        when ["BAV"]
          make_mission_not_tag_specific!(mission, tags, Property["owns", 65])
        when ["HAB"]
          make_mission_not_tag_specific!(mission, tags, Property["owns", 134])
        when ["POL"]
          # Krakow and Warsaw
          make_mission_not_tag_specific!(mission, tags, Property["owns", 262], Property["owns", 257])
        when ["PAP"]
          make_mission_not_tag_specific!(mission, tags, Property["owns", 118], Property["religion", "catholic"], Property["is_papal_controller", true])
        when ["SCO"]
          make_mission_not_tag_specific!(mission, tags, Property["owns", 248])
        when ["NED"]
          make_mission_not_tag_specific!(mission, tags, Property["owns", 97])
        when ["SWE"]
          make_mission_not_tag_specific!(mission, tags, Property["owns", 1])
        when ["DAN"]
          make_mission_not_tag_specific!(mission, tags, Property["owns", 12])
        when ["POR"]
          make_mission_not_tag_specific!(mission, tags, Property["owns", 227])
        when ["HSA"]
          if name == "end_sound_toll"
            # You have to be merchant republic for this as well
            make_mission_not_tag_specific!(mission, tags, Property["owns", 45], Property::NOT["tag", "DAN"])
          else
            warn "Unknown HSA mission"
          end
        when ["HUN"]
          # Pressburg and Buda
          make_mission_not_tag_specific!(mission, tags, Property["owns", 153], Property["owns", 154])
        when ["TUR"]
          # Edirne and Constantinople and 20 cities as these are very geographically ambitious goals
          if name == "muslim_asia_minor"
            make_mission_not_tag_specific!(mission, tags, Property["owns", 149], Property["owns", 151], Property["num_of_cities", 20], Property["religion_group", "muslim"])
          else
            make_mission_not_tag_specific!(mission, tags, Property["owns", 149], Property["owns", 151], Property["num_of_cities", 20])
          end
        when ["ENG", "GBR"]
          make_mission_not_tag_specific!(mission, tags, Property["owns", 236], Property["num_of_cities", 20])
        when ["CAS", "SPA"], ["SPA"]
          # Valladolid, Castilla La Vieja, Madrid, and Toledo are all historical capitals
          # Is Castile excluded from SPA-only missions on purpose, or just out of silliness?
          make_mission_not_tag_specific!(mission, tags, Property["owns", 214], Property["owns", 215], Property["owns", 217], Property["owns", 219], Property["num_of_cities", 20])
        when ["FRA", "RFR"], ["FRA"]
          make_mission_not_tag_specific!(mission, tags, Property["owns", 183], Property["num_of_cities", 20])
        when ["MOS", "RUS"], ["RUS"]
          # Moskva and Novgorod
          make_mission_not_tag_specific!(mission, tags, Property["owns", 295], Property["owns", 310],  Property["num_of_cities", 20])
        when []
          # p [name, tags, change_tag_references_to_root_references!(mission, "XXXXXX").to_a]

          # The following missions mention specific tags, need to be double checked:

          # ["take_from_rival_culture", [], ["PAP"]]
          # ["discover_mission", [], ["POR", "SPA", "CAS", "ENG", "GBR", "FRA"]]
          # ["establish_colony_mission", [], ["POR", "SPA", "CAS", "ENG", "GBR", "FRA"]]
          # ["annex_minor_mission", [], ["PAP", "JAP"]]
          # ["conquer_a_port", [], ["PAP"]]
          # ["conquer_neighbour", [], ["PAP", "JAP"]]
          # ["conquer_core", [], ["JAP"]]
          # ["protect_cultural_minority", [], ["PAP"]]
          # ["attack_prestigous_rival", [], ["JAP"]]
          # ["attack_weaker_rival", [], ["JAP"]]
          # ["sankin_kotai", [], ["JAP"]]
          # ["connect_the_prussian_lands", [], ["BRA", "PRU"]]
          # ["restore_holy_see", [], ["PAP", "SPA"]]
          # ["solidify_our_papal_relations", [], ["PAP"]]
          # ["control_the_pope", [], ["PAP"]]
          # ["fortify_the_eastern_border", [], ["SWE", "MOS", "RUS"]]

        else
          # p [name, tags, change_tag_references_to_root_references!(mission, "XXXXXX").to_a]
          # puts name, allow, ""
          # puts name, mission, ""
        end
      end
    end
  end
end

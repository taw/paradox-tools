require_relative "holy_sites"
require_relative "missions"

module FunAndBalanceCommon
  # This is seriously horrible, code started blobbing like France
  include FunAndBalanceFeatureHolySites
  include FunAndBalanceFeatureMissions


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
    patch_mod_file!("common/cb_types/00_cb_types.txt") do |node|
      node["cb_crusade"]["prerequisites"].delete "is_neighbor_of"
      node["cb_crusade"]["prerequisites"].prepend! Property::OR[
        "is_neighbor_of", "FROM",
        "any_country", PropertyList[
          "is_subject_of", "ROOT",
          "religion_group", "ROOT",
          "is_neighbor_of", "FROM",
          "cb_on_religious_enemies", true,
        ],
      ]
      node["cb_heretic"]["prerequisites"].delete "is_neighbor_of"
      node["cb_heretic"]["prerequisites"].prepend! Property::OR[
        "is_neighbor_of", "FROM",
        "any_country", PropertyList[
          "is_subject_of", "ROOT",
          "religion", "ROOT",
          "is_neighbor_of", "FROM",
          "cb_on_religious_enemies", true,
        ],
      ]
    end
    patch_mod_file!("common/wargoal_types/00_wargoal_types.txt") do |node|
      modify_node! node,
        ["take_province_ban", "badboy_factor", 1.0, 0.1]
    end
  end

  def each_country_primary_culture
    glob("common/cultures/*.txt").each do |path|
      parse(path).each do |group_name, group|
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
    cant_by_formed_by = %W[HLR PAP HIN MUG SPA FRA GER BYZ BUK ITA RUS SCA PER GBR PLC EGY VIJ INC]

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

      loc_tag = localization(tag)
      loc_culture = localization(culture)
      localization! "extra_formable_countries",
        "extra_formable_form_#{tag}_title" => "Form #{loc_tag}",
        "extra_formable_form_#{tag}_desc"  => "Our country is one true home of #{loc_culture} people, let's call it #{loc_tag}!"
    end
    create_mod_file! "decisions/extra_formable_countries.txt", PropertyList[
      *decisions
    ]
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
            religion["province"] ||= PropertyList[]
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
      menu_set_flag_option("enable_achievements", "Enable Achievements"),
      menu_clr_flag_option("enable_achievements", "Disable Achievements"),
      menu_set_flag_option("disable_holy_sites", "Disable Holy Sites"),
      menu_clr_flag_option("disable_holy_sites", "Enable Holy Sites"),
      menu_set_flag_option("disable_extra_missions", "Disable extra missions"),
      menu_clr_flag_option("disable_extra_missions", "Enable extra missions"),
      menu_set_flag_option("disable_extra_formable_countries", "Disable extra formable countries"),
      menu_clr_flag_option("disable_extra_formable_countries", "Enable extra formable countries"),
      menu_set_flag_option("enable_partial_westernization", "Enable partial westernization"),
      menu_clr_flag_option("enable_partial_westernization", "Disable partial westernization"),
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

  # Run after all other mission modifications
  def improve_mission_pool!
    modifiers = []
    patch_mod_files!("missions/*.txt") do |node|
      node.each do |name, mission|
        flag_name = "recently_cancelled_#{name}"
        modifiers << flag_name
        if mission["abort_effect"] == nil or mission["abort_effect"] == []
          mission["abort_effect"] = PropertyList[]
        end
        mission["abort_effect"].add! "FROM", PropertyList[
          "add_country_modifier", PropertyList[
            "name", flag_name,
            "duration", 365*25,
            "hidden", true,
          ],
        ]
        mission["chance"].add! "modifier", PropertyList[
          "factor", 0.01,
          "has_country_modifier", flag_name,
        ]
      end
    end
    create_mod_file! "common/event_modifiers/10_mission_pool.txt", PropertyList[
      *modifiers.map{|name| Property[name, PropertyList[]]},
    ]
  end
end

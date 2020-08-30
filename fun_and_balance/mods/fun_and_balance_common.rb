require_relative "base"
require_relative "../../eu4_trade_graph/trade_graph"

class FunAndBalanceCommonGameModification < EU4GameModification
  def anyone_can_form_byzantium!
    patch_mod_file!("decisions/RestoreByzantineEmpire.txt") do |node|
      node["country_decisions"]["restore_byzantine_empire"]["potential"].delete! do |prop|
        prop.key == "NOT" and (prop.val == PropertyList["tag", "HLR"] or prop.val == PropertyList["tag", "TUR"] or prop.val == PropertyList["tag", "ROM"])
      end
    end
  end

  def buff_awful_idea_groups!
    patch_mod_file!("common/ideas/00_basic_ideas.txt") do |node|
      node["maritime_ideas"]["merchant_marine"]["merchants"] = 1
      node["maritime_ideas"]["bonus"]["global_ship_trade_power"] = 0.5
      node["naval_ideas"]["boarding_parties"]["free_leader_pool"] = 1
    end
  end

  def cheaper_fort_maintenance!
    soft_patch_defines_lua!("fun_and_balance_cheaper_forts",
      ["NMilitary.FORTRESS_COST", 0.50, 0.25],
    )
  end

  def coalition_cb_defend_capital!
    patch_mod_file!("common/cb_types/00_cb_types.txt") do |node|
      # Make Punitive Wars into Take Capital
      node["cb_super_badboy"]["war_goal"] = "take_capital_punitive"
    end
    patch_mod_file!("common/wargoal_types/00_wargoal_types.txt") do |node|
      # Description doesn't match what it does
      node["take_capital_punitive"]["prov_desc"] = "ALL_CORES"
    end
  end

  def custom_nation_tweaks!
    soft_patch_defines_lua!("fun_and_balance_custom_nations",
      ["NNationDesigner.IDEAS_MAX_LEVEL", 4, 10],
      ["NNationDesigner.IDEAS_PERCENTAGE_LIMIT", 50, 100],
      ["NNationDesigner.MAX_DISTANCE_TO_OWNER_AREA", 400, 1000],
      ["NNationDesigner.RULER_BASE_SKILL", 2, 3]
    )
  end

  def disable_call_for_peace!
    patch_mod_file!("common/static_modifiers/00_static_modifiers.txt") do |node|
      node["call_for_peace"].delete!{true}
    end
  end

  def disable_end_game_tag_check_for_player!
    patch_mod_file!("common/scripted_triggers/00_scripted_triggers.txt") do |node|
      node["was_never_end_game_tag_trigger"] = PropertyList["OR", PropertyList["ai", false, "AND", node["was_never_end_game_tag_trigger"]]]
    end
    # However, we reeable it for Mughals into Delhi
    patch_mod_file!("decisions/DelhiNation.txt") do |node|
      node["country_decisions"]["sultan_of_delhi"]["potential"].add! "NOT", PropertyList["tag", "MUG"]
    end
  end

  def double_tradition_gain_from_battles!
    soft_patch_defines_lua!("fun_and_balance_more_tradition_from_battles",
      ["NMilitary.TRADITION_GAIN_LAND", 20, 40],
      ["NMilitary.TRADITION_GAIN_NAVAL", 40, 80]
    )
  end

  def everybody_can_can_claim_states!
    patch_mod_file!("common/government_reforms/00_government_reforms.txt") do |node|
      node["defaults_reform"]["claim_states"] = true
    end
  end

  def increase_rival_distance!
    soft_patch_defines_lua!("fun_and_balance_rival_distance",
      ["NAI.DIPLOMATIC_INTEREST_DISTANCE", 150, 200],
    )
  end

  def longer_cb_on_backstabbers!
    patch_mod_file!("common/cb_types/00_cb_types.txt") do |node|
      node["cb_dishonored_call"]["months"] = 120
    end
  end

  def lower_defender_ae!
    soft_patch_defines_lua!("fun_and_balance_lower_defender_ae",
      ["NDiplomacy.DEFENDER_AE_MULT", 0.75, 0.5],
    )
  end

  def lower_piracy_penalty!
    patch_mod_file!("common/opinion_modifiers/00_opinion_modifiers.txt") do |node|
      modify_node! node,
        ["pirated_us", "min", -100, -25]
    end
  end

  def lower_culture_conversion_penalty!
    patch_mod_file!("common/opinion_modifiers/00_opinion_modifiers.txt") do |node|
      modify_node! node,
        ["converted_our_culture", "opinion", -30, -5],
        ["converted_our_culture", "min", nil, -100]
    end
  end

  def rebalance_ottomans_constantinople!
    # Because Orthodox Ottomans are a thing now
    # And don't change culture/religion, that's both OP and not historical
    patch_mod_file!("decisions/Ottoman.txt") do |node|
      constantinople_decision = node["country_decisions"]["make_constantinople_capital"]
      constantinople_decision["allow"].delete! "primary_culture"
      constantinople_decision["allow"].delete! "religion_group"
      constantinople_decision["effect"][151].delete!("change_culture")
      constantinople_decision["effect"][151].delete!("change_religion")
    end
  end

  def more_building_slots!
    patch_mod_file!("common/static_modifiers/00_static_modifiers.txt") do |node|
      node["development"]["allowed_num_of_buildings"] = 0.2
    end
  end

  def no_naval_attrition!
    patch_mod_file!("common/technologies/dip.txt") do |node|
      node.find_all("technology").each_with_index do |tech, i|
        if i == 0
          tech["reduced_naval_attrition"] = true
        else
          tech.delete! "reduced_naval_attrition"
        end
      end
    end
  end

  def power_projection_tweaks!
    patch_mod_file!("common/powerprojection/00_static.txt") do |node|
      modify_node! node,
        ["eclipsed_rival",               "power",         10,  30],
        ["eclipsed_rival",               "max",           30, 100],
        ["declared_war_at_rival",        "yearly_decay",   1, 0.5],
        ["joined_war_against_rival",     "yearly_decay",   1, 0.5],
        ["refused_war_against_rival",    "yearly_decay",   1, 0.5],
        ["vassalized_rival",             "yearly_decay",   1, 0.5],
        ["took_province_from_rival",     "yearly_decay",   1, 0.5],
        ["rival_lost_province",          "yearly_decay",   1, 0.5],
        ["great_power_1",                "power",         25,  40],
        ["great_power_2",                "power",         22,  35],
        ["great_power_3",                "power",         20,  32],
        ["great_power_4",                "power",         18,  29],
        ["great_power_5",                "power",         16,  26],
        ["great_power_6",                "power",         14,  22],
        ["great_power_7",                "power",         12,  19],
        ["great_power_8",                "power",         10,  16],
        ["warned_rival",                 "power",          0,   5],
        ["guarantee_neighbour_of_rival", "power",          0,   5],
        ["current_age_power_projection", "power",          3,   5],
        ["last_age_power_projection",    "power",          3,   5],
        ["current_age_power_projection", "max",           21,  35],
        ["last_age_power_projection",    "max",           21,  35]
    end
  end

  def primary_greek_tag_is_byz!
    patch_mod_file!("common/cultures/00_cultures.txt") do |node|
      node.each do |group_name, group|
        next unless group_name == "byzantine"
        group["greek"]["primary"] = "BYZ"
      end
    end
  end

  def reduce_ai_cheats!
    patch_mod_file!("common/static_modifiers/00_static_modifiers.txt") do |node|
      modify_node! node,
        ["ai_nation", "free_leader_pool", 1, 0]
    end
  end

  def rebalance_war_exhaustion!
    patch_mod_file!("common/static_modifiers/00_static_modifiers.txt") do |node|
      modify_node! node,
        ["war", "war_exhaustion_cost", nil, 1],
        ["peace", "war_exhaustion", -0.1, -0.2]
    end
    soft_patch_defines_lua!("fun_and_balance_war_exhaustion",
        ["NAI.PEACE_WAR_EXHAUSTION_FACTOR", 1.0, 2.0],
    )
  end

  def religious_shift_decision!
    localization! "religious_shift",
      "religious_shift_title" => "Accept Religious Shift",
      "religious_shift_desc"  => "Religious beliefs of the ruling elite are shifting, as our $COUNTRY_RELIGION$ heritage is gradually losing ground to the religion of $CAPITAL$."

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
            "add_stability", -3,
            "add_country_modifier", PropertyList["name", "conversion_zeal", "duration", 3650],
          ],
          "ai_will_do", PropertyList["factor", 0],
        ]
      ]
    ]
  end

  def subject_religious_cbs!
    patch_mod_file!("common/cb_types/00_cb_types.txt") do |node|
      # Press vassal's religious CBs
      node["cb_crusade"]["prerequisites"].delete! "is_neighbor_of"
      node["cb_crusade"]["prerequisites"].prepend! Property::OR[
        "is_neighbor_of", "FROM",
        "any_country", PropertyList[
          "is_subject_of", "ROOT",
          "religion_group", "ROOT",
          "is_neighbor_of", "FROM",
          "cb_on_religious_enemies", true,
        ],
      ]
      node["cb_heretic"]["prerequisites"].delete! "is_neighbor_of"
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
  end

  def subject_tweaks!
    soft_patch_defines_lua!("fun_and_balance_subject_tweaks",
      ["NDiplomacy.VASSALIZE_BASE_DEVELOPMENT_CAP", 100, 300]
    )

    patch_mod_file!("common/opinion_modifiers/00_opinion_modifiers.txt") do |node|
      modify_node! node,
        ["opinion_annex_vassal", "min", nil, -100],
        ["supporting_independence", "opinion", 50, 100]
    end

    patch_mod_file!("common/subject_types/00_subject_types.txt") do |node|
      # Due to forward declarations, it's a bit weird
      types = {}
      node.each do |subject_type, subject|
        next if subject.empty?
        raise "Multiple declarations, wtf" if types[subject_type]
        types[subject_type] = subject
      end

      # to balance LD from relative power (also tariffs, mercantilism etc.)
      types["colony"]["relative_power_class"] = 1
      types["colony"]["base_liberty_desire"] = -25.0
    end
  end

  def holy_orders_for_all!
    patch_mod_files!("common/holy_orders/00_holy_orders.txt") do |node|
      ["jesuit_order", "dominican_order", "franciscan_order"].each do |k|
        node[k]["trigger"] =  PropertyList[
          "religion", "catholic",
        ]
      end
    end
  end

  def allow_peace_terms_for_all_cbs!
    patch_mod_file!("common/cb_types/00_cb_types.txt") do |node|
      node.each do |key, cb|
        # It mostly just makes those CBs unusable
        cb.delete! "attacker_disabled_po"
      end
    end

    patch_mod_file!("common/wargoal_types/00_wargoal_types.txt") do |node|
      node["humiliate_rotw"].delete! "allowed_provinces_are_eligible"
    end
  end

  # These changes look really extreme,
  # but 1.30.2 Ming doesn't come even close to exploding
  # even with very brutal looking values
  def rebalance_ming_crisis!
    # First, make sure crisis lasts at least 10 years, no cheating

    patch_mod_file!("common/disasters/ming_crisis.txt") do |node|
      crisis = node["ming_crisis"]
      modify_node! crisis,
        ["modifier", "global_unrest", 5, 10],
        ["modifier", "land_morale", -0.15, -0.30]
      crisis["can_end"]["custom_trigger_tooltip"] = PropertyList[
        "tooltip", "disaster_active_for_10_years_tooltip",
        "had_country_flag", PropertyList[
          "flag", "had_ming_crisis",
          "days", 3650,
        ]
      ]
    end

    patch_mod_file!("events/disaster_ming_crisis.txt") do |node|
      event = node.to_a.find{|prop| prop.key == "country_event" and prop.val["id"] == "ming_crisis.1"}
      event.val["immediate"].add! Property["set_country_flag", "had_ming_crisis"]
    end

    # Then make low mandate actually painful
    patch_mod_file!("common/static_modifiers/00_static_modifiers.txt") do |node|
      modify_node! node,
        ["negative_mandate", "global_unrest", 5, 10],
        ["negative_mandate", "global_manpower_modifier", -0.5, -1.0],
        ["negative_mandate", "mercenary_manpower", -0.5, -1.0],
        ["negative_mandate", "fire_damage_received", 0.5, 1.0],
        ["negative_mandate", "shock_damage_received", 0.5, 1.0]
      end
  end

  ###################################################################
  ### DISABLED STUFF, NOT ENABLED IN RELEASE                      ###
  ### (only for ones I'm still evaluating)                        ###
  ###################################################################

  # Not needed 1.30+ as corruption from territories is gone
  def double_corruption_slider!
    warn "Disabled code. Do not enable in release. #{__FILE__}:#{__LINE__}"
    soft_patch_defines_lua!("fun_and_balance_corruption",
      ["NCountry.CORRUPTION_COST", 0.05, 0.10],
    )
    patch_mod_file!("common/static_modifiers/00_static_modifiers.txt") do |node|
      node["root_out_corruption"]["yearly_corruption"] = -2.0
    end
  end

  # So many things changed, need to verify this still makes sense
  # (also it makes F&B incompatible with too many things)
  def rebalance_conversion_rates!
    warn "Disabled code. Do not enable in release. #{__FILE__}:#{__LINE__}"
    patch_mod_file!("common/static_modifiers/00_static_modifiers.txt") do |node|
      modify_node! node,
        ["base_values", "global_missionary_strength", 0.02, 0.01],
        ["base_values", "global_heretic_missionary_strength", nil, 0.01]
    end

    patch_mod_file!("common/religions/00_religion.txt") do |node|
      node.each do |group_name, group|
        group.each do |name, religion|
          next if ["crusade_name", "defender_of_faith", "can_form_personal_unions", "center_of_religion", "flags_with_emblem_percentage", "flag_emblem_index_range", "harmonized_modifier", "ai_will_propagate_through_trade"].include?(name)
          if group_name == "pagan"
            religion["province"] ||= PropertyList[]
            religion["province"]["local_missionary_strength"] = 0.03
          else
            religion["province"].delete!("local_missionary_strength") if religion["province"]
          end
        end
      end
    end
  end

  ###################################################################
  ### EXPERIMENTAL STUFF, NOT ENABLED IN RELEASE                  ###
  ###################################################################

  def bring_tech_groups_back!
    warn "Experimental code. Do not enable in release. #{__FILE__}:#{__LINE__}"

    patch_mod_file!("common/institutions/00_Core.txt") do |node|
      node.each do |name, institution|
        if name != "feudalism"
          institution["penalty"] = 0.25
        end

        # Any non-Europe start really messes up with historical tech spread
        if institution["can_start"]
          institution["can_start"].add! "continent", "europe"
        end
      end

      # TODO: fix node[*]["embracement_speed"]
    end

    soft_patch_defines_lua!("fun_and_balance_tech",
      ["NCountry.EMBRACE_INSTITUTION_COST", 2.5, 5.0],
      ["NCountry.POWER_MAX", 999, 3000],
      # For institution balance testing:
      # ["NGame.END_DATE", '"1821.1.2"', '"1750.1.2"'],
    )

    groups = [
      # ["western",         0.00, 0.00, 0.00],
      # ["high_american",   0.00, 0.00, 0.00],
      ["eastern",         0.10, 0.10, 0.20, -0.10, 0.20], # avg 15 %
      ["ottoman",         0.20, 0.20, 0.40, -0.20, 0.40], # avg 25 %
      ["muslim",          0.30, 0.30, 0.60, -0.30, 0.60], # avg 40 %
      ["indian",          0.40, 0.40, 0.80, -0.40, 0.80], # avg 60 %
      ["chinese",         0.45, 0.45, 0.90, -0.45, 0.90], # avg 60 %
      ["east_african",    0.45, 0.45, 0.90, -0.45, 0.90], # avg 60 %
      ["central_african", 0.60, 0.60, 1.20, -0.60, 1.20], # avg 80 %
      ["sub_saharan",     0.60, 0.60, 1.20, -0.60, 1.20], # avg 80 %
      ["nomad_group",     0.60, 0.60, 1.20, -0.60, 1.20], # avg 80 %
      ["mesoamerican",    0.75, 0.75, 1.50, -0.75, 1.50], # avg 100 %
      ["andean",          0.75, 0.75, 1.50, -0.75, 1.50], # avg 100 %
      ["north_american",  1.00, 1.00, 2.00, -0.90, 2.00], # avg 135 %
      ["south_american",  1.00, 1.00, 2.00, -0.90, 2.00], # avg 135 %
    ]

    node = PropertyList[]
    groups.each do |tech, adm, dip, mil, spread, emb|
      node.add! "has_#{tech}", PropertyList[
        "potential", PropertyList["technology_group", tech],
        "trigger", PropertyList["technology_group", tech],
        "adm_tech_cost_modifier", adm,
        "dip_tech_cost_modifier", dip,
        "mil_tech_cost_modifier", mil,
        "global_institution_spread", spread,
        "embracement_cost", emb,
      ]
    end

    create_mod_file! "common/triggered_modifiers/01_tech_groups.txt", node
    # TODO: localization
  end

  def rebalance_unrest!
    warn "Experimental code. Do not enable in release. #{__FILE__}:#{__LINE__}"

    patch_mod_file!("common/static_modifiers/00_static_modifiers.txt") do |node|
      # node["prosperity"]["local_unrest"] = -2
      node["devastation"]["local_unrest"] = 4
      # node["non_accepted_culture"]["local_unrest"] = 4
      # node["non_accepted_culture_republic"]["local_unrest"] = -2
      node["under_siege"]["local_unrest"] = 4
      node["occupied"]["local_unrest"] = 4
    end

    patch_mod_files!("common/rebel_types/*.txt") do |node|
      node.each do |name, rebels|
        if rebels["religion"]
          rebels["spawn_chance"]["factor"] *= 10
          rebels["defect_delay"] = 60 # from 120
          rebels["defection"] = "religion" # from "none"
        elsif name == "particularist_rebels"
          # Do not defect
          rebels["spawn_chance"]["factor"] /= 2
        elsif name == "nationalist_rebels"
          rebels["defect_delay"] = 36 # from 60

          # accepted culture does not block it
          req = rebels["spawn_chance"].find_all("modifier").find{|x| x["factor"] == 0.01} or raise
          req["owner"] = PropertyList[
            "primary_culture", "ROOT",
            "OR", PropertyList[
              "NOT", PropertyList["has_reform", "celestial_empire"],
              "has_country_modifier", "the_mandate_of_heaven",
              "AND", PropertyList[
                "has_reform", "celestial_empire",
                "has_dlc", "Mandate of Heaven",
                "imperial_mandate", 80,
              ],
            ],
          ]
          rebels["spawn_chance"].add! "modifier", PropertyList[
            "factor", 0.1,
            "owner", PropertyList[
              "culture_group", "ROOT",
            ],
          ]
        else
          # warn "What are: #{name}? #{rebels["defect_delay"]} #{rebels["defection"]}"
          # It's OK for the rest to not defect
        end
      end
    end
  end

  def rebalance_unrest_experimental!
    warn "Experimental code. Do not enable in release. #{__FILE__}:#{__LINE__}"

    # This is experimental code:
    create_mod_file! "common/triggered_modifiers/02_age_rebels.txt", PropertyList[
      "rebels_age_of_discovery", PropertyList[
        "potential", PropertyList["current_age", "age_of_discovery"],
        "trigger", PropertyList["current_age", "age_of_discovery"],
        "tolerance_heathen", -2,
        # "tolerance_own", 2,
      ],
      "rebels_age_of_reformation", PropertyList[
        "potential", PropertyList["current_age", "age_of_reformation"],
        "trigger", PropertyList["current_age", "age_of_reformation"],
        "tolerance_heretic", -2,
        # "tolerance_own", 2,
      ],
      "rebels_age_of_absolutism", PropertyList[
        "potential", PropertyList["current_age", "age_of_absolutism"],
        "trigger", PropertyList["current_age", "age_of_absolutism"],
        "global_unrest", 2,
      ],
      "rebels_age_of_revolutions", PropertyList[
        "potential", PropertyList["current_age", "age_of_revolutions"],
        "trigger", PropertyList["current_age", "age_of_revolutions"],
        "global_unrest", 4,
      ],
    ]
    # TODO: localization
    # triggered extra unrest
  end

  def all_religions_propagate_by_trade!
    warn "Experimental code. Do not enable in release. #{__FILE__}:#{__LINE__}"

    patch_mod_file!("common/trading_policies/00_trading_policies.txt") do |node|
      node["propagate_religion"]["can_select"].delete! "religion_group"
      node["propagate_religion"]["can_maintain"].delete! "religion_group"
    end
  end

  # In principle this could move them between files
  def move_culture!(culture, from_group, to_group)
    patch_mod_file! "common/cultures/00_cultures.txt" do |node|
      from_node = node[from_group] or raise "Can't find #{from_group}"
      to_node = node[to_group] or raise "Can't find #{to_group}"
      culture_node = from_node[culture] or raise "Can't find #{culture} in #{from_group}"
      from_node.delete! culture
      to_node.add! culture, culture_node
    end
  end
end

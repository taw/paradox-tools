require_relative "base"

class CK2TweaksGameModification < CK2GameModification
  def fix_gavelkind!
    # Bonus is not applied correctly and is far less than 30% claimed
    # Increase it to balance things out a bit
    override_defines_lua!("gavelkind",
      "NDiplomacy.GAVELKIND_MAX_SIZE_BONUS" => "0.50"
    )
  end

  def no_multiple_empires!
    # This is AI dumb
    override_defines_lua!("no_multiple_empire",
      "NAI.MAX_EMPIRE_TITLES_TO_CREATE" => 1,
    )
  end

  def reduce_wrong_gov_type_penalties!
    # This punishes feudalizing tribals way too much
    override_defines_lua!("wrong_gov_type",
      "NCharacter.WRONG_GOV_FORM_TAX_MOD"  => -0.50,
      "NCharacter.WRONG_GOV_FORM_LEVY_MOD" => -0.50,
    )
  end

  def reduce_revocation_timer!
    # This is exploit-prevention silliness, but at 12 months
    # it gets in way of legit revocation
    # (like when infidel vassal grants titles)
    override_defines_lua!("reduce_revocation_timer",
      "NTitle.MIN_REVOKE_MONTHS_AFTER_GRANT" => 1,
    )
  end

  def allow_intermarriage!
    patch_mod_files!("common/religions/*.txt") do |node|
      node.each do |group_name, group|
        group.each do |religion_name, religion|
          next unless religion.is_a?(PropertyList)
          religion.delete! "intermarry"
          religion_groups.each do |g|
            religion.add! "intermarry", g
          end
        end
      end
    end
  end

  def allow_heir_designation!
    patch_mod_files!("common/religions/*.txt") do |node|
      node.each do |group_name, group|
        next if group_name == "muslim"
        group.each do |religion_name, religion|
          next unless religion.is_a?(PropertyList)
          religion["has_heir_designation"] = true
        end
      end
    end
  end

  def pagans_can_go_feudal!
    # Otherwise AI never will
    patch_mod_file!("decisions/realm_decisions.txt") do |node|
      %W[
        convert_to_feudalism_indep
        convert_to_feudalism_vassal
        convert_to_republic_indep
      ].each do |decision|
        allow = node["decisions"][decision]["allow"]
        allow_orig = allow.dup
        allow.delete!{|prop|
          prop == Property[
            "custom_tooltip", PropertyList[
                "text", "TT_NOT_UNREFORMED_PAGAN",
                "hidden_tooltip", PropertyList["OR", PropertyList[
                  "NOT", PropertyList["religion_group", "pagan_group"],
                  "is_reformed_religion", true,
                ],
              ],
            ]
          ]
        }
        raise "Can't find condition" if allow == allow_orig
      end
    end
  end

  def preserve_culture_buildings!
    patch_mod_files!("common/buildings/*.txt") do |node|
      node.each do |category, buildings|
        buildings.each do |name, building|
          potential = building["potential"]
          next unless potential
          next if potential == []
          next unless potential["FROM"].to_s =~ /culture/
          culture_rules = potential["FROM"]

          if culture_rules.size == 1
            province_rule = culture_rules.to_a[0]
          else
            province_rule = Property::AND[*culture_rules.to_a]
          end

          potential.delete! "FROM"
          potential.add! Property::OR[
            "FROM", culture_rules,
            province_rule,
            "FROMFROM", PropertyList["has_building", name],
          ]
        end
      end
    end
  end

  def fast_de_jure_drift!
    override_defines_lua!("de_jure_drift",
      "NTitle.DE_JURE_ASSIMILATION_YEARS" => 50,
      "NTitle.EMPIRE_DE_JURE_ASSIMILATION_YEARS" => 20,
    )
  end

  def seduce_any_religion!
    patch_mod_file!("decisions/way_of_life_decisions.txt") do |node|
      allow = node["targetted_decisions"]["seduce_decision"]["allow"]
      allow_orig = allow.dup
      allow.delete!{|prop|
        prop == Property::OR["religion_group", "FROM", "is_liege_or_above", "FROM"]
      }
      raise "Can't find condition" if allow == allow_orig
    end
  end

  def hunie_can_always_seduce!(node)
    fix_node = false # Do this after fixing children
    node.each do |key, val|
      if key == "has_focus" and val == "focus_seduction"
        fix_node = true
      end
      hunie_can_always_seduce!(val) if val.is_a?(PropertyList)
    end
    if fix_node
      # More complex patching but generates better looking diffs
      # Maybe this should get API too?
      i = node.list.index{|key,val| key == "has_focus" and val == "focus_seduction"}
      node.instance_eval{@list}[i] = ["OR", PropertyList[
        "has_focus", "focus_seduction",
        "trait", "hunie",
      ]]
    end
  end

  def create_minimal_hunie_trait!
    create_mod_file! "common/traits/99_hunie_traits.txt", PropertyList[
      "hunie", PropertyList[
        "inherit_chance", 100,
      ],
    ]
    create_mod_file! "interface/hunie.gfx", PropertyList[
      "spriteTypes", PropertyList[
        "spriteType", PropertyList[
          "name", "GFX_trait_hunie",
          "texturefile", "gfx/traits/seductress.tga",
          "noOfFrames", 1,
          "norefcount", true,
          "effectFile", "gfx/FX/buttonstate.lua",
        ],
      ],
    ]
    localization!("hunie_trait",
      "hunie" => "Hunie",
      "hunie_desc" => "A total hunie",
    )
  end

  # As high as allowed by your technology
  def setup_sensible_ai_for_demesne_laws!
    patch_mod_file!("common/laws/demesne_laws.txt") do |node|
      laws_to_fix = %W[
        feudal_contract
        feudal_tax
        city_contract
        city_tax
        temple_contract
        temple_tax
        iqta_contract
        iqta_tax
      ]
      laws_to_fix.each do |law|
        node["laws"]["#{law}_0"]["ai_will_do"] = PropertyList[
          "factor", 0,
        ]
        node["laws"]["#{law}_1"]["ai_will_do"] = PropertyList[
          "factor", 1,
          "modifier", PropertyList["factor", 0, "has_law", "#{law}_2"],
          "modifier", PropertyList["factor", 0, "has_law", "#{law}_3"],
        ]
        node["laws"]["#{law}_2"]["ai_will_do"] = PropertyList[
          "factor", 1,
          "modifier", PropertyList["factor", 0, "has_law", "#{law}_3"],
        ]
        node["laws"]["#{law}_3"]["ai_will_do"] = PropertyList[
          "factor", 1,
        ]
      end
    end
  end

  def allow_everyone_river_access!
    override_defines_lua!("major_rivers",
      "NMilitary.MAX_RIVER_MOVEMENT_FORT_LEVEL" => 1000.0,
    )
    patch_mod_files!("common/religions/*.txt") do |node|
      node.each do |group_name, group|
        group.each do |religion_name, religion|
          next unless religion.is_a?(PropertyList)
          religion["allow_rivermovement"] = true
        end
      end
    end
  end

  def divine_blood_full_fertility!
    override_defines_lua!("divine_blood",
      "NReligion.DIVINE_BLOOD_FERTILITY_MULT" => 1.0,
    )
  end

  # If this had a timeout it would be fine, but it's ridiculous lasting forever
  def no_foreign_conqueror_penalty!
    patch_mod_file!("common/opinion_modifiers/00_opinion_modifiers.txt") do |node|
      node["opinion_foreign_conqueror"].delete! "opinion"
    end
  end

  def increase_vassal_limit!
    # The entire mechanic is dumb - it either does nothing
    # (short of preventing North Korea mode)
    # or is ridiculously punishing - and unlike with demesne limit there's no reasonable workaround
    #
    # duke / great duke / king / emperor
    # Vanilla base:  10/15/20/ 30  +5/centralization
    #         mod:   25/40/50/100  +5/centralization
    # Conclave base   8/11/15/ 20  +5/centralization +2/council law
    #          mod:  20/30/40/ 60  +5/centralization +4/council law
    #
    # However Conclave gives big bonuses for giving council powers
    override_defines_lua!("vassal_limit",
      "NDiplomacy.VASSAL_LIMIT_DUKE_MULT" => 25.0,
      "NDiplomacy.VASSAL_LIMIT_GREAT_DUKE_BONUS" => 15.0,
      "NDiplomacy.VASSAL_LIMIT_KING_MULT" => 50.0,
      "NDiplomacy.VASSAL_LIMIT_EMPEROR_MULT" => 100.0,
      "NDiplomacy.CONCLAVE_VASSAL_LIMIT_DUKE_MULT" => 20.0,
      "NDiplomacy.CONCLAVE_VASSAL_LIMIT_GREAT_DUKE_BONUS" => 10.0,
      "NDiplomacy.CONCLAVE_VASSAL_LIMIT_KING_MULT" => 40.0,
      "NDiplomacy.CONCLAVE_VASSAL_LIMIT_EMPEROR_MULT" => 60.0,
      # Much lower penalties for going over the limit, but exact formula is unclear
      "NDiplomacy.VASSAL_LIMIT_LEVY_MULTIPLIER" => 0.2,
      "NDiplomacy.VASSAL_LIMIT_TAX_MULTIPLIER"  => 0.2,
    )
    patch_mod_file!("common/laws/ze_council_power_laws.txt") do |node|
      node["laws"].each do |law_name, law|
        law["vassal_limit"] = 4 if law["vassal_limit"] == 2
      end
    end
  end

  def increase_trade_post_limit!
    # Retinues and mercs got nerfed hard, why not keep at least this high?
    patch_mod_files!("common/buildings/00_buildings.txt") do |node|
      node["family_palace"]["fp_mansion_1"]["max_tradeposts"] = 10
      node["family_palace"]["fp_mansion_2"]["max_tradeposts"] = 10
      node["family_palace"]["fp_mansion_3"]["max_tradeposts"] = 10
      node["family_palace"]["fp_mansion_4"]["max_tradeposts"] = 10
    end
    override_defines_lua!("trade_posts",
      "NEconomy.MAX_TRADE_POSTS_BASE" => 10,
    )
  end

  def allow_feasts_at_minor_wars!
    # Optimal way would be to allow them in case of minor wars
    # (like being secondary partner, or peasant revolt)
    # but no major war, but for now let's just do this
    #
    # Hard to say in how many other places this needs to be updated
    # Diwali events seem to be checking if vassals are at war,
    # and if we are then all of them will be etc.
    # Oh well

    feasts = [
      "feast_0",
      "summer_fair",
      "hold_grand_hunt",
      "hold_tiger_hunt",
      "catholic_pilgrimage",
      "go_on_hajj",
      "observe_ramadan",
      "hold_nerge",
      "hold_blot",
      "hold_ukon_juhla",
      "hold_uzgavenes",
      "hold_jarilo",
      "celebrate_passover",
      "hold_diwali_feast_hindu",
      "hold_diwali_feast_buddhist",
      "hold_diwali_feast_jain",
      "hold_diwali_feast_kali_puja",
      "hold_zun_feast",
      "hold_a_epic_tournament",
      "hold_a_furusiyya",
      "hold_nomad_wargames",
    ]

    patch_mod_files!("decisions/*.txt") do |node|
      node.each do |category, decisions|
        next unless category == "decisions"
        decisions.each do |name, decision|
          next unless feasts.include?(name)
          next unless decision["allow"]["war"] == false
          decision["allow"].delete! Property["war", false]
        end
      end
    end

    # 2.7.0 fix
    patch_file!("events/mnm_hermetics_events.txt") do |content|
      content.gsub("random 70", "random = 70")
    end

    patch_mod_files!("events/*.txt") do |node|
      node.each do |category, event|
        trigger = event["trigger"]
        next if trigger.nil? or trigger == []
        next unless trigger["has_character_modifier"] == "holding_large_feast" or
                    trigger["has_character_modifier"] == "holding_grand_hunt"

        if trigger["war"] == false
          trigger.delete! Property["war", false]
        elsif event["trigger"]["war"] == true
          raise unless event["id"] == 72112 or event["id"] == 36089
        end
      end
      # 72112 - cancel feast because war
      # 36089 - cancel hunt because war
      node.delete!{|prop| prop.val["id"] == 72112 or prop.val["id"] == 36089}
    end
  end

  # Can't just delete, as there are references to them in events etc.
  def remove_all_anachronistic_factions!
    patch_mod_file!("common/objectives/00_factions.txt") do |node|
      good_factions = [
        "faction_independence",
        "faction_claimant",
        "faction_antiking",
      ]
      bad_factions = node.keys - good_factions
      good_factions.each do |faction_name|
        faction = node[faction_name]
        # Increase their chances, not sure if it even does much
        faction["chance"]["factor"] *= 5
      end
      bad_factions.each do |faction_name|
        faction = node[faction_name]
        faction["potential"] = PropertyList["always", false]
      end
    end
  end

  # This is very speculative, no idea if it does anything or not
  # (unlike let's say law changes which are pretty proven)
  def rebalance_faction_priorities!
    # AI faction choices drastically affect how things develop.
    # Rebalancing faction priorities can lead to much more interesting choices
    patch_mod_file!("common/objectives/00_factions.txt") do |node|
      # Not allowed unless Germanic culture
      # It would probably be better to disallow this succession type otherwise
      node["faction_succ_feudal_elective"]["potential"].add! Property::OR[
        "culture_group", "north_germanic",
        "culture_group", "central_germanic",
        "culture_group", "west_germanic",
      ]
      node["faction_succ_feudal_elective"]["allow_join"]["ROOT"].add! Property::OR[
        "culture_group", "north_germanic",
        "culture_group", "central_germanic",
        "culture_group", "west_germanic",
      ]
      # Allow elective->gavelkind.
      # I hate elective all over the place, create some counterbalance to it
      node["faction_succ_gavelkind"]["chance"].delete! do |prop|
        prop.key == "modifier" and prop.val["has_law"] == "succ_feudal_elective"
      end
      # Make nomads a more eager to split
      node["faction_independence"]["membership"].add! "modifier", PropertyList[
        "factor", 10,
        "is_nomadic", true,
      ]
      # Nomads OP, forcing them to go independent instead will weaken them
      node["faction_overthrow"]["potential"] = PropertyList["always", false]
      # This faction is full retard. Want a title, get a claim.
      node["faction_powerful_vassal_takeover"]["potential"] = PropertyList["always", false]
    end
  end

  def allow_joining_all_wars!
    patch_mod_files!("common/cb_types/*.txt") do |node|
      node.each do |name, cb|
        cb["can_ask_to_join_war"] = true
        cb["attacker_can_call_allies"] = true
        cb["defender_can_call_allies"] = true
      end
    end
  end

  def more_plots!
    # More republican plots for start
    # Should do more fun plots later
    #
    # The code is a bit awkward
    patch_mod_file!("common/objectives/00_plots.txt") do |node|
      seize_plot = node["plot_seize_trade_post"]
      seize_plot["allow"]["trade_post_owner"].delete! Property[
        "num_of_trade_post_diff",
        PropertyList["character", "FROM", "value", 1],
      ]
      seize_plot["allow"]["trade_post_owner"]["OR"].add! "de_facto_liege", "FROM"
      seize_plot["potential"].delete! "is_merchant_republic"
    end
  end

  def dont_call_duke_kings_ever!
    # There's also a setting in common/governments/* but it doesn't seem to work
    patch_mod_files!("common/cultures/00_cultures.txt") do |node|
      node.each do |group_name, group|
        group.each do |name, culture|
          next unless culture.is_a?(PropertyList)
          culture.delete! "dukes_called_kings"
        end
      end
    end
  end

  # Start dates in extended timeline are bugged as hell,
  # but it's still better than nothing
  def extend_timeline!
    patch_mod_file!("common/defines.txt") do |node|
      node["start_date"] = Date.parse("0769.1.1")
    end
  end

  # Vanilla map is really really dumb
  # It would take a lot of work to make it sensible, so just some easy code
  #
  # The most annoying crap is empire of Italy
  def fix_de_jure_map!
    # patch_mod_file!("common/landed_titles/landed_titles.txt") do |node|
    #   require 'pry'; binding.pry
    # end
    patch_mod_file!("history/titles/k_italy.txt") do |node|
      node[Date.parse("0100.1.1")] = PropertyList["de_jure_liege", "e_byzantium"]
      node[Date.parse("0867.1.1")] = PropertyList["de_jure_liege", "e_hre"]
      node.instance_eval{ @entries.sort! }
    end
    patch_mod_file!("history/titles/k_venice.txt") do |node|
      node[Date.parse("0100.1.1")] = PropertyList["de_jure_liege", "e_byzantium"]
      node.instance_eval{ @entries.sort! }
    end
  end

  # Culture conversion has extremely strict restrictions,
  # enable it even when they're not met, at lower chance
  # This will increase total rate by a lot, as one silly province will bloke
  # conversion futher down
  def easier_culture_conversion!
    patch_mod_file!("events/culture_conversion_events.txt") do |node|
      node.find_all("province_event").each do |event|
        if event["id"] == 55000
          # There were also rules about not depopulated, but who cares about that
          event["trigger"].delete! "any_neighbor_province"
          # Speed it up by 2x base
          event["mean_time_to_happen"]["months"] /= 2
          event["mean_time_to_happen"].add! "modifier", PropertyList[
            "factor", 4.0,
            # Convert only if same culture as neighbouring province and its owner
            # This was hard requirement, make it just 4x slower if not met
            "NOT", PropertyList[
              "any_neighbor_province", PropertyList[
                "has_owner", true,
                "ROOT", PropertyList["owner", PropertyList["culture", "PREVPREV"]],
                "owner", PropertyList["ROOT", PropertyList["owner", PropertyList["culture", "PREVPREV"]]],
              ],
            ],
          ]
        elsif event["id"] == 55001
          # Conquest culture capital conversion. Just speed it up a bit.
          event["mean_time_to_happen"]["months"] /= 2
        end
      end
    end
  end

  # yields parent of node
  def deep_search(node, path=[], &blk)
    node.each do |key, val|
      if val.is_a?(PropertyList)
        deep_search(val, [*path, key], &blk)
      end
      yield(node, [*path, key])
    end
  end

  def easier_title_creation!
    patch_mod_file!("common/landed_titles/landed_titles.txt") do |titles|
      # No idea what it even does, other than screwing with setting up vassal Hungary
      # when it gets accidentally destroyed
      titles["e_carpathia"]["k_hungary"]["allow"] = PropertyList["always", true]

      deep_search(titles) do |node, path|
        next unless path[-1] == "allow"
        allow = node["allow"]
        # title = path[-2]
        # These are generally sensible
        next if allow == PropertyList["always", false]
        next if allow == PropertyList["always", true]
        next if allow == PropertyList["is_republic", true]
        next if node["controls_religion"]
        next if node["mercenary"]

        # AI not being allowed to create title is really silly
        # especially in shattered world style games
        if allow["hidden_tooltip"] and
           allow["hidden_tooltip"]["OR"] and
           allow["hidden_tooltip"]["OR"]["ai"] == false
          allow.delete! "hidden_tooltip"
          node["allow"] = PropertyList["always", true] if allow.empty?
          next
        end
      end
    end
  end

  # They are just way too silly, slowing down their reinforcements
  # will at least let them be weak sometimes instead of instantly rebounding
  # to full strength
  def nerf_nomads!
    override_defines_lua!("nerf_nomads",
      "NNomad.HORDE_REINFORCE_MULTIPLIER" => 1,
    )
  end

  def stronger_claims_on_rebels!
    # Regexp is actually more sensible than path expressions which would be needed here
    patch_file!("common/cb_types/00_cb_types.txt") do |content|
      content.gsub("add_weak_pressed_claim", "add_pressed_claim")
    end

    patch_file!("events/plot_events.txt") do |content|
      content.gsub("add_weak_pressed_claim", "add_pressed_claim")
    end
  end

  def allow_more_commanders!
    # Contrary to what game claims, it's not possible to assign marshal,
    # so it's really hidden -1
    override_defines_lua!("more_commanders",
      "NMilitary.MAX_COMMANDERS_BARON"   => 1,  #  1,
      "NMilitary.MAX_COMMANDERS_COUNT"   => 3,  #  2,
      "NMilitary.MAX_COMMANDERS_DUKE"    => 6,  #  4,
      "NMilitary.MAX_COMMANDERS_KING"    => 9,  #  6,
      "NMilitary.MAX_COMMANDERS_EMPEROR" => 12, #  8,
    )
  end

  def nerf_demand_conversion!
    override_defines_lua!("nerf_demand_conversion",
      "NDiplomacy.DEMAND_RELIGIOUS_CONVERSION_INTERACTION_PIETY" => 25,
    )
  end

  # Based on http://steamcommunity.com/sharedfiles/filedetails/?id=477406895
  def extra_cb_de_jure_duchy_conquest!
    cb = PropertyList["emf_dejure_duchy_claim", PropertyList[
      "name", "CB_NAME_EMF_DEJURE_DUCHY_CLAIM",
      "war_name", "WAR_NAME_EMF_DEJURE_DUCHY_CLAIM",
      "sprite", 16,
      "truce_days", 1825,
      "hostile_against_others", true,
      "is_permanent", true,
      "check_de_jure_tier", "DUKE",
      "can_ask_to_join_war", false,
      "can_use_title", PropertyList[
        "OR", PropertyList[
          "empire", PropertyList["holder", "ROOT"],
          "kingdom", PropertyList["holder", "ROOT"],
        ],
        "FROM", PropertyList["num_of_realm_counties", PropertyList[
          "value", 2,
          "title", "PREV",
        ]],
        "OR", PropertyList[
          "FROM", PropertyList["ai", false],
          "ROOT", PropertyList["ai", false],
          "ROOT", PropertyList["is_merchant_republic", true],
          "NOT", PropertyList["FROM", PropertyList[
            "is_merchant_republic", true,
            "capital_scope", PropertyList["county", PropertyList["de_jure_liege_or_above", "PREVPREVPREV"]],
          ]],
        ],
      ],
      "is_valid_title", PropertyList[
        "FROM", PropertyList["or", PropertyList[
          "has_landed_title", "PREV",
          "any_realm_title", PropertyList["de_jure_liege_or_above", "PREVPREV"],
        ]],
        "or", PropertyList[
          "kingdom", PropertyList["holder", "ROOT"],
          "empire", PropertyList["holder", "ROOT"],
        ],
      ],
      "on_success_title", PropertyList[
        "ROOT", PropertyList["vassalize_or_take_under_title", PropertyList[
          "title", "PREV",
          "enemy", "FROM",
        ]],
        "hidden_tooltip", PropertyList["if", PropertyList[
          "limit", PropertyList[
            "not", PropertyList["FROM", PropertyList["is_liege_or_above", "ROOT"]],
            "has_holder", true,
            "holder_scope", PropertyList["or", PropertyList[
              "character", "FROM",
              "is_liege_or_above", "FROM",
            ]],
          ],
          "usurp_title", PropertyList[
            "target", "ROOT",
            "type", "claim",
          ],
        ]],
        "any_attacker", PropertyList[
          "limit", PropertyList["character", "ROOT"],
          "participation_scaled_prestige", 150,
        ],
        "any_attacker", PropertyList[
          "limit", PropertyList["not", PropertyList["character", "ROOT"]],
          "hidden_tooltip", PropertyList["participation_scaled_prestige", 150],
        ],
      ],
      "on_fail", PropertyList[
        "ROOT", PropertyList["prestige", -150],
        "any_defender", PropertyList[
          "limit", PropertyList["character", "FROM"],
          "participation_scaled_prestige", 75,
        ],
        "any_defender", PropertyList[
          "limit", PropertyList["not", PropertyList["character", "FROM"]],
          "hidden_tooltip", PropertyList["participation_scaled_prestige", 75],
        ],
      ],
      "on_reverse_demand", PropertyList[
        "ROOT", PropertyList[
          "prestige", -300,
          "transfer_scaled_wealth", PropertyList[
            "to", "FROM",
            "value", 4.0,
          ],
        ],
        "any_defender", PropertyList[
          "limit", PropertyList["character", "FROM"],
          "participation_scaled_prestige", 150,
        ],
        "any_defender", PropertyList[
          "limit", PropertyList["not", PropertyList["character", "FROM"]],
          "hidden_tooltip", PropertyList["participation_scaled_prestige", 150],
        ],
      ],
      "attacker_ai_victory_worth", PropertyList["factor", -1],
      "attacker_ai_defeat_worth", PropertyList["factor", 100],
      "defender_ai_victory_worth", PropertyList["factor", -1],
      "defender_ai_defeat_worth", PropertyList["factor", 100],
      "ai_will_do", PropertyList["factor", 1],
    ]]

    create_mod_file! "common/cb_types/99_de_jure_duchy_cb.txt", cb
    localization!("abolish_title_cb",
      "CB_NAME_EMF_DEJURE_DUCHY_CLAIM" => "De Jure Claim on [Title.GetBaseName]",
      "WAR_NAME_EMF_DEJURE_DUCHY_CLAIM" => "$ORDER$$FIRST_ADJ$-$SECOND_ADJ$ De Jure War over $OTHER_TITLE$",
      "emf_dejure_duchy_claim_desc" => "The $TITLE$ is, de jure, a vassal of $CLAIMANT$'s, which is cause enough for war.",
    )
  end


  # Based on http://steamcommunity.com/sharedfiles/filedetails/?id=639295392
  def extra_cb_abolish_title!
    cb = PropertyList["abolish_title", PropertyList[
      "name", "SM_ABOLISH",
      "war_name", "WAR_NAME_SM_ABOLISH",
      "sprite", 6,
      "truce_days", 3650,
      "is_permanent", true,
      "can_ask_to_join_war", true,
      "hostile_against_others", false,
      "prestige_cost", 100,
      "check_all_titles", true,
      "can_use", PropertyList[
        "ROOT", PropertyList[
          "NOT", PropertyList["is_liege_or_above", "FROM"],
          "any_realm_title", PropertyList["de_jure_liege_or_above", "FROM"],
        ],
        "FROM", PropertyList["is_landed", true],
        "OR", PropertyList[
          "AND", PropertyList[
            "ROOT", PropertyList["NOT", PropertyList["same_realm", "FROM"]],
            "FROM", PropertyList["independent", true],
          ],
          "ROOT", PropertyList["same_realm", "FROM"],
        ],
      ],
      "can_use_title", PropertyList[
        "is_primary_type_title", false,
        "temporary", false,
        "higher_tier_than", "COUNT",
        "ROOT", PropertyList[
          "any_realm_title", PropertyList["de_jure_liege_or_above", "PREVPREV"],
          "any_demesne_title", PropertyList["PREVPREV", PropertyList["any_de_jure_vassal_title", PropertyList["title", "PREVPREV"]]],
        ],
      ],
      "is_valid", PropertyList["always", true],
      "is_valid_title", PropertyList["FROM", PropertyList["has_landed_title", "PREV"]],
      "on_add", [],
      "on_success_title", PropertyList[
        "FROM", PropertyList["destroy_landed_title", "PREV"],
        "if", PropertyList[
          "limit", PropertyList["tier", "duke"],
          "FROM", PropertyList["prestige", -200],
        ],
        "if", PropertyList[
          "limit", PropertyList["tier", "king"],
          "FROM", PropertyList["prestige", -400],
        ],
        "if", PropertyList[
          "limit", PropertyList["tier", "emperor"],
          "FROM", PropertyList["prestige", -800],
        ],
      ],
      "on_success", PropertyList[
        "ROOT", PropertyList["prestige", 100],
        "any_attacker", PropertyList[
          "limit", PropertyList["not", PropertyList["character", "ROOT"]],
          "hidden_tooltip", PropertyList["participation_scaled_prestige", 100],
        ],
        "FROM", PropertyList["piety", -100],
      ],
      "on_fail", PropertyList[
        "FROM", PropertyList["prestige", 100],
        "any_defender", PropertyList[
          "limit", PropertyList["NOT", PropertyList["character", "FROM"]],
          "hidden_tooltip", PropertyList["participation_scaled_prestige", 100],
        ],
      ],
      "on_reverse_demand", PropertyList[
        "ROOT", PropertyList["transfer_scaled_wealth", PropertyList[
          "to", "FROM",
          "value", 4.0,
        ]],
        "FROM", PropertyList["prestige", 200],
        "any_defender", PropertyList[
          "limit", PropertyList["not", PropertyList["character", "FROM"]],
          "hidden_tooltip", PropertyList["participation_scaled_prestige", 100],
        ],
      ],
      "attacker_ai_victory_worth", PropertyList["factor", -1],
      "attacker_ai_defeat_worth", PropertyList["factor", 100],
      "defender_ai_victory_worth", PropertyList["factor", -1],
      "defender_ai_defeat_worth", PropertyList["factor", 100],
      "ai_will_do", PropertyList["factor", 1],
    ]]

    create_mod_file! "common/cb_types/99_abolish_title.txt", cb
    localization!("abolish_title_cb",
      "SM_ABOLISH" => "Abolish [Title.GetBaseName]",
      "WAR_NAME_SM_ABOLISH" => "War to Abolish $OTHER_TITLE$",
      "abolish_title_desc" => "War to directly challenge the dejure right of this ruler and show the title does not have any authority or power as it claims to. On success the title will be declared forfeit.",
    )
  end

  def rebalance_conclave!
    patch_mod_file!("common/job_titles/00_job_titles.txt") do |node|
      node.each do |job_title, job|
        job["opinion_effect"] += 15
      end
    end
    patch_mod_file!("common/laws/ze_council_power_laws.txt") do |node|
      node["laws"].each do |law_name, law|
        if law_name =~ /1/
          law["vassal_opinion"] = 3
        end
      end
    end
  end

  def make_holy_wars_convert!
    # This code is quite nasty, but it's hard to patch more precisely
    patch_mod_file!("decisions/conversion_decisions.txt") do |node|
      convert = node["decisions"]["convert_to_attacker_religion"]
      # Anyone can press the button
      convert["potential"] = PropertyList[
        "is_playable", true,
        "controls_religion", false,
        "war", true,
        "any_war", PropertyList[
          "defender", PropertyList["character", "ROOT"],
          "attacker", PropertyList["NOT", PropertyList["religion", "ROOT"]],
          "OR", PropertyList[
            "using_cb", "crusade",
            "using_cb", "religious",
            "using_cb", "muslim_invasion",
            "using_cb", "buddhist_holy_war",
            "using_cb", "pagan_holy_war",
          ],
        ],
      ]
      # Make AI 10x as likely to press the button
      convert["ai_will_do"] = PropertyList[
        "factor", 1,
        "modifier", PropertyList[
          "factor", 0,
          "NOT", PropertyList["any_war", PropertyList[
            "defender", PropertyList["character", "ROOT"],
            "attacker", PropertyList["NOT", PropertyList["religion", "ROOT"]],
            "OR", PropertyList[
              "using_cb", "crusade",
              "using_cb", "religious",
              "using_cb", "muslim_invasion",
              "using_cb", "buddhist_holy_war",
              "using_cb", "pagan_holy_war",
            ],
            "war_score", 50,
            "thirdparty_title_scope", PropertyList["ROOT", PropertyList["primary_title", PropertyList["title", "PREVPREV"]]],
          ]],
        ],
        "modifier", PropertyList[
          "factor", 2,
          "any_war", PropertyList[
            "defender", PropertyList["character", "ROOT"],
            "attacker", PropertyList["NOT", PropertyList["religion", "ROOT"]],
            "OR", PropertyList[
              "using_cb", "crusade",
              "using_cb", "religious",
              "using_cb", "muslim_invasion",
              "using_cb", "buddhist_holy_war",
              "using_cb", "pagan_holy_war",
            ],
            "war_score", 75,
            "thirdparty_title_scope", PropertyList["ROOT", PropertyList["primary_title", PropertyList["title", "PREVPREV"]]],
          ],
        ],
      ]
    end
    # make it forced?
    # patch_mod_file!("common/cb_types/00_cb_types.txt") do |node|
    #   # religious
    # end
  end

  def easier_seduction!
    # You can seduce family, exes
    # seducing spouses doesn't work due to events
    # what about consorts?
    # lustful makes you bisexual
    patch_mod_file!("decisions/way_of_life_decisions.txt") do |node|
      seduce = node["targetted_decisions"]["seduce_decision"]
      seduce["potential"] = PropertyList[
        "is_marriage_adult", true,
        "NOT", PropertyList["character", "FROM"],
        "NOT", PropertyList["trait", "incapable"],
        "prisoner", false,
        "NOT", PropertyList["is_lover", "FROM"],
        "NOT", PropertyList["any_spouse", PropertyList["character", "FROM"]],
        "OR", PropertyList[
          "AND", PropertyList[
            "NOT", PropertyList["same_sex", "FROM"],
            "OR", PropertyList[
              "FROM", PropertyList["trait", "lustful"],
              "FROM", PropertyList["NOT", PropertyList["trait", "homosexual"]],
            ],
            "OR", PropertyList[
              "trait", "lustful",
              "NOT", PropertyList["trait", "homosexual"],
            ]
          ],
          "AND", PropertyList[
            "same_sex", "FROM",
            "OR", PropertyList[
              "FROM", PropertyList["trait", "lustful"],
              "FROM", PropertyList["trait", "homosexual"],
            ],
            "OR", PropertyList[
              "trait", "lustful",
              "trait", "homosexual",
            ]
          ],
        ],
      ]
    end
    # Less stressful to have multiple lovers
    patch_mod_file!("events/wol_lover_events.txt") do |node|
      event = node.find_all("character_event").find{|ev| ev["id"] == "WoL.1150"}
      event["mean_time_to_happen"]["months"] *= 5
    end
  end

  # Tanisty sounded like a good idea, but it's just too random in practice
  # Enable enatic and enatic-cognatic
  def enable_more_succession_laws!
    patch_mod_file!("common/laws/succession_laws.txt") do |node|
      #succession = node["succession_laws"]
      #succession["succ_tanistry"]["potential"] = succession["succ_gavelkind"]["potential"]
      gender = node["gender_laws"]
      gender["enatic_cognatic_succession"]["potential"] = gender["true_cognatic_succession"]["potential"]
      gender["enatic_cognatic_succession"]["allow"] = gender["true_cognatic_succession"]["allow"]
      gender["enatic_succession"]["potential"] = gender["true_cognatic_succession"]["potential"]
      gender["enatic_succession"]["allow"] = gender["true_cognatic_succession"]["allow"]
    end
  end

  def fix_council_positions!
    # The bullshit of enemy being simultaneously too weak for glory hounds
    # and too numerous for pragmatists
    patch_mod_file!("common/council_voting/01_pragmatist_pattern.txt") do |node|
      yes = node["pragmatist_pattern_for"]["declare_war_interaction"]
      yes["NOT"]["custom_tooltip"]["hidden_tooltip"]["liege"] =
        PropertyList["is_primary_war_defender", true]
      no = node["pragmatist_pattern_against"]["declare_war_interaction"]
      no_busy = no["OR"].find_all("custom_tooltip").find{|nd| nd["text"] == "pattern_pragmatist_were_already_busy_fighting_tooltip"}
      no_busy["hidden_tooltip"]["liege"] = PropertyList["is_primary_war_defender", true]
    end
  end

  def more_battle_captives!
    #         <duke  duke king emperor
    # Vanilla:  1.000    0.5   0.25  0.125
    # BP Mod:  50.000   50.0  50.00 50.000
    # This:    50.000   25.0  12.50  6.250
    patch_mod_file!("events/battle_events.txt") do |node|
      imprison_event = node.find_all("character_event").find{|e| e["id"] == 250}
      mods = imprison_event["weight_multiplier"]
      mods.add! "modifier", PropertyList["factor", 50, "always", true]
    end
  end

  def fix_hostile_supply!
    # It's supposed to apply to enemy, actually applies to allies!
    override_defines_lua!("hostile_supply",
      "NMilitary.ENEMY_SETTLEMENT_SUPPLY_BONUS" => 0.0,
    )
  end

  def allow_settle_tribe_job!
    patch_mod_file!("common/job_actions/00_job_actions.txt") do |node|
      settle = node["action_settle_tribe"]
      settle["potential"].delete! Property["FROM", PropertyList["is_tribal", true]]
      # Doesn't need demesne
      settle["trigger"] = PropertyList[
        "any_province_lord", PropertyList[
          "OR", PropertyList[
            "character", "FROM",
            "is_liege_or_above", "FROM",
          ],
        ],
        "NOT", PropertyList["culture", "FROM"],
      ]
    end

    patch_mod_file!("events/job_steward.txt") do |node|
      event = node.find_all("character_event").find{|e| e["id"] == 925}
      event["trigger"] = PropertyList[
        "has_job_action", "action_settle_tribe",
        "NOT", PropertyList["location", PropertyList["culture", "ROOT"]],
        "location", PropertyList["owner", PropertyList["same_realm", "ROOT"]],
      ]
    end
  end

  def remove_viceroyalty_opinion_penalty!
    patch_mod_file!("common/opinion_modifiers/00_opinion_modifiers.txt") do |node|
      node.keys.grep(/opinion_granted_other_.*_vice_royalty/).each do |key|
        node[key]["opinion"] = 0
      end
    end
  end

  def viceroyalties_can_use_gavelkind!
    # I hate patches like this
    patch_mod_file!("common/laws/succession_laws.txt") do |node|
      succession = node["succession_laws"]
      gavelkind = succession["succ_gavelkind"]
      gavelkind["potential"]["holder_scope"] = PropertyList[
       "OR", PropertyList[
         "independent", true,
         "NOT", PropertyList["any_liege", PropertyList["holy_order", true]],
       ],
       "NOT", PropertyList["religion_group", "muslim"],
       "is_merchant_republic", false,
       "is_patrician", false,
       "in_revolt", false,
      ]
      # Also ban it for viceroyalties or weird stuff happens
      primogeniture = succession["succ_primogeniture"]
      primogeniture["potential"]["holder_scope"].add! Property[
        "OR", PropertyList[
          "independent", true,
          "NOT", PropertyList["any_demesne_title", PropertyList["is_vice_royalty", true]],
        ],
      ]
    end
  end

  def open_societies!
    patch_mod_file!("common/societies/00_societies.txt") do |node|
      # Indians can join both
      # Code is a bit dubious
      ### Hermetics
      hermetics = node["hermetics"]
      show = hermetics["show_society"]
      join = hermetics["can_join_society"]
      populate = hermetics["startup_populate"]["trigger"].to_a.find{|x| x.inspect =~ /christian/}
      show["OR"].add! Property["religion_group", "indian_group"]
      join["OR"].add! Property["religion_group", "indian_group"]
      populate.val.add! Property["religion_group", "indian_group"]

      ### Kali Cult
      kali = node["the_cult_of_kali"]
      show = kali["show_society"]
      populate = kali["startup_populate"]["trigger"]

      show["OR"].delete! Property["religion", "hindu"]
      show["OR"].delete! Property["trait", "secretly_hinduism"]
      show["OR"].add! Property["true_religion_group_indian_group_trigger", true]
      populate.delete! Property["true_religion_hinduism_trigger", true]
      populate.add! Property["true_religion_group_indian_group_trigger", true]
    end

    patch_mod_file!("common/scripted_triggers/00_scripted_triggers.txt") do |node|
      node["has_cult_of_kali_prerequisites"] = PropertyList[
        "has_common_devilworship_prerequisites", true,
        "true_religion_group_indian_group_trigger", true,
      ]
    end

    patch_mod_file!("decisions/mnm_society_decisions.txt") do |node|
      cult_of_kali_recruit = node.to_a.map{|n| n.val["cult_of_kali_recruit"] }.find(&:itself)
      cult_of_kali_recruit["allow"].delete! Property["religion", "hindu"]
      cult_of_kali_recruit["allow"].add! Property["true_religion_group_indian_group_trigger", true]
    end
  end

  def fix_regency!
    patch_mod_file!("common/minor_titles/00_minor_titles.txt") do |node|
      node["title_appointed_regent"]["allowed_to_grant"].delete! Property["has_regent", false]
    end
  end

  def more_zoom!
    override_defines_lua!("more_zoom",
      "NFrontend.MAX_ZOOM_LEVEL" => "4000",
    )
  end

  def no_random_coas!
    patch_mod_files!("common/religions/*.txt") do |node|
      node.each do |group_name, group|
        # is this enough?
        group.delete! Property["has_coa_on_barony_only", false]
      end
    end
  end

  def unhappy_late_vassals!
    # Triple them all
    patch_mod_file!("common/laws/ze_crown_laws.txt") do |node|
      node["de_jure_laws"]["vassal_wars_law_1"]["feudal_opinion"] = -15
      node["de_jure_laws"]["vassal_wars_law_2"]["feudal_opinion"] = -30
    end
    patch_mod_file!("common/laws/ze_demesne_laws.txt") do |node|
      node["laws"]["ze_administration_laws_2"]["feudal_opinion"] = -30
    end
  end

  def increase_cap!(event)
    # bleh...
    s = ParadoxModFileSerializer.serialize(event["immediate"])
    s = s.gsub("match_max = 5000", "match_max = 20000")
    s = s.gsub("match_max = 10000", "match_max = 40000")
    event["immediate"] = ParadoxModFile.new(string: s).parse!
  end

  def adventurers_cap!
    patch_mod_file!("events/adventures_the_old_gods.txt") do |node|
      events = node.find_all("character_event")
      increase_cap!(events.find{|e| e["id"] == "TOG.1202"})
      increase_cap!(events.find{|e| e["id"] == "TOG.1212"})
    end

    patch_mod_file!("events/family_events.txt") do |node|
      events = node.find_all("character_event")
      increase_cap!(events.find{|e| e["id"] == 37015})
    end
  end

  def much_less_attriton!
    override_defines_lua!("much_less_attrition",
      "NMilitary.ATTRITION_LEVEL_FACTOR" => 0.05,
      "NMilitary.ATTRITION_LEVEL_FACTOR_50_OVER" => 0.1,
      "NMilitary.ATTRITION_LEVEL_FACTOR_100_OVER" => 0.2,
    )
  end

  def remove_siege_defense_bonus!
    # I seriously can't patch it because <CULTURE> clashes with < > etc.
    patch_file!("common/technology.txt") do |content|
      content.sub!("SIEGE_DEFENCE = 1.0", "") or raise
    end
  end

  def fix_eu4_converter_merchant_republics!
    # I moved eu4 converter dlc files to weird place
    # maybe best to merge it with everything else?
    # Easier to regexp CSVs than parse and redo
    content = resolve("dlc/dlc030/eu4_converter/government_table.csv").read
    content.sub!("gov_oligarchic_republic;oligarchic_republic",
                 "gov_oligarchic_republic;merchant_republic")
    content.sub!("gov_oligarchic_republic;oligarchic_republic",
                 "administrative_republic;merchant_republic")
    create_file!("eu4_converter/government_table.csv", content)
  end

  def apply!
    ### General fixes:
    extra_cb_de_jure_duchy_conquest!
    extra_cb_abolish_title!
    allow_intermarriage!
    fix_gavelkind!
    reduce_wrong_gov_type_penalties!
    seduce_any_religion!
    preserve_culture_buildings!
    pagans_can_go_feudal!
    setup_sensible_ai_for_demesne_laws! # Obsolete with Conclave but whatever, just keep it
    fast_de_jure_drift! # This is now in game rules, but maybe custom values are better?
    allow_everyone_river_access!
    no_foreign_conqueror_penalty!
    increase_vassal_limit!
    increase_trade_post_limit!
    allow_feasts_at_minor_wars!
    no_multiple_empires!
    more_plots!
    dont_call_duke_kings_ever!
    stronger_claims_on_rebels!
    fix_de_jure_map!
    easier_culture_conversion! # could be too much...
    easier_title_creation!
    allow_more_commanders!
    nerf_demand_conversion!
    easier_seduction!
    fix_council_positions!
    more_battle_captives!
    fix_hostile_supply!
    allow_settle_tribe_job!
    reduce_revocation_timer!
    divine_blood_full_fertility!
    open_societies!
    fix_regency!
    more_zoom!
    no_random_coas!
    fix_eu4_converter_merchant_republics!
    # TODO: de jure drift by title_decisions

    ### Specific things for specific campaign, kept for reference:
    create_minimal_hunie_trait!
    allow_heir_designation!
    # rebalance_faction_priorities!
    allow_joining_all_wars!
    # nerf_nomads!
    # rebalance_conclave!
    remove_all_anachronistic_factions!
    make_holy_wars_convert!
    enable_more_succession_laws!
    remove_viceroyalty_opinion_penalty!
    viceroyalties_can_use_gavelkind!
    # extend_timeline!

    # Trying to make late game work:
    unhappy_late_vassals!
    adventurers_cap!
    much_less_attriton!
    remove_siege_defense_bonus!
  end
end

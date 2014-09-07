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
            "NOT", PropertyList["is_subject_of", "ROOT"],
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
        cond.add! "NOT", PropertyList["stability", 0]

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

    patch_mod_file!("events/GenericOnActionEvents.txt") do |node|
      node.find_all("country_event").each do |event|
        if event["id"] == 610 # integrating vassal
          event["option"]["add_republican_tradition"] *= 0.3
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
    @game.glob("common/ideas/*.txt").each do |ideas_file|
      patch_mod_file!(ideas_file) do |node|
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
  end

  def dont_destroy_buildings_on_conquest!
    @game.glob("common/buildings/*.txt").each do |path|
      patch_mod_file!(path) do |node|
        node.each_value do |building|
          if building["spare_on_core"] == true
            building.delete "spare_on_core"
            building["destroy_on_conquest"] = false
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

  def reverse_burgundy_nerfs!
    patch_mod_file!("events/FlavorBUR.txt") do |node|
      node.delete_if do |key, val|
        key == "country_event" and val["id"] =~ /\Aflavor_bur\.(1|2|3|4|5|6|7|19)\z/
      end
    end

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
end

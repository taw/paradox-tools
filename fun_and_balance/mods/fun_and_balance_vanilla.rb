require_relative "fun_and_balance_common"

class FunAndBalanceGameModification < FunAndBalanceCommonGameModification
  def apply!
    anyone_can_form_byzantium!
    buff_awful_idea_groups!
    coalition_cb_defend_capital!
    custom_nation_tweaks!
    disable_call_for_peace!
    # disable_end_game_tag_check_for_player! # already end game rule
    double_tradition_gain_from_battles!
    everybody_can_can_claim_states!
    increase_rival_distance!
    lower_defender_ae!
    lower_opinion_penalties!
    rebalance_ottomans_constantinople!
    more_base_relations!
    more_building_slots!
    no_naval_attrition!
    power_projection_tweaks!
    primary_greek_tag_is_byz!
    rebalance_war_exhaustion!
    religious_shift_decision!
    subject_religious_cbs!
    subject_tweaks!
    # trade_map_fixes! # 1.35 fixed it?
    allow_peace_terms_for_all_cbs!
    holy_orders_for_all! # it's a minor feature
    improve_religious_rebels!
    buff_support_rebels!
    buff_covert_actions!
    # fix_culture_groups! # disabled in 1.35 as vanilla fixed Slovaks, needs reevaluation for Turkish
    fix_localization!
    # remove_all_natives! # maybe 1.34 removed the need for it?
    declare_war_in_regency!
    fix_roman_empire_decision!
    remove_all_straits!
    mandate_of_heavens_for_all_asians!

    # Evaluating for reals:
    eurocentric_institutions!
    reduce_ahead_of_time_penalty!
    revanchism_is_bad!

    # Experimental:
    # more_aggressive_ai!
    # allow_more_estate_privileges! # needs UI mod to display more than 5
    # enable_more_idea_groups!
    # rebalance_unrest!
    # rebalance_unrest_experimental!
    # all_religions_propagate_by_trade!
    # super_lucky_nations!
    # super_unlucky_nations!

    # Obsolete
    # cheaper_fort_maintenance! # not sure this is the right way tbh
    # longer_cb_on_backstabbers! # this is meaningless anyway
    # rebalance_ming_crisis! # no longer needed in 1.33?
    # nerf_tribal_development! # 1.31, we no longer need it
    # make_hegemony_achievable!
    # reduce_ai_cheats! # at this point it was just free leader, and leaders are plentiful in recent patches anyway

    soft_patch_defines_lua!(
      "fun_and_balance",
      ["NAI.PEACE_TIME_EARLY_FACTOR", 0.75, 0.50],
      ["NCountry.MAX_IDEA_GROUPS_FROM_SAME_CATEGORY", 0.5, 1.0],
      ["NCountry.PS_CHANGE_CULTURE", 10, 5],
      ["NCountry.PS_MOVE_CAPITAL", 200, 100],
      ["NCountry.PS_MOVE_TRADE_PORT", 200, 100],
      ["NAI.SUPPORT_INDEPENDENCE_DESIRE_TOO_MANY_RELATIONS", -20, 0],
      ["NDiplomacy.MIN_RELATIONS_TO_SUPPORT_INDEPENDENCE", -25, -50],
      ["NDiplomacy.PEACE_COST_GOLD_MAX", 5, 10],
    )
  end

  def more_base_relations!
    patch_mod_file!("common/static_modifiers/00_static_modifiers.txt") do |node|
      modify_node! node,
        ["base_values", "diplomatic_upkeep", 4, 6]
    end
  end

  # 1.35 redid trade map?
  def trade_map_fixes!
    rewrite_trade_map! do |edges|
      edges - [
        ["polynesia_node", "panama"],
        ["philippines", "polynesia_node"],
        ["mexico", "panama"],
      ] + [
        ["panama", "mexico"],
        # ["patagonia", "lima"], # would be nice, but not working without drawing a path
        ["polynesia_node", "philippines"],
      ]
    end
  end

  # Many decisions and events assume certain cultures are in certain groups,
  # so any drastic changes might need extra work
  #
  # * delete stupid Carpathian culture group, move everyone to West Slavic or Balkan
  # * create separate Turkish group for Turks
  #
  # Other things that might need fixing:
  # * Finland/Sampi/Karelian/Estonian are split
  # * Greeks joining Balkan group?
  def fix_culture_groups!
    # move_culture! "slovak", "carpathian", "west_slavic" # This is done in 1.35
    move_culture! "transylvanian", "carpathian", "south_slavic"
    move_culture! "romanian", "carpathian", "south_slavic"
    move_culture! "hungarian", "carpathian", "south_slavic"

    patch_mod_file!("common/cultures/00_cultures.txt") do |node|
      # Looks like I get million errors if I do this, so instead:
      # node.delete! "carpathian"
      hun = node["south_slavic"]["hungarian"]
      node["carpathian"].add! "old_hungarian", PropertyList[
        "dynasty_names", hun["dynasty_names"],
        "male_names", hun["male_names"],
        "female_names", hun["female_names"],
      ]

      turkish = node["turko_semitic"]["turkish"]
      node["turko_semitic"].delete! "turkish"
      node.add! "turkish_g", PropertyList[
        "graphical_culture", "muslimgfx",
        "turkish", turkish,
      ]
    end

    patch_mod_file!("missions/EMP_Hungarian_Missions.txt") do |node|
      mission = node["emp_hun_bulwark_of_christianity_branch"]["emp_hun_bulwark_of_christianity"]
      culture_check = mission["trigger"]["if"]["custom_trigger_tooltip"]["NOT"]["any_country"]["OR"]
      culture_check.add! "culture", "turkish"
    end

    patch_mod_file!("common/government_reforms/01_government_reforms_monarchies.txt") do |node|
      bonuses = node["mughal_government"]["assimilation_cultures"]
      raise unless bonuses["carpathian"] ==  PropertyList["mercenary_cost", -0.1]
      bonuses.delete! "carpathian"
      bonuses["south_slavic"]["mercenary_cost"] = -0.1
    end

    patch_mod_file!("common/government_names/00_government_names.txt") do |node|
      ssm = node["south_slavic_monarchy"]["trigger"]
      ssm.add! "NOT", PropertyList["culture", "transylvanian"]
      ssm.add! "NOT", PropertyList["culture", "hungarian"]
      ssm.add! "NOT", PropertyList["culture", "romanian"]

      ssr = node["south_slavic_republic"]["trigger"]
      ssr.add! "NOT", PropertyList["culture", "transylvanian"]
      ssr.add! "NOT", PropertyList["culture", "hungarian"]
      ssr.add! "NOT", PropertyList["culture", "romanian"]
    end

    # I don't care, but it generates endless errors
    # Just keep them matching vanilla

    patch_file!("customizable_localization/00_customizable_localization_FR.txt") do |node|
      node.gsub("OR  {", " OR = {")
    end

    patch_mod_files! "customizable_localization/*.txt" do |node|
      node.find_all("defined_text").each do |dt|
        dt.find_all("text").each do |t|
          if t["trigger"] ==  PropertyList["culture_group", "carpathian"]
            t["trigger"] = PropertyList["OR", PropertyList[
              "culture", "slovak",
              "culture", "hungarian",
              "culture", "transylvanian",
              "culture", "romanian",
            ]]
          end
          raise if t["trigger"].inspect =~ /carpathian/
        end
      end
    end
  end

  def fix_localization!
    localization! "replace/ZZZ_localization_fixes",
      "BYZ" => "East Rome",
      "BYZ_ADJ" => "East Roman",
      "BYZ_ADJ2" => "East Roman",
      "south_slavic" => "Balkan",
      "turkish_g" => "Turkish"
  end
end

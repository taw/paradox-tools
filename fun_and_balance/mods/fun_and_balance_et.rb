require_relative "fun_and_balance_common"

class FunAndBalanceETGameModification < FunAndBalanceCommonGameModification
  def apply!
    anyone_can_form_byzantium!
    buff_awful_idea_groups!
    cheaper_fort_maintenance!
    coalition_cb_defend_capital!
    custom_nation_tweaks!
    disable_call_for_peace!
    disable_end_game_tag_check_for_player!
    double_tradition_gain_from_battles!
    everybody_can_can_claim_states!
    increase_rival_distance!
    longer_cb_on_backstabbers!
    lower_defender_ae!
    lower_piracy_penalty!
    lower_culture_conversion_penalty!
    rebalance_ottomans_constantinople!
    more_base_relations!
    more_building_slots!
    no_naval_attrition!
    power_projection_tweaks!
    primary_greek_tag_is_byz!
    reduce_ai_cheats!
    rebalance_war_exhaustion!
    religious_shift_decision!
    subject_religious_cbs!
    subject_tweaks!
    trade_map_fixes!
    allow_peace_terms_for_all_cbs!
    holy_orders_for_all!
    rebalance_ming_crisis!

    # ET specific
    fix_adopt_secularism_decision!

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

  def fix_adopt_secularism_decision!
    patch_mod_file!("decisions/et_conversion_decisions.txt") do |node|
      node["country_decisions"]["adopt_secularism"]["allow"].add! "is_subject", false
    end
  end

  # It changes from age to age
  def more_base_relations!
    patch_mod_file!("common/static_modifiers/00_static_modifiers.txt") do |node|
      modify_node! node,
        ["base_values", "diplomatic_upkeep", 3, 7]
    end
  end

  def trade_map_fixes!
    rewrite_trade_map! do |edges|
      edges - [
        ["philippines", "panama"],
        ["mexico", "panama"],
      ] + [
        ["panama", "mexico"],
      # ["patagonia", "lima"], # already there
      ]
    end
  end
end

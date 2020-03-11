require_relative "fun_and_balance_common"

class FunAndBalanceGameModification < FunAndBalanceCommonGameModification
  def apply!
    anyone_can_form_byzantium!
    buff_awful_idea_groups!
    can_convert_in_territories!
    cheaper_fort_maintenance!
    coalition_cb_defend_capital!
    custom_nation_tweaks!
    # disable_burgundy_inheritance! # it goes away in 1.30
    disable_call_for_peace!
    disable_end_game_tag_check_for_player!
    double_corruption_slider!
    double_tradition_gain_from_battles!
    everybody_can_can_claim_states!
    fewer_mercs!
    imperial_ban_cb_low_ae!
    increase_rival_distance!
    longer_cb_on_backstabbers!
    lower_defender_ae!
    lower_piracy_penalty!
    lower_culture_conversion_penalty!
    make_constantinople_capital_ignore_culture_and_religion!
    merchant_republic_province_limit_remove!
    more_base_relations!
    more_building_slots!
    no_naval_attrition!
    power_projection_tweaks!
    primary_greek_tag_is_byz!
    rebalance_conversion_rates!
    reduce_ai_cheats!
    reduce_we_only_at_peace!
    religious_shift_decision!
    subject_religious_cbs!
    subject_tweaks!
    trade_map_fixes!
    rebalance_hre!
    allow_peace_terms_for_all_cbs!
    holy_orders_for_all!
    unlimited_states!

    # Experimental:
    rebalance_unrest!
    rebalance_unrest_experimental!
    # all_religions_propagate_by_trade!

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
        ["base_values", "diplomatic_upkeep", 4, 8]
    end
  end

  def trade_map_fixes!
    rewrite_trade_map! do |edges|
      edges - [
        ["philippines", "panama"],
        ["mexico", "panama"],
      ] + [
        ["panama", "mexico"],
        ["patagonia", "lima"],
      ]
    end
  end
end

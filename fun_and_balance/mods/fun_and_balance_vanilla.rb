require_relative "fun_and_balance_common"

class FunAndBalanceGameModification < FunAndBalanceCommonGameModification
  def apply!
    buff_awful_idea_groups!
    can_convert_in_territories!
    cheaper_fort_maintenance!
    coalition_cb_defend_capital!
    custom_nation_tweaks!
    disable_burgundy_inheritance!
    disable_call_for_peace!
    disable_end_game_tag_check_for_player!
    double_tradition_gain_from_battles!
    everybody_can_can_claim_states!
    fewer_mercs!
    longer_cb_on_backstabbers!
    lower_defender_ae!
    more_base_relations!
    more_building_slots!
    no_naval_attrition!
    power_projection_tweaks!
    rebalance_conversion_rates!
    reduce_ai_cheats!
    reduce_we_only_at_peace!
    religious_shift_decision!
    subject_religious_cbs!
    trade_map_fixes!

    soft_patch_defines_lua!("fun_and_balance",
      ["NAI.DIPLOMATIC_INTEREST_DISTANCE", 150, 200],
      ["NAI.PEACE_TIME_EARLY_FACTOR", 0.75, 0.50],
      ["NCountry.LIBERTY_DESIRE_HISTORICAL_FRIEND", -50, -30],
      ["NCountry.LIBERTY_DESIRE_HISTORICAL_RIVAL", 50, 30],
      ["NCountry.MAX_IDEA_GROUPS_FROM_SAME_CATEGORY", 0.5, 1.0],
      ["NCountry.MERCHANT_REPUBLIC_SIZE_LIMIT", 20, 10000],
      ["NCountry.PS_CHANGE_CULTURE", 10, 5],
      ["NCountry.PS_MOVE_CAPITAL", 200, 100],
      ["NCountry.PS_MOVE_TRADE_PORT", 200, 100],
      ["NDiplomacy.ANNEX_DIP_COST_PER_DEVELOPMENT", 8, 4],
      ["NDiplomacy.INTEGRATE_VASSAL_MIN_YEARS", 10, 20],
      ["NDiplomacy.VASSALIZE_BASE_DEVELOPMENT_CAP", 100, 300],
    )

    anyone_can_form_byzantium!
    fix_opinions!
    fix_wargoals!
    patch_religion!
    subject_tweaks!
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

require_relative "fun_and_balance_common"

class FunAndBalanceETGameModification < FunAndBalanceCommonGameModification
  def fix_adopt_secularism_decision!
    patch_mod_file!("decisions/et_conversion_decisions.txt") do |node|
      node["religion_decisions"]["adopt_secularism"]["allow"].add! "is_subject", false
    end
  end

  def apply!
    anyone_can_form_byzantium!
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
    make_constantinople_capital_ignore_culture_and_religion!
    more_building_slots!
    no_naval_attrition!
    power_projection_tweaks!
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

    # Extended timeline diplomatic relations per era:
    # classical   3-2   -> 6-4
    # medieval    3-1   -> 6-2
    # (default)   3     -> 6
    # industrial  3+3   -> 6+4
    # modern      3+6   -> 6+8
    #
    # It's much less calibrated than vanilla.

    patch_mod_file!("common/static_modifiers/00_static_modifiers.txt") do |node|
      modify_node! node,
        ["base_values", "diplomatic_upkeep", 3, 6]
    end
    # We could do something fancier here
    # patch_mod_file!("common/triggered_modifiers/et_triggered_modifiers.txt") do |node|
    #   modify_node! node,
    #     ["classical_era",  "diplomatic_upkeep", -2, -4],
    #     ["medieval_era",   "diplomatic_upkeep", -1, -2],
    #     ["industrial_era", "diplomatic_upkeep",  3,  4],
    #     ["modern_times",   "diplomatic_upkeep",  6,  8]
    # end

    fix_opinions!
    fix_wargoals!
    subject_tweaks!
    # ET specific
    # fix_adopt_secularism_decision!
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

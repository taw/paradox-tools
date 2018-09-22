require_relative "fun_and_balance_common"

class FunAndBalance1356GameModification < FunAndBalanceCommonGameModification
  def apply!
    anyone_can_form_byzantium!
    buff_awful_idea_groups!
    # can_convert_in_territories!
    cheaper_fort_maintenance!
    coalition_cb_defend_capital!
    custom_nation_tweaks!
    disable_burgundy_inheritance!
    disable_call_for_peace!
    # disable_end_game_tag_check_for_player!
    double_tradition_gain_from_battles!
    everybody_can_can_claim_states!
    fewer_mercs!
    imperial_ban_cb_low_ae!
    increase_rival_distance!
    longer_cb_on_backstabbers!
    lower_defender_ae!
    make_constantinople_capital_ignore_culture_and_religion!
    merchant_republic_province_limit_remove!
    more_base_relations!
    more_building_slots!
    no_naval_attrition!
    power_projection_tweaks!
    rebalance_conversion_rates!
    reduce_ai_cheats!
    reduce_we_only_at_peace!
    religious_shift_decision!
    subject_religious_cbs!
    subject_tweaks!
    trade_map_fixes!
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

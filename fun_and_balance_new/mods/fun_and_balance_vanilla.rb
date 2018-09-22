require_relative "fun_and_balance_common"

class FunAndBalanceGameModification < FunAndBalanceCommonGameModification
  def apply!
    buff_awful_idea_groups!
    can_convert_in_territories!
    cheaper_fort_maintenance!
    disable_call_for_peace!
    disable_end_game_tag_check_for_player!
    everybody_can_can_claim_states!
    fewer_mercs!
    lower_defender_ae!
    more_base_relations!
    more_building_slots!
    no_naval_attrition!
    power_projection_tweaks!
    rebalance_conversion_rates!
    reduce_ai_cheats!
    religious_shift_decision!
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

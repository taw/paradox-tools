require_relative "fun_and_balance_common"

class FunAndBalanceGameModification < FunAndBalanceCommonGameModification
  def apply!
    more_base_relations!
    fewer_mercs!
    cheaper_fort_maintenance!
    reduce_ai_cheats!
    no_naval_attrition!
    disable_call_for_peace!
  end

  def more_base_relations!
    patch_mod_file!("common/static_modifiers/00_static_modifiers.txt") do |node|
      modify_node! node,
        ["base_values", "diplomatic_upkeep", 4, 8]
    end
  end
end

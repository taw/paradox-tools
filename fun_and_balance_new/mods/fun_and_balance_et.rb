require_relative "fun_and_balance_common"

class FunAndBalanceETGameModification < FunAndBalanceCommonGameModification
  def apply!
    buff_awful_idea_groups!
    can_convert_in_territories!
    cheaper_fort_maintenance!
    disable_call_for_peace!
    fewer_mercs!
    more_base_relations!
    more_building_slots!
    no_naval_attrition!
    power_projection_tweaks!
    reduce_ai_cheats!
  end

  # FIXME: This should be era-specific
  def more_base_relations!
    patch_mod_file!("common/static_modifiers/00_static_modifiers.txt") do |node|
      modify_node! node,
        ["base_values", "diplomatic_upkeep", 3, 6]
    end
  end
end

require_relative "base"
require_relative "../../eu4_trade_graph/trade_graph"

class FunAndBalanceCommonGameModification < EU4GameModification
  def buff_awful_idea_groups!
    patch_mod_file!("common/ideas/00_basic_ideas.txt") do |node|
      node["maritime_ideas"]["merchant_marine"]["merchants"] = 1
      node["maritime_ideas"]["bonus"]["global_ship_trade_power"] = 0.5
      node["naval_ideas"]["boarding_parties"]["free_leader_pool"] = 1
    end
  end

  def can_convert_in_territories!
    soft_patch_defines_lua!("fun_and_balance_fewer_mercs",
      ["NCountry.CAN_CONVERT_TERRITORY_CULTURE", 0, 1],
      ["NCountry.CAN_CONVERT_TERRITORY_RELIGION", 0, 1],
    )
  end

  def cheaper_fort_maintenance!
    soft_patch_defines_lua!("fun_and_balance_cheaper_forts",
      ["NMilitary.FORTRESS_COST", 0.50, 0.25],
    )
  end

  def disable_call_for_peace!
    patch_mod_file!("common/static_modifiers/00_static_modifiers.txt") do |node|
      node["call_for_peace"].delete!{true}
    end
  end

  def everybody_can_can_claim_states!
    patch_mod_files!("common/governments/*.txt") do |node|
      node.each do |name, government|
        next if government["claim_states"]
        government["claim_states"] = true
        # I tried to make this locked to empire rank, but game just ignore that
        # next unless government["rank"]
        # government["rank"].each do |rank, rank_bonuses|
        #   if rank >= 3
        #     rank_bonuses["claim_states"] = true
        #   end
        # end
      end
    end
  end

  def fewer_mercs!
    soft_patch_defines_lua!("fun_and_balance_fewer_mercs",
      ["NMilitary.MERCENARY_SUPPORT_LIMIT_BASE", 20, 10],
      ["NMilitary.MERCENARY_SUPPORT_LIMIT_FRACTION", 0.3, 0.15],
    )
  end

  def more_building_slots!
    patch_mod_file!("common/static_modifiers/00_static_modifiers.txt") do |node|
      node["development"]["allowed_num_of_buildings"] = 0.2
    end
  end

  def no_naval_attrition!
    patch_mod_file!("common/technologies/dip.txt") do |node|
      node.find_all("technology").each_with_index do |tech,i|
        if i == 0
          tech["reduced_naval_attrition"] = true
        else
          tech.delete! "reduced_naval_attrition"
        end
      end
    end
  end

  def power_projection_tweaks!
    patch_mod_file!("common/powerprojection/00_static.txt") do |node|
      modify_node! node,
        ["eclipsed_rival",            "power",         10,  30],
        ["eclipsed_rival",            "max",           30, 100],
        ["declared_war_at_rival",     "yearly_decay",   1, 0.5],
        ["joined_war_against_rival",  "yearly_decay",   1, 0.5],
        ["refused_war_against_rival", "yearly_decay",   1, 0.5],
        ["vassalized_rival",          "yearly_decay",   1, 0.5],
        ["took_province_from_rival",  "yearly_decay",   1, 0.5],
        ["rival_lost_province",       "yearly_decay",   1, 0.5],
        ["great_power_1",             "power",         25,  50],
        ["great_power_2",             "power",         22,  46],
        ["great_power_3",             "power",         20,  43],
        ["great_power_4",             "power",         18,  39],
        ["great_power_5",             "power",         16,  36],
        ["great_power_6",             "power",         14,  32],
        ["great_power_7",             "power",         12,  29],
        ["great_power_8",             "power",         10,  25]
    end
  end

  def reduce_ai_cheats!
    patch_mod_file!("common/static_modifiers/00_static_modifiers.txt") do |node|
      modify_node! node,
        ["ai_nation", "free_leader_pool", 1, 0]
    end
  end
end

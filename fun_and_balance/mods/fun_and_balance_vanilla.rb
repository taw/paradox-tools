require_relative "fun_and_balance_common"

class FunAndBalanceGameModification < FunAndBalanceCommonGameModification
  def apply!
    patch_file!("missions/Anti_Rival_Missions.txt") do |content|
      content.sub("FROM {", "FROM = {")
    end

    soft_patch_defines_lua!([
      ["NAI.DIPLOMATIC_INTEREST_DISTANCE", 150, 200],
      ["NAI.FORT_MAINTENANCE_CHEAT", 1, 0],
      ["NAI.PEACE_TIME_EARLY_FACTOR", 0.75, 0.50],
      ["NAI.PEACE_WAR_EXHAUSTION_FACTOR", 1.0, 2.0],
      ["NCountry.CULTURE_GAIN_THRESHOLD", "0.20", "0.10"], # This goes away in 1.8 anyway
      ["NCountry.MAX_IDEA_GROUPS_FROM_SAME_CATEGORY", 0.5, 1.0],
      ["NCountry.MAX_WAR_EXHAUSTION", 20, 50],
      ["NCountry.POLICY_COST", 1, 0],
      ["NCountry.PROTECTORATE_LOWER_BOUND", 0.5, 5.0], # 1.8 changes this
      ["NCountry.PROTECTORATE_TECH_THRESHOLD", 0.5, 5.0], # 1.8 changes this
      ["NCountry.PS_CHANGE_CULTURE", 10, 5],
      ["NCountry.PS_MOVE_CAPITAL", 200, 100],
      ["NCountry.PS_MOVE_TRADE_PORT", 200, 100],
      ["NCountry.RANDOM_LUCKY_DEVELOPMENT_WEIGHT", 0.4, 0],
      ["NCountry.RANDOM_LUCKY_SLOW_TECH_PENALTY", 0.33, 1],
      ["NCountry.RANDOM_LUCKY_TECH_WEIGHT", 1, 0],
      ["NCountry.TECH_AHEAD_OF_TIME", 0.1, 0.05],
      ["NCountry.WESTERN_POWER_TICK_REDUCTION_FACTOR", 100, 1000000],
      ["NDiplomacy.ANNEX_DIP_COST_PER_DEVELOPMENT", 8, 4],
      ["NDiplomacy.INTEGRATE_VASSAL_MIN_YEARS", 10, 20],
      ["NDiplomacy.MONTHS_BEFORE_TOTAL_OCCUPATION", 60, 24],
      ["NDiplomacy.VASSALIZE_BASE_DEVELOPMENT_CAP", 100, 300],
      ["NMilitary.FORTRESS_COST", 0.5, 0.125],
      ["NNationDesigner.IDEAS_MAX_LEVEL", 4, 10],
      ["NNationDesigner.IDEAS_PERCENTAGE_LIMIT", 50, 100],
      ["NNationDesigner.MAX_DISTANCE_TO_OWNER_AREA", 400, 1000],
      ["NNationDesigner.RULER_BASE_SKILL", 2, 3],
    ])

    patch_mod_file!("common/static_modifiers/00_static_modifiers.txt") do |node|
      modify_node! node,
        ["base_values", "global_missionary_strength", 0.02, 0.01],
        ["base_values", "global_heretic_missionary_strength", nil, 0.01],
        ["base_values", "diplomatic_upkeep", 4, 8],
        ["emperor", "diplomatic_upkeep", 1, 2]
    end

    anyone_can_form_byzantium!
    double_diplo_rel_limit_from_ideas!
    fix_opinions!
    fix_wargoals!
    no_naval_attrition!
    patch_religion!
    disable_burgundy_inheritance!
    move_burgundy_capital_to_hre!
    power_projection_tweaks!
    disable_call_for_peace!
  end
end

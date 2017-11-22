require_relative "fun_and_balance_common"

class FunAndBalanceGameModification < FunAndBalanceCommonGameModification
  def apply!
    patch_file!("missions/Anti_Rival_Missions.txt") do |content|
      content.sub("FROM {", "FROM = {")
    end

    soft_patch_defines_lua!([
      ["NAI.DIPLOMATIC_INTEREST_DISTANCE", 150, 200],
      ["NAI.FORT_MAINTENANCE_CHEAT", 0, 0],
      ["NAI.PEACE_TIME_EARLY_FACTOR", 0.75, 0.50],
      ["NAI.PEACE_WAR_EXHAUSTION_FACTOR", 1.0, 2.0],
      ["NCountry.CULTURE_GAIN_THRESHOLD", "0.20", "0.10"], # This goes away in 1.18 anyway
      ["NCountry.LIBERTY_DESIRE_HISTORICAL_FRIEND", -50, -30],
      ["NCountry.LIBERTY_DESIRE_HISTORICAL_RIVAL", 50, 30],
      ["NCountry.MAX_IDEA_GROUPS_FROM_SAME_CATEGORY", 0.5, 1.0],
      ["NCountry.MERCHANT_REPUBLIC_SIZE_LIMIT", 20, 10000],
      ["NCountry.POLICY_COST", 1, 0],
      ["NCountry.PS_CHANGE_CULTURE", 10, 5],
      ["NCountry.PS_MOVE_CAPITAL", 200, 100],
      ["NCountry.PS_MOVE_TRADE_PORT", 200, 100],
      ["NCountry.RANDOM_LUCKY_DEVELOPMENT_WEIGHT", 0.4, 0],
      ["NCountry.RANDOM_LUCKY_SLOW_TECH_PENALTY", 0.33, 1],
      ["NCountry.RANDOM_LUCKY_TECH_WEIGHT", 1, 0],
      ["NCountry.TECH_AHEAD_OF_TIME", 0.1, 0.05],
      ["NDiplomacy.ANNEX_DIP_COST_PER_DEVELOPMENT", 8, 4],
      ["NDiplomacy.DEFENDER_AE_MULT", 0.75, 0.5],
      ["NDiplomacy.INTEGRATE_VASSAL_MIN_YEARS", 10, 20],
      ["NDiplomacy.MONTHS_BEFORE_TOTAL_OCCUPATION", 60, 24],
      # ["NDiplomacy.PO_BECOME_VASSAL_AE", 0.5, 0.33],
      # ["NDiplomacy.PO_CONCEDE_COLONIAL_AE", 0.25, 0.17],
      # ["NDiplomacy.PO_DEMAND_PROVINCES_AE", 0.75, 0.5],
      # ["NDiplomacy.PO_FORM_PU_AE", 0.1, 0.066],
      # ["NDiplomacy.PO_RETURN_CORES_AE", 0.5, 0.33],
      # ["NDiplomacy.PO_REVOKE_ELECTOR_AE", 25, 15],
      ["NDiplomacy.VASSALIZE_BASE_DEVELOPMENT_CAP", 100, 300],
      ["NMilitary.FORTRESS_COST", 0.50, 0.25],
      ["NNationDesigner.IDEAS_MAX_LEVEL", 4, 10],
      ["NNationDesigner.IDEAS_PERCENTAGE_LIMIT", 50, 100],
      ["NNationDesigner.MAX_DISTANCE_TO_OWNER_AREA", 400, 1000],
      ["NNationDesigner.RULER_BASE_SKILL", 2, 3],
      ["NDiplomacy.CELESTIAL_EMPIRE_MANDATE_PER_HUNDRED_TRIBUTARY_DEV", 0.15, 0.1],
      # ["NDiplomacy.CELESTIAL_EMPIRE_MANDATE_PER_HUNDRED_NONTRIBUTARY_DEV", -0.3, -0.6],
    ])

    patch_mod_file!("common/static_modifiers/00_static_modifiers.txt") do |node|
      modify_node! node,
        ["base_values", "global_missionary_strength", 0.02, 0.01],
        ["base_values", "global_heretic_missionary_strength", nil, 0.01],
        ["base_values", "diplomatic_upkeep", 4, 8],
        ["ai_nation", "free_leader_pool", 1, 0],
        ["war", "war_exhaustion_cost", nil, 100]
    end

    anyone_can_form_byzantium!
    fix_opinions!
    fix_wargoals!
    no_naval_attrition!
    patch_religion!
    disable_burgundy_inheritance!
    move_burgundy_capital_to_hre!
    power_projection_tweaks!
    disable_call_for_peace!
    longer_cb_on_backstabbers!
    faster_institution_spread!
    subject_tweaks!
    more_building_slots!
    nerf_china!
    everybody_can_can_claim_states!
  end
end

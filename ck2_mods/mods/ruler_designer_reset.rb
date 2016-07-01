require_relative "base"

class RulerDesignerResetGameModification < CK2GameModification
  def apply!
    keys  = %W[
      COST_ATTRIB
      COST_SON
      COST_DAUGHTER
      COST_MARRIED
      COST_FERTILITY
      COST_HEALTH
      COST_MONTHLY_PRESTIGE
      COST_MONTHLY_PIETY
      COST_MONTHLY_WEALTH
      COST_GLOBAL_TAX
      COST_CHURCH_OPINION
      COST_SPOUCE_OPINION
      COST_SEXAPPEAL_OPINION
      COST_DYNASTY_OPINION
      COST_VASSAL_OPINION
      COST_LIEGE_OPINION
      COST_INFIDEL_OPINION
      COST_OPPOSITE_TRAIT_OPINION
      COST_SAME_TRAIT_OPINION
      COST_SAME_RELIGION_OPINION
      COST_AMBITION_OPINION
      COST_TRIBAL_OPINION
      COST_UNREFORMED_TRIBAL_OPINION
      COST_GENERAL_OPINION
      COST_MUSLIM_OPINION
      COST_JEWISH_OPINION
      COST_CHRISTIAN_OPINION
      COST_ZOROASTRIAN_OPINION
      COST_MORALE_OFFENCE
      COST_MORALE_DEFENCE
      COST_DEFENCE
    ]
    # Keep BASE_*, MAX_AGE
    override_defines_lua!("ruler_designer",
      Hash[keys.map{|key| ["NRulerDesigner.#{key}", 0] }]
    )
    patch_mod_files!("common/traits/*.txt") do |node|
      node.each do |name, trait|
        trait.delete! "ruler_designer_cost"
      end
    end
  end
end

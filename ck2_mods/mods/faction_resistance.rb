require_relative "base"

class FactionResistanceGameModification < CK2GameModification
  # AI folds to all factions way too easily beacuse faction power calculations are just dumb
  # It would be nice to setup proper calculations, but it's better if AI just never folds
  def apply!
    patch_mod_file!("events/plot_events.txt") do |node|
      node.find_all("letter_event").select{|x| x["trigger"]}.each do |ultimatum|
        faction = ultimatum["trigger"]["FROM"]["in_faction"]
        case faction.sub(/\Afaction_/, "")
        when "succ_seniority", "succ_primogeniture", "succ_gavelkind"
          # These are harmless, keep 20%
        when "succ_feudal_elective"
          # If you're weak enough to fold, you're weak enough to lose elections, so fight! 20%->0%
          ultimatum["option"]["ai_chance"]["factor"] = 0
        when "lower_crown_authority", "lower_tribal_organization"
          # Not worth risking the realm over sometimes, keep at 10%
        when "independence"
          # You can get it back later, keep at 5%
        when "overthrow", "antiking", "claimant", "powerful_vassal_takeover"
          # Never! It's your only chance to keep your legacy!
          ultimatum["option"]["ai_chance"]["factor"] = 0
        when "increase_council_power"
          # OK, enjoy your Conclave DLC
        else
          raise "Unknown faction #{faction}"
        end
      end
    end
  end
end

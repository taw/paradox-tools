require_relative "base"

# This only applies to people without Dharma DLC
class ChangeGovernmentGameModification < EU4GameModification
  def apply!
    not_21_cities = proc{|prop| prop.key == "NOT" and prop.val == PropertyList["num_of_provinces_in_states", 21]}

    patch_mod_file!("decisions/Governments.txt") do |node|
      node["country_decisions"].each do |key, decision|
        case key
        when "plutocratic_administration_rep",
             "plutocratic_administration"
          decision["potential"].delete!(&not_21_cities)
          decision["allow"].delete!(&not_21_cities)
        end
      end
    end
  end
end

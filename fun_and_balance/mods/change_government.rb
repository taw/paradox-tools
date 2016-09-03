require_relative "base"

class ChangeGovernmentGameModification < EU4GameModification
  def apply!
    not_20_cities = proc{|prop| prop.key == "NOT" and prop.val == PropertyList["num_of_cities", 20]}

    patch_mod_file!("decisions/Governments.txt") do |node|
      node["country_decisions"].each do |key, decision|
        case key
        when "plutocratic_administration_rep",
             "plutocratic_administration"
          decision["potential"].delete!(&not_20_cities)
          decision["allow"].delete!(&not_20_cities)
        end
      end
    end
  end
end

require_relative "base"

class ChangeGovernmentGameModification < EU4GameModification
  def apply!
    not_20_cities = proc{|k,v| k == "NOT" and v == PropertyList["num_of_cities", 20]}

    patch_mod_file!("decisions/Governments.txt") do |node|
      node["country_decisions"].each do |key, decision|
        case key
        when "plutocratic_administration_rep",
             "plutocratic_administration",
             "aristocratic_administration",
             "theocratic_administration"
          decision["potential"].delete_if(&not_20_cities)
          decision["allow"].delete_if(&not_20_cities)
        end
      end
    end
  end
end

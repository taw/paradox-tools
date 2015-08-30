require_relative "base"

class EU3StyleElectionsGameModification < EU4GameModification
  def eu3_style_elections!(node)
    node.delete("change_adm")
    node.delete("change_dip")
    node.delete("change_mil")
    node["add_scaled_republican_tradition"] *= 0.3 if node["add_scaled_republican_tradition"]
    node["define_ruler"].delete("fixed") if node["define_ruler"]
    eu3_style_elections! node["FROM"] if node["FROM"]
    eu3_style_elections! node["tooltip"] if node["tooltip"]
  end

  def apply!
    patch_mod_file!("events/Elections.txt") do |node|
      node.find_all("country_event").each do |event|
        event.find_all("option").each do |option|
          eu3_option = option.deep_copy
          eu3_style_elections!(eu3_option)

          next if option == eu3_option

          eu3_option.add! "trigger", PropertyList[Property::NOT["has_global_flag", "fun_and_balance_config.disable_eu3_style_elections"]]
          event.add! "option", eu3_option

          option.add! "trigger", PropertyList["has_global_flag", "fun_and_balance_config.disable_eu3_style_elections"]
        end
      end
    end
  end
end

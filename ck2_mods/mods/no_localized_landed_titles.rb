require_relative "base"

class NoLocalizedTitlesGameModification < CK2GameModification
  def no_localized_landed_titles!(node)
    cultures.each do |culture|
      node.delete(culture)
    end

    node.each do |key, val|
      next if val.is_a?(Numeric) or val == true or val == false
      case key
      when /\A[ekdcb]_/
        no_localized_landed_titles!(val)
      when *%W[
        color color2 dignity culture capital title title_female tribe holy_site
        foa controls_religion religion allow mercenary_type coat_of_arms
        male_names pagan_coa gain_effect graphical_culture
      ]
        # OK
      when *%W[]
      else
        puts "Unknown node: #{key} #{val.class} #{val}"
      end
    end
  end

  def apply!
    patch_mod_files!("common/landed_titles/*.txt") do |node|
      node.each do |title_name, title_node|
        no_localized_landed_titles!(title_node)
      end
    end
    # There's also localization like d_york_adj_norse
    # but it doesn't seem to be used if we cleanup landed titles
  end
end

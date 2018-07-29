class TechnologyData
  extend Memoist

  def initialize(game)
    @game = game
  end

  def each_technology
    @game.glob("common/technologies/*.txt").each do |path|
      @game.parse(path)["technologies"].each do |key, tech|
        next if key =~ /\A@/ and tech.is_a?(Integer)
        yield(key, jsonify(tech).merge("name" => @game.localization(key)))
      end
    end
  end

  def fix_start_year(name, tech)
    # Doctrines have no year
    return if tech["doctrine"]
    # Special non-researchable "techs"
    return if tech["allow"] == {"always"=>false}

    if @game.mod == "vanilla" or @game.mod == "kaiserreich"
      case name
      when "gw_artillery"
        tech["start_year"] ||= 1934
      when "concentrated_industry", "dispersed_industry", "radio", "radio_detection", "mechanical_computing", "excavation1"
        tech["start_year"] ||= 1936
      end
    elsif @game.mod == "millennium_dawn"
      case name
      when "gw_artillery"
        tech["start_year"] ||= 1960
      end
    end

    return if tech["start_year"]
    warn "No start year for technology: #{@game.localization(name)} (#{name}) in #{@game.mod}"
  end

  memoize def data
    result = {}
    each_technology do |name, tech|
      tech.delete "ai_will_do"
      tech.delete "ai_research_weights"
      tech.delete "folder"
      tech.delete "on_research_complete"

      paths = tech.delete("path") || []
      paths = [paths] unless paths.is_a?(Array)
      # There's some nonsense in files with Excavation techs having path without destination
      tech["leads_to"] = paths.map{|t| t["leads_to_tech"]}.compact

      unless tech["start_year"]
        fix_start_year(name, tech)
      end

      tech["unit_bonuses"] = {}

      @game.unit_types_and_categories.each do |type|
        if tech[type]
          unit_bonus = tech.delete(type)
          terrain_bonuses = {}
          @game.terrain_types.each do |terrain_type|
            if unit_bonus[terrain_type]
              terrain_bonuses[terrain_type] = unit_bonus.delete(terrain_type)
            end
          end
          unit_bonus["terrain_bonuses"] = terrain_bonuses unless terrain_bonuses.empty?
          tech["unit_bonuses"][type] = unit_bonus
        end
      end

      result[name] = tech
    end
    result
  end

  def land_doctrines
    data.select do |name, tech|
      tech["doctrine"] and tech["categories"].include?("land_doctrine")
    end
  end
end

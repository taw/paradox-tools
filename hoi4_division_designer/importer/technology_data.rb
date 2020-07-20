class TechnologyData
  extend Memoist

  def initialize(game)
    @game = game
  end

  def each_technology
    @game.glob("common/technologies/*.txt").each do |path|
      node = @game.parse(path)
      (node["technologies"] || []).each do |key, tech|
        next if key =~ /\A@/ and tech.is_a?(Integer)
        yield(key, jsonify(tech).merge("name" => @game.localization(key)))
      end
    end
  end

  memoize def raw_data
    enum_for(:each_technology).to_a
  end

  memoize def enabled_equipments
    raw_data.flat_map{|name, tech| tech["enable_equipments"] || []}.map{|k| EquipmentRenames[k] || k} &
      @game.equipment.equipment_names
  end

  memoize def enabled_subunits
    raw_data.flat_map{|k,v| v["enable_subunits"] || [] }
  end

  private def fix_start_year(name, tech)
    # Doctrines have no year
    return if tech["doctrine"]
    # Special non-researchable "techs"
    return if tech["allow"] == {"always"=>false}

    if @game.mod == "vanilla" or @game.mod == "kaiserreich" or @game.mod == "road_to_56"
      case name
      when "gw_artillery"
        tech["start_year"] ||= 1934
      when "concentrated_industry", "dispersed_industry", "radio", "radio_detection", "mechanical_computing", "excavation1"
        tech["start_year"] ||= 1936
      # 1.6 DLC Modules, just ignore as it's navy only
      when "damage_control_1", "damage_control_2", "damage_control_3", "fire_control_methods_1", "fire_control_methods_2", "fire_control_methods_3", "basic_fire_control_system", "improved_fire_control_system", "advanced_fire_control_system"
        tech["start_year"] ||= 1941
      end

      if @game.mod == "road_to_56"
        # Just doesn't matter
        tech["start_year"] ||= 1934
      end
    elsif @game.mod == "millennium_dawn"
      tech["start_year"] ||= 1960
    end

    return if tech["start_year"]
    warn "No start year for technology: #{@game.localization(name)} (#{name}) in #{@game.mod}"
  end

  memoize def data
    result = {}
    raw_data.each do |name, tech|
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

      if tech["enable_equipments"]
        tech["enable_equipments"] = [] if tech["enable_equipments"] == {}
        tech["enable_equipments"] = tech["enable_equipments"].map{|k| EquipmentRenames[k] || k}
        tech["enable_equipments"] &= @game.equipment.equipment_names
      end

      tech["unit_bonuses"] = {}

      @game.unit_types_and_categories.each do |type|
        if tech[type]
          unit_bonus = tech.delete(type)
          # Multiple entries with bonus for same type, annoying
          if unit_bonus.is_a?(Array)
            unit_bonus = unit_bonus.inject{|a,b|
              c = a.merge(b)
              # Only works if both are numbers
              (a.keys & b.keys).each do |k|
                c[k] = a[k] + b[k]
              end
              c
            }
          end
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

  memoize def land_doctrines
    data.select do |name, tech|
      tech["doctrine"] and tech["categories"].include?("land_doctrine")
    end
  end
end

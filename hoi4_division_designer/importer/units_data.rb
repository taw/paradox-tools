class UnitsData
  def initialize(game)
    @game = game
  end

  def each_unit
    @game.glob("common/units/*.txt").each do |path|
      node = @game.parse(path)
      next if node.empty?
      node["sub_units"].each do |name, unit|
        yield(name, jsonify(unit).merge("name" => @game.localization(name)))
      end
    end
  end

  def default_values
    {
      "air_attack" => 0,
      "breakthrough" => 0,
      "casualty_trickleback" => 0,
      "defense" => 0,
      "entrenchment" => 0,
      "equipment_capture_factor" => 0,
      "experience_loss_factor" => 0,
      "hard_attack" => 0,
      "initiative" => 0,
      "maximum_speed" => 0,
      "recon" => 0,
      "reliability_factor" => 0,
      "soft_attack" => 0,
      "supply_consumption_factor" => 0,
      "suppression" => 0,
      "supply_use" => 0,
    }
  end

  # Some awkward names changed
  def renamed
    {
      "need" => "equipment",
      "supply_consumption" => "supply_use",
      "max_organisation" => "org",
      "max_strength" => "hp",
      "default_morale" => "recovery_rate",
    }
  end

  def data
    result = {}
    each_unit do |name, unit|
      raise "Duplicate name: #{name}" if result[name]

      unless unit["active"] or @game.technology.enabled_subunits.include?(name)
        warn "Unit #{name} is #{@game.mod} is never enabled"
        next
      end

      unless unit["need"].keys.all?{|eq| @game.equipment.archetype_names.include?(eq) }
        # warn "Unit #{name} is #{@game.mod} is never enabled because of equipment"
        next
      end

      bonuses = {}
      unit_data = default_values
      unit.each do |key, value|
        case key
        when *@game.terrain_types
          bonuses[key] = value
        when "priority", "ai_priority", "sprite", "map_icon_category"
          # Skip
        else
          unit_data[renamed[key] || key] = value
        end
      end

      unit_data["terrain_bonuses"] = jsonify(bonuses)
      result[name] = unit_data
    end
    result
  end
end

class UnitsData
  def initialize(game)
    @game = game
  end

  def each_unit
    @game.glob("common/units/*.txt").each do |path|
      @game.parse(path)["sub_units"].each do |name, unit|
        yield(name, jsonify(unit).merge("name" => @game.localization(name)))
      end
    end
  end

  def data
    result = {}
    each_unit do |name, unit|
      raise "Duplicate name: #{name}" if result[name]
      bonuses = {}
      unit_data = {}
      unit.each do |key, value|
        case key
        when "forest", "marsh", "hills", "urban", "mountain",
             "jungle", "amphibious", "river", "fort", "plains",
             "desert"
          bonuses[key] = value
        when "priority", "ai_priority", "sprite", "map_icon_category"
          # Skip
        else
          unit_data[key] = value
        end
      end

      unit_data["bonuses"] = bonuses
      result[name] = unit_data
    end
    result
  end
end

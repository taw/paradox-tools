class Country
  def initialize(database, technologies)
    @database = database
    @technologies = technologies
  end

  def equipment_map
    {
      "infantry_equipment" => @database.equipment["infantry_equipment_0"],
      "artillery_equipment" => @database.equipment["artillery_equipment_1"],
      "motorized_equipment" => @database.equipment["motorized_equipment_1"],
      "motorized_rocket_equipment" => @database.equipment["motorized_rocket_equipment_1"],
    }
  end

  def division(unit_types)
    units = unit_types.flat_map{|k,v|
      unit_type = @database.unit_types.fetch(k.to_s)
      unit = Unit.new(unit_type, self)
      [unit] * v
    }
    Division.new(*units)
  end

  def available_units
    []
  end
end

require "pathname"
require "json"
require_relative "division"
require_relative "unit_type"
require_relative "unit"
require_relative "equipment"
require_relative "technology"

module Enumerable
  def avg
    return if empty?
    sum.to_f / size
  end
end

class DivisionDesigner
  def initialize
    db = JSON.parse(Pathname("#{__dir__}/../data/data.json").read)

    @unit_types = db["units"].map do |name, stats|
      [name, UnitType.new(name, stats)]
    end.to_h

    @equipment = db["equipment"].map do |name, stats|
      [name, Equipment.new(name, stats)]
    end.to_h

    @technology = db["technology"].map do |name, effects|
      [name, Technology.new(name, effects)]
    end.to_h
  end

  def technology
    {
      equipment: {
        "infantry_equipment" => @equipment["infantry_equipment_0"],
        "artillery_equipment" => @equipment["artillery_equipment_1"],
        "motorized_equipment" => @equipment["motorized_equipment_1"],
        "motorized_rocket_equipment" => @equipment["motorized_rocket_equipment_1"],
      },
    }
  end

  def division(unit_types)
    units = unit_types.flat_map{|k,v|
      unit_type = @unit_types.fetch(k.to_s)
      unit = Unit.new(unit_type, technology)
      [unit] * v
    }
    Division.new(*units)
  end
end

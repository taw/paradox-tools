require "pathname"
require "json"
require_relative "division"
require_relative "unit_type"
require_relative "unit"
require_relative "equipment"

module Enumerable
  def avg
    return if empty?
    sum.to_f / size
  end
end

class DivisionDesigner
  def initialize
    @unit_types = {}
    @equipment = {}
    db = JSON.parse(Pathname("#{__dir__}/../data/data.json").read)
    db["units"].each do |name, stats|
      @unit_types[name] = UnitType.new(name, stats)
    end

    db["equipment"].each do |name, stats|
      @equipment[name] = Equipment.new(name, stats)
    end
  end

  def technology
    {
      equipment: {
        "infantry_equipment" => @equipment["infantry_equipment"],
        "artillery_equipment" => @equipment["artillery_equipment"],
        "motorized_equipment" => @equipment["motorized_equipment"],
        "motorized_rocket_equipment" => @equipment["motorized_rocket_equipment"],
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

require "pathname"
require "json"
require_relative "division"
require_relative "unit"
require_relative "equipment"

module Enumerable
  def avg
    return if empty?
    sum / size
  end
end

class DivisionDesigner
  def initialize
    db = JSON.parse(Pathname("#{__dir__}/../data/data.json").read)
    @units = {}
    db["units"].each do |name, stats|
      @units[name] = Unit.new(name, stats)
    end
  end

  def division(unit_types)
    units = unit_types.flat_map{|k,v|
      [@units.fetch(k.to_s)] * v
    }
    Division.new(*units)
  end
end

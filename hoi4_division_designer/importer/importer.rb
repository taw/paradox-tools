require "pathname"
require "json"
require "memoist"
require_relative "../../lib/paradox_game"
require_relative "equipment_data"
require_relative "technology_data"
require_relative "units_data"
require_relative "doctrine_data"

def jsonify(obj)
  return obj.map{|e| jsonify(e)} if obj.is_a?(Array)
  return obj unless obj.is_a?(PropertyList)
  obj.to_h.sort.map{|k,v|
    [k, jsonify(v)]
  }.to_h
end

class Importer < ParadoxGame
  extend Memoist
  attr_reader :mod

  def initialize(mod, *roots)
    super(*roots)
    @save_path = Pathname("#{__dir__}/../data/#{mod}.json")
    @mod = mod
  end

  # This could be based on game files in case mods change it
  def terrain_types
    ["forest", "marsh", "hills", "urban", "mountain", "jungle", "amphibious", "river", "fort", "plains", "desert"]
  end

  memoize def units
    UnitsData.new(self)
  end

  memoize def equipment
    EquipmentData.new(self)
  end

  memoize def unit_types_and_categories
    (units.data.keys + units.data.values.flat_map{|unit| unit["categories"] || [] }).uniq
  end

  memoize def technology
    TechnologyData.new(self)
  end

  memoize def doctrines
    DoctrineData.new(self)
  end

  def call
    data = {
      units: units.data,
      equipment: equipment.data,
      technology: technology.data,
      doctrines: doctrines.data,
    }
    @save_path.write JSON.pretty_generate(data)
  end

  def inspect
    "Importer"
  end
end

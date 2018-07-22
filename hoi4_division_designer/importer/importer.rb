require_relative "../../lib/paradox_game"
require_relative "equipment_data"
require_relative "technology_data"
require_relative "units_data"
require_relative "doctrine_data"
require "pathname"
require "json"

def jsonify(obj)
  return obj.map{|e| jsonify(e)} if obj.is_a?(Array)
  return obj unless obj.is_a?(PropertyList)
  obj.to_h.sort.map{|k,v|
    [k, jsonify(v)]
  }.to_h
end

class Importer < ParadoxGame
  def initialize(*roots)
    super(*roots)
  end

  def call
    data = {
      units: UnitsData.new(self).data,
      equipment: EquipmentData.new(self).data,
      technology: TechnologyData.new(self).data,
      doctrines: DoctrineData.new(self).data,
    }
    Pathname("#{__dir__}/../data/data.json").write JSON.pretty_generate(data)
  end
end

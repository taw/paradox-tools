class Database
  extend Memoist

  attr_reader :unit_types, :equipment_types, :technology, :doctrines, :upgrades

  def initialize(mod)
    path = Database.mod_path_for(mod)
    db = JSON.parse(path.read)

    @unit_types = db["units"].map do |name, stats|
      [name, UnitType.new(name, stats)]
    end.to_h

    @equipment_types = db["equipment"].map do |name, stats|
      [name, EquipmentType.new(self, name, stats)]
    end.to_h

    @technology = db["technology"].map do |name, effects|
      [name, Technology.new(self, name, effects)]
    end.to_h

    @doctrines = db["doctrines"]

    @upgrades = db["upgrades"]

    fallback_equipment_map
  end

  def country(technology_names)
    techs = technology_names.map{|n| @technology.fetch(n) }
    Country.new(self, techs)
  end

  def techs_up_to(year)
    @technology.select do |name, tech|
      tech.start_year && tech.start_year <= year
    end.keys
  end

  def techs_for_doctrine(name)
    @doctrines.fetch(name)
  end

  memoize def years
    @technology.values.map(&:start_year).compact.uniq.sort
  end

  # Assume key order within archetype
  memoize def fallback_equipment_map
    @equipment_types
      .values
      .group_by(&:archetype)
      .transform_values{|eqs| eqs.min_by(&:key)}
      .transform_values{|eq| Equipment.new(self, eq, {}) }
  end

  # // Using any of these results in invalid division, but it won't crash app
  # // Pick oldest equipment for each archetype
  # calculateFallbackEquipmentMap() {
  #   let result = {};
  #   for(let name in this.equipment) {
  #     let equipment = this.equipment[name];
  #     let archetype = equipment.archetype;
  #     if(!result[archetype] || (equipment.key < result[archetype].key)) {
  #       result[archetype] = equipment;
  #     }
  #   }
  #   return result;
  # }

  def inspect
    "Database"
  end

  class << self
    def mod_base_path
      Pathname("#{__dir__}/../data/")
    end

    def available_mods
      mod_base_path.glob("*.json").map{|n| n.basename(".json").to_s}
    end

    def mod_path_for(mod)
      unless available_mods.include?(mod)
        raise "No such mod #{mod} - available mods are: #{available_mods.join(" ")}"
      end
      mod_base_path + "#{mod}.json"
    end
  end
end

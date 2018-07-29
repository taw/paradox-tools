class Database
  attr_reader :unit_types, :equipment, :technology, :doctrines

  def initialize(mod)
    path = Database.mod_path_for(mod)
    db = JSON.parse(path.read)

    @unit_types = db["units"].map do |name, stats|
      [name, UnitType.new(name, stats)]
    end.to_h

    @equipment = db["equipment"].map do |name, stats|
      [name, Equipment.new(name, stats)]
    end.to_h

    @technology = db["technology"].map do |name, effects|
      [name, Technology.new(self, name, effects)]
    end.to_h

    @doctrines = db["doctrines"]
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

  def years
    @technology.values.map(&:start_year).compact.uniq.sort
  end

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

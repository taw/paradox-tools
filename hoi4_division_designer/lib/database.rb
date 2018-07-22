class Database
  attr_reader :unit_types, :equipment, :technology, :doctrines

  def initialize
    db = JSON.parse(Pathname("#{__dir__}/../data/data.json").read)

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

  def unit_types_and_categories
    @unit_types.keys.to_set | @unit_types.values.flat_map(&:categories).to_set
  end

  def years
    @technology.values.map(&:start_year).compact.uniq.sort
  end
end

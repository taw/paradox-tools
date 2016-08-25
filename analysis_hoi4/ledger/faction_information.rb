class FactionInformation < InformationTables
  def initialize(ledger, name)
    @ledger = ledger
    @name = name
    @countries = []
    @resources = Hash.new(0)
    @ic = Hash.new(0)
    @divisions = 0
    @manpower = Hash.new(0)
    @ships = Hash.new(0)
    @equipment = {}
  end

  def add_country!(country)
    @divisions += country.divisions
    country.manpower.each do |cat, count|
      @manpower[cat] += count
    end
    country.resources.each do |cat, count|
      @resources[cat] += count
    end
    country.ic.each do |cat, count|
      @ic[cat] += count
    end
    country.ships.each do |cat, count|
      @ships[cat] += count
    end
    country.equipment.each do |archetype, details|
      @equipment[archetype] ||= Hash.new(0)
      details.each do |equipment, count|
        @equipment[archetype][equipment] += count
      end
    end
    @countries << country
  end

  def to_json
    {
      name: @name,
      members: @countries.map(&:name).sort,
      resources: Hash[@resources.sort],
      ic: Hash[@ic.sort],
      divisions: @divisions,
      manpower:  Hash[@manpower.sort],
      ships: Hash[@ships.sort],
      equipment: summarize_equipment_table,
      equipment_categories: equipment_categories,
    }
  end
end

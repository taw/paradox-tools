class CountryInformation < InformationTables
  attr_reader :tag, :name
  attr_reader :divisions, :manpower, :ships, :equipment, :ic, :resources, :research_cost
  attr_accessor :faction
  def initialize(ledger, tag, country)
    @ledger = ledger
    @tag = tag
    @original_tag = country["original_tag"] || @tag
    @resources = Hash.new(0)
    @ic = Hash.new(0)
    @divisions = 0
    @manpower = Hash.new(0)
    @ships = Hash.new(0)
    @equipment = {}
    @faction = "Neutrals"
    @ideology = country["politics"]["ruling_party"]
    @name = ledger.localization("#{@original_tag}_#{@ideology}")

    @research_cost = 0
    (country["technology"]["technologies"] || {}).each do |name, tech|
      next unless tech["level"]
      raise unless tech["level"] == 1
      if ledger.technology_cost[name]
        @research_cost += ledger.technology_cost[name]
      else
        warn "Unknown tech: `#{name}' for #{@tag}"
      end
    end

    country["resources"]["produced"].each do |name, amount|
      raise unless amount == amount.to_i
      @resources[name] = amount.to_i
    end
    add_equipments! country["production"]["equipments"]
    add_units! country["units"]
    add_deployment! country["deployment"]
  end

  def add_deployment!(deployment)
    return unless deployment
    deployment.each do |type, data|
      next unless type == "military_deployment_conveyor"
      data.find_all("military_deployment_line").each do |line|
        add_unit_in_training! line["military_deployment"]
      end
    end
  end

  def add_unit_in_training!(unit)
    @manpower["training"] += unit["manpower"] if unit["manpower"]
    add_equipments! unit["equipment"] if unit["equipment"]
  end

  def add_units!(units)
    return unless units
    units.each do |type, unit|
      # unit["logical_country"] # For expeditionary corps/volunteers/etc. presumably?
      case type
      when "division"
        add_division! unit
      when "navy"
        add_navy! unit
      else
        binding.pry
      end
    end
  end

  def add_owned_state!(state)
    return unless state["buildings"]
    ["dockyard", "industrial_complex", "arms_factory"].each do |type|
      next unless state["buildings"][type]
      next if state["buildings"][type] == []
      count = state["buildings"][type]["level"].size
      @ic["owned_#{type}"] += count
      @ic["owned_total"] += count
    end
  end

  def add_controlled_state!(state)
    return unless state["buildings"]
    ["dockyard", "industrial_complex", "arms_factory"].each do |type|
      next unless state["buildings"][type]
      next if state["buildings"][type] == []
      count = state["buildings"][type]["level"].size
      count_working = state["buildings"][type]["level"].select{|lvl| lvl == 100}.size
      @ic["controlled_#{type}"] += count
      @ic["controlled_total"] += count
      @ic["working_#{type}"] += count_working
      @ic["working_total"] += count_working
    end
  end

  def add_navy!(unit)
    @manpower["navy"] += unit["manpower"]
    unit.find_all("ship").each do |ship|
      @ships[ship["definition"]] += 1
      @ships["total"] += 1
    end
  end

  def add_division!(unit)
    @manpower["army"] += unit["manpower"]
    @divisions += 1
    add_equipments! unit["equipment"]
  end

  def add_equipments!(equipments)
    equipments.each do |cat, equipment|
      binding.pry unless cat == "equipment"
      add_equipment! equipment
    end
  end

  def add_equipment!(equipment_node)
    amount = equipment_node["amount"]
    amount = amount.to_i if amount == amount.to_i
    id = equipment_node["id"]
    equipment = @ledger.id_to_equipment[id]
    archetype = equipment.archetype

    if archetype.name == "convoy"
      @ships["convoy"] += amount
    else
      @equipment[archetype] ||= Hash.new(0)
      @equipment[archetype][equipment] += amount
    end
  end

  def add_air_force!(air_force)
    air_force.find_all("air_wing_pool").each do |air_wing_pool|
      air_wing_pool.find_all("air_wings").each do |air_wing|
        @manpower["air"] += air_wing["manpower"]
        add_equipments! air_wing["equipment"]
      end
    end
  end

  def to_json
    {
      name: @name,
      ideology: @ideology,
      faction: @faction,
      research_cost: @research_cost,
      resources: Hash[@resources.sort],
      ic: Hash[@ic.sort],
      divisions: @divisions,
      manpower:  Hash[@manpower.sort],
      ships:  Hash[@ships.sort],
      equipment: summarize_equipment_table,
      equipment_categories: equipment_categories,
    }
  end
end

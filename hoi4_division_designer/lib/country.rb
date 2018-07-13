class Country
  extend Memoist

  def initialize(database, technologies)
    @database = database
    @technologies = technologies
  end

  def equipment_map
    # Making a silly assumption that they're sorted asciibetically
    # It seems to be right, as they're all X0, X1, X2 etc.
    enabled_equipments
      .map{|eq| @database.equipment[eq] }
      .group_by(&:archetype)
      .transform_values{|eqs| eqs.max_by(&:key) }
  end

  def division(unit_types)
    units = unit_types.flat_map{|k,v|
      unit_type = @database.unit_types.fetch(k.to_s)
      unit = Unit.new(unit_type, self)
      [unit] * v
    }
    Division.new(*units)
  end

  memoize def available_units
    @database.unit_types.values.select do |unit_type|
      next unless unit_type.active? or enabled_subunits.include?(unit_type.key)
      unit_type.equipment.keys.all? do |equipment|
        enabled_equipment_archetypes.include?(equipment)
      end
    end
  end

  memoize def unit_bonuses
    unit_bonuses = {}
    @technologies.each do |tech|
      unit_bonuses.recursively_merge!(tech.unit_bonuses){ |a,b| (a+b).round(6) }
    end
    unit_bonuses
  end

  def unit_bonuses_for(unit_type_name)
    unit_type = @database.unit_types.fetch(unit_type_name)
    categories = [unit_type.key, *unit_type.categories]
    result = {}
    categories.each do |category|
      next unless unit_bonuses[category]
      result.recursively_merge!(unit_bonuses[category]){|a,b| (a+b).round(6) }
    end
    result
  end

  def inspect
    "Country<#{@technologies.sort.join(", ")}>"
  end

  private

  memoize def enabled_subunits
    @technologies.flat_map{|x| x.enable_subunits }.to_set
  end

  memoize def enabled_equipments
    @technologies.flat_map{|x| x.enable_equipments }.to_set
  end

  memoize def enabled_equipment_archetypes
    enabled_equipments.map{|eq| @database.equipment[eq].archetype }.to_set
  end
end

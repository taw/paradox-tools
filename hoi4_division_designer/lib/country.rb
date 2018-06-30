class Country
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
      .transform_values{|eqs| eqs.max_by(&:name) }
  end

  def division(unit_types)
    units = unit_types.flat_map{|k,v|
      unit_type = @database.unit_types.fetch(k.to_s)
      unit = Unit.new(unit_type, self)
      [unit] * v
    }
    Division.new(*units)
  end

  def available_units
    @database.unit_types.values.select do |unit_type|
      next unless unit_type.active? or enabled_subunits.include?(unit_type.name)
      unit_type.equipment.keys.all? do |equipment|
        enabled_equipment_archetypes.include?(equipment)
      end
    end
  end

  def unit_bonuses
    unit_bonuses = {}
    @technologies.each do |tech|
      tech.unit_bonuses.each do |unit, bonuses|
        unit_bonuses[unit] ||= {}
        bonuses.each do |key, val|
          if val.is_a?(Hash)
            unit_bonuses[unit][key] ||= {}
            # Terrain bonuses
            val.each do |subkey, subval|
              unit_bonuses[unit][key][subkey] ||= 0
              unit_bonuses[unit][key][subkey] += subval
            end
          else
            unit_bonuses[unit][key] ||= 0
            unit_bonuses[unit][key] += val
            unit_bonuses[unit][key] = unit_bonuses[unit][key].round(6)
          end
        end
      end
    end
    unit_bonuses
  end

  private

  def enabled_subunits
    @technologies.flat_map{|x| x.enable_subunits }.to_set
  end

  def enabled_equipments
    @technologies.flat_map{|x| x.enable_equipments }.to_set
  end

  def enabled_equipment_archetypes
    enabled_equipments.map{|eq| @database.equipment[eq].archetype }.to_set
  end
end

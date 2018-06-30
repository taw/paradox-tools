class Unit
  attr_reader :unit_type

  def initialize(unit_type, technology)
    @unit_type = unit_type
    @technology = technology
    @equipment = {}
    @unit_type.equipment.each do |name, count|
      equipment = @technology[:equipment].fetch(name)
      @equipment[equipment] = count
    end
  end

  %i[
    combat_width manpower training_time suppression hp org weight recovery_rate
    supply_use bonuses special_forces? can_be_parachuted? frontline? name].each do |key|
    define_method(key) { @unit_type.send(key) }
  end

  attr_reader :equipment

  def soft_attack
    base = @equipment.map{|eq, count| eq.soft_attack || 0}.sum
    base * (1 + @unit_type.soft_attack)
  end

  def hard_attack
    base = @equipment.map{|eq, count| eq.hard_attack || 0}.sum
    base * (1 + @unit_type.hard_attack)
  end

  def defense
    base = @equipment.map{|eq, count| eq.defense || 0}.sum
    base * (1 + @unit_type.defense)
  end

  def breakthrough
    base = @equipment.map{|eq, count| eq.breakthrough || 0}.sum
    base * (1 + @unit_type.breakthrough)
  end

  def piercing
    @equipment.map{|eq, count| eq.ap_attack || 0}.sum
  end

  def armor
    @equipment.map{|eq, count| eq.armor_value || 0}.sum
  end

  def ic_cost
    @equipment.map{|eq, count| eq.build_cost_ic * count}.sum
  end

  def speed
    # Unclear what to do when multiply types are used. Mot uses mot(12)+inf(4)
    equipment_speed = @equipment.map{|eq, count| eq.maximum_speed}.compact.max || 4.0
    equipment_speed * (1 + @unit_type.maximum_speed)
  end
end

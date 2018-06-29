class Unit
  attr_reader :name, :unit_type

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
    supply_use speed bonuses special_forces?].each do |key|
    define_method(key) { @unit_type.send(key) }
  end

  attr_reader :equipment

  def soft_attack
    @equipment.map{|eq, count| eq.soft_attack}.sum
  end

  def hard_attack
    @equipment.map{|eq, count| eq.hard_attack}.sum
  end

  def defense
    @equipment.map{|eq, count| eq.defense}.sum
  end

  def breakthrough
    base = @equipment.map{|eq, count| eq.breakthrough}.sum
    base * (1 + @unit_type.breakthrough)
  end

  def piercing
    @equipment.map{|eq, count| eq.ap_attack}.sum
  end

  def armor
    @equipment.map{|eq, count| eq.armor_value}.sum
  end

  def ic_cost
    @equipment.map{|eq, count| eq.build_cost_ic * count}.sum
  end
end

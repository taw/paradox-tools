class Equipment
  attr_reader :name

  def initialize(name, stats)
    @name = name
    @stats = stats
  end

  %i[soft_attack hard_attack air_attack
    defense breakthrough ap_attack armor_value
    build_cost_ic maximum_speed archetype hardness].each do |key|
    define_method(key) { @stats[key.to_s] }
  end

  def inspect
    "Equipment<#{@name}>"
  end
end

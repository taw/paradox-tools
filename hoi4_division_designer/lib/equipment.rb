class Equipment
  attr_reader :name

  def initialize(name, stats)
    @name = name
    @stats = stats
  end

  %i[soft_attack hard_attack defense breakthrough ap_attack armor_value build_cost_ic maximum_speed].each do |key|
    define_method(key) { @stats[key.to_s] }
  end
end

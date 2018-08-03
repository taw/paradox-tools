class Equipment
  extend Memoist

  def initialize(database, equipment_type, upgrades)
    @database = database
    @equipment_type = equipment_type
    @upgrades = upgrades

    bad_upgrades = @upgrades.keys - @equipment_type.available_upgrades.keys
    unless bad_upgrades.empty?
      raise "Bad upgrades for #{@equipment_type} requested: #{bad_upgrades.join(", ")}"
    end
  end

  memoize def variant_bonus
    result = {}
    @upgrades.each do |key, level|
      available_upgrades.fetch(key).each do |stat, value|
        next if ["name", "max_level", "cost"].include?(stat)
        result[stat] ||= 0.0
        result[stat] = (result[stat] + value * level).round(6)
      end
    end
    result
  end

  # In principle other stats could get upgrades too
  UPGRADABLE_STATS = %W[
    air_agility
    air_attack
    air_bombing
    air_ground_attack
    air_range
    anti_air_attack
    ap_attack
    armor_value
    attack
    carrier_size
    evasion
    fire_range
    hard_attack
    maximum_speed
    naval_range
    naval_speed
    naval_strike_attack
    reliability
    shore_bombardment
    soft_attack
    sub_attack
    sub_detection
    sub_visibility
    torpedo_attack
  ]

  UPGRADABLE_STATS.each do |stat|
    define_method(stat) do
      base = @equipment_type.send(stat)
      bonus = variant_bonus[stat]
      if bonus
        (base * (1 + bonus)).round(6)
      else
        base
      end
    end
  end

  def method_missing(m, *args, &block)
    @equipment_type.send(m, *args, &block)
  end
end

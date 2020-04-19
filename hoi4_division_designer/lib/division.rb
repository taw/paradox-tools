class Division
  extend Memoist

  def initialize(country, *units)
    @country = country
    @units = units
  end

  def manpower
    @units.map(&:manpower).sum
  end

  def training_time
    @units.map(&:training_time).max
  end

  def combat_width
    @units.map(&:combat_width).sum
  end

  def hp
    @units.map(&:hp).sum
  end

  def org
    @units.map(&:org).avg.round(3)
  end

  def weight
    @units.map(&:weight).sum
  end

  def recovery_rate
    @units.map(&:recovery_rate).avg.round(3)
  end

  def suppression
    base = @units.map(&:suppression).sum
    factor = @units.map(&:suppression_factor).sum
    (base * (1+factor)).round(6)
  end

  # Doctrine bonus is only shown in Unit Details not in Division Designer
  # They stack multiplicatively
  def supply_use
    base = @units.map(&:supply_use).sum.round(6)
    company_bonus = @units.map(&:supply_consumption_factor).sum
    doctrine_bonus = @country.division_bonuses["supply_consumption_factor"] || 0
    (base * (1 + company_bonus) * (1 + doctrine_bonus)).round(6)
  end

  def fuel_consumption
    base = @units.map(&:fuel_consumption).sum.round(6)
    factor = @units.map(&:fuel_consumption_factor).sum
    (base * (1+factor)).round(6)
  end

  def fuel_capacity
    # No idea where this 28.8 factor is coming from
    # It's 6/5 of 24
    # fuel_consumption_factor does not affect capacity so we need to reverse it
    factor = 28.8
    base = @units.map(&:fuel_consumption).sum.round(6)
    (factor * base).round(2)
  end

  def soft_attack
    @units.map(&:soft_attack).sum.round(6)
  end

  def hard_attack
    @units.map(&:hard_attack).sum.round(6)
  end

  def air_attack
    @units.map(&:air_attack).sum.round(6)
  end

  def defense
    @units.map(&:defense).sum.round(6)
  end

  def breakthrough
    @units.map(&:breakthrough).sum.round(6)
  end

  def ic_cost
    @units.map(&:ic_cost).sum.round(6)
  end

  def entrenchment
    base = 5 # from defines.lua, so could vary by mod
    units_bonus = @units.map(&:entrenchment).sum
    doctrine_bonus = @country.division_bonuses["max_dig_in"] || 0
    base + units_bonus + doctrine_bonus
  end

  def reliability_factor
    @units.map(&:reliability_factor).sum
  end

  def casualty_trickleback
    @units.map(&:casualty_trickleback).sum
  end

  def equipment_capture_factor
    @units.map(&:equipment_capture_factor).sum
  end

  def experience_loss_factor
    @units.map(&:experience_loss_factor).sum
  end

  def recon
    @units.map(&:recon).sum
  end

  def initiative
    @units.map(&:initiative).sum
  end

  memoize def frontline_units
    @units.select(&:frontline?)
  end

  memoize def support_units
    @units.reject(&:frontline?)
  end

  memoize def terrain_bonuses
    result = {}
    frontline_units.each do |unit|
      result.recursively_merge!(unit.terrain_bonuses){|a,b| a+b}
    end
    result.each do |terrain, bonuses|
      bonuses.each do |key, val|
        bonuses[key] = (val / frontline_units.size).round(3)
      end
    end
    support_units.each do |unit|
      result.recursively_merge!(unit.terrain_bonuses){|a,b| (a+b).round(3)}
    end
    result
  end

  # It doesn't stack quite right, but it's more helpful this way
  def speed
    base_speed = @units.select(&:frontline?).map(&:speed).min || 0
    doctrine_bonus = @country.division_bonuses["army_speed_factor"] || 0
    (base_speed * (1 + doctrine_bonus)).round(2)
  end

  memoize def equipment
    result = {}
    @units.each do |unit|
      unit.equipment.each do |type, count|
        result[type.key] ||= 0
        result[type.key] += count
      end
    end
    result
  end

  def armor
    mx = @units.map(&:armor).max || 0.0
    wa = @units.map(&:armor).avg
    (0.3 * mx + 0.7 * wa).round(3)
  end

  def piercing
    mx = @units.map(&:piercing).max || 0.0
    wa = @units.map(&:piercing).avg
    (0.4 * mx + 0.6 * wa).round(3)
  end

  def can_be_parachuted?
    @units.all?(&:can_be_parachuted?)
  end

  def special_forces
    @units.count(&:special_forces?)
  end

  def hardness
    frontline_units.map(&:hardness).avg.round(6)
  end

  memoize def missing_equipment
    @units.map(&:missing_equipment).reduce(Set.new, &:|)
  end

  memoize def warnings
    results = []
    infantry = frontline_units.select{|u| u.group == "infantry" }.size
    mobile = frontline_units.select{|u| u.group == "mobile" }.size
    armored = frontline_units.select{|u| u.group == "armor" }.size
    brigades = (infantry + 4) / 5 + (mobile + 4) / 5 + (armored + 4) / 5

    if frontline_units.size == 0
      results << "No frontline battalions"
    end

    if frontline_units.size > 25
      results << "#{frontline_units.size}/25 frontline battalions"
    elsif brigades > 5
      # No need to use this warning if there's just too many units
      results << "#{brigades}/5 brigades"
    end

    if support_units.size > 5
      results << "#{support_units.size}/5 support companies"
    end

    missing_equipment.each do |eq|
      results << "Missing equipment: #{eq.name}"
    end

    results
  end
end

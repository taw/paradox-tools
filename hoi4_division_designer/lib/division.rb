class Division
  def initialize(*units)
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

  def suppression
    @units.map(&:suppression).sum
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

  def supply_use
    @units.map(&:supply_use).sum.round(6)
  end

  def soft_attack
    @units.map(&:soft_attack).sum
  end

  def hard_attack
    @units.map(&:hard_attack).sum
  end

  def defense
    @units.map(&:defense).sum
  end

  def breakthrough
    @units.map(&:breakthrough).sum
  end

  def ic_cost
    @units.map(&:ic_cost).sum
  end

  def entrenchment
    @units.map(&:entrenchment).sum
  end

  def recon
    @units.map(&:recon).sum
  end

  def frontline_units
    @units.select(&:frontline?)
  end

  def bonuses
    result = {}
    frontline_units.each do |unit|
      result.recursively_merge!(unit.bonuses){|a,b| a+b}
    end
    result.each do |terrain, bonuses|
      bonuses.each do |key, val|
        bonuses[key] = (val / frontline_units.size).round(3)
      end
    end
    result
  end

  def speed
    @units.select(&:frontline?).map(&:speed).min
  end

  def equipment
    result = {}
    @units.each do |unit|
      unit.equipment.each do |type, count|
        result[type.name] ||= 0
        result[type.name] += count
      end
    end
    result
  end

  def armor
    mx = @units.map(&:armor).max
    wa = @units.map(&:armor).avg
    (0.3 * mx + 0.7 * wa).round(3)
  end

  def piercing
    mx = @units.map(&:piercing).max
    wa = @units.map(&:piercing).avg
    (0.4 * mx + 0.6 * wa).round(3)
  end

  def can_be_parachuted?
    @units.all?(&:can_be_parachuted?)
  end

  def special_forces
    @units.count(&:special_forces?)
  end

  def method_missing(m, *args)
    0
  end
end

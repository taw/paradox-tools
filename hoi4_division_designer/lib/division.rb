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
    @units.map(&:org).avg
  end

  def weight
    @units.map(&:weight).sum
  end

  def recovery_rate
    @units.map(&:recovery_rate).avg
  end

  def supply_use
    @units.map(&:supply_use).sum
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

  def armor # FIXME: wrong formula
    @units.map(&:armor).avg
  end

  def piercing # FIXME: wrong formula
    @units.map(&:piercing).avg
  end

  def bonuses
    sums = {}
    @units.each do |unit|
      unit.bonuses.each do |terrain, terrain_bonuses|
        terrain_bonuses.each do |kind, value|
          sums[[terrain, kind]] ||= 0
          sums[[terrain, kind]] += value
        end
      end
    end
    result = {}
    sums.each do |(terrain, kind), value|
      value = (value / @units.size).round(6)
      result[terrain] ||= {}
      result[terrain][kind] = value
    end
    result
  end

  def speed
    @units.map(&:speed).min
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

  # FIXME: remove this once we're done
  def method_missing(m, *args)
    0
  end
end

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

  def bonuses
    {}
  end

  def speed
    @units.map(&:speed).min
  end

  def equipment
    result = {}
    @units.each do |unit|
      unit.equipment.each do |type, count|
        result[type] ||= 0
        result[type] += count
      end
    end
    result
  end

  # FIXME: remove this once we're done
  def method_missing(m, *args)
    0
  end
end

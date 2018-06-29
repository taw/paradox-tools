class Unit
  def initialize(name, stats)
    @name = name
    @stats = stats
  end

  def combat_width
    @stats["combat_width"]
  end

  def manpower
    @stats["manpower"]
  end

  def training_time
    @stats["training_time"]
  end

  def suppression
    @stats["suppression"]
  end

  def hp
    @stats["max_strength"]
  end

  def org
    @stats["max_organisation"]
  end

  def weight
    @stats["weight"]
  end

  def recovery_rate
    @stats["default_morale"]
  end

  def equipment
    @stats["need"]
  end

  def supply_use
    @stats["supply_consumption"]
  end

  def speed
    if @stats["maximum_speed"]
      4.0 * (1 + @stats["maximum_speed"])
    else
      4.0
    end
  end
end

class UnitType
  attr_reader :name

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
    @stats["suppression"] || 0
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

  def maximum_speed
    @stats["maximum_speed"] || 0
  end

  def bonuses
    @stats["bonuses"]
  end

  def special_forces?
    @stats["special_forces"]
  end

  def soft_attack
    @stats["soft_attack"] || 0
  end

  def hard_attack
    @stats["hard_attack"] || 0
  end

  def breakthrough
    @stats["breakthrough"] || 0
  end

  def defense
    @stats["defense"] || 0
  end

  def can_be_parachuted?
    @stats["can_be_parachuted"]
  end

  def frontline?
    combat_width != 0
  end
end

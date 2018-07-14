class UnitType < OpenStruct
  def initialize(key, stats)
    super(stats.merge("key" => key))
  end

  def inspect
    "Equipment<#{key}>"
  end

  def frontline?
    combat_width != 0
  end

  def special_forces?
    !!special_forces
  end

  def can_be_parachuted?
    !!can_be_parachuted
  end

  def active?
    !!active
  end
end

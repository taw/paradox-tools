class Equipment
  def initialize(database, equipment_type, upgrades)
    @database = database
    @equipment_type = equipment_type
    @upgrades = upgrades
  end

  def method_missing(m, *args, &block)
    @equipment_type.send(m, *args, &block)
  end
end

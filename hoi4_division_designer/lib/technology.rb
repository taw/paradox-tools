class Technology
  attr_reader :name
  def initialize(database, name, effects)
    @database = database
    @name = name
    @effects = effects
  end

  def enable_subunits
    @effects["enable_subunits"] || []
  end

  def enable_equipments
    @effects["enable_equipments"] || []
  end

  def start_year
    @effects["start_year"]
  end

  def unit_bonuses
    @effects.slice(*@database.unit_types_and_categories)
  end
end

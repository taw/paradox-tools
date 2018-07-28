class Technology
  attr_reader :name, :effects
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

  # There's some nonsense in files with Excavation techs having path without destination
  def leads_to
    @effects["leads_to"]
  end
end

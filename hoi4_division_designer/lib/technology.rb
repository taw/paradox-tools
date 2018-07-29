class Technology
  attr_reader :key, :effects
  def initialize(database, key, effects)
    @database = database
    @key = key
    @effects = effects
  end

  def name
    @effects["name"]
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
    @effects["unit_bonuses"] || {}
  end

  # There's some nonsense in files with Excavation techs having path without destination
  def leads_to
    @effects["leads_to"]
  end
end

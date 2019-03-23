class Technology
  extend Memoist

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

  # This is a very ad hoc approach
  memoize def division_bonuses
    result = {}
    @effects.each do |k, v|
      case k
      when "dig_in_speed_factor",
           "land_night_attack",
           "land_reinforce_rate",
           "max_dig_in",
           "max_planning",
           "special_forces_no_supply_grace",
           "special_forces_out_of_supply_factor",
           "special_forces_training_time_factor",
           "supply_consumption_factor",
           "acclimatization_cold_climate_gain_factor",
           "acclimatization_hot_climate_gain_factor",
           "army_speed_factor"
        result[k] = v
      end
    end
    result
  end

  # There's some nonsense in files with Excavation techs having path without destination
  def leads_to
    @effects["leads_to"]
  end
end

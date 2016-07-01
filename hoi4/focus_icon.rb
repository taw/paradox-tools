class FocusIcon
  attr_reader :icon
  def initialize(focus_name, icon_name)
    @icon = case icon_name
    when *%W[
      air_bomber
      air_doctrine
      air_fighter
      air_naval_bomber
      army_artillery
      army_artillery2
      army_doctrines
      army_motorized
      army_tanks
      build_navy
      build_tank
      CAS
      navy_battleship
      navy_cruiser
      navy_doctrines_tactics
      navy_submarine
      production
      secret_weapon
      small_arms
      special_forces
      wolf_pack
    ]
      "GFX_goal_generic_#{icon_name}"
    when "airforce"
      "GFX_goal_generic_build_#{icon_name}"
    when "infantry"
      "GFX_goal_generic_allies_build_#{icon_name}"
    when "rocketry", "wonderweapons", "research"
      "GFX_focus_#{icon_name}"
    when "civ_factory", "mil_factory", "infrastructure", "naval_dockyard"
      "GFX_goal_generic_construct_#{icon_name}"
    else
      raise "Unknown icon name #{icon_name} for #{focus_name}"
    end
  end
end

require_relative "base"

class HideCancelledMissionsGameModification < EU4GameModification
  # Run after all other mission modifications
  def apply!
    modifiers = []
    patch_mod_files!("missions/*.txt") do |node|
      node.each do |name, mission|
        flag_name = "recently_cancelled_#{name}"
        modifiers << flag_name
        if mission["abort_effect"] == nil or mission["abort_effect"] == []
          mission["abort_effect"] = PropertyList[]
        end
        mission["abort_effect"].add! "FROM", PropertyList[
          "add_country_modifier", PropertyList[
            "name", flag_name,
            "duration", 365*25,
            "hidden", true,
          ],
        ]
        mission["chance"].add! "modifier", PropertyList[
          "factor", 0.01,
          "has_country_modifier", flag_name,
        ]
      end
    end
    create_mod_file! "common/event_modifiers/10_mission_pool.txt", PropertyList[
      *modifiers.map{|name| Property[name, PropertyList[]]},
    ]
  end
end

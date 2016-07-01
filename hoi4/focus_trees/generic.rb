# This reimplements Generic Focus tree just to test the DSL
focus_tree "Generic 2", "SWE" do
  focus "Army Effort", x: 1, y: 0, icon: "infantry" do
    army_xp 5
    research_bonus :land_doc, bonus: 0.5
  end

  focus "Equipment Effort", x: 0, y: 1, icon: "small_arms" do
    req "Army Effort"
    research_bonus :infantry_weapons, bonus: 0.5
  end

  focus "Motorization Effort", x: 2, y: 1, icon: "army_motorized" do
    req "Army Effort"
    bypass_if_has_tech :motorised_infantry
    research_bonus :motorised_infantry, bonus: 0.75
  end

  focus "Doctrine Effort", x: 1, y: 2, icon: "army_doctrines" do
    req "Army Effort"
    army_xp 5
    research_bonus :land_doc, bonus: 0.5
  end

  focus "Equipment Effort 2", x: 0, y: 3, icon: "army_artillery" do
    req "Equipment Effort"
    research_bonus :infantry_artillery, bonus: 0.5
  end

  focus "Mechanization Effort", x: 2, y: 3, icon: "build_tank" do
    req "Motorization Effort"
    research_bonus :motorized_equipment, ahead: 0.5
  end

  focus "Doctrine Effort 2", x: 1, y: 4, icon: "army_doctrines" do
    req "Doctrine Effort"
    army_xp 5
    research_bonus :land_doc, bonus: 0.5
  end

  focus "Equipment Effort 3", x: 0, y: 5, icon: "army_artillery2" do
    req "Equipment Effort 2"
    research_bonus :infantry_artillery, ahead: 1
  end

  focus "Armor Effort", x: 2, y: 5, icon: "army_tanks" do
    req "Mechanization Effort"
    research_bonus :armor, bonus: 0.5, uses: 2
  end

  focus "Special Forces", x: 1, y: 6, icon: "special_forces" do
    req "Equipment Effort 3"
    req "Doctrine Effort 2"
    req "Armor Effort"
    research_bonus :special_forces, bonus: 0.5
  end

  focus "Aviation Effort", x: 5, y: 0, icon: "airforce" do
    air_xp 25
    # TODO: very complex reward with air bases
    research_bonus :air_doc, bonus: 0.5
  end

  focus "Fighter Focus", x: 4, y: 1, icon: "air_fighter" do
    req "Aviation Effort"
    mutually_exclusive "Bomber Focus"
    research_bonus :fighter, bonus: 0.5, uses: 2
  end

  focus "Bomber Focus", x: 6, y: 1, icon: "air_bomber" do
    req "Aviation Effort"
    mutually_exclusive "Fighter Focus"
    research_bonus :bomber, bonus: 0.5, uses: 2
  end

  focus "Aviation Effort 2", x: 5, y: 2, icon: "air_doctrine" do
    req "Bomber Focus", "Fighter Focus"
    air_xp 25
    # TODO: very complex reward with air bases
    research_bonus :air_doc, bonus: 0.5
  end

  focus "CAS Effort", x: 4, y: 3, icon: "CAS" do
    req "Aviation Effort 2"
    req "Motorization Effort"
    research_bonus :CAS, bonus: 0.5, ahead: 1
  end

  focus "Rocket Effort", x: 5, y: 4, icon: "rocketry" do
    req "Aviation Effort 2"
    req "Infrastructure Effort"
    research_bonus :jet_rocket, ahead: 0.5, uses: 2
  end

  focus "NAV Effort", x: 6, y: 3, icon: "air_naval_bomber" do
    req "Aviation Effort 2"
    req "Flexible Navy"
    research_bonus :nav_bomber, bonus: 0.5, ahead: 1
  end

  focus "Naval Effort", x: 9, y: 0, icon: "naval_dockyard" do
    available_if_has_coastal_state
    navy_xp 25
    dockyards 3
    ai_wont_do_without_coastal_province
  end

  focus "Flexible Navy", x: 8, y: 1, icon: "build_navy" do
    req "Naval Effort"
		mutually_exclusive "Large Navy"
    research_bonus :sub_op, bonus: 0.5, uses: 2
    ai_wont_do_without_coastal_province
  end

  focus "Large Navy", x: 10, y: 1, icon: "navy_doctrines_tactics" do
    req "Naval Effort"
    mutually_exclusive "Flexible Navy"
    research_bonus :fleet_in_being, bonus: 0.5, uses: 2
    ai_wont_do_without_coastal_province
  end

  focus "Submarine Effort", x: 8, y: 2, icon: "navy_submarine" do
    req "Flexible Navy", "Large Navy"
    research_bonus :ss, bonus: 0.5, ahead: 1
    ai_wont_do_without_coastal_province
  end

  focus "Cruiser Effort", x: 10, y: 2, icon: "navy_cruiser" do
    req "Large Navy", "Flexible Navy"
    research_bonus :cr, bonus: 0.5, ahead: 1
    ai_wont_do_without_coastal_province
  end

  focus "Destroyer Effort", x: 8, y: 3, icon: "wolf_pack" do
    req "Submarine Effort"
    research_bonus :dd, bonus: 0.5, ahead: 1
    ai_wont_do_without_coastal_province
  end

  focus "Capital Ships Effort", x: 10, y: 3, icon: "navy_battleship" do
    req "Cruiser Effort"
    navy_xp 25
    research_bonus :capital_ships, bonus: 0.5, ahead: 1
    ai_wont_do_without_coastal_province
  end

  focus "Industrial Effort", x: 13, y: 0, icon: "production" do
    research_bonus :industrial, bonus: 0.5
  end

  focus "Construction Effort", x: 12, y: 1, icon: "civ_factory" do
    req "Industrial Effort"
    civ_factory 1
  end

  focus "Production Effort", x: 14, y: 1, icon: "mil_factory" do
    req "Industrial Effort"
    mil_factory 1
  end

  focus "Construction Effort 2", x: 12, y: 2, icon: "civ_factory" do
    req "Construction Effort"
    civ_factory 1
  end

  focus "Production Effort 2", x: 14, y: 2, icon: "mil_factory" do
    req "Production Effort"
    mil_factory 1
  end

  focus "Infrastructure Effort", x: 12, y: 3, icon: "infrastructure" do
    req "Construction Effort 2"
  end

  focus "Production Effort 3", x: 14, y: 3, icon: "mil_factory" do
    req "Production Effort 2"
    civ_factory 1
  end

  focus "Infrastructure Effort 2", x: 12, y: 4, icon: "infrastructure" do
    req "Infrastructure Effort"
  end

  focus "Construction Effort 3", x: 14 , y: 4, icon: "civ_factory" do
    req "Infrastructure Effort"
    civ_factory 2
  end

  focus "Nuclear Effort", x: 10, y: 5, icon: "wonderweapons" do
    req "Infrastructure Effort 2"
  end

  focus "Extra Tech Slot", x: 12, y: 5, icon: "research" do
    req "Infrastructure Effort 2"
  end

  focus "Extra Tech Slot 2", x: 12, y: 6, icon: "research" do
    req "Extra Tech Slot"
  end

  focus "Secret Weapons", x: 14, y: 5, icon: "secret_weapon" do
    req "Infrastructure Effort 2"
    research_bonus :secret, bonus: 0.5, uses: 4
    ai_factor 0.25
  end
end

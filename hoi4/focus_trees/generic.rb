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

  focus "Equipment Effort II", x: 0, y: 3, icon: "army_artillery" do
    req "Equipment Effort"
    research_bonus :infantry_artillery, bonus: 0.5
  end

  focus "Equipment Effort III", x: 0, y: 5, icon: "army_artillery2" do
    req "Equipment Effort II"
    research_bonus :infantry_artillery, ahead: 1.0
  end

  focus "Doctrine Effort", x: 1, y: 2, icon: "army_doctrines" do
    req "Army Effort"
    army_xp 5
    research_bonus :land_doc, bonus: 0.5
  end

  focus "Doctrine Effort II", x: 1, y: 4, icon: "army_doctrines" do
    req "Doctrine Effort"
    army_xp 5
    research_bonus :land_doc, bonus: 0.5
  end

  focus "Motorization Effort", x: 2, y: 1, icon: "army_motorized" do
    req "Army Effort"
    research_bonus :motorised_infantry, bonus: 0.75
  end

  focus "Mechanization Effort", x: 2, y: 3, icon: "build_tank" do
    req "Motorization Effort"
    research_bonus :motorized_equipment, bonus: 0.5
  end

  focus "Armor Effort", x: 2, y: 5, icon: "army_tanks" do
    req "Mechanization Effort"
    research_bonus :armor, bonus: 0.5, uses: 2
  end

  focus "Special Forces", x: 1, y: 6, icon: "special_forces" do
    req "Equipment Effort III", "Doctrine Effort II", "Armor Effort"
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

  focus "Aviation Effort II", x: 5, y: 2, icon: "air_doctrine" do
    req "Aviation Effort"
    air_xp 25
    # TODO: very complex reward with air bases
    research_bonus :air_doc, bonus: 0.5
  end

  focus "CAS Effort", x: 4, y: 3, icon: "CAS" do
    req "Aviation Effort II"
    req "Motorization Effort"
    research_bonus :CAS, bonus: 0.5, ahead: 1.0
  end

  focus "NAV Effort", x: 6, y: 3, icon: "air_naval_bomber" do
    req "Aviation Effort II"
    req "Flexible Navy"
    research_bonus :CAS, bonus: 0.5, ahead: 1.0
  end

  focus "Rocket Effort", x: 5, y: 4, icon: "rocketry" do
    req "Aviation Effort II"
    req "Infrastructure Effort"
    research_bonus :jet_rocket, ahead: 0.5, uses: 2
  end

  focus "Naval Effort", x: 9, y: 0, icon: "naval_dockyard" do
    available_if_has_coastal_state
    navy_xp 25
    # build_dockyards 3
    # TODO
  end

  focus "Flexible Navy", x: 8, y: 1, icon: "build_navy" do
    req "Naval Effort"
		mutually_exclusive "Large Navy"
    research_bonus :sub_op, bonus: 0.5, uses: 2
  end

  focus "Submarine Effort", x: 8, y: 2, icon: "navy_submarine" do
    req "Flexible Navy", "Large Navy" # TODO: make it an OR
  end

  focus "Destroyer Effort", x: 8, y: 3, icon: "wolf_pack" do
    req "Submarine Effort"
    # TODO
  end

  focus "Large Navy", x: 10, y: 1, icon: "navy_doctrines_tactics" do
    req "Naval Effort"
    mutually_exclusive "Flexible Navy"
    research_bonus :fleet_in_being, bonus: 0.5, uses: 2
  end

  focus "Cruiser Effort", x: 10, y: 2, icon: "navy_cruiser" do
    req "Flexible Navy", "Large Navy" # TODO: make it an OR
    # TODO
  end

  focus "Capital Ship Effort", x: 10, y: 3, icon: "navy_battleship" do
    req "Cruiser Effort"
    # TODO
  end

  focus "Industrial Effort", x: 13, y: 0, icon: "production" do
    research_bonus :industrial, bonus: 0.5
  end

  focus "Construction Effort", x: 12, y: 1, icon: "civ_factory" do
    req "Industrial Effort"
    # TODO
  end

  focus "Construction Effort II", x: 12, y: 2, icon: "civ_factory" do
    req "Construction Effort"
    # TODO
  end

  focus "Infrastructure Effort", x: 12, y: 3, icon: "infrastructure" do
    req "Construction Effort II"
    # TODO
  end

  focus "Infrastructure Effort II", x: 12, y: 4, icon: "infrastructure" do
    req "Infrastructure Effort"
    # TODO
  end

  focus "Nuclear Effort", x: 10, y: 5, icon: "wonderweapons" do
    req "Infrastructure Effort II"
    # TODO
  end

  focus "Extra Research Slot", x: 12, y: 5, icon: "research" do
    req "Infrastructure Effort II"
    # TODO
  end

  focus "Extra Research Slot II", x: 12, y: 6, icon: "research" do
    req "Extra Research Slot"
    # TODO
  end

  focus "Secret Weapons", x: 14, y: 5, icon: "secret_weapon" do
    req "Infrastructure Effort II"
    # TODO
  end

  focus "Construction Effort III", x: 14 , y: 4, icon: "civ_factory" do
    req "Infrastructure Effort"
    # TODO
  end

  focus "Armament Effort", x: 14, y: 1, icon: "mil_factory" do
    req "Industrial Effort"
    # TODO
  end

  focus "Armament Effort II", x: 14, y: 2, icon: "mil_factory" do
    req "Armament Effort"
    # TODO
  end

  focus "Armament Effort III", x: 14, y: 3, icon: "mil_factory" do
    req "Armament Effort II"
    # TODO
  end
end

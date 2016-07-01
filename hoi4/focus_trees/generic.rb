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
    # TODO: req "Flexible Navy"
    research_bonus :CAS, bonus: 0.5, ahead: 1.0
  end

  focus "Rocket Effort", x: 5, y: 4, icon: "rocketry" do
    req "Aviation Effort II"
    # TODO: req "Infrastructure Effort"
    research_bonus :jet_rocket, ahead: 0.5, uses: 2
  end
end

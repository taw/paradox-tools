# This reimplements Generic Focus tree just to test the DSL
focus_tree "Generic 2", "SWE" do
  focus "Army Effort" do
    loc 1, 0
    army_xp 5
    research_bonus :land_doc, bonus: 0.5
  end

  focus "Equipment Effort" do
    req "Army Effort"
    loc 0, 1
    research_bonus :infantry_weapons, bonus: 0.5
  end

  focus "Equipment Effort II" do
    req "Equipment Effort"
    loc 0, 3
    research_bonus :infantry_artillery, bonus: 0.5
  end

  focus "Equipment Effort III" do
    req "Equipment Effort II"
    loc 0, 5
    research_bonus :infantry_artillery, ahead: 1.0
  end

  focus "Doctrine Effort" do
    req "Army Effort"
    loc 1, 2
    army_xp 5
    research_bonus :land_doc, bonus: 0.5
  end

  focus "Doctrine Effort II" do
    req "Doctrine Effort"
    loc 1, 4
    army_xp 5
    research_bonus :land_doc, bonus: 0.5
  end

  focus "Motorization Effort" do
    req "Army Effort"
    loc 2, 1
    research_bonus :motorised_infantry, bonus: 0.75
  end

  focus "Mechanization Effort" do
    req "Motorization Effort"
    loc 2, 3
    research_bonus :motorized_equipment, bonus: 0.5
  end

  focus "Armor Effort" do
    req "Mechanization Effort"
    loc 2, 5
    research_bonus :armor, bonus: 0.5, uses: 2
  end

  focus "Special Forces" do
    req "Equipment Effort III", "Doctrine Effort II", "Armor Effort"
    loc 1, 6
    research_bonus :special_forces, bonus: 0.5
  end
end

describe DivisionDesigner do
  let(:division_designer) { DivisionDesigner.new }
  let(:division) { division_designer.division(units) }

  # Some defaults for stuff that's mostly zeroes anyway
  let(:default_stats) {
    {
      # Left Column
      reliability: 0.0,
      trickleback: 0.0,
      reconnaissance: 0.0,
      exp_loss: 0.0,
      recovery_rate: 0.30,

      # Middle Column
      air_attack: 0.0,
      initiative: 0.0,
      entrechment: 0.0,
      equipment_capture_rate: 0.0,
      armor: 0.0,

      # Right Column

      # Adjusters
      bonuses: {},
      special_forces: 0,
      can_be_parachuted: false,
      hardness: 0,
    }
  }

  def expect_stats(division, stats)
    stats = default_stats.merge(stats)
    expect(division.speed).to eq stats[:speed]
    expect(division.hp).to eq stats[:hp]
    expect(division.org).to eq stats[:org]
    expect(division.recovery_rate).to eq stats[:recovery_rate]
    expect(division.reconnaissance).to eq stats[:reconnaissance]
    expect(division.suppression).to eq stats[:suppression]
    expect(division.weight).to eq stats[:weight]
    expect(division.supply_use).to eq stats[:supply_use]
    expect(division.reliability).to eq stats[:reliability]
    expect(division.trickleback).to eq stats[:trickleback]
    expect(division.exp_loss).to eq stats[:exp_loss]
    # Middle Column
    expect(division.soft_attack).to eq stats[:soft_attack]
    expect(division.hard_attack).to eq stats[:hard_attack]
    expect(division.air_attack).to eq stats[:air_attack]
    expect(division.defense).to eq stats[:defense]
    expect(division.breakthrough).to eq stats[:breakthrough]
    expect(division.armor).to eq stats[:armor]
    expect(division.piercing).to eq stats[:piercing]
    expect(division.initiative).to eq stats[:initiative]
    expect(division.entrechment).to eq stats[:entrechment]
    expect(division.equipment_capture_rate).to eq stats[:equipment_capture_rate]
    expect(division.combat_width).to eq stats[:combat_width]
    # Right Column
    expect(division.manpower).to eq stats[:manpower]
    expect(division.training_time).to eq stats[:training_time]
    expect(division.equipment).to eq stats[:equipment]
    expect(division.ic_cost).to eq stats[:ic_cost]
    # Adjusters
    expect(division.bonuses).to eq stats[:bonuses]
    expect(division.special_forces).to eq stats[:special_forces]
    expect(division.can_be_parachuted?).to eq stats[:can_be_parachuted]
    expect(division.hardness).to eq stats[:hardness]
  end

  describe "2inf, no tech" do
    let(:tech) { nil }
    let(:units) { {infantry: 2} }
    it do
      expect_stats division, {
        speed: 4.0,
        hp: 50.0,
        org: 60.0,
        suppression: 2.0,
        weight: 1.0,
        supply_use: 0.14,
        soft_attack: 6.0,
        hard_attack: 1.0,
        defense: 40.0,
        breakthrough: 4.0,
        piercing: 1.0,
        combat_width: 4,
        manpower: 2000,
        training_time: 90,
        equipment: {"infantry_equipment" => 200},
        ic_cost: 80,
        bonuses: {},
      }
    end
  end

  describe "6cav, no tech" do
    let(:tech) { nil }
    let(:units) { {cavalry: 6} }
    it do
      expect_stats division, {
        speed: 6.4,
        hp: 150.0,
        org: 70.0,
        suppression: 12.0,
        weight: 3.0,
        supply_use: 0.72,
        soft_attack: 18.0,
        hard_attack: 3.0,
        defense: 120.0,
        breakthrough: 12.0,
        piercing: 1.0,
        combat_width: 12,
        manpower: 6000,
        training_time: 120,
        equipment: {"infantry_equipment" => 720},
        ic_cost: 288,
        bonuses: {
          "forest" => {"attack" => -0.05},
          "hills" => {"attack" => -0.05},
          "mountain" => {"attack" => -0.10, "movement" => -0.05},
          "urban" => {"attack" => -0.05},
          "jungle" => {"attack" => -0.10},
          "amphibious" => {"attack" => -0.40},
        },
      }
    end
  end

  describe "2mnt 2inf" do
    let(:tech) { nil }
    let(:units) { {infantry: 2, mountaineers: 2} }
    it do
      expect_stats division, {
        speed: 4.0,
        hp: 90.0,
        org: 65.0,
        recovery_rate: 0.35,
        suppression: 4.0,
        weight: 2.0,
        supply_use: 0.28,
        soft_attack: 12.0,
        hard_attack: 2.0,
        defense: 80.0,
        breakthrough: 9.2,
        piercing: 1.0,
        combat_width: 8,
        manpower: 4000,
        training_time: 120,
        equipment: {"infantry_equipment" => 480},
        ic_cost: 192,
        bonuses: {
          "hills" => {"movement" => 0.05, "attack" => 0.10, "defence" => 0.025},
          "mountain" => {"movement" => 0.10, "attack" => 0.175, "defence" => 0.05},
        },
        special_forces: 2,
      }
    end
  end

  describe "7inf 2art" do
    let(:tech) { nil }
    let(:units) { {infantry: 7, artillery_brigade: 2} }
    it do
      expect_stats division, {
        speed: 4.0,
        hp: 176.2,
        org: 46.667, # displayed as 46.6
        recovery_rate: 0.256, # displayed as 0.25
        suppression: 7.0,
        weight: 4.5,
        supply_use: 0.89,
        soft_attack: 71.0,
        hard_attack: 7.5,
        defense: 160.0,
        breakthrough: 26.0,
        piercing: 3.133, # displayed as 3.1
        combat_width: 20,
        manpower: 8000,
        training_time: 120,
        equipment: {"infantry_equipment" => 700, "artillery_equipment" => 72},
        ic_cost: 532,
        bonuses: { # different rounding in game
          "forest" => {"movement" => -0.044, "attack" => -0.044},
          "hills" => {"movement" => -0.011},
          "mountain" => {"movement" => -0.044},
          "jungle" => {"movement" => -0.044, "attack" => -0.056},
          "marsh" => {"movement" => -0.067, "attack" => -0.044},
          "fort" => {"attack" => 0.022},
          "river" => {"movement" => -0.044, "attack" => -0.044},
          "amphibious" => {"attack" => -0.089},
        },
      }
    end
  end

  describe "3par + support art" do
    let(:tech) { nil }
    let(:units) { {paratrooper: 3, artillery: 1} }
    it do
      expect_stats division, {
        speed: 4.0,
        hp: 66.2,
        org: 52.5,
        recovery_rate: 0.325, # displayed as 0.32
        suppression: 3.0,
        weight: 1.6,
        supply_use: 0.34,
        soft_attack: 24.0,
        hard_attack: 2.7,
        defense: 66.0,
        breakthrough: 9.6,
        piercing: 3.2,
        combat_width: 6,
        manpower: 3300,
        training_time: 150,
        equipment: {"infantry_equipment" => 390, "artillery_equipment" => 12},
        ic_cost: 198,
        bonuses: {},
        special_forces: 3,
        can_be_parachuted: true,
      }
    end
  end

  describe "4mot + 4rart + support art" do
    let(:tech) { nil }
    let(:units) { {motorized: 4, motorized_rocket_brigade: 4, artillery: 1} }
    it do
      expect_stats division, {
        speed: 12.0,
        hp: 102.6,
        org: 26.667, # displayed as 26.6
        recovery_rate: 0.189, # displayed as 0.18
        suppression: 4.0,
        weight: 5.1,
        supply_use: 1.72,
        soft_attack: 171.0,
        hard_attack: 7.2,
        defense: 146.0,
        breakthrough: 59.6,
        piercing: 3.133, # displayed 3.1
        combat_width: 20,
        manpower: 7100,
        training_time: 120,
        equipment: {
          "infantry_equipment" => 400,
          "artillery_equipment" => 12,
          "motorized_equipment" => 260,
          "motorized_rocket_equipment" => 80,
        },
        ic_cost: 1812,
        bonuses: {
          "forest" => {"movement" => -0.50, "attack" => -0.10},
          "hills" => {"movement" => -0.025},
          "mountain" => {"movement" => -0.10, "attack" => -0.025},
          "urban" => {"attack" => -0.05},
          "jungle" => {"movement" => -0.50, "attack" => -0.225},
          "marsh" => {"movement" => -0.40, "attack" => -0.15},
          "fort" => {"attack" => 0.05},
          "river" => {"movement" => -0.15, "attack" => -0.15},
          "amphibious" => {"attack" => -0.30},
        },
      }
    end
  end
end

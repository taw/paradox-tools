describe Division do
  let(:db) { Database.new("vanilla") }
  let(:country) { db.country(tech) }
  # Just lowest level equipment, no bonuses
  let(:tech_year) { nil }
  let(:doctrine) { nil }
  let(:tech) do
    if tech_year
      db.techs_up_to(tech_year)
    else
      %W[infantry_weapons gw_artillery motorised_infantry motorized_rocket_unit]
    end + if doctrine
      db.techs_for_doctrine(doctrine)
    else
      []
    end
  end
  let(:division) { country.division(units) }
  let(:warnings) { division.warnings }

  # Some defaults for stuff that's mostly zeroes anyway
  let(:default_stats) {
    {
      # Left Column
      reliability_factor: 0.0,
      casualty_trickleback: 0.0,
      recon: 0.0,
      suppression: 0.0,
      experience_loss_factor: 0.0,
      recovery_rate: 0.30,

      # Middle Column
      air_attack: 0.0,
      armor: 0.0,
      initiative: 0.0,
      entrenchment: 0.0,
      equipment_capture_factor: 0.0,

      # Right Column
      fuel_consumption: 0.0,
      fuel_capacity: 0.0,

      # Adjusters
      terrain_bonuses: {},
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
    expect(division.recon).to eq stats[:recon]
    expect(division.suppression).to eq stats[:suppression]
    expect(division.weight).to eq stats[:weight]
    expect(division.supply_use).to eq stats[:supply_use]
    expect(division.reliability_factor).to eq stats[:reliability_factor]
    expect(division.casualty_trickleback).to eq stats[:casualty_trickleback]
    expect(division.experience_loss_factor).to eq stats[:experience_loss_factor]
    # Middle Column
    expect(division.soft_attack).to eq stats[:soft_attack]
    expect(division.hard_attack).to eq stats[:hard_attack]
    expect(division.air_attack).to eq stats[:air_attack]
    expect(division.defense).to eq stats[:defense]
    expect(division.breakthrough).to eq stats[:breakthrough]
    expect(division.armor).to eq stats[:armor]
    expect(division.piercing).to eq stats[:piercing]
    expect(division.initiative).to eq stats[:initiative]
    expect(division.entrenchment).to eq stats[:entrenchment]
    expect(division.equipment_capture_factor).to eq stats[:equipment_capture_factor]
    expect(division.combat_width).to eq stats[:combat_width]
    # Right Column
    expect(division.manpower).to eq stats[:manpower]
    expect(division.training_time).to eq stats[:training_time]
    expect(division.equipment).to eq stats[:equipment]
    expect(division.ic_cost).to eq stats[:ic_cost]
    expect(division.fuel_consumption).to eq stats[:fuel_consumption]
    expect(division.fuel_capacity).to eq stats[:fuel_capacity]
    # Adjusters
    expect(division.terrain_bonuses).to eq stats[:terrain_bonuses]
    expect(division.special_forces).to eq stats[:special_forces]
    expect(division.can_be_parachuted?).to eq stats[:can_be_parachuted]
    expect(division.hardness).to eq stats[:hardness]
  end

  describe "2inf, no tech" do
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
        equipment: {"infantry_equipment_0" => 200},
        ic_cost: 80,
        terrain_bonuses: {},
      }
    end
  end

  describe "6cav, no tech" do
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
        equipment: {"infantry_equipment_0" => 720},
        ic_cost: 288,
        terrain_bonuses: {
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
        equipment: {"infantry_equipment_0" => 480},
        ic_cost: 192,
        terrain_bonuses: {
          "hills" => {"movement" => 0.05, "attack" => 0.10, "defence" => 0.025},
          "mountain" => {"movement" => 0.10, "attack" => 0.175, "defence" => 0.05},
        },
        special_forces: 2,
      }
    end
  end

  describe "7inf 2art" do
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
        equipment: {"infantry_equipment_0" => 700, "artillery_equipment_1" => 72},
        ic_cost: 532,
        terrain_bonuses: { # different rounding in game
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
        equipment: {"infantry_equipment_0" => 390, "artillery_equipment_1" => 12},
        ic_cost: 198,
        terrain_bonuses: {},
        special_forces: 3,
        can_be_parachuted: true,
      }
    end
  end

  describe "4mot + 4rart + support art" do
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
          "infantry_equipment_0" => 400,
          "artillery_equipment_1" => 12,
          "motorized_equipment_1" => 260,
          "motorized_rocket_equipment_1" => 80,
        },
        ic_cost: 1812,
        hardness: 0.1,
        terrain_bonuses: {
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
        fuel_consumption: 10.08,
        fuel_capacity: 290.3,
      }
    end
  end

  describe "late game bonuses" do
    let(:tech_year) { 1950 }
    let(:units) { {motorized: 10} }
    it do
      expect(division.hardness).to eq 0.2
      expect(division.piercing).to eq 30.0
    end
  end

  describe "10inf + support art; some tech" do
    let(:tech) { %W[infantry_weapons infantry_weapons1 gw_artillery] }
    let(:units) { {infantry: 10, artillery: 1} }
    it do
      expect_stats division, {
        speed: 4.0,
        hp: 250.2,
        org: 54.545, # displayed 54.5
        recovery_rate: 0.282, # displayed 0.28
        suppression: 10.0,
        weight: 5.1,
        supply_use: 0.86,
        soft_attack: 75.0,
        hard_attack: 11.2,
        defense: 226.0,
        breakthrough: 33.6,
        piercing: 4.455, # displayed 4.4
        combat_width: 20,
        manpower: 10300,
        training_time: 120,
        equipment: {
          "infantry_equipment_1" => 1000,
          "artillery_equipment_1" => 12,
        },
        ic_cost: 542,
        terrain_bonuses: {},
      }
    end
  end

  describe "1940 tech 7/2 + supports" do
    let(:tech_year) { 1940 }
    let(:units) { {infantry: 7, artillery_brigade: 2, recon: 1, engineer: 1, artillery: 1} }
    it do
      expect_stats division, {
        speed: 4.0,
        hp: 180.4,
        org: 38.333, # displayed 38.3
        recovery_rate: 0.25,
        recon: 3,
        suppression: 7.0,
        weight: 4.8,
        supply_use: 1.09,
        soft_attack: 170.7,
        hard_attack: 17.35, # displayed 17.3
        defense: 309.2,
        breakthrough: 58.4,
        piercing: 5.0,
        entrenchment: 7,
        combat_width: 20,
        manpower: 9100,
        training_time: 120,
        equipment: {
          "infantry_equipment_2" => 750,
          "artillery_equipment_2" => 84,
          "support_equipment_1" => 40,
        },
        ic_cost: 946,
        terrain_bonuses: {
          "forest"=>{"movement"=>0.106, "attack"=>-0.044, "defence"=>0.25},
          "hills"=>{"movement"=>0.089, "defence"=>0.1},
          "mountain"=>{"movement"=>0.056},
          "plains"=>{"movement"=>0.1},
          "jungle"=>{"movement"=>0.056, "attack"=>-0.056, "defence"=>0.25},
          "marsh"=>{"movement"=>0.233, "attack"=>-0.044, "defence"=>0.25},
          "fort"=>{"attack"=>0.222, "defence"=>0.35},
          "river"=>{"movement"=>0.306, "attack"=>-0.044, "defence"=>0.25},
          "amphibious"=>{"attack"=>0.161}, # displayed 0.162
          # Not displayed:
          "desert"=>{"movement"=>0.1},
        },
      }
    end
  end

  describe "1945 + doctrine + monster armored division" do
    let(:tech_year) { 1945 }
    let(:doctrine) { "Superior Firepower / Integrated Support / Shock & Awe" }
    let(:units) { {
      heavy_armor: 5,
      heavy_sp_anti_air_brigade: 5,
      heavy_tank_destroyer_brigade: 5,
      heavy_sp_artillery_brigade: 5,
      maintenance_company: 1,
      signal_company: 1,
      field_hospital: 1,
      logistics_company: 1,
      rocket_artillery: 1,
    } }
    it do
      expect_stats division, {
        speed: 6.0,
        hp: 24.2,
        org: 9.2,
        recovery_rate: 0.252, # displayed 0.25
        weight: 30.5,
        supply_use: 4.056, # displayed 4.05
        reliability_factor: 0.20,
        casualty_trickleback: 0.50,
        experience_loss_factor: -0.40,

        # Game seems to lose 10% bonus for rocket art here somehow
        # applying only +90% not +100%
        soft_attack: 783.25, # in game: 779.4
        hard_attack: 543.05, # displaed 543.0
        air_attack: 220.0,
        defense: 140.0,
        breakthrough: 422.9,
        armor: 100.6,
        piercing: 110.488, # displayed 110.4
        initiative: 0.56,
        equipment_capture_factor: 0.20,
        combat_width: 40,

        manpower: 12300,
        training_time: 180,
        equipment: {
          "rocket_artillery_equipment_2" => 24,
          "motorized_equipment_1" => 40,
          "support_equipment_1" => 95,
          "heavy_tank_equipment_3" => 200,
          "heavy_tank_artillery_equipment_3" => 120,
          "heavy_tank_destroyer_equipment_3" => 100,
          "heavy_tank_aa_equipment_3" => 40,
        },
        ic_cost: 14400,
        hardness: 0.875, # displayed 0.87
        terrain_bonuses: {
          "forest" => {"movement"=>-0.4, "attack"=>-0.4},
          "hills" => {"attack"=>-0.2},
          "mountain" => {"attack"=>-0.3},
          "urban" => {"attack"=>-0.5, "defence"=>-0.2},
          "jungle" => {"movement"=>-0.4, "attack"=>-0.6},
          "marsh" => {"movement"=>-0.2, "attack"=>-0.4},
          "fort" => {"attack"=>0.038},
          "river" => {"movement"=>-0.4, "attack"=>-0.4},
          "amphibious" => {"attack"=>-0.8},
        },
        fuel_consumption: 39.6,
        fuel_capacity: 1425.6,
      }
    end
  end

  describe "Kaiserreich" do
    let(:db) { Database.new("kaiserreich") }
    describe "2 militia, no tech" do
      let(:units) { {militia: 2} }
      it do
        expect_stats division, {
          speed: 4.0,
          hp: 40.0,
          org: 40.0,
          suppression: 2.0,
          weight: 1.0,
          supply_use: 0.08,
          soft_attack: 3.0,
          hard_attack: 0.5,
          defense: 28.0,
          breakthrough: 2.8,
          piercing: 1.0,
          combat_width: 4,
          manpower: 3000,
          training_time: 40,
          equipment: {"infantry_equipment_0" => 150},
          ic_cost: 60,
          terrain_bonuses: {},
          recovery_rate: 0.35,
        }
      end
    end
  end

  describe "Warnings" do
    let(:tech_year) { 1945 }
    describe "No units" do
      let(:units) { {} }
      it do
        expect(warnings).to eq(["No frontline battalions"])
      end
    end

    describe "Only support units" do
      let(:units) { { recon: 1, artillery: 1 } }
      it do
        expect(warnings).to eq(["No frontline battalions"])
      end
    end

    describe "Too many frontline units" do
      let(:units) { { cavalry: 35 } }
      it do
        expect(warnings).to eq(["35/25 frontline battalions"])
      end
    end

    describe "Too many supports" do
      let(:units) { { infantry: 5, recon: 1, artillery: 1, anti_air: 1, engineer: 1, maintenance_company: 1, anti_tank: 1 } }
      it do
        expect(warnings).to eq(["6/5 support companies"])
      end
    end

    describe "Too many frontline and support units" do
      let(:units) { { cavalry: 35, recon: 1, artillery: 1, anti_air: 1, engineer: 1, maintenance_company: 1, anti_tank: 1 } }
      it do
        expect(warnings).to match_array(["35/25 frontline battalions", "6/5 support companies"])
      end
    end

    describe "Too many brigades" do
      let(:units) { { infantry: 6, cavalry: 6, light_armor: 6 } }
      it do
        expect(warnings).to eq(["6/5 brigades"])
      end
    end
  end

  describe "Fallback equipment" do
    let(:tech_year) { 1933 }
    # let(:tech_year) { 1942 }
    let(:units) { { medium_armor: 5, motorized: 5, artillery: 1, engineer: 1 } }
    it do
      expect(warnings).to match_array([
        "Missing equipment: Medium Tank I",
        "Missing equipment: Motorized",
        "Missing equipment: Towed Artillery",
      ])
      expect(division.equipment).to eq({
        "artillery_equipment_1" => 12,
        "infantry_equipment_0" => 510,
        "medium_tank_equipment_1" => 250,
        "motorized_equipment_1" => 250,
        "support_equipment_1" => 30,
      })
    end
  end
end

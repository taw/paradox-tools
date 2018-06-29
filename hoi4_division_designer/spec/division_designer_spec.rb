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
        air_attack: 0.0,
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
end

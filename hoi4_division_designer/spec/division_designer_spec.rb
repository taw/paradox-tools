describe DivisionDesigner do
  let(:division_designer) { DivisionDesigner.new }
  let(:division) { division_designer.division(units) }

  describe "2inf, no tech" do
    let(:tech) { nil }
    let(:units) { {infantry: 2} }
    it do
      # Left Column
      expect(division.speed).to eq 4.0
      expect(division.hp).to eq 50.0
      expect(division.org).to eq 60.0
      expect(division.recovery_rate).to eq 0.30
      expect(division.reconnaissance).to eq 0.0
      expect(division.suppression).to eq 2.0
      expect(division.weight).to eq 1.0
      expect(division.supply_use).to eq 0.0
      expect(division.reliability).to eq 0.0
      expect(division.trickleback).to eq 0.0
      expect(division.exp_loss).to eq 0.0
      # Middle Column
      expect(division.soft_attack).to eq 6.0
      expect(division.hard_attack).to eq 1.0
      expect(division.air_attack).to eq 0.0
      expect(division.defense).to eq 40.0
      expect(division.breakthrough).to eq 4.0
      expect(division.armor).to eq 0.0
      expect(division.piercing).to eq 1.0
      expect(division.initiative).to eq 0.0
      expect(division.entrechment).to eq 0.0
      expect(division.equipment_capture_rate).to eq 0.0
      expect(division.combat_width).to eq 4
      # Right Column
      expect(division.manpower).to eq 2000
      expect(division.training_time).to eq 90
      expect(division.equipment).to eq("basic infantry equipment" => 200)
      # Adjusters
      expect(division.bonuses).to eq({})
    end
  end
end

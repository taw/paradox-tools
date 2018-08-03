describe Equipment do
  let(:db) { Database.new("vanilla") }
  let(:equipment_type) { db.equipment_types[type] }
  let(:base_equipment) { Equipment.new(db, equipment_type, {}) }
  let(:variant_equipment) { Equipment.new(db, equipment_type, upgrades) }
  let(:variant_bonus) { variant_equipment.variant_bonus }
  let(:actual_diff) {
    Equipment::UPGRADABLE_STATS.map{|stat|
      base_value = base_equipment.send(stat)
      variant_value = variant_equipment.send(stat)
      if base_value != variant_value
        [stat, [base_value, variant_value]]
      end
    }.compact.to_h
  }

  describe "Light Tank" do
    let(:type) { "light_tank_equipment_1" }
    describe "5 armor 2 engine" do
      let(:upgrades) { {
        "tank_armor_upgrade" => 5,
        "tank_engine_upgrade" => 2,
      } }
      let(:expected_diff) { {
        "armor_value" => [10.0, 12.5],
        "reliability" => [0.8, 0.6],
        "maximum_speed" => [10.0, 9.8],
      } }
      it do
        expect(variant_bonus).to eq({
          "armor_value" => 0.25,
          "maximum_speed" => -0.02,
          "reliability" => -0.25,
        })
        expect(actual_diff).to eq(expected_diff)
      end
    end

    describe "2 reliability 4 main gun" do
      let(:upgrades) { {
        "tank_reliability_upgrade" => 2,
        "tank_gun_upgrade" => 4,
      } }
      let(:expected_diff) { {
        "ap_attack" => [10.0, 12.0],
        "soft_attack" => [13.0, 14.56],
        "hard_attack" => [4.0, 5.6],
        "maximum_speed" => [10.0, 9.2],
      } }
      it do
        expect(actual_diff).to eq(expected_diff)
      end
    end
  end
end

describe Country do
  let(:db) { Database.new }
  let(:country) { db.country(tech) }
  let(:equipment_map) {
    country.equipment_map.map{|k,v| [k, v.name]}.to_h
  }
  let(:available_units) { country.available_units.map(&:name) }

  describe "no techs" do
    let(:tech) { [] }
    it do
      expect(equipment_map).to eq({})
      expect(available_units).to eq([])
    end
  end

  describe "basic techs" do
    let(:tech) { ["infantry_weapons"] }
    it do
      expect(equipment_map).to eq({
        "infantry_equipment" => "infantry_equipment_0",
      })
      expect(available_units).to match_array(["infantry", "cavalry"])
    end
  end

  describe "some more techs" do
    let(:tech) { [
      "infantry_weapons", "infantry_weapons1", "infantry_weapons2", "improved_infantry_weapons",
      "marines",
      "motorised_infantry",
      "gw_artillery",
    ] }
    it do
      expect(equipment_map).to eq({
        "infantry_equipment" => "infantry_equipment_2",
        "artillery_equipment" => "artillery_equipment_1",
        "motorized_equipment" => "motorized_equipment_1",
      })
      expect(available_units).to match_array([
        "infantry", "cavalry", "artillery", "artillery_brigade", "marine", "motorized"
      ])
    end
  end

  describe "unit bonuses" do
    let(:tech) { db.techs_up_to(1942) }
    it do
      expect(country.unit_bonuses).to eq({
        "artillery" => {"soft_attack" => 0.3},
        "artillery_brigade" => {"soft_attack" => 0.3},
        "rocket_artillery" => {"soft_attack" => 0.3},
        "rocket_artillery_brigade" => {"soft_attack" => 0.3},
        "motorized_rocket_brigade" => {"soft_attack" => 0.3},
        "anti_air" => {"air_attack" => 0.3},
        "anti_air_brigade" => {"air_attack" => 0.3},
        "anti_tank" => {"ap_attack" => 0.4, "hard_attack" => 0.3},
        "anti_tank_brigade" => {"ap_attack" => 0.4, "hard_attack" => 0.3},
        "cavalry" => {"soft_attack" => 0.1, "breakthrough" => 0.08, "defense" => 0.08},
        "motorized" =>  {"soft_attack" => 0.1, "breakthrough" => 0.2, "defense" => 0.2, "hardness" => 1.0},
        "mechanized" => {"soft_attack" => 0.1, "breakthrough" => 0.2, "defense" => 0.2},
        "category_light_infantry" => {"soft_attack" => 0.1},
        "category_all_infantry" => {"ap_attack" => 1, "hard_attack" => 0.25},
        "paratrooper" =>  {"max_organisation" => 5, "soft_attack" => 0.05, "breakthrough" => 0.12, "defense" => 0.12},
        "marine" =>  {"max_organisation" => 5, "soft_attack" => 0.05, "breakthrough" => 0.12, "defense" => 0.12},
        "mountaineers" => {"max_organisation" => 5, "soft_attack" => 0.05, "breakthrough" => 0.12, "defense" => 0.12},
        "category_special_forces" => {
          "acclimatization_cold_climate_gain_factor" => 0.75,
          "acclimatization_hot_climate_gain_factor" => 0.75,
          "defense" => 0.05,
          "max_organisation" => 5,
        },
        "infantry" => {"breakthrough" => 0.2, "defense" => 0.2},
        "engineer" => {
          "entrenchment" => 4,
          "fort" => {"attack" => 0.1, "defence" => 0.1},
          "river" => {"attack" => 0.1, "defence" => 0.1}
        },
        "recon" => {"recon" => 4},
        "military_police" => {"suppression_factor" => 0.2},
        "maintenance_company" => {"equipment_capture_factor" => 0.1, "reliability_factor" => 0.1},
        "field_hospital" => {"casualty_trickleback" => 0.2, "experience_loss_factor" => -0.2},
        "logistics_company" => {"supply_consumption_factor" => -0.2},
        "signal_company" => {"initiative" => 0.24},
      })
    end
  end
end

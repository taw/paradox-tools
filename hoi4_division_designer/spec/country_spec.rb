describe Country do
  let(:db) { Database.new("vanilla") }
  let(:country) { db.country(tech) }
  let(:equipment_map) {
    country.equipment_map.map{|k,v| [k, v.key]}.to_h
  }
  let(:available_units) { country.available_units.map(&:key) }

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
        "infantry", "cavalry", "artillery", "artillery_brigade", "marine", "motorized", "mot_artillery_brigade",
      ])
    end
  end

  describe "unit bonuses" do
    let(:tech) { db.techs_up_to(1942) }
    it do
      expect(country.unit_bonuses).to eq({
        "amphibious_mechanized" => {"breakthrough" => 0.2, "defense" => 0.2, "soft_attack" => 0.1},        "artillery" => {"soft_attack" => 0.3},
        "anti_air_brigade" => {"air_attack" => 0.3},
        "anti_air" => {"air_attack" => 0.3},
        "anti_tank_brigade" => {"ap_attack" => 0.4, "hard_attack" => 0.3},
        "anti_tank" => {"ap_attack" => 0.4, "hard_attack" => 0.3},
        "artillery_brigade" => {"soft_attack" => 0.3},
        "battle_cruiser" => {"hg_armor_piercing" => 0.1, "hg_attack" => 0.4, "lg_armor_piercing" => 0.1, "lg_attack" => 0.4},
        "battleship" => {"hg_armor_piercing" => 0.1, "hg_attack" => 0.4, "lg_armor_piercing" => 0.1, "lg_attack" => 0.4},
        "bicycle_battalion" => {"breakthrough" => 0.2, "defense" => 0.2},
        "carrier" => {"lg_armor_piercing" => 0.1, "lg_attack" => 0.1},
        "category_all_infantry" => {"ap_attack" => 1, "hard_attack" => 0.25},
        "category_light_infantry" => {"soft_attack" => 0.1},
        "category_nav_bomber" => {"mines_planting" => 0.05},
        "category_special_forces" => {
          "acclimatization_cold_climate_gain_factor" => 0.75,
          "acclimatization_hot_climate_gain_factor" => 0.75,
          "defense" => 0.05,
          "max_organisation" => 5,
        },
        "category_strat_bomber" => {"mines_planting" => 0.13},
        "category_tac_bomber" => {"mines_planting" => 0.08},
        "cavalry" => {"soft_attack" => 0.1, "breakthrough" => 0.08, "defense" => 0.08},
        "destroyer" => {"hg_attack" => 0.05, "lg_armor_piercing" => 0.1, "lg_attack" => 0.15, "torpedo_attack" => 0.4},
        "engineer" => {
          "entrenchment" => 4,
          "terrain_bonuses" => {
            "fort" => {"attack" => 0.1, "defence" => 0.1},
            "river" => {"attack" => 0.1, "defence" => 0.1},
          },
        },
        "field_hospital" => {"casualty_trickleback" => 0.2, "experience_loss_factor" => -0.2},
        "heavy_cruiser" => {"hg_armor_piercing" => 0.1, "hg_attack" => 0.25, "lg_armor_piercing" => 0.1, "lg_attack" => 0.25, "torpedo_attack" => 0.4},
        "infantry" => {"breakthrough" => 0.2, "defense" => 0.2},
        "light_cruiser" => {"hg_attack" => 0.1, "lg_armor_piercing" => 0.2, "lg_attack" => 0.3, "torpedo_attack" => 0.4},
        "logistics_company" => {"fuel_consumption_factor" => -0.1, "supply_consumption_factor" => -0.2},
        "maintenance_company" => {"equipment_capture_factor" => 0.1, "reliability_factor" => 0.1},
        "marine" =>  {"max_organisation" => 5, "soft_attack" => 0.05, "breakthrough" => 0.12, "defense" => 0.12},
        "mechanized" => {"soft_attack" => 0.1, "breakthrough" => 0.2, "defense" => 0.2},
        "military_police" => {"suppression_factor" => 0.2},
        "mot_anti_air_brigade" => {"air_attack" => 0.3, "hardness" => 1.0},
        "mot_anti_tank_brigade" => {"ap_attack" => 0.4, "hard_attack" => 0.3, "hardness" => 1.0},
        "mot_artillery_brigade" => {"hardness" => 1.0, "soft_attack" => 0.3},
        "mot_rocket_artillery_brigade" => {"hardness" => 1.0, "soft_attack" => 0.3},
        "motorized_rocket_brigade" => {"soft_attack" => 0.3},
        "motorized" =>  {"soft_attack" => 0.1, "breakthrough" => 0.2, "defense" => 0.2, "hardness" => 1.0},
        "mountaineers" => {"max_organisation" => 5, "soft_attack" => 0.05, "breakthrough" => 0.12, "defense" => 0.12},
        "paratrooper" =>  {"max_organisation" => 5, "soft_attack" => 0.05, "breakthrough" => 0.12, "defense" => 0.12},
        "recon" => {"recon" => 4},
        "rocket_artillery_brigade" => {"soft_attack" => 0.3},
        "rocket_artillery" => {"soft_attack" => 0.3},
        "signal_company" => {"initiative" => 0.24},
        "submarine" => {"mines_planting" => 0.2, "torpedo_attack" => 0.4},
      })

      # marine, category_light_infantry, category_all_infantry, category_special_forces
      expect(country.unit_bonuses_for("marine")).to eq({
        "acclimatization_cold_climate_gain_factor" => 0.75,
        "acclimatization_hot_climate_gain_factor" => 0.75,
        "ap_attack" => 1,
        "breakthrough" => 0.12,
        "defense" => 0.17,
        "hard_attack" => 0.25,
        "max_organisation" => 10,
        "soft_attack" => 0.15,
      })

      # motorized, category_all_infantry
      expect(country.unit_bonuses_for("motorized")).to eq({
        "ap_attack" => 1,
        "breakthrough" => 0.2,
        "defense" => 0.2,
        "hard_attack" => 0.25,
        "hardness" => 1.0,
        "soft_attack" => 0.1,
      })

      # Just motorized_rocket_brigade
      expect(country.unit_bonuses_for("motorized_rocket_brigade")).to eq({
        "soft_attack" => 0.3,
      })
    end
  end
end

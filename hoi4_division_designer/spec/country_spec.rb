describe Country do
  let(:db) { Database.new }
  let(:country) { db.country(tech) }
  let(:equipment_map) {
    country.equipment_map.map{|k,v| [k, v.name]}.to_h
  }
  let(:available_units) { country.available_units }

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
      expect(available_units).to eq(["infantry", "cavalry"])
    end
  end

  describe "some more techs" do
    let(:tech) { ["infantry_weapons", "infantry_weapons1", "marines"] }
    it do
      expect(equipment_map).to eq({
        "infantry_equipment" => "infantry_equipment_1",
        "artillery_equipment" => "artillery_equipment_1",
        "motorized_equipment" => "motorized_equipment_1",
      })
      expect(available_units).to eq(["infantry", "cavalry", "artillery", "artillery_brigade", "marines", "motorized"])
    end
  end
end

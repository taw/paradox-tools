describe Division do
  let(:db) { Database.new("millennium_dawn") }

  it "does not include impossible equipments" do
    expect(db.equipment_types["CAS_equipment_2"]).to be_nil
  end

  it "does not include impossible units" do
    expect(db.unit_types["heavy_tank_destroyer_brigade"]).to be_nil
  end
end

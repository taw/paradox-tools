describe Technology do
  let(:db) { Database.new("vanilla") }

  it "groups unit bonuses, terrain bonuses, and paths" do
    expect(db.technology["tech_engineers3"].effects).to eq({
      "categories"=>["support_tech", "engineers_tech"],
      "unit_bonuses" => {
        "engineer"=>{
          "entrenchment"=>2,
          "terrain_bonuses" => { "river"=>{"attack"=>0.1, "defence"=>0.1} },
        },
      },
      "leads_to"=>["tech_engineers4"],
      "research_cost"=>1.5,
      "start_year"=>1942,
      "name"=>"Engineer Company III",
    })
  end
end

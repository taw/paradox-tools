describe "CLI" do
  let(:bin) { Pathname("#{__dir__}/../bin") }

  it "available_doctrines" do
    expect(`#{bin}/available_doctrines`).to include "Superior Firepower / Dispersed Support / Shock & Awe"
  end

  it "available_units" do
    expect(`#{bin}/available_units kaiserreich`).to include "Medium SP Artillery [medium_sp_artillery_brigade] [not available]\n"
    expect(`#{bin}/available_units 1940`).to include "Medium Tank Destroyer [medium_tank_destroyer_brigade]\n"
    expect(`#{bin}/available_units millennium_dawn 2000`).to include "SP. Artillery [sp_artillery_brigade]\n"
  end

  it "available_years" do
    expect(`#{bin}/available_years`).to include("1950\n")
    expect(`#{bin}/available_years millennium_dawn`).to include "2030\n"
  end

  # division stats
  it "division_stats" do
    expect(`#{bin}/division_stats millennium_dawn 2000 10xinfantry`).to include "soft_attack: 101.25\n"
  end
end

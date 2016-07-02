class FocusResearchBonus
  def initialize(focus_name, bonus_name, uses: 1, bonus: nil, ahead: nil)
    raise "Must have some bonus for #{focus_name}" unless bonus or ahead

    @uses = uses
    @bonus = bonus
    @ahead = ahead
    @bonus_name = bonus_name.to_s
    @technologies = []
    @categories = []

    case @bonus_name
    when "land_doc"
      @categories = ["land_doctrine"]
    when "air_doc"
      @categories = ["air_doctrine"]
    when "infantry_weapons", "infantry_artillery"
      @categories = ["infantry_weapons", "artillery"]
    # motorised / motorized inconsistency is in the game
    when "motorized_equipment"
      @bonus_name = "motorized"
      @categories = ["motorized_equipment"]
    when "motorised_infantry"
      @bonus_name = "motorized"
      @technologies = ["motorised_infantry"]
    when "armor"
      @categories = ["armor"]
    when "special_forces"
      @technologies = ["paratroopers", "paratroopers2", "marines", "marines2", "tech_mountaineers", "tech_mountaineers2"]
    when "fighter"
      @technologies = %W[early_fighter	fighter1 fighter2	fighter3 heavy_fighter1	heavy_fighter2 heavy_fighter3]
    when "bomber"
      @technologies = %W[strategic_bomber1 strategic_bomber2 strategic_bomber3]
      @categories = %W[tactical_bomber]
    when "CAS"
      @categories = %W[cas_bomber]
    when "nav_bomber"
      @categories = %W[naval_bomber]
    when "jet_rocket"
      @categories = %W[rocketry jet_technology]
    when "fleet_in_being"
      @categories = %W[fleet_in_being_tree]
    when "sub_op"
      @technologies = %W[convoy_interdiction_ti unrestricted_submarine_warfare wolfpacks advanced_submarine_warfare combined_operations_raiding]
    when "industrial"
      @categories = %W[industry]
    when "ss"
      @technologies = %W[
        early_submarine
        basic_submarine
        improved_submarine
        advanced_submarine
      ]
    when "dd"
      @technologies = %W[
        early_destroyer
        basic_destroyer
        improved_destroyer
        advanced_destroyer
      ]
    when "cr"
      @technologies = %W[
        improved_light_cruiser
        advanced_light_cruiser
        improved_heavy_cruiser
        advanced_heavy_cruiser
      ]
    when "capital_ships"
      @technologies = %W[
        basic_battlecruiser
        basic_battleship
        improved_battleship
        advanced_battleship
        heavy_battleship
        heavy_battleship2
        early_carrier
        basic_carrier
        improved_carrier
        advanced_carrier
      ]
    when "secret"
      @categories = %W[
        electronics
        nuclear
        rocketry
      ]
    when "nuclear"
      @categories = %W[nuclear]
    else
      raise "Can't infer bonus name for #{bonus_name}"
    end
  end

  def to_plist
    reward = PropertyList[
      "name", "#{@bonus_name}_bonus",
    ]
    reward.add! "bonus", @bonus if @bonus
    reward.add! "ahead_reduction", @ahead if @ahead
    reward.add! "uses", @uses if @uses
		@categories.each do |c|
      reward.add! "category", c
    end
    @technologies.each do |t|
      reward.add! "technology", t
    end
    reward
  end
end

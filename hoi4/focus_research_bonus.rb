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
      @categories = ["artillery", "infantry_weapons"]
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

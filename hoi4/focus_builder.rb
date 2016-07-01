class FocusBuilder
  def initialize(prefix, name, &block)
    @prefix = prefix
    @name = name
    @x = nil
    @y = nil
    @prerequisites = []
    @reward = PropertyList[]
    @icon = nil
    instance_eval(&block)
  end

  def build
    Focus.new(@name, id_for_name(@name), @x, @y, @reward, @prerequisites, @icon || inferred_icon)
  end

  def loc(x,y)
    @x, @y = x, y
  end

  def req(*names)
    names.each do |name|
      @prerequisites << PropertyList["focus", id_for_name(name)]
    end
  end

  def army_xp(val)
    @reward.add! "army_experience", 5
  end

  def research_bonus(name, uses: 1, bonus: nil, ahead: nil)
    raise "Must have some bonus" unless bonus or ahead

    bonus_name, categories, technologies = categories_for_research_bonus(name.to_s)
    reward = PropertyList[
      "name", "#{bonus_name}_bonus",
    ]
    reward.add! "bonus", bonus if bonus
    reward.add! "ahead_reduction", ahead if ahead
    reward.add! "uses", uses if uses
		categories.each do |c|
      reward.add! "category", c
    end
    technologies.each do |t|
      reward.add! "technology", t
    end
    @reward.add! "add_tech_bonus", reward
  end

  def inferred_icon
    warn "No idea which icon to choose for #{@name}"
    "GFX_goal_generic_construct_infrastructure"
  end

  private

  def categories_for_research_bonus(name)
    bonus_name = name
    technologies = []
    categories = []
    case name
    when "land_doc"
      categories = ["land_doctrine"]
    when "infantry_weapons", "infantry_artillery"
      categories = ["artillery", "infantry_weapons"]
    # motorised / motorized inconsistency is in the game
    when "motorized_equipment"
      bonus_name = "motorized"
      categories = ["motorized_equipment"]
    when "motorised_infantry"
      bonus_name = "motorized"
      technologies = ["motorised_infantry"]
    when "armor"
      categories = ["armor"]
    when "special_forces"
      technologies = ["paratroopers", "paratroopers2", "marines", "marines2", "tech_mountaineers", "tech_mountaineers2"]
    else
      raise "Can't infer bonus name for #{name}"
    end
    [bonus_name, categories, technologies]
  end

  def id_for_name(name)
    "#{@prefix}_#{name.downcase.gsub(" ", "_")}"
  end
end

class FocusBuilder
  def initialize(prefix, name, icon:, x:, y:, &block)
    @prefix = prefix
    @name = name
    @x = x
    @y = y
    @icon = FocusIcon.new(name, icon).icon
    @available = nil
    @prerequisites = []
    @mutually_exclusive = []
    @reward = PropertyList[]
    instance_eval(&block)
  end

  def build
    raise "No icon for #{@name}" unless @icon
    raise "No X/Y for #{@name}" unless @x and @y
    Focus.new(@name, id_for_name(@name), x: @x, y: @y, reward: @reward, prerequisites: @prerequisites, icon: @icon, mutually_exclusive: @mutually_exclusive, available: @available)
  end

  def req(*names)
    names.each do |name|
      @prerequisites << PropertyList["focus", id_for_name(name)]
    end
  end

  def mutually_exclusive(name)
    @mutually_exclusive << name
  end

  def army_xp(val)
    @reward.add! "army_experience", val
  end

  def air_xp(val)
    @reward.add! "air_experience", val
  end

  def navy_xp(val)
    @reward.add! "navy_experience", val
  end

  def research_bonus(*args)
    @reward.add! "add_tech_bonus", FocusResearchBonus.new(@name, *args).to_plist
  end

  def available_if_has_coastal_state
    @available = PropertyList[
			"any_state", PropertyList[
				"is_coastal", true,
				"is_controlled_by", "ROOT",
			]
		]
  end

  private

  def id_for_name(name)
    "#{@prefix}_#{name.downcase.gsub(" ", "_")}"
  end
end

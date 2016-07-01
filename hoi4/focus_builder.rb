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
    @bypass = nil
    @ai = nil
    instance_eval(&block)
  end

  def build
    raise "No icon for #{@name}" unless @icon
    raise "No X/Y for #{@name}" unless @x and @y
    Focus.new(@name, id_for_name(@name),
      x: @x,
      y: @y,
      reward: @reward,
      prerequisites: @prerequisites,
      icon: @icon,
      mutually_exclusive: @mutually_exclusive,
      available: @available,
      bypass: @bypass,
      ai: @ai,
    )
  end

  def req(*names)
    @prerequisites << PropertyList[*names.map{|name| Property["focus", id_for_name(name)]}]
  end

  def mutually_exclusive(name)
    @mutually_exclusive << id_for_name(name)
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

  def bypass_if_has_tech(tech)
    @bypass = PropertyList["has_tech", tech]
  end

  def available_if_has_coastal_state
    @available = PropertyList[
			"any_state", PropertyList[
				"is_coastal", true,
				"is_controlled_by", "ROOT",
			]
		]
  end

  def ai_wont_do_without_coastal_province
    @ai = PropertyList[
      "factor", 1,
      "modifier", PropertyList[
        "factor", 0,
        "all_owned_state", PropertyList[
          "OR", PropertyList[
            "is_coastal", false,
            "dockyard", Property::LT[1],
          ]
        ]
      ]
    ]
  end

  private

  def id_for_name(name)
    "#{@prefix}_#{name.downcase.gsub(" ", "_")}"
  end
end

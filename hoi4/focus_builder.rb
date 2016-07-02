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
    @tooltip = PropertyList[]
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
      tooltip: (@tooltip == @reward ? nil : @tooltip),
    )
  end

  def req(*names)
    @prerequisites << PropertyList[*names.map{|name| Property["focus", id_for_name(name)]}]
  end

  def mutually_exclusive(name)
    @mutually_exclusive << id_for_name(name)
  end

  def army_xp(val)
    add_reward! Property["army_experience", val]
  end

  def air_xp(val)
    add_reward! Property["air_experience", val]
  end

  def navy_xp(val)
    add_reward! Property["navy_experience", val]
  end

  def research_slot
    add_reward! Property["add_research_slot", 1]
  end

  def research_bonus(*args)
    add_reward! Property["add_tech_bonus", FocusResearchBonus.new(@name, *args).to_plist]
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

  def ai_will_do_3x_unless_tiny
    @ai = PropertyList[
      "ai_will_do", PropertyList[
        "factor", 3,
        "modifier", PropertyList[
          "factor", 0,
          "date", Property::LT["1939-01-01"],
          "OR", PropertyList[
            "tag", "GXC",
            "tag", "YUN",
            "tag", "SHX",
            "tag", "XSM",
            "tag", "BEL",
            "tag", "LUX",
            "tag", "HOL",
            "tag", "DEN",
            "num_of_controlled_states", Property::LT[2],
          ],
        ],
      ],
    ]
  end

  def civ_factory(number)
    add_building! "industrial_complex", number
  end

  def mil_factory(number)
    add_building! "arms_factory", number
  end

  def dockyards(number, flag)
    add_building! "dockyard", number, flag
  end

  def air_base(number, flag)
    add_building! "air_base", number, flag
  end

  def infrastructure(number)
    add_building! "infrastructure", number
  end

  def ai_factor(n)
    # No idea why it's coded this way
    if n > 1
      @ai = PropertyList[
        "factor", n,
      ]
    else
      @ai = PropertyList[
        "factor", 1,
        "modifier", PropertyList[
          "factor", n,
          "always", true,
        ]
      ]
    end
  end

  private

  def add_building!(type, number, flag=nil)
    bonus = FocusBuildingBonus.new(type, number, flag)
    @tooltip.add_many! *bonus.tooltip
    @reward.add_many! *bonus.reward
  end

  def add_reward!(prop, tooltip=prop)
    @reward.add! prop
    @tooltip.add! prop
  end

  def id_for_name(name)
    "#{@prefix}_#{name.downcase.gsub(" ", "_")}"
  end
end

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

  def civ_factory(number)
    @tooltip.add! Property["add_extra_state_shared_building_slots", number]
    @tooltip.add! Property["add_building_construction", PropertyList[
      "type", "industrial_complex",
      "level", number,
      "instant_build", true,
    ]]
    @reward.add! Property["random_owned_state", PropertyList[
      "limit", PropertyList[
        "free_building_slots", PropertyList[
          "building", "industrial_complex",
          "size", Property::GT[number-1],
          "include_locked", true,
        ],
        "OR", PropertyList[
          "is_in_home_area", true,
          "NOT", PropertyList["owner", PropertyList["any_owned_state", PropertyList[
            "free_building_slots", PropertyList[
              "building", "industrial_complex",
              "size", Property::GT[number-1],
              "include_locked", true,
            ],
            "is_in_home_area", true,
          ]]],
        ],
      ],
      "add_extra_state_shared_building_slots", number,
      "add_building_construction", PropertyList[
        "type", "industrial_complex",
        "level", number,
        "instant_build", true,
      ],
    ]]
  end

  def mil_factory(number)
    @tooltip.add! Property["add_extra_state_shared_building_slots", number]
    @tooltip.add! Property["add_building_construction", PropertyList[
      "type", "arms_factory",
      "level", number,
      "instant_build", true,
    ]]
    @reward.add! Property["random_owned_state", PropertyList[
      "limit", PropertyList[
        "free_building_slots", PropertyList[
          "building", "arms_factory",
          "size", Property::GT[number-1],
          "include_locked", true,
        ],
        "OR", PropertyList[
          "is_in_home_area", true,
          "NOT", PropertyList["owner", PropertyList["any_owned_state", PropertyList[
            "free_building_slots", PropertyList[
              "building", "arms_factory",
              "size", Property::GT[number-1],
              "include_locked", true,
            ],
            "is_in_home_area", true,
          ]]],
        ],
      ],
      "add_extra_state_shared_building_slots", number,
      "add_building_construction", PropertyList[
        "type", "arms_factory",
        "level", number,
        "instant_build", true,
      ],
    ]]
  end

  # This only works with number=3, and focus=Naval Effort
  def dockyards(number)
    @tooltip.add! Property["add_extra_state_shared_building_slots", number]
    @tooltip.add! Property["add_building_construction", PropertyList[
      "type", "dockyard",
      "level", number,
      "instant_build", true,
    ]]
    @tooltip.add! Property[
      "if", PropertyList[
        "limit", PropertyList[
          "NOT", PropertyList["any_owned_state", PropertyList[
            "dockyard", Property::GT[0],
            "free_building_slots", PropertyList[
              "building", "dockyard",
              "size", Property::GT[2],
              "include_locked", true,
            ],
          ]],
          "any_owned_state", PropertyList["is_coastal", true],
        ],
        "random_owned_state", PropertyList[
          "limit", PropertyList[
            "is_coastal", true,
            "free_building_slots", PropertyList[
              "building", "dockyard",
              "size", Property::GT[2],
              "include_locked", true,
            ],
          ],
          "add_extra_state_shared_building_slots", 3,
          "add_building_construction", PropertyList[
            "type", "dockyard",
            "level", 3,
            "instant_build", true,
          ],
        ],
        "set_country_flag", "naval_effort_built",
      ]
    ]
    @tooltip.add! Property[
      "if", PropertyList[
        "limit", PropertyList[
          "NOT", PropertyList["has_country_flag", "naval_effort_built"],
          "any_owned_state", PropertyList[
            "dockyard", Property::GT[0],
            "free_building_slots", PropertyList[
              "building", "dockyard",
              "size", Property::GT[2],
              "include_locked", true,
            ],
          ],
        ],
        "random_owned_state", PropertyList[
          "limit", PropertyList[
            "dockyard", Property::GT[0],
            "free_building_slots", PropertyList[
              "building", "dockyard",
              "size", Property::GT[2],
              "include_locked", true,
            ],
          ],
          "add_extra_state_shared_building_slots", 3,
          "add_building_construction", PropertyList[
            "type", "dockyard",
            "level", 3,
            "instant_build", true,
          ],
        ],
        "set_country_flag", "naval_effort_built",
      ],
    ]
    @tooltip.add! Property[
      "if", PropertyList[
        "limit", PropertyList[
          "NOT", PropertyList["has_country_flag", "naval_effort_built"],
          "NOT", PropertyList["any_owned_state", PropertyList["free_building_slots", PropertyList[
            "building", "dockyard",
            "size", Property::GT[2],
            "include_locked", true,
          ]]],
        ],
        "random_state", PropertyList[
          "limit", PropertyList[
            "controller", PropertyList["tag", "ROOT"],
            "free_building_slots", PropertyList[
              "building", "dockyard",
              "size", Property::GT[2],
              "include_locked", true,
            ],
          ],
          "add_extra_state_shared_building_slots", 3,
          "add_building_construction", PropertyList[
            "type", "dockyard",
            "level", 3,
            "instant_build", true,
          ],
        ],
      ],
    ]
  end

  private

  def add_reward!(prop, tooltip=prop)
    @reward.add! prop
    @tooltip.add! prop
  end

  def id_for_name(name)
    "#{@prefix}_#{name.downcase.gsub(" ", "_")}"
  end
end

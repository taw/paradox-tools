class FocusBuildingBonus
  attr_reader :tooltip, :reward
  def initialize(type, number, flag=nil)
    @tooltip = []
    @reward = []
    @type = type
    @number = number
    @flag = flag

    case @type
    when "arms_factory", "industrial_complex"
      add_regular_building!
    when "dockyard"
      add_dockyard!
    when "air_base"
      add_air_base!
    when "infrastructure"
      add_infrastructure!
    else
      raise "No idea how to build #{@type}"
    end
  end

  private

  def add_infrastructure!
    @number.times do
      @tooltip << add_building(@type, 1)
      @reward << Property["random_owned_state", PropertyList[
        "limit", PropertyList[
          has_free_building_slots(@type, 1),
          "OR", PropertyList[
            "is_in_home_area", true,
            "NOT", PropertyList[
              "owner", PropertyList[
                "any_owned_state", PropertyList[
                  has_free_building_slots(@type, 1),
                  "is_in_home_area", true,
                ],
              ],
            ],
          ],
        ],
        add_building(@type, 1),
      ]]
    end
  end

  def add_air_base!
    @tooltip << Property[
      "if", PropertyList[
        "limit", PropertyList["has_country_flag", @flag],
        add_building(@type, @number),
      ]
    ]
    @reward << Property["if", PropertyList[
      "limit", PropertyList[
        "capital_scope", PropertyList[
          "NOT", PropertyList[has_free_building_slots(@type, @number)]
        ],
      ],
      "random_owned_state", PropertyList[
        "limit", PropertyList[has_free_building_slots(@type, @number)],
        add_building(@type, @number),
        "ROOT", PropertyList["set_country_flag", @flag],
      ],
    ]]
    @reward << Property["if", PropertyList[
      "limit", PropertyList[
        "capital_scope", PropertyList[has_free_building_slots(@type, @number)]
      ],
      "capital_scope", PropertyList[
        add_building(@type, @number),
        "ROOT", PropertyList["set_country_flag", @flag],
      ],
    ]]
  end

  def add_regular_building!
    @tooltip << extra_slots(@number)
    @tooltip << add_building(@type, @number)
    @reward << Property[
      "random_owned_state", PropertyList[
        "limit", PropertyList[
          has_free_building_slots(@type, @number),
          "OR", PropertyList[
            "is_in_home_area", true,
            "NOT", PropertyList[
              "owner", PropertyList[
                "any_owned_state", PropertyList[
                  has_free_building_slots(@type, @number),
                  "is_in_home_area", true,
                ],
              ],
            ],
          ],
        ],
        extra_slots(@number),
        add_building(@type, @number),
      ],
    ]
  end

  def add_dockyard!
    @tooltip << extra_slots(@number)
    @tooltip << add_building(@type, @number)
    @reward << Property[
      "if", PropertyList[
        "limit", PropertyList[
          "NOT", PropertyList["any_owned_state", PropertyList[
            "dockyard", Property::GT[0],
            has_free_building_slots(@type, @number),
          ]],
          "any_owned_state", PropertyList["is_coastal", true],
        ],
        "random_owned_state", PropertyList[
          "limit", PropertyList[
            "is_coastal", true,
            has_free_building_slots(@type, @number),
          ],
          extra_slots(@number),
          add_building(@type, @number),
        ],
        "set_country_flag", @flag,
      ]
    ]
    @reward << Property[
      "if", PropertyList[
        "limit", PropertyList[
          "NOT", PropertyList["has_country_flag", @flag],
          "any_owned_state", PropertyList[
            "dockyard", Property::GT[0],
            has_free_building_slots(@type, @number),
          ],
        ],
        "random_owned_state", PropertyList[
          "limit", PropertyList[
            "dockyard", Property::GT[0],
            has_free_building_slots(@type, @number),
          ],
          extra_slots(@number),
          add_building(@type, @number),
        ],
        "set_country_flag", @flag,
      ],
    ]
    @reward << Property[
      "if", PropertyList[
        "limit", PropertyList[
          "NOT", PropertyList["has_country_flag", @flag],
          "NOT", PropertyList["any_owned_state", PropertyList[
            has_free_building_slots(@type, @number),
          ]],
        ],
        "random_state", PropertyList[
          "limit", PropertyList[
            "controller", PropertyList["tag", "ROOT"],
            has_free_building_slots(@type, @number),
          ],
          extra_slots(@number),
          add_building(@type, @number),
        ],
      ],
    ]
  end

  def extra_slots(n)
    Property["add_extra_state_shared_building_slots", n]
  end

  def add_building(type, number)
    Property["add_building_construction", PropertyList[
      "type", type,
      "level", number,
      "instant_build", true,
    ]]
  end

  def has_free_building_slots(type, number)
    case type
    when "air_base", "infrastructure"
      Property["free_building_slots", PropertyList[
        "building", type,
        "size", Property::GT[number-1],
      ]]
    else
      Property["free_building_slots", PropertyList[
        "building", type,
        "size", Property::GT[number-1],
        "include_locked", true,
      ]]
    end
  end
end

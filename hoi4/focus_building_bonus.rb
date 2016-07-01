class FocusBuildingBonus
  attr_reader :tooltip, :reward
  def initialize(type, number, flag=nil)
    @tooltip = []
    @reward = []
    @type = type
    @number = number

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

  private

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
    Property["free_building_slots", PropertyList[
      "building", type,
      "size", Property::GT[number-1],
      "include_locked", true,
    ]]
  end
end

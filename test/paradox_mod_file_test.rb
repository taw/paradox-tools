require_relative "test_helper"

class ParadoxModFileTest < MiniTest::Test
  def assert_parse_tree(number, expected)
    parsed = ParadoxModFile.new(path: "#{__dir__}/sample_#{number}.txt").parse!
    assert_equal parsed, expected
  end

  def test_sample_1
    assert_parse_tree 1, PropertyList[
      "country_decisions", PropertyList[
        "partial_westernization", PropertyList[
          "major", true,
          "potential", PropertyList[
            "OR", PropertyList[
              "technology_group", "south_american",
              "technology_group", "mesoamerican",
              "technology_group", "north_american",
              "technology_group", "sub_saharan",
              "technology_group", "chinese",
              "technology_group", "indian",
            ],
            "is_subject", false,
          ],
          "allow", PropertyList[
            "stability", 2,
            "is_at_war", false,
            "adm_power", 200,
            "dip_power", 200,
            "mil_power", 200,
            "any_neighbor_country", PropertyList[
              "OR", PropertyList[
                "technology_group", "muslim",
                "technology_group", "eastern",
                "technology_group", "ottoman",
                "technology_group", "western",
              ],
            ],
          ],
          "effect", PropertyList[
            "change_technology_group", "muslim",
            "add_stability", -5,
            "add_adm_power", -200,
            "add_dip_power", -200,
            "add_mil_power", -200,
            "add_country_modifier", PropertyList[
              "name", "western_influences",
              "duration", 3650,
            ],
          ],
          "ai_will_do", PropertyList["factor", 1],
        ],
      ],
    ]
  end

  def test_sample_2
    assert_parse_tree 2, PropertyList[
      "decisions", PropertyList[
        "commit_suicide", PropertyList[
          "potential", PropertyList["age", 16],
          "allow", PropertyList["age", 16],
          "effect", PropertyList[
            "death", PropertyList["death_reason", "death_suicide"],
          ],
          "revoke_allowed", PropertyList["always", false],
          "ai_will_do", PropertyList["factor", 0],
        ],
      ],
      "vassal_decisions", PropertyList[
        "adopt_decision", PropertyList[
          "from_potential", PropertyList["age", 16, "is_female", false],
          "potential", PropertyList[
            "NOT", PropertyList["is_child_of", "FROM"],
          ],
          "allow", PropertyList[
            "NOT", PropertyList["is_child_of", "FROM"],
            "opinion", PropertyList["who", "FROM", "value", 50],
          ],
          "effect", PropertyList["set_father", "FROM", "dynasty", "FROM"],
          "revoke_allowed", PropertyList["always", false],
          "ai_will_do", PropertyList["factor", 0],
        ],
        "disinherit_decision", PropertyList[
          "from_potential", PropertyList["age", 16, "is_female", false],
          "potential", PropertyList["is_child_of", "FROM"],
          "allow", PropertyList["is_child_of", "FROM"],
          "effect", PropertyList["set_father", 0],
          "revoke_allowed", PropertyList["always", false],
          "ai_will_do", PropertyList["factor", 0],
        ],
      ],
    ]
  end

  def test_sample_3
    assert_parse_tree 3, PropertyList[
      "title", "c_cagliari",
      "max_settlements", 4,
      "b_cagliari", "castle",
      "b_ogliastra", "city",
      "b_assemini", "temple",
      "culture", "italian",
      "religion", "norse_pagan",
      "terrain", "hills",
      Date.new(867, 1, 1), PropertyList["b_cagliari", "ca_shipyard_1"],
      Date.new(1066, 1, 1), PropertyList["trade_post", "b_caetani"],
      Date.new(1285, 1, 1), PropertyList["trade_post", "b_grimaldi"],
    ]
  end

  def test_sample_4
    assert_parse_tree 4, PropertyList[
      "christian", PropertyList[
        "defender_of_faith", true,
        "catholic", PropertyList[
          "color", [0.8, 0.8, 0],
          "icon", 1,
          "allowed_conversion", ["reformed", "protestant"],
          "country", PropertyList["tolerance_own", 1, "tolerance_heretic", -1],
          "on_convert", PropertyList[
            "change_religion", "catholic",
            "add_prestige", -100,
            "remove_country_modifier", "the_test_act",
            "remove_country_modifier", "superintendent_office",
            "remove_country_modifier", "the_popery_act",
            "add_country_modifier", PropertyList["name", "conversion_zeal", "duration", 3650],
          ],
          "heretic", ["BOGOMILIST", "WALDENSIAN", "FRATICELLI", "HUSSITE", "LOLLARD", "SOCINIAN"],
          "papacy", true,
        ],
      ]
    ]
  end

  def test_sample_5
    assert_parse_tree 5, PropertyList[
      "government", "administrative_republic",
      "mercantilism", 0.1,
      "primary_culture", "dutch",
      "religion", "catholic",
      "technology_group", "western",
      "capital", 100,
      Date.new(1399, 1, 1), PropertyList["monarch",
        PropertyList[
          "name", "Fryske frijheid",
          "adm", 3,
          "dip", 3,
          "mil", 3,
          "regent", true,
        ],
      ],
      Date.new(1515, 1, 1), PropertyList["leader",
        PropertyList[
          "name", "Greate Pier",
          "type", "admiral",
          "rank", 0,
          "fire", 1,
          "shock", 1,
          "manuever", 2,
          "siege", 0,
          "death_date", Date.new(1520, 10, 28),
        ],
      ],
    ]
  end

  def test_sample_6
    assert_parse_tree 6, PropertyList[
       269, "Palenké",
       270, "Trakai",
       271, "Žemaitija",
       272, "Vilnius",
       277, "Brasta",
      1936, "Kaunas",
      1937, "Gardinas",
        40, "Klaipéda",
        41, "Karaliaucius",
        42, "Varmé",
        43, "Gdanskas",
      1841, "Marienburgas",
      1859, "Kulmas",
        35, "Sarema",
        36, "Talinas",
        37, "Césis",
        38, "Ryga",
        39, "Kuršas",
       273, "Daugpilis",
      1834, "Tartu",
      1842, "Narva",
      1935, "Žiemgala",
    ]
  end

  def test_sample_7_inequality
    assert_parse_tree 7, PropertyList[
      "OR", PropertyList[
        "num_of_factories", Property::GT[50],
        "any_country", PropertyList[
          "is_in_faction_with", "ROOT",
          "num_of_factories", Property::GT[50],
        ],
      ],
      "if", PropertyList[
        "limit", PropertyList["original_research_slots", Property::LT[3]],
        "add_research_slot", 1,
      ],
    ]
  end

  def test_sample_8_utf8bom
    assert_parse_tree 8, PropertyList[
      "division_template", PropertyList[
        "name", "División de Infanteria",
        "regiments", PropertyList[
          "infantry", PropertyList["x", 0, "y", 0],
          "infantry", PropertyList["x", 0, "y", 1],
          "infantry", PropertyList["x", 1, "y", 0],
          "infantry", PropertyList["x", 1, "y", 1],
        ],
      ],
      "units", PropertyList[
        "division", PropertyList[
          "name", "1era División de Infantería",
          "location", 10362,
          "division_template", "División de Infanteria",
          "start_experience_factor", 0.1,
          "start_equipment_factor", 0.3,
        ],
        "division", PropertyList[
          "name", "2da División de Infantería",
          "location", 10362,
          "division_template", "División de Infanteria",
          "start_experience_factor", 0.1,
          "start_equipment_factor", 0.3,
        ],
        "navy", PropertyList[
          "name", "Armada Nacional",
          "base", 10362,
          "location", 10362,
          "ship", PropertyList[
            "name", "ROU Uruguay",
            "definition", "destroyer",
            "equipment", PropertyList["destroyer_1", PropertyList[
              "amount", 1,
              "owner", "URG",
            ]],
          ],
        ],
      ],
      "instant_effect", PropertyList["add_equipment_production", PropertyList[
        "equipment", PropertyList[
          "type", "infantry_equipment_0",
          "creator", "URG",
        ],
        "requested_factories", 1,
        "progress", 0.79,
        "efficiency", 100,
      ]],
    ]
  end

  # EU4 1.32 introduced this for one file :-(
  def test_sample_9
    assert_parse_tree 9, PropertyList["has_completed_idea_group_of_category", PropertyList[
      "adm_ideas", Property::SQDEF[PropertyList["custom_trigger_tooltip", PropertyList[
        "tooltip", "has_completed_one_adm_idea_group",
        "OR", PropertyList[
          "full_idea_group", "innovativeness_ideas",
          "full_idea_group", "religious_ideas",
          "full_idea_group", "economic_ideas",
          "full_idea_group", "expansion_ideas",
          "full_idea_group", "administrative_ideas",
          "full_idea_group", "humanist_ideas",
        ],
      ]]],
      "dip_ideas", Property::SQDEF[PropertyList["custom_trigger_tooltip", PropertyList[
        "tooltip", "has_completed_one_dip_idea_group",
        "OR", PropertyList[
          "full_idea_group", "spy_ideas",
          "full_idea_group", "diplomatic_ideas",
          "full_idea_group", "trade_ideas",
          "full_idea_group", "exploration_ideas",
          "full_idea_group", "maritime_ideas",
          "full_idea_group", "influence_ideas",
        ],
      ]]],
      "mil_ideas", Property::SQDEF[PropertyList["custom_trigger_tooltip", PropertyList[
        "tooltip", "has_completed_one_mil_idea_group",
        "OR", PropertyList[
          "full_idea_group", "aristocracy_ideas",
          "full_idea_group", "offensive_ideas",
          "full_idea_group", "defensive_ideas",
          "full_idea_group", "quality_ideas",
          "full_idea_group", "quantity_ideas",
          "full_idea_group", "naval_ideas",
          "full_idea_group", "theocracy_gov_ideas",
          "full_idea_group", "indigenous_ideas",
          "full_idea_group", "horde_gov_ideas",
          "full_idea_group", "plutocracy_ideas",
        ],
      ]]],
    ]]
  end
end

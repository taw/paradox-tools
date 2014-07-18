#!/usr/bin/env ruby

require "minitest/autorun"
require_relative "../lib/paradox"

class ParadoxModFileTest < MiniTest::Test
  def assert_parse_tree(number, expected)
    parsed = ParadoxModFile.new("#{__dir__}/sample_#{number}.txt").parse!
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
end

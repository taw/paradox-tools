require_relative "base"

class PartialWesternizationGameModification < EU4GameModification
  def apply!
    localization! "partial_westernization",
      "partial_westernization_title" => "Reform The Government",
      "partial_westernization_desc"  => "Reform the government as much along Western lines as you currently can."
    create_mod_file! "decisions/PartialWesternization.txt", PropertyList[
      "country_decisions", PropertyList[
        "partial_westernization", PropertyList[
          "major", true,
          "potential", PropertyList[
            "has_global_flag", "fun_and_balance_config.enable_partial_westernization",
            Property::OR[
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
            Property::OR[
              "stability", 3,
              "adm_tech", 8,
            ],
            "is_at_war", false,
            Property::NOT["num_of_revolts", 1],
            "adm_power", 250,
            "dip_power", 250,
            "mil_power", 250,
            "any_neighbor_country", PropertyList[
              Property::OR[
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
            "add_adm_power", -250,
            "add_dip_power", -250,
            "add_mil_power", -250,
            "add_country_modifier", PropertyList[
              "name", "western_influences",
              "duration", 3650,
            ],
          ],
          "ai_will_do", PropertyList["factor", 1],
        ]
      ]
    ]
  end
end

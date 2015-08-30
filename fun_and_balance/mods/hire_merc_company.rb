require_relative "base"

# For Extended Timeline
class HireMercCompanyGameModification < EU4GameModification
  def apply!
    create_mod_file! "common/event_modifiers/private_military_company.txt", PropertyList[
      "recently_hired_mercs", PropertyList[],
    ]
    create_mod_file! "decisions/private_military_company.txt", PropertyList[
      "country_decisions", PropertyList[
        "hire_merc_company", PropertyList[
          "potential", PropertyList[
            "year", 1900,
          ],
          "allow", PropertyList[
            "treasury", 1000,
            Property::NOT["has_country_modifier", "recently_hired_mercs"],
            Property::NOT["num_of_loans", 5],
            Property::NOT["manpower_percentage", 0.10],
            Property::OR[
              "is_at_war", true,
              "num_of_revolts", 1,
            ],
          ],
          "effect", PropertyList[
            "add_treasury", -1000,
            "add_manpower", 20,
            "add_country_modifier", PropertyList[
              "name", "recently_hired_mercs",
              "duration", 365*5,
            ],
          ],
          "ai_will_do", PropertyList["factor", 1],
        ]
      ]
    ]
    localization! "private_military_company",
      "recently_hired_mercs"    => "Recently hired private military company",
      "hire_merc_company_title" => "Employ private military company",
      "hire_merc_company_desc"  => "Private military companies can supplement your manpower"
  end
end

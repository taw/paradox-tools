require_relative "base"

class BecomeRepublicGameModification < CK2GameModification
  def apply!
    create_mod_file! "decisions/feudal_to_republic.txt", PropertyList[
       "settlement_decisions", PropertyList[
        "feudal_adopt_republicanism", PropertyList[
          "filter", "sub_realm_owned",
          "ai_target_filter", "sub_realm_owned",
          "from_potential", PropertyList[
            "ai", false,
            "is_feudal", true,
            "is_female", false,
          ],
          "potential", PropertyList[
            "holding_type", "city",
            "capital_scope", PropertyList["port", true],
            "holder_scope", PropertyList["OR", PropertyList[
              "character", "FROM",
              "AND", PropertyList["any_liege", PropertyList["character", "FROM"]],
            ]],
          ],
          "allow", PropertyList[
            "OR", PropertyList[
              "is_capital", true,
              "capital_scope", PropertyList["holder_scope", PropertyList["character", "FROM"]],
            ],
            "has_siege", false,
            "FROM", PropertyList[
              # "independent", true,
              "war", false,
            ],
          ],
          "effect", PropertyList[
            "if", PropertyList[
              "limit", PropertyList["NOT", PropertyList["holder", "FROM"]],
              "usurp_title", "FROM",
            ],
            "if", PropertyList[
              "limit", PropertyList["is_capital", false],
              "make_capital_holding", true,
            ],
            "FROM", PropertyList[
              "capital", "PREV",
              "create_family_palace", true,
              "set_government_type", "merchant_republic_government",
              "wealth", 500,
            ],
          ],
          "revoke_allowed", PropertyList["always", false],
          "ai_will_do", PropertyList["factor", 0],
        ]
      ]
    ]
  end
end

require_relative "base"

class DynasticDecisionsGameModification < CK2GameModification
  def apply!
    # All these should be filtered etc.
    # Extremely basic functionality only
    #
    # These are meant for setting up scenarios, not for routine use
    targetted_decisions = PropertyList[
      "switch_to_spouse_dynasty", PropertyList[
        "filter", "spouse",
        "ai_target_filter", "spouse",
        "from_potential", PropertyList["age", 16],
        "potential", PropertyList["is_married", "FROM"],
        "allow", PropertyList["age", 16],
        "effect", PropertyList["FROM", PropertyList["dynasty", "ROOT"]],
        "revoke_allowed", PropertyList["always", false],
        "ai_will_do", PropertyList["factor", 0],
      ],
      "make_marriage_regular", PropertyList[
        "filter", "spouse",
        "ai_target_filter", "spouse",
        "from_potential", PropertyList["age", 16],
        "potential", PropertyList["is_married", "FROM"],
        "allow", PropertyList["age", 16],
        "effect", PropertyList["FROM", PropertyList["add_spouse", "ROOT"]],
        "revoke_allowed", PropertyList["always", false],
        "ai_will_do", PropertyList["factor", 0],
      ],
      "make_marriage_matrilineal", PropertyList[
        "filter", "spouse",
        "ai_target_filter", "spouse",
        "from_potential", PropertyList["age", 16],
        "potential", PropertyList["is_married", "FROM"],
        "allow", PropertyList["age", 16],
        "effect", PropertyList["FROM", PropertyList["add_spouse_matrilineal", "ROOT"]],
        "revoke_allowed", PropertyList["always", false],
        "ai_will_do", PropertyList["factor", 0],
      ],
      "educate_kin", PropertyList[
        "filter", "dynasty",
        "ai_target_filter", "dynasty",
        "from_potential", PropertyList["age", 16],
        "potential", PropertyList[
          "age", 6,
          Property::NOT["age", 16],
        ],
        # "allow", PropertyList[
          # "is_close_relative", "ROOT",
          # Property::NOT["guardian", "ROOT"],
        # ],
        "effect", PropertyList["set_guardian", "FROM"],
        "revoke_allowed", PropertyList["always", false],
        "ai_will_do", PropertyList["factor", 0],
      ],
      "make_rival", PropertyList[
        "filter", "all",
        "ai_target_filter", "court",
        "effect", PropertyList["add_rival", "FROM"],
        "ai_will_do", PropertyList["factor", 0],
      ],
      "make_friend", PropertyList[
        "filter", "all",
        "ai_target_filter", "court",
        "effect", PropertyList["add_friend", "FROM"],
        "ai_will_do", PropertyList["factor", 0],
      ],
      "make_lover", PropertyList[
        "filter", "all",
        "ai_target_filter", "court",
        "effect", PropertyList["add_lover", "FROM"],
        "ai_will_do", PropertyList["factor", 0],
      ],
      "trigger_revolt_peasant", PropertyList[
        "filter", "all",
        "ai_target_filter", "court",
        "effect", PropertyList[
          "random_realm_province", PropertyList[
            "province_event", PropertyList["id", "TOG.1000"],
          ],
        ],
        "ai_will_do", PropertyList["factor", 0],
      ],
      "trigger_revolt_heretic", PropertyList[
        "filter", "all",
        "ai_target_filter", "court",
        "effect", PropertyList[
          "random_realm_province", PropertyList[
            "province_event", PropertyList["id", "TOG.1020"],
          ],
        ],
        "ai_will_do", PropertyList["factor", 0],
      ],
      "trigger_revolt_nationalist", PropertyList[
        "filter", "all",
        "ai_target_filter", "court",
        "effect", PropertyList[
          "random_realm_province", PropertyList[
            "province_event", PropertyList["id", "TOG.1040"],
          ],
        ],
        "ai_will_do", PropertyList["factor", 0],
      ],
      "trigger_revolt_religious", PropertyList[
        "filter", "all",
        "ai_target_filter", "court",
        "effect", PropertyList[
          "random_realm_province", PropertyList[
            "province_event", PropertyList["id", "TOG.1060"],
          ],
        ],
        "ai_will_do", PropertyList["factor", 0],
      ],
    ]

    create_mod_file! "decisions/dynastic_decisions.txt", PropertyList[
      "targetted_decisions", targetted_decisions,
    ]
    localization!("dynastic_decisions",
      "switch_to_spouse_dynasty" => "Swich to spouse's dynasty",
      "switch_to_spouse_dynasty_desc" => "Abandon your current family name, become part of spouse's dynasty",
      "make_marriage_regular" => "Make marriage regular",
      "make_marriage_regular_desc" => "All children will by of father's dynasty",
      "make_marriage_matrilineal" => "Make marriage matrilineal",
      "make_marriage_matrilineal_desc" => "All children will by of mother's dynasty",
      "educate_kin" => "Educate close kin",
      "educate_kin_desc" => "Can use even if beyond education limit",
    )
  end
end

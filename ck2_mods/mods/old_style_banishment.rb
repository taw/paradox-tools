require_relative "base"

class OldStyleBanishmentGameModification < CK2GameModification
  # There seems to be no way to restore old functionality via defines.txt etc.
  # So recoded from scratch
  # AI should have access to it, but it's simpler to start with player-only code
  def apply!
    create_mod_file! "decisions/banish_traitor_decisions.txt", PropertyList["targetted_decisions",
      PropertyList["banish_traitor_decision", PropertyList[
        "filter", "court",
        "ai_target_filter", "court",
        "is_high_prio", true,
        "from_potential", PropertyList[
          "is_ruler", true,
          "ai", false,
        ],
        "potential", PropertyList[
          "host", PropertyList["character", "FROM"],
          "prisoner", true,
        ],
        "allow", PropertyList[
          "prisoner", true,
          "FROM", PropertyList["OR", PropertyList[
            "has_opinion_modifier", PropertyList[
              "who", "ROOT",
              "modifier", "opinion_traitor",
            ],
            "has_opinion_modifier", PropertyList[
              "who", "ROOT",
              "modifier", "opinion_rebel_traitor",
            ],
            "has_opinion_modifier", PropertyList[
              "who", "ROOT",
              "modifier", "opinion_dishonorable",
            ],
          ]],
        ],
        "effect", PropertyList[
          "prisoner", false,
          "FROM", PropertyList[
            "remove_opinion", PropertyList[
              "who", "ROOT",
              "modifier", "opinion_traitor",
            ],
            "remove_opinion", PropertyList[
              "who", "ROOT",
              "modifier", "opinion_rebel_traitor",
            ],
            "remove_opinion", PropertyList[
              "who", "ROOT",
              "modifier", "opinion_dishonorable",
            ],
          ],
          "FROM", PropertyList["wealth", "ROOT"],
          "clear_wealth", true,
          "any_demesne_title", PropertyList[
            "limit", PropertyList["controls_religion", false],
            "usurp_title", "FROM",
          ],
        ],
        "revoke_allowed", PropertyList["always", false],
        "ai_will_do", PropertyList["factor", 0],
    ]]]
    localization!("banish_traitor",
      "banish_traitor_decision" => "Banish traitor!",
      "banish_traitor_decision_desc" => "Banish traitor and take all their gold and lands"
    )
  end
end

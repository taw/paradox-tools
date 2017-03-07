require_relative "base"

class VassalTransferGameModification < CK2GameModification
  def king_level_titles
    @king_level_titles ||= begin
      titles  = parse("common/landed_titles/landed_titles.txt")
      empires = titles.keys.grep(/\Ae_/)
      [titles, *empires.map{|e| titles[e]}].map(&:keys).flatten(1).grep(/\Ak_/).sort
    end
  end

  # Transferring vassal dukes under vassal kings is broken
  # Don't setup any other transfers as that's unnecessary
  # Can't handle custom titles etc.
  def apply!
    decisions = []
    # FROM - emperor
    # ROOT - duke vassal
    # PREV - king vassal (within holder_scope)
    king_level_titles.each do |k_title|
      # Oops, localization system doesn't support CK2 yet, just EU4 :-/
      # Anyway, there's probably some way to make it work with %codes% instead
      k_title_loc = k_title.sub(/\Ak_/, "").split("_").map(&:capitalize).join(" ")

      decisions << Property[
        "transfer_vassal_under_#{k_title}", PropertyList[
          "filter", "vassals",
          "ai_target_filter", "vassals",
          "from_potential", PropertyList[
            "tier", "emperor",
            "any_vassal", PropertyList["has_landed_title", k_title],
          ],
          "potential", PropertyList[
            "tier", "duke",
            # Neighbouring vassal king
            "any_realm_province", PropertyList[
              "any_neighbor_province", PropertyList[
                "has_owner", true,
                "holder_scope", PropertyList[
                  "OR", PropertyList[
                    "has_landed_title", k_title,
                    "any_liege", PropertyList["has_landed_title", k_title],
                  ],
                ],
              ],
            ],
          ],
          "allow", PropertyList[
            "tier", "duke",
            "liege", PropertyList["character", "FROM"],
          ],
          "effect", PropertyList[
            k_title, PropertyList[
              "holder_scope", PropertyList[
                "ROOT", PropertyList[
                  "set_defacto_liege", "PREV",
                ],
                "opinion", PropertyList[
                  "modifier", "opinion_vassal_transfer",
                  "who", "liege",
                  "months", 120,
                ],
              ],
            ],
          ],
          "revoke_allowed", PropertyList["always", false],
          "ai_will_do", PropertyList["factor", 0],
        ],
      ]
      localization!("vassal_transfer_decisions",
        "transfer_vassal_under_#{k_title}" => "Transfer under #{k_title_loc}",
        "transfer_vassal_under_#{k_title}_desc" => "Make duke vassal of #{k_title_loc} instead of you directly",
      )
    end

    create_mod_file! "decisions/vassal_transfer_decisions.txt", PropertyList["targetted_decisions", PropertyList[*decisions]]
  end
end

require_relative "base"

class ReligiousLeaguesGameModification < EU4GameModification
  # Event numbers:
  # Vanilla:
  #   1 - The Emperor Triumphant (Catholic)
  #   2 - Victory of the Protestant League
  #   3 - Victory of the Catholic League
  #   4 - Peace of Westphalia
  #   5 - The Evangelical Union
  #   6 - The Imperial Diet (Catholic)
  #   7 - The Imperial Diet (Protestant)
  #   8 - The Emperor Triumphant (Protestant)
  #
  # Added:
  # 10x - x emperor won (1 catholic, 8 protestant)
  # 20x - x diet (6 catholic, 7 protestant)
  # 3yx - x league victory over y (2 protestant-over-catholic, 3 catholic-over-protestant; we delete them)
  # 40x - x league starts (5 protestant; we delete it)

  RELIGION = {
    "catholic" => 1,
    "protestant" => 2,
    "reformed" => 3,
    "orthodox" => 4,
    "coptic" => 5,
    "anglican" => 6,
    "hussite" => 7,
  }

  def make_trigerred_modifiers_globally_visible!
    patch_mod_file! "common/triggered_modifiers/00_triggered_modifiers.txt" do |node|
      ["catholic", "protestant", "reformed"].each do |religion|
        node["hre_dominant_#{religion}"]["potential"].delete! "OR"
        node["hre_dominant_#{religion}"]["potential"].add! "religion_group", "christian"
      end
    end
  end

  def create_other_trigerred_modifiers!
    node = PropertyList[]
    ["orthodox", "coptic", "anglican", "hussite"].each do |religion|
      node.add! "hre_dominant_#{religion}", PropertyList[
        "potential", PropertyList[
          "capital_scope", PropertyList["continent", "europe"],
          "religion_group", "christian",
        ],
        "trigger", PropertyList[
          "religion", religion,
          "hre_religion", religion,
          "hre_religion_locked", true,
        ],
        "legitimacy", 0.25,
        "tolerance_own", 1,
        "global_missionary_strength", 0.01,
        "imperial_authority", 0.25,
      ]
    end

    create_mod_file! "common/triggered_modifiers/99_fun_and_balance_religious_leagues.txt", node
  end

  def setup_loc!
    localization!("fun_and_balance_religious_leagues",
      "hre_dominant_orthodox" => "Orthodox Empire",
      "hre_dominant_coptic" => "Coptic Empire",
      "hre_dominant_anglican" => "Anglican Empire",
      "hre_dominant_hussite" => "Hussite Empire",

      "desc_hre_dominant_orthodox" => "The Orthodox faith is the official religion of the Holy Roman Empire. Following this faith grants our nation a certain moral legitimacy.",
      "desc_hre_dominant_coptic" => "The Coptic faith is the official religion of the Holy Roman Empire. Following this faith grants our nation a certain moral legitimacy.",
      "desc_hre_dominant_anglican" => "The Anglican faith is the official religion of the Holy Roman Empire. Following this faith grants our nation a certain moral legitimacy.",
      "desc_hre_dominant_hussite" => "The Hussite faith is the official religion of the Holy Roman Empire. Following this faith grants our nation a certain moral legitimacy.",

      "religious_leagues.1.d.reformed" => "The War of Religion in the Empire has ended in total victory for the Emperor and the Imperial Parliament has convened in a Diet to proclaim Reformed as the sole confessional faith of the Holy Roman Empire. Electors who follow a different confession will be stripped of their privileges, and the Emperor is given broad authority to enforce Reformed unity within the Empire.",
      "religious_leagues.1.d.orthodox" => "The War of Religion in the Empire has ended in total victory for the Emperor and the Imperial Parliament has convened in a Diet to proclaim Orthodoxy as the sole confessional faith of the Holy Roman Empire. Electors who follow a different confession will be stripped of their privileges, and the Emperor is given broad authority to enforce Orthodox unity within the Empire.",
      "religious_leagues.1.d.coptic" => "The War of Religion in the Empire has ended in total victory for the Emperor and the Imperial Parliament has convened in a Diet to proclaim Coptic as the sole confessional faith of the Holy Roman Empire. Electors who follow a different confession will be stripped of their privileges, and the Emperor is given broad authority to enforce Coptic unity within the Empire.",
      "religious_leagues.1.d.anglican" => "The War of Religion in the Empire has ended in total victory for the Emperor and the Imperial Parliament has convened in a Diet to proclaim Anglican as the sole confessional faith of the Holy Roman Empire. Electors who follow a different confession will be stripped of their privileges, and the Emperor is given broad authority to enforce Anglican unity within the Empire.",
      "religious_leagues.1.d.hussite" => "The War of Religion in the Empire has ended in total victory for the Emperor and the Imperial Parliament has convened in a Diet to proclaim Hussite as the sole confessional faith of the Holy Roman Empire. Electors who follow a different confession will be stripped of their privileges, and the Emperor is given broad authority to enforce Hussite unity within the Empire.",

      "religious_leagues.diet.catholic" => "With the failure of the heretic league to successfully challenge the Emperor, the Imperial Parliament has convened in a Diet to proclaim Catholicism as the sole confessional faith of the Holy Roman Empire. Electors who follow a different confession will be stripped of their privileges, and the Emperor is given broad authority to enforce Catholic unity within the Empire.",
      "religious_leagues.diet.protestant" => "With the failure of the heretic league to successfully challenge the Emperor, the Imperial Parliament has convened in a Diet to proclaim Protestantism as the sole confessional faith of the Holy Roman Empire. Electors who follow a different confession will be stripped of their privileges, and the Emperor is given broad authority to enforce Protestant unity within the Empire.",
      "religious_leagues.diet.reformed" => "With the failure of the heretic league to successfully challenge the Emperor, the Imperial Parliament has convened in a Diet to proclaim Reformed as the sole confessional faith of the Holy Roman Empire. Electors who follow a different confession will be stripped of their privileges, and the Emperor is given broad authority to enforce Reformed unity within the Empire.",
      "religious_leagues.diet.orthodox" => "With the failure of the heretic league to successfully challenge the Emperor, the Imperial Parliament has convened in a Diet to proclaim Orthodoxy as the sole confessional faith of the Holy Roman Empire. Electors who follow a different confession will be stripped of their privileges, and the Emperor is given broad authority to enforce Orthodox unity within the Empire.",
      "religious_leagues.diet.coptic" => "With the failure of the heretic league to successfully challenge the Emperor, the Imperial Parliament has convened in a Diet to proclaim Coptic as the sole confessional faith of the Holy Roman Empire. Electors who follow a different confession will be stripped of their privileges, and the Emperor is given broad authority to enforce Coptic unity within the Empire.",
      "religious_leagues.diet.anglican" => "With the failure of the heretic league to successfully challenge the Emperor, the Imperial Parliament has convened in a Diet to proclaim Anglican as the sole confessional faith of the Holy Roman Empire. Electors who follow a different confession will be stripped of their privileges, and the Emperor is given broad authority to enforce Anglican unity within the Empire.",
      "religious_leagues.diet.hussite" => "With the failure of the heretic league to successfully challenge the Emperor, the Imperial Parliament has convened in a Diet to proclaim Hussite as the sole confessional faith of the Holy Roman Empire. Electors who follow a different confession will be stripped of their privileges, and the Emperor is given broad authority to enforce Hussite unity within the Empire.",

      "religious_leagues.warwon.t.catholic" => "The Catholic League is Victorious",
      "religious_leagues.warwon.t.protestant" => "The Protestant League is Victorious",
      "religious_leagues.warwon.t.reformed" => "The Reformed League is Victorious",
      "religious_leagues.warwon.t.orthodox" => "The Orthodox League is Victorious",
      "religious_leagues.warwon.t.coptic"   => "The Coptic League is Victorious",
      "religious_leagues.warwon.t.anglican" => "The Anglican League is Victorious",
      "religious_leagues.warwon.t.hussite" => "The Hussite League is Victorious",

      "religious_leagues.warwon.d.catholic" => "The War of Religion in the Empire has ended in victory for the Catholic Union. The Emperor has been forced to abdicate and Catholic is now the dominant faith in the Empire.",
      "religious_leagues.warwon.d.protestant" => "The War of Religion in the Empire has ended in victory for the Protestant Union. The Emperor has been forced to abdicate and Protestant is now the dominant faith in the Empire.",
      "religious_leagues.warwon.d.reformed" => "The War of Religion in the Empire has ended in victory for the Reformed Union. The Emperor has been forced to abdicate and Reformed is now the dominant faith in the Empire.",
      "religious_leagues.warwon.d.orthodox" => "The War of Religion in the Empire has ended in victory for the Orthodox Union. The Emperor has been forced to abdicate and Orthodoxy is now the dominant faith in the Empire.",
      "religious_leagues.warwon.d.coptic"   => "The War of Religion in the Empire has ended in victory for the Coptic Union. The Emperor has been forced to abdicate and Coptic is now the dominant faith in the Empire.",
      "religious_leagues.warwon.d.anglican" => "The War of Religion in the Empire has ended in victory for the Anglican Union. The Emperor has been forced to abdicate and Anglican is now the dominant faith in the Empire.",
      "religious_leagues.warwon.d.hussite" => "The War of Religion in the Empire has ended in victory for the Hussite Union. The Emperor has been forced to abdicate and Hussite is now the dominant faith in the Empire.",

      "religious_leagues.403.t" => "The Reformed Union",
      "religious_leagues.404.t" => "The Orthodox Union",
      "religious_leagues.405.t" => "The Coptic Union",
      "religious_leagues.406.t" => "The Anglican Union",
      "religious_leagues.407.t" => "The Hussite Union",

      "religious_leagues.403.d" => "After Emperor $MONARCH$ rejected the Reformed confessional positions at the Imperial Parliament, the Reformed Imperial estates formed the League of Schmalkalden, with a joint army and treasury and seeking ties abroad. The German Catholic states, feeling threatened by this new alliance, have regrouped into a Catholic League. The stage is set for religious conflict in the Empire.",
      "religious_leagues.404.d" => "After Emperor $MONARCH$ rejected the Orthodox confessional positions at the Imperial Parliament, the Orthodox Imperial estates formed the League of Schmalkalden, with a joint army and treasury and seeking ties abroad. The German Catholic states, feeling threatened by this new alliance, have regrouped into a Catholic League. The stage is set for religious conflict in the Empire.",
      "religious_leagues.405.d" => "After Emperor $MONARCH$ rejected the Coptic confessional positions at the Imperial Parliament, the Coptic Imperial estates formed the League of Schmalkalden, with a joint army and treasury and seeking ties abroad. The German Catholic states, feeling threatened by this new alliance, have regrouped into a Catholic League. The stage is set for religious conflict in the Empire.",
      "religious_leagues.406.d" => "After Emperor $MONARCH$ rejected the Anglican confessional positions at the Imperial Parliament, the Anglican Imperial estates formed the League of Schmalkalden, with a joint army and treasury and seeking ties abroad. The German Catholic states, feeling threatened by this new alliance, have regrouped into a Catholic League. The stage is set for religious conflict in the Empire.",
      "religious_leagues.407.d" => "After Emperor $MONARCH$ rejected the Hussite confessional positions at the Imperial Parliament, the Hussite Imperial estates formed the League of Schmalkalden, with a joint army and treasury and seeking ties abroad. The German Catholic states, feeling threatened by this new alliance, have regrouped into a Catholic League. The stage is set for religious conflict in the Empire.",
    )
  end

  def setup_on_action!
    patch_mod_file!("common/on_actions/00_on_actions.txt") do |node|
      node["on_lock_hre_religion"]["events"] += (3..7).map{|i| "religious_leagues.10#{i}" }
      # This needs to be extended if we ever do wars other than Catholcs vs X
      node["on_change_hre_religion"]["events"] += (3..7).map{|i| "religious_leagues.31#{i}" }
    end
  end

  def events_emperor_won!
    patch_mod_file!("events/ReligiousLeagues.txt") do |node|
      RELIGION.each do |religion, i|
        next if religion == "catholic" or religion == "protestant"
        id = "10#{i}"
        node.add! "country_event", PropertyList[
            "id", "religious_leagues.#{id}",
            "title", "religious_leagues.#{id}.t",
            "desc", "religious_leagues.#{id}.d",
            "picture", "RELIGIOUS_WARS_eventPicture",
            "major", true,
            "is_triggered_only", true,
            "trigger", PropertyList[
              "has_dlc", "Art of War",
              "hre_religion", religion,
            ],
            "immediate", PropertyList["hidden_effect", PropertyList["set_hre_religion_locked", true]],
            "option", PropertyList[
              "name", "religious_leagues.#{id}.a",
              "tooltip", PropertyList["set_hre_religion_locked", true],
            ],
          ]
      end
    end
  end

  # I don't think these happen anymore
  def events_diet!
    patch_mod_file!("events/ReligiousLeagues.txt") do |node|
      RELIGION.each do |religion, i|
        next if religion == "catholic" or religion == "protestant"
        id = "20#{i}"
        node.add! "country_event", PropertyList[
          "id", "religious_leagues.#{id}",
          "title", "religious_leagues.#{id}.t",
          "desc", "religious_leagues.#{id}.d",
          "picture", "RELIGIOUS_WARS_eventPicture",
          "major", true,
          "fire_only_once", true,
          "trigger", PropertyList[
            "has_dlc", "Art of War",
            "is_emperor", true,
            "is_at_war", false,
            "NOT", PropertyList["any_known_country", PropertyList["is_in_league_war", true]],
            "has_regency", false,
            "hre_religion_locked", false,
            "hre_religion_treaty", false,
            "religion", religion,
            "OR", PropertyList[
              "AND", PropertyList[
                "hre_leagues_enabled", true,
                "had_global_flag", PropertyList[
                  "flag", "evangelical_union_happened",
                  "days", 10950,
                ],
                "NOT", PropertyList["any_known_country", PropertyList[
                  "is_elector", true,
                  "NOT", PropertyList["religion", religion],
                  "is_league_enemy", "ROOT",
                  "truce_with", "ROOT",
                ]],
              ],
              "AND", PropertyList[
                "NOT", PropertyList["has_global_flag", "evangelical_union_happened"],
                "is_year", 1625,
              ],
            ],
          ],
          "mean_time_to_happen", PropertyList["months", 60],
          "option", PropertyList[
            "name", "religious_leagues.#{id}.a",
            "set_hre_heretic_religion", religion,
            "set_hre_religion_locked", true,
          ],
        ]
      end
    end
  end

  # This could be extended to every combination, but do only Catholic vs X for now
  def events_league_victory!
    patch_mod_file!("common/on_actions/00_on_actions.txt") do |node|
      node["on_change_hre_religion"]["events"].delete("religious_leagues.2")
      node["on_change_hre_religion"]["events"].delete("religious_leagues.3")
    end

    patch_mod_file!("events/ReligiousLeagues.txt") do |node|
      node.delete!{|prop| prop.key == "country_event" and prop.val["id"] == "religious_leagues.2"}
      node.delete!{|prop| prop.key == "country_event" and prop.val["id"] == "religious_leagues.3"}

      RELIGION.each do |previous_religion, j|
        RELIGION.each do |religion, i|
          next if religion == previous_religion
          id = "3#{j}#{i}"
          node.add! "country_event", PropertyList[
            "id", "religious_leagues.#{id}",
            "title", "religious_leagues.warwon.t.#{religion}",
            "desc", "religious_leagues.warwon.d.#{religion}",
            "picture", "RELIGIOUS_WARS_eventPicture",
            "major", true,
            "is_triggered_only", true,
            "trigger", PropertyList[
              "has_dlc", "Art of War",
              "hre_religion", previous_religion,
              "hre_heretic_religion", religion,
              "OR", PropertyList[
                "NOT", PropertyList["has_country_flag", "hre_religion_changed"],
                "had_country_flag", PropertyList[
                  "flag", "hre_religion_changed",
                  "days", 30,
                ],
              ],
            ],
            "immediate", PropertyList[
              "set_country_flag", "hre_religion_changed",
              "hidden_effect", PropertyList[
                "set_hre_heretic_religion", previous_religion,
                "set_hre_religion", religion,
                "set_hre_religion_locked", true,
              ],
            ],
            "option", PropertyList[
              "name", "religious_leagues.#{id}.a",
              "tooltip", PropertyList[
                "set_hre_heretic_religion", previous_religion,
                "set_hre_religion", religion,
                "set_hre_religion_locked", true,
              ],
            ],
          ]
        end
      end
    end
  end

  def events_league_starts!
    patch_mod_file!("events/ReligiousLeagues.txt") do |node|
      node.delete!{|x| x.key == "country_event" and x.val["id"] == "religious_leagues.5"}
      previous_religion = "catholic"
      RELIGION.each do |religion, i|
        next if religion == "catholic"
        id = "40#{i}"
        node.add! "country_event", PropertyList[
          "id", "religious_leagues.#{id}",
          "title", "religious_leagues.#{id}.t",
          "desc", "religious_leagues.#{id}.d",
          "picture", "RELIGIOUS_WARS_eventPicture",
          "major", true,
          "fire_only_once", true,
          "trigger", PropertyList[
            "has_dlc", "Art of War",
            "NOT", PropertyList["has_global_flag", "evangelical_union_happened"],
            "hre_leagues_enabled", false,
            "hre_religion_locked", false,
            "hre_religion_treaty", false,
            "is_emperor", true,
            "OR", PropertyList[
              "AND", PropertyList[
                "is_year", 1550,
                "has_global_flag", "counter_reformation",
              ],
              "calc_true_if", PropertyList[
                "all_elector", PropertyList[
                  "religion", religion,
                ],
                "amount", 4,
              ]
            ],
            "religion", previous_religion,
            "any_known_country", PropertyList[
              "is_elector", true,
              "religion", religion,
              "is_free_or_tributary_trigger", true,
            ],
            "NOT", PropertyList["hre_reform_passed", "erbkaisertum"],
            "NOT", PropertyList["has_global_flag", "great_peasants_war_flag"],
          ],
          "mean_time_to_happen", PropertyList[
            "months", 120,
            "modifier", PropertyList[
              "factor", 0.5,
              "is_year", 1575,
            ],
            "modifier", PropertyList[
              "factor", 0.1,
              "is_year", 1600,
            ],
            "modifier", PropertyList[
              "factor", 0.5,
              "calc_true_if", PropertyList[
                "all_elector", PropertyList[
                  "religion", religion,
                ],
                "amount", 3,
              ],
            ],
            "modifier", PropertyList[
              "factor", 0.1,
              "calc_true_if", PropertyList[
                "all_elector", PropertyList[
                  "religion", religion,
                ],
                "amount", 4,
              ],
            ],
          ],
          "option", PropertyList[
            "name", "religious_leagues.#{id}.a",
            "enable_hre_leagues", true,
            "set_global_flag", "evangelical_union_happened",
            "set_hre_heretic_religion", religion,
          ],
        ]
      end
    end
  end

  def apply!
    make_trigerred_modifiers_globally_visible!
    create_other_trigerred_modifiers!
    setup_on_action!
    setup_loc!
    events_emperor_won!
    events_diet!
    events_league_victory!
    events_league_starts!
  end
end

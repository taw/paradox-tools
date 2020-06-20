require_relative "base"

class ReligiousLeaguesGameModification < EU4GameModification
  # Event numbers:
  # 10x - x emperor won
  # 20x - x diet
  # 3xy - victory in x-vs-y war
  # 40x - x league starts

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
    ["reformed", "orthodox", "coptic", "hussite"].each do |religion|
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

    create_mod_file! "common/triggered_modifiers//99_fun_and_balance_religious_leagues.txt", node
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
      node["on_lock_hre_religion"]["events"] += ["religious_leagues.103", "religious_leagues.104", "religious_leagues.105", "religious_leagues.106"]

      node["on_change_hre_religion"]["events"] = (1..6).map do |i|
        (1..6).map do |j|
          "religious_leagues.3#{i}#{j}" unless i == j
        end
      end.flatten.compact
    end
  end

  def events_emperor_won!
    patch_mod_file!("events/ReligiousLeagues.txt") do |node|
      {"reformed" => 3, "orthodox" => 4, "coptic" => 5, "anglican" => 6, "hussite" => 7}.each do |religion, i|
        node.add! "country_event", PropertyList[
          "id", "religious_leagues.10#{i}",
          "title", "religious_leagues.1.t",
          "desc", "religious_leagues.1.d.#{religion}",
          "picture", "RELIGIOUS_WARS_eventPicture",
          "major", true,
          "is_triggered_only", true,
          "trigger", PropertyList[
            "has_dlc", "Art of War",
            "hre_religion", religion,
          ],
          "immediate", PropertyList["hidden_effect", PropertyList["set_hre_religion_locked", true]],
          "option", PropertyList[
            "name", "religious_leagues.1.a",
            "tooltip", PropertyList["set_hre_religion_locked", true],
          ],
        ]
      end
    end
  end

  def events_diet!
    patch_mod_file!("events/ReligiousLeagues.txt") do |node|
      {"reformed" => 3, "orthodox" => 4, "coptic" => 5, "anglican" => 6, "hussite" => 7}.each do |religion, i|
        node.add! "country_event", PropertyList[
          "id", "religious_leagues.20#{i}",
          "title", "religious_leagues.6.t",
          "desc", "religious_leagues.diet.#{religion}",
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
                  "is_league_enemy", "ROOT",
                  "truce_with", "ROOT",
                  "NOT", PropertyList["religion", religion],
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
            "name", "religious_leagues.6.a",
            "set_hre_religion_locked", true,
          ],
        ]
      end
    end
  end

  def apply!
    make_trigerred_modifiers_globally_visible!
    setup_on_action!
    setup_loc!
    events_emperor_won!
    events_diet!

    patch_mod_file!("events/ReligiousLeagues.txt") do |node|
      node.delete!{|prop| prop.key == "country_event" and prop.val["id"] == "religious_leagues.2"}
      node.delete!{|prop| prop.key == "country_event" and prop.val["id"] == "religious_leagues.3"}

      RELIGION.each do |hre_religion, i|
        RELIGION.each do |heretic_religion, j|
          next if hre_religion == heretic_religion

          node.add! "country_event", PropertyList[
            "id", "religious_leagues.3#{i}#{j}",
            "title", "religious_leagues.warwon.t.#{hre_religion}",
            "desc", "religious_leagues.warwon.d.#{hre_religion}",
            "picture", "RELIGIOUS_WARS_eventPicture",
            "major", true,
            "is_triggered_only", true,
            "trigger", PropertyList[
              "has_dlc", "Art of War",
              "hre_religion", heretic_religion,
              "hre_heretic_religion", hre_religion,
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
                "set_hre_heretic_religion", heretic_religion,
                "set_hre_religion", hre_religion,
              ],
            ],
            "option", PropertyList[
              "name", "religious_leagues.2.a",
              "tooltip", PropertyList[
                "set_hre_heretic_religion", heretic_religion,
                "set_hre_religion", hre_religion,
              ],
            ],
          ]
        end
      end

      protestant_league = node.find_all("country_event").find{|v| v["id"] == "religious_leagues.5"}
      protestant_league["option"].add! "set_hre_heretic_religion", "protestant"

      {"reformed"=>403, "anglican"=>406, "hussite"=>407}.each do |religion, id|
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
            "is_year", 1550,
            "religion", "catholic",
            "has_global_flag", "counter_reformation",
            "any_known_country", PropertyList[
              "is_elector", true,
              "religion", religion,
              "is_free_or_tributary_trigger", true,
            ],
            "NOT", PropertyList["hre_reform_level", 6],
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
          ],
          "option", PropertyList[
            "name", "religious_leagues.5.a",
            "enable_hre_leagues", true,
            "set_global_flag", "evangelical_union_happened",
            "set_hre_heretic_religion", religion,
          ],
        ]
      end

      {"orthodox"=>404, "coptic"=>405}.each do |religion, id|
        # Does not depend on 1550 and counterreformation
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
            "religion", "catholic",
            "any_known_country", PropertyList[
              "is_elector", true,
              "religion", religion,
              "is_free_or_tributary_trigger", true,
            ],
            "NOT", PropertyList["hre_reform_level", 6],
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
          ],
          "option", PropertyList[
            "name", "religious_leagues.5.a",
            "enable_hre_leagues", true,
            "set_global_flag", "evangelical_union_happened",
            "set_hre_heretic_religion", religion,
          ],
        ]
      end

      # This code is seriously dumb and fragile
      catholic_diet = node.find_all("country_event").find{|v| v["id"] == "religious_leagues.7"}
      catholic_diet["trigger"]["OR"]["AND"]["NOT"]["any_known_country"].delete! "religion"
      catholic_diet["trigger"]["OR"]["AND"]["NOT"]["any_known_country"].add! "NOT", PropertyList["religion", "catholic"]
      catholic_diet["desc"] = "religious_leagues.diet.catholic"
      protestant_diet = node.find_all("country_event").find{|v| v["id"] == "religious_leagues.7"}
      protestant_diet["trigger"]["OR"]["AND"]["NOT"]["any_known_country"].delete! "religion"
      protestant_diet["trigger"]["OR"]["AND"]["NOT"]["any_known_country"].add! "NOT", PropertyList["religion", "protestant"]
      protestant_diet["desc"] = "religious_leagues.diet.protestant"
    end
  end
end

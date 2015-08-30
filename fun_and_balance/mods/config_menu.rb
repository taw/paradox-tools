require_relative "base"

class ConfigMenuGameModification < EU4GameModification
  def build_mod_config_menu!(*options)
    create_mod_file! "decisions/fun_and_balance_menu.txt", PropertyList[
      "country_decisions", PropertyList[
        "fun_and_balance_display_menu", PropertyList[
          "potential", PropertyList["ai", false],
          "allow", PropertyList["ai", false],
          "effect", PropertyList[
            "country_event", PropertyList["id", "fun_and_balance_menu.show_menu"],
          ],
        ],
      ],
    ]
    localization! "fun_and_balance_menu",
      "fun_and_balance_display_menu_title"   => "Change Fun and Balance configuration",
      "fun_and_balance_display_menu_desc"    => "Display menu to change various features",
      "fun_and_balance_menu.show_menu_title" => "Fun and Balance configuration",
      "fun_and_balance_menu.show_menu_desc"  => "These settings should generally be changed at start of campaign."

    create_mod_file! "events/fun_and_balance_menu.txt", PropertyList[
      "namespace", "fun_and_balance_menu",
      "country_event", PropertyList[
        "id", "fun_and_balance_menu.show_menu",
        "title", "fun_and_balance_menu.show_menu_title",
        "desc", "fun_and_balance_menu.show_menu_desc",
        "picture", "BIG_BOOK_eventPicture",
        "is_triggered_only", true,
        "trigger", PropertyList["ai", false],
        *options.map{|option|
          Property["option", option]
        },
      ],
    ]
  end

  def menu_set_flag_option(flag, localization)
    localization! "fun_and_balance_menu", "fun_and_balance_menu.set_#{flag}" => localization
    PropertyList[
      "name", "fun_and_balance_menu.set_#{flag}",
      "trigger", PropertyList["NOT", PropertyList["has_global_flag", "fun_and_balance_config.#{flag}"]],
      "set_global_flag", "fun_and_balance_config.#{flag}",
    ]
  end

  def menu_clr_flag_option(flag, localization)
    localization! "fun_and_balance_menu", "fun_and_balance_menu.clr_#{flag}" => localization
    PropertyList[
      "name", "fun_and_balance_menu.clr_#{flag}",
      "trigger", PropertyList["has_global_flag", "fun_and_balance_config.#{flag}"],
      "clr_global_flag", "fun_and_balance_config.#{flag}",
    ]
  end
end

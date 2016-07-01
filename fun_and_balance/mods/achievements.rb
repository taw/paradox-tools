require_relative "base"

class AchievementsGameModification < EU4GameModification
  # FIXME: ROOT is wrong in on_startup trigged, change to PREV or something
  def apply!
    triggers = []
    init_script = PropertyList[]

    parse("common/achievements.txt").each do |name, achievement|
      id = achievement["id"]
      flag_name = "achievement_#{id}_#{name}"

      possible = achievement["possible"].deep_copy
      possible.delete! "ironman"
      possible.add! "ai", false
      criteria = achievement["happened"]

      init_script.add! "if", PropertyList[
        "limit", PropertyList[
          "any_country", possible,
        ],
        "set_global_flag", "achievement_possible_#{id}",
      ]

      if criteria.size == 1
        # This is just for pretty printing, more generic else clause would work just as well
        happened = Property::OR[
          "has_country_modifier", flag_name,
          *criteria.to_a,
        ]
      else
        happened = Property::OR[
          "has_country_modifier", flag_name,
          "AND", criteria,
        ]
      end

      triggers << Property[flag_name, PropertyList[
        "potential", PropertyList[
          Property::AND[
            "has_global_flag", "achievement_possible_#{id}",
            "has_global_flag", "fun_and_balance_config.enable_achievements",
          ],
        ],
        "trigger", PropertyList[happened],
        "prestige", 0.001, # There's no good way to change pic, so add tiny amount of prestige
      ]]
      loc_name = localization(name, name.split("_").map(&:capitalize).join(" "))

      localization! "fun_and_balance_achievements",
        "#{flag_name}"      => "Achievement #{loc_name}",
        "desc_#{flag_name}" => "EU4 disables achievements if you play with mods, but feel free to use Steam Achievement Manager to add it to your account, or just buy yourself some congratulatory ice cream."
    end
    create_mod_file! "common/triggered_modifiers/achievements.txt", PropertyList[*triggers]
    create_mod_file! "common/on_actions/20_achievements.txt", PropertyList[
      "on_startup", init_script,
    ]
  end
end

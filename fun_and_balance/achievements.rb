module FunAndBalanceFeatureAchievements
  def feature_achievements!
    # This is not an amazing system, but good start
    triggers = []

    @game.parse("common/achievements.txt").each do |name, achievement|
      id = achievement["id"]
      flag_name = "achievement_#{id}_#{name}"

      possible = achievement["possible"].deep_copy
      possible.delete "ironman"
      possible.add! "ai", false
      # possible.add! "has_global_flag", "fun_and_balance_config.enable_achievements"
      criteria = achievement["happened"]

      if criteria.size == 1
        # This is just for pretty printing, more generic else clause would work just as well
        happened = Property::OR[
          "has_country_modifier", flag_name,
          *criteria.list[0],
        ]
      else
        happened = Property::OR[
          "has_country_modifier", flag_name,
          "AND", criteria,
        ]
      end

      triggers << Property[flag_name, PropertyList[
        "potential", possible,
        "trigger",   PropertyList[happened],
      ]]

      localization! "fun_and_balance_achievements",
        "#{flag_name}"      => "Achievement #{@game.localization(name)}",
        "desc_#{flag_name}" => "EU4 disables achievements if you play with mods, but feel free to use Steam Achievement Manager to add it to your account, or just buy yourself some congratulatory ice cream."
    end
    create_mod_file! "common/triggered_modifiers/achievements.txt", PropertyList[*triggers]
  end
end

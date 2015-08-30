require_relative "base"

class ChangeGovernmentGameModification < EU4GameModification
  def apply!
    not_20_cities = proc{|k,v| k == "NOT" and v == PropertyList["num_of_cities", 20]}

    patch_mod_file!("decisions/Governments.txt") do |node|
      node["country_decisions"].each do |key, decision|
        case key
        when "plutocratic_administration_rep",
             "plutocratic_administration",
             "aristocratic_administration"
          decision["potential"].delete_if(&not_20_cities)
          decision["allow"].delete_if(&not_20_cities)
        end
      end
    end

    create_mod_file! "decisions/GovernmentsTheocracy.txt", PropertyList[
      "country_decisions", PropertyList[
        "theocratic_administration", PropertyList[
          "major", true,
          "potential", PropertyList[
            "government", "monarchy",
            Property::OR[
              "technology_group", "western",
              "technology_group", "eastern",
              "technology_group", "ottoman",
              "technology_group", "muslim",
            ],
          ],
          "allow", PropertyList[
            "stability", 1,
            "religious_unity", 1,
            "full_idea_group", "religious_ideas",
            "is_at_war", false,
            "is_subject", false,
          ],
          "effect", PropertyList[
            "change_government", "theocratic_government",
            "add_stability", -4,
          ],
          "ai_will_do", PropertyList["factor", 0],
        ]
      ]
    ]

    localization! "governments_theocracy",
      "theocratic_administration_title" => "Adopt Theocratic Administration",
      "theocratic_administration_desc"  => "Kings only rule by divine right, so why not skip the middleman and put priests directly in control?"
  end
end

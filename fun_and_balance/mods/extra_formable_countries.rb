require_relative "base"

class ExtraFormableCountriesGameModification < EU4GameModification
  def each_country_primary_culture
    glob("common/cultures/*.txt").each do |path|
      parse(path).each do |group_name, group|
        group = group.to_h
        group.delete "graphical_culture"
        group.delete "second_graphical_culture"
        group.delete "dynasty_names"
        group.each do |culture_name, details|
          next if details.is_a?(Array)
          details = details.to_h
          next unless details["primary"]
          yield group_name, culture_name, details["primary"]
        end
      end
    end
  end

  # analysis_eu4/list_formable_countries
  def already_formable
    @already_formable ||= %W[
      ADU
      ALA
      ALG
      ANN
      AOT
      ARB
      ARM
      AUS
      BAN
      BAV
      BHA
      BRZ
      BUK
      BYZ
      CAL
      CAM
      CAN
      CHK
      CHL
      COL
      CRB
      CRO
      CSC
      CUB
      DAI
      DAL
      DEC
      DLH
      DNZ
      EGY
      ENG
      FKN
      FLO
      FRA
      GBR
      GEO
      GER
      GLH
      GRE
      HAB
      HAN
      HAT
      HIN
      HLR
      ICE
      ILI
      ILK
      INC
      IRE
      ITA
      JAP
      KLK
      KOJ
      KSD
      KUR
      LAP
      LFA
      LOT
      LOU
      LUA
      LXA
      MAM
      MAR
      MAY
      MCH
      MEX
      MGE
      MOR
      MSA
      MUG
      NAG
      NED
      NPL
      NZL
      ORI
      PER
      PEU
      PLC
      POL
      POM
      PRG
      PRU
      PUN
      QNG
      QUE
      RJP
      RMN
      ROM
      RUM
      RUS
      SAX
      SCA
      SCO
      SIA
      SIL
      SNA
      SOK
      SPA
      SPI
      SST
      SWA
      SWI
      TEX
      TIB
      TIM
      TOK
      TRA
      TRP
      TTS
      TUN
      TUS
      UHW
      UKR
      USA
      VIE
      VIT
      VNZ
      VRM
      WES
      WSI
      YEM
      YUA
      ZUN
    ].to_set
  end

  def apply!
    decisions = []
    each_country_primary_culture do |culture_group, culture, tag|
      next if already_formable.include?(tag)
      next if culture_group == "east_slavic" # Form Russia instead
      next if culture_group == "japanese_g" # Form Japan instead
      next if culture_group == "east_asian" # Become Empire of China instead
      # Indians have enough formable paths already
      next if culture_group == "eastern_aryan"
      next if culture_group == "western_aryan"
      next if culture_group == "hindusthani"
      next if culture_group == "dravidian"
      next if culture_group == "central_indic"

      decisions << "country_decisions"
      decisions << PropertyList[
        "extra_formable_form_#{tag}", PropertyList[
          "major", true,
          "potential", PropertyList[
            "normal_or_historical_nations", true,
            "was_never_end_game_tag_trigger", true,
            Property::NOT["has_country_flag", "fun_and_balance.formed_#{tag}"],
            Property::NOT["exists", tag],
            "primary_culture", culture,
            "was_never_end_game_tag_trigger", true,
            Property::NOT["tag", "PAP"], # even as player, no conversion to Urbino and such
          ],
          "provinces_to_highlight", PropertyList[
            "culture", culture,
            "OR", PropertyList[
              "NOT", PropertyList["owned_by", "ROOT"],
              "NOT", PropertyList["is_core", "ROOT"],
            ],
          ],
          "allow", PropertyList[
            "adm_tech", 10,
            "num_of_cities", 3,
            "is_free_or_tributary_trigger", true,
            "is_at_war", false,
            "primary_culture", culture,
            "custom_trigger_tooltip", PropertyList[
              "tooltip", "controls_all_#{culture}",
              Property::NOT["any_province", PropertyList[
                "culture", culture,
                Property::NOT["owned_by", "ROOT"],
                Property::NOT["is_core", "ROOT"],
              ]]
            ],
          ],
          "effect", PropertyList[
            "change_tag", tag,
            "add_country_modifier", PropertyList[
              "name", "centralization_modifier",
              "duration", 7300,
            ],
            "remove_non_electors_emperors_from_empire_effect", true,
            "add_prestige", 25,
            "if", PropertyList[
              "limit", PropertyList["NOT", PropertyList["government_rank", 2]],
              "set_government_rank", 2,
            ],
            "if", PropertyList[
              "limit", PropertyList["has_custom_ideas", false],
              "country_event", PropertyList["id", "ideagroups.1"],
            ],
            "set_country_flag", "fun_and_balance.formed_#{tag}",
          ],
          "ai_will_do", PropertyList["factor", 1],
          "ai_importance", 400,
        ],
      ]

      loc_tag = localization(tag)
      loc_culture = localization(culture)
      localization! "extra_formable_countries",
        "extra_formable_form_#{tag}_title" => "Form #{loc_tag}",
        "extra_formable_form_#{tag}_desc"  => "Our country is the one true home of #{loc_culture} people, let's call it #{loc_tag}!",
        "controls_all_#{culture}" => "Controls all #{loc_culture} provinces"
    end
    create_mod_file! "decisions/extra_formable_countries.txt", PropertyList[
      *decisions
    ]
  end
end

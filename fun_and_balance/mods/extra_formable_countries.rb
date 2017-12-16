require_relative "base"

class ExtraFormableCountriesGameModification < EU4GameModification
  def each_country_primary_culture
    glob("common/cultures/*.txt").each do |path|
      parse(path).each do |group_name, group|
        group = group.to_h
        group.delete "graphical_culture"
        group.delete "dynasty_names"
        group.each do |culture_name, details|
          next if details.is_a?(Array)
          details = details.to_h
          next unless details["primary"]
          yield culture_name, details["primary"]
        end
      end
    end
  end

  def culture_to_culture_group
    @culture_to_culture_group = begin
      map = {}
      glob("common/cultures/*.txt").each do |path|
        parse(path).each do |group_name, group|
          group.each do |culture_name, culture|
            next unless culture.is_a?(PropertyList)
            map[culture_name] = group_name
          end
        end
      end
      map
    end
  end

  def apply!
    already_formable = %W[
      ADU
      ALG
      ARB
      ARM
      AUS
      BHA
      BRZ
      BUK
      BYZ
      CAM
      CAN
      CHL
      COL
      CRO
      EGY
      ENG
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
      INC
      IRE
      ITA
      JAP
      KOJ
      KUR
      LAP
      LOU
      MAM
      MAY
      MCH
      MEX
      MOR
      MSA
      MUG
      NED
      PER
      PEU
      PLC
      POL
      PRG
      PRU
      QNG
      QUE
      RMN
      ROM
      RUM
      RUS
      SCA
      SOK
      SPA
      SPI
      SST
      TIB
      TIM
      TRA
      TRP
      TUN
      TUS
      UKR
      USA
      VNZ
      WES
      YEM
      YUA
    ]
    cant_by_formed_by = %W[
      BHA
      BUK
      BYZ
      EGY
      FRA
      GBR
      GER
      HIN
      HLR
      INC
      ITA
      MUG
      PAP
      PER
      PLC
      RUS
      SCA
      SPA
      VIJ
    ]

    decisions = []
    each_country_primary_culture do |culture, tag|
      next if already_formable.include?(tag)
      next if tag == "MOS" # Form Russia instead
      next if tag == "MRI" or tag == "OTM" # Form Japan instead

      culture_group = culture_to_culture_group[culture]

      decisions << "country_decisions"
      decisions << PropertyList[
        "extra_formable_form_#{tag}", PropertyList[
          "major", true,
          "potential", PropertyList[
            Property::NOT["has_global_flag", "fun_and_balance_config.disable_extra_formable_countries"],
            Property::NOT["has_country_flag", "fun_and_balance.formed_#{tag}"],
            Property::NOT["exists", tag],
            *cant_by_formed_by.map{|ct| Property::NOT["tag", ct] },
            Property::OR[
              "culture_group", culture_group,
              "accepted_culture", culture,
            ],
          ],
          "allow", PropertyList[
            "adm_tech", 10,
            "num_of_cities", 3,
            "is_free_or_tributary_trigger", true,
            "is_at_war", false,
            "primary_culture", culture,
            Property::NOT["any_province", PropertyList[
              "culture", culture,
              Property::NOT["owned_by", "ROOT"],
              Property::NOT["is_core", "ROOT"],
            ]],
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
        ],
      ]

      loc_tag = localization(tag)
      loc_culture = localization(culture)
      localization! "extra_formable_countries",
        "extra_formable_form_#{tag}_title" => "Form #{loc_tag}",
        "extra_formable_form_#{tag}_desc"  => "Our country is the one true home of #{loc_culture} people, let's call it #{loc_tag}!"
    end
    create_mod_file! "decisions/extra_formable_countries.txt", PropertyList[
      *decisions
    ]
  end
end

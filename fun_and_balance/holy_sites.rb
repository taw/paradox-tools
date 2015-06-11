module FunAndBalanceFeatureHolySites
  # Based on history, CK2 precedence, and gameplay considerations
  # Many CK2 locations mapped to vaguely similar EU4 provinces as map correspondence is not very high
  # Better suggestions welcome
  # Protestant/Reformed set to same as Catholic because we don't know where they'll trigger
  def holy_site_info_vanilla
    {
      groups: {
        catholic:              :western_christian,
        protestant:            :western_christian,
        reformed:              :western_christian,
        inti:                  :new_world,
        nahuatl:               :new_world,
        mesoamerican_religion: :new_world,
      },
      sites: {
        christian:    ["Roma", "Jerusalem", "Constantinople"],
        western_christian: ["Galicia / Santiago de Compostela", "Kent / Cantenbury"],
        orthodox:     ["Thessaloniki / Mount Athos", "Kiev"],
        coptic:       ["Alexandria", "Tigre / Ark of the Covenant"],

        muslim:       ["Mecca", "Jerusalem", "Constantinople", "Cordoba", "Hillah / Karbala"],
        # Varanasi, Chidambaram, Angkor Wat - Hindu
        # Palitana - Jain
        # Harmandir Sahib - Sikh
        dharmic:     ["Jaunpur / Varanasi", "Coromandel / Chidambaram", "Baroda / Palitana", "Angkor / Angkor Wat", "Lahore / Harmandir Sahib"],

        # These are not amazing, but they'll have to do:
        eastern:     ["Bihar / Bodhgaya / 558", "Angkor / Angkor Wat", "Qingzhou / Qufu", "Owari / Ise Jingu", "West Gyeongsang / Bulguksa"],

        # Adapted from CK2
        norse_pagan_reformed:   ["Zeeland", "Hannover / Paderborn / 1758", "Sjaelland", "Trondelag", "Uppland / Uppsala"],
        jewish:                 ["Jerusalem", "Sinai", "Damascus", "Hamadan", "Dhofar / Salahah"],

        # One site moved way east as EU4 map has more Tengri land
        tengri_pagan_reformed: ["Pest", "Crimea", "Astrakhan", "Alty-Kuduk", "Barguzinsky"],
        zoroastrian: ["Zanjan", "Bushehr", "Bojnord", "Bam", "Balkh"],
        # Old world sites are Sunset Invasion siliness
        # New world sites are one per religion so they have reason to fight each other
        new_world: ["London", "Ile-de-France / Paris", "Mexico", "Belize", "Cuzco"],
        # Not getting any ever, these are generic groupings not real religions
        shamanism:    [],
        animism:      [],
        totemism:     [],
      }
    }
  end

  def province_id(province_name)
    @province_ids ||= @game.glob("history/provinces/*.txt")
    matches = @province_ids.select{|n|
      n.basename(".txt").to_s.sub(/\A\d+[ -]*/, "").downcase == province_name.downcase
    }
    raise "No match for #{province_name}" unless matches.size == 1
    matches[0].basename.to_s.to_i
  end

  def each_religion
    @game.glob("common/religions/*.txt").each do |path|
      @game.parse(path).each do |group_name, group|
        group.each do |religion_name, religion|
          next unless religion.is_a?(PropertyList)
          yield(group_name, religion_name, religion)
        end
      end
    end
  end

  def universal_province_id(site)
    province, name, id = site.split(/\s*\/\s*/)
    id || province_id(province)
  end

  def site_information(site)
    province, name, id = site.split(/\s*\/\s*/)
    id ||= province_id(province)
    short_name = name || province
    name = name ? "#{name} (#{province})" : "#{province}"
    {province: province, name: name, short_name: short_name, id: id}
  end

  def add_holy_site!(religion, site, n)
    trigger_name = "holy_sites_#{religion}_#{n}"
    localization! "holy_sites",
      trigger_name => "#{site[:short_name]} is #{@game.localization(religion)}",
      "desc_#{trigger_name}" => "#{religion.to_s.capitalize} rulers control holy site #{site[:name]}"
    Property[
      trigger_name, PropertyList[
        "potential", PropertyList[
          "religion", religion,
          Property::NOT["has_global_flag", "fun_and_balance_config.disable_holy_sites"],
        ],
        "trigger", PropertyList[site[:id], PropertyList["owner", PropertyList["religion", religion]]],
        "global_missionary_strength", 0.002,
      ]
    ]
  end

  def add_holy_sites_all!(religion, sites)
    # For sake of balance keep it at 0 or 5
    raise "Expected 0 or 5 sites, not #{sites.size}" unless sites.size == 5
    trigger_name = "holy_sites_#{religion}"
    localization! "holy_sites",
      trigger_name           => "All #{@game.localization(religion)} holy sites",
      "desc_#{trigger_name}" => "#{@game.localization(religion)} controls all its holy sites #{ sites.map{|x| x[:name]}.join(", ") }."
    Property[trigger_name, PropertyList[
      "potential", PropertyList[
        "religion", religion,
        Property::NOT["has_global_flag", "fun_and_balance_config.disable_holy_sites"],
      ],
      "trigger", PropertyList[
        *sites.map{|site| Property[site[:id], PropertyList["owner", PropertyList["religion", religion]]] }
      ],
      "global_missionary_strength", 0.010,
      "prestige", 1,
    ]]
  end

  def add_holy_site_mission!(religion, site, n)
    id = site[:id]
    mission_name = "conquest_#{religion}_holy_site_#{n}"
    localization! "holy_sites",
      "#{mission_name}_title" => "Conquer Holy Site #{site[:short_name]}",
      "#{mission_name}_desc" => "We must not allow infidels to hold our holy site #{site[:name]}!"
    Property[mission_name, PropertyList[
      "type", "country",
      "category", "MIL",
      "ai_mission", true,
      "allow", PropertyList[
        "religion", religion,
        Property::NOT["has_global_flag", "fun_and_balance_config.disable_holy_sites"],
        Property::OR[
          id, PropertyList["owner", PropertyList["is_neighbor_of", "ROOT"]],
          "has_idea", "deus_vult",
        ],
        "is_subject", false,
        id, PropertyList[
          "owner", PropertyList[Property::NOT["religion", religion]],
          "has_discovered", "ROOT",
        ],
      ],
      "success", PropertyList[
        id, PropertyList["owned_by", "ROOT"],
      ],
      "abort", PropertyList[
        Property::OR[
          "is_subject", true,
          id, PropertyList["owner" , PropertyList["religion", religion]],
          Property::NOT["religion", religion],
        ]
      ],
      "immediate", PropertyList["add_claim", id],
      "abort_effect", PropertyList["remove_claim", id],
      "chance", PropertyList[
        "factor", 1000,
        "modifier", PropertyList["factor", 2, "is_neighbor_of", "ROOT"],
        "modifier", PropertyList["factor", 2, "has_idea", "deus_vult"]
      ],
      "effect", PropertyList["add_adm_power", 200, "add_prestige", 40],
    ]]
  end

  def feature_holy_sites!(holy_site_info)
    missions    = []
    triggers    = []
    by_religion = {}
    by_province = {}
    province_modifiers = {}
    init_script = PropertyList[]
    use_singular = {}

    each_religion do |group_name, religion_name, info|
      use_singular[religion_name] = true
      subgroup = holy_site_info[:groups][religion_name.to_sym]
      holy_sites = [
        holy_site_info[:sites][group_name.to_sym],
        (holy_site_info[:sites][subgroup] if subgroup),
        holy_site_info[:sites][religion_name.to_sym],
      ].compact.inject(&:+)
      by_religion[religion_name] =  holy_sites
    end
    holy_site_info[:sites].each do |group, sites|
      name = @game.localization(group)

      if use_singular[group.to_s]
        name_religion = "#{name} religion"
      else
        name_religion = "#{name} religions"
      end

      mod = "#{group}_holy_site_modifier"
      if name.is_a?(Symbol)
        name = name.to_s.split("_").map(&:capitalize).join(" ")
      end
      sites.each do |site|
        (by_province[site] ||= []) << mod
      end
      province_modifiers[mod] ||= [
        "#{name} Holy Site",
        "This province is considered a holy site by #{name_religion}. It gives a bonus to all #{name} countries if it is held by a country of same religion.",
      ]
    end

    by_religion.each do |religion, sites|
      next if sites.empty?
      sites = sites.map{|s| site_information(s)}
      sites.each_with_index do |s,i|
        triggers << add_holy_site!(religion, s, i+1)
        missions << add_holy_site_mission!(religion, s, i+1)
      end
      triggers << add_holy_sites_all!(religion, sites)
    end

    by_province.each do |site, mods|
      id = universal_province_id(site)
      init_script.add! id, PropertyList[
        *mods.map{|mod|
          Property["add_province_modifier", PropertyList["name", mod, "duration", -1]]
        }
      ]
    end
    province_modifiers.each do |mod, (title, dsc)|
      localization! "holy_sites",
        "#{mod}" => title,
        "desc_#{mod}" => dsc
    end
    create_mod_file! "common/event_modifiers/10_holy_sites.txt", PropertyList[
      *province_modifiers.keys.map{|mod| Property[mod, PropertyList[]]}
    ]
    create_mod_file! "common/on_actions/10_holy_sites.txt", PropertyList[
      "on_startup", init_script,
    ]
    create_mod_file! "common/triggered_modifiers/holy_sites.txt", PropertyList[*triggers]
    create_mod_file! "missions/Holy_Sites_Missions.txt", PropertyList[*missions]
  end
end

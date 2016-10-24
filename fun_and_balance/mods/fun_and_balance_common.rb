require_relative "base"

# This file is still a bit too big, but no longer insanely so
class FunAndBalanceCommonGameModification < EU4GameModification
  def modify_node!(node, *modifications)
    modifications.each do |*path, expected, modified|
      actual = path.inject(node){|n,p| n ? n[p] : nil}
      raise "Node[#{path.join('/')}] expected `#{expected}', got `#{actual}'" unless actual == expected
      path[0..-2].inject(node){|n,p| n[p]}[path[-1]] = modified
    end
  end

  def no_naval_attrition!
    patch_mod_file!("common/technologies/dip.txt") do |node|
      node.find_all("technology").each_with_index do |tech,i|
        if i == 0
          tech["reduced_naval_attrition"] = true
        else
          tech.delete! "reduced_naval_attrition"
        end
      end
    end
  end

  def double_diplo_rel_limit_from_ideas!
    patch_mod_files!("common/ideas/*.txt") do |node|
      node.each do |group_name, idea_group|
        idea_group.each do |name, idea|
          next if %W[category trigger ai_will_do important free].include?(name)
          next if idea == [] # Empty idea
          if idea["diplomatic_upkeep"] == 1
            idea["diplomatic_upkeep"] = 2
          end
        end
      end
    end
  end

  def disable_burgundy_inheritance!
    patch_mod_file!("events/FlavorBUR.txt") do |node|
      node.each do |key, val|
        # Events: flavor_bur.(3|4|5|6|19)
        # are part of the chain but trigger from other events within it so they don't need the fix
        next unless key == "country_event" and val["id"] =~ /\Aflavor_bur\.(1|2|7)\z/
        val["trigger"].add! Property["has_global_flag", "fun_and_balance_config.enable_burgundian_succession_crisis"]
      end
    end
  end

  def move_burgundy_capital_to_hre!
    patch_mod_file!("history/countries/BUR - Burgundy.txt") do |node|
      node["capital"] = 193
    end
  end

  def fix_opinions!
    patch_mod_file!("common/opinion_modifiers/00_opinion_modifiers.txt") do |node|
      modify_node! node,
        ["opinion_annex_vassal", "min", nil, -100],
        ["broke_march", "opinion", -200, -100],
        ["broke_march", "years", nil, 10]
    end
  end

  def fix_wargoals!
    patch_mod_file!("common/cb_types/00_cb_types.txt") do |node|
      node["cb_crusade"]["prerequisites"].delete! "is_neighbor_of"
      node["cb_crusade"]["prerequisites"].prepend! Property::OR[
        "is_neighbor_of", "FROM",
        "any_country", PropertyList[
          "is_subject_of", "ROOT",
          "religion_group", "ROOT",
          "is_neighbor_of", "FROM",
          "cb_on_religious_enemies", true,
        ],
      ]
      node["cb_heretic"]["prerequisites"].delete! "is_neighbor_of"
      node["cb_heretic"]["prerequisites"].prepend! Property::OR[
        "is_neighbor_of", "FROM",
        "any_country", PropertyList[
          "is_subject_of", "ROOT",
          "religion", "ROOT",
          "is_neighbor_of", "FROM",
          "cb_on_religious_enemies", true,
        ],
      ]
    end
    patch_mod_file!("common/wargoal_types/00_wargoal_types.txt") do |node|
      modify_node! node,
        ["take_province_ban", "badboy_factor", 1.0, 0.1]
    end
  end

  def anyone_can_form_byzantium!
    patch_mod_file!("decisions/RestoreByzantineEmpire.txt") do |node|
      node["country_decisions"]["restore_byzantine_empire"]["potential"].delete! do |prop|
        prop.key == "NOT" and (prop.val == PropertyList["tag", "HLR"] or prop.val == PropertyList["tag", "TUR"])
      end
    end
  end

  def patch_religion!
    patch_mod_file!("common/religions/00_religion.txt") do |node|
      node.each do |group_name, group|
        group.each do |name, religion|
          next if ["crusade_name", "defender_of_faith", "can_form_personal_unions", "center_of_religion", "flags_with_emblem_percentage", "flag_emblem_index_range"].include?(name)
          if group_name == "pagan"
            religion["province"] ||= PropertyList[]
            religion["province"]["local_missionary_strength"] = 0.03
          else
            religion["province"].delete!("local_missionary_strength") if religion["province"]
          end
        end
      end

    localization! "religious_shift",
      "religious_shift_title" => "Accept Religious Shift",
      "religious_shift_desc"  => "Religious beliefs of the ruling elite are shifting, as our $COUNTRY_RELIGION$ heritage is gradually losing ground to the religion of $CAPITAL$."
    end

    create_mod_file! "decisions/ReligiousShift.txt", PropertyList[
      "country_decisions", PropertyList[
        "religious_shift", PropertyList[
          "potential", PropertyList[
            "capital_scope", PropertyList[
              "NOT", PropertyList["religion", "ROOT"],
            ],
            "NOT", PropertyList["tag", "PAP"],
          ],
          "allow", PropertyList[
            "stability", 1,
            "is_at_war", false,
            "is_subject", false,
          ],
          "effect", PropertyList[
            "change_religion", "capital",
            "add_stability", -2,
            "add_country_modifier", PropertyList["name", "conversion_zeal", "duration", 3650],
          ],
          "ai_will_do", PropertyList["factor", 0],
        ]
      ]
    ]

    # Because Orthodox Ottomans are a thing now
    patch_mod_file!("decisions/Ottoman.txt") do |node|
      constantinople_decision = node["country_decisions"]["make_constantinople_capital"]
      constantinople_decision["allow"].delete! "primary_culture"
      constantinople_decision["allow"].delete! "religion"
      constantinople_decision["effect"][151]["change_culture"] = "ROOT"
      constantinople_decision["effect"][151]["change_religion"] = "ROOT"
    end
  end

  def rescale(val, range_a, range_b)
    position_in_range = (val-range_a.begin).to_f /  range_a.size
    (range_b.begin + position_in_range * range_b.size).round
  end

  def rescale_tech_times_to_1399_1820_timeframe!
    patch_mod_files!("common/technologies/*.txt") do |node|
      node.find_all("technology").each_with_index do |tech,i|
        # p [tech["year"], rescale(tech["year"], 1444..1820, 1399..1820)]
        tech["year"] = rescale(tech["year"], 1444..1820, 1399..1820)
      end
    end
  end

  def power_projection_tweaks!
    patch_mod_file!("common/powerprojection/00_static.txt") do |node|
      modify_node! node,
        ["eclipsed_rival",            "power",         10,  30],
        ["eclipsed_rival",            "max",           30, 100],
        ["declared_war_at_rival",     "yearly_decay",   1, 0.5],
        ["joined_war_against_rival",  "yearly_decay",   1, 0.5],
        ["refused_war_against_rival", "yearly_decay",   1, 0.5],
        ["vassalized_rival",          "yearly_decay",   1, 0.5],
        ["took_province_from_rival",  "yearly_decay",   1, 0.5],
        ["rival_lost_province",       "yearly_decay",   1, 0.5],
        ["great_power_1",             "power",         25,  50],
        ["great_power_2",             "power",         22,  46],
        ["great_power_3",             "power",         20,  43],
        ["great_power_4",             "power",         18,  39],
        ["great_power_5",             "power",         16,  36],
        ["great_power_6",             "power",         14,  32],
        ["great_power_7",             "power",         12,  29],
        ["great_power_8",             "power",         10,  25]
    end
  end

  def override_defines_lua!(name, overrides)
    create_file!(
      "common/defines/#{name}.lua",
      overrides.map{|key, val| "NDefines.#{key} = #{val}\n"}.join
    )
  end

  def soft_patch_defines_lua!(changes)
    orig_lua = resolve("common/defines.lua").read
    changes.each do |full_variable, orig, updated|
      base_variable = full_variable.sub(/.*\./, "")
      if orig_lua =~ /^(\s+#{base_variable}\s*=\s*)(.*?)(\s*,|\s*$)/
        if $2 == orig.to_s
          # OK
        else
          raise "Tried to change `#{full_variable}' from `#{orig}' to `#{updated}', but is it `#{$2}' instead"
        end
      else
        raise("Tried to change `#{full_variable}' from `#{orig}' to `#{updated}', can't find it in the file")
      end
    end

    override_defines_lua!("fun_and_balance",
      Hash[changes.map{|var,_,nv| [var,nv]}]
    )
  end

  def disable_call_for_peace!
    patch_mod_file!("common/static_modifiers/00_static_modifiers.txt") do |node|
      node["call_for_peace"].delete!{true}
    end
  end
end

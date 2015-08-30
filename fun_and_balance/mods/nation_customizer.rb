require_relative "base"

class NationCustomizerGameModification < EU4GameModification
  # Patch 1.12 incorporated most of that into vanilla
  def fix_custom_idea_extra_governments!
    extra_government_costs = {
      # Use at your own risk:
      "siberian_native_council" => 0,
      "colonial_government" => 20,
      # Not available:
      # "papal_government",
      # "celestial_empire",
    }
    patch_mod_file!("common/governments/00_governments.txt") do |node|
      extra_government_costs.each do |gov, cost|
        node[gov]["valid_for_nation_designer"] = true
        node[gov]["nation_designer_cost"] = cost
      end
    end
  end

  def fix_custom_idea_extra_ideas!
    extra_custom_ideas = {
      "adm_tech_cost_modifier"             => [-0.05,  "adm", loc: "Innovative Administration"],
      "global_heretic_missionary_strength" => [ 0.01,  "adm", loc: "Witch Burning"],
      "migration_cooldown"                 => [-0.2,   "adm", loc: "Restless Tribe", max_level: 3],
      "monthly_fervor_increase"            => [ 0.25,  "adm", loc: "Religious Fervor"],

      "dip_tech_cost_modifier"             => [-0.05,  "dip", loc: "Innovative Diplomacy"],
      "global_ship_cost"                   => [-0.05,  "dip", loc: "Navy Provisioning"],
      "global_trade_goods_size"            => [ 0.05,  "dip", loc: "Craftsmen Guild"],
      "envoy_travel_time"                  => [-0.25,  "dip", loc: "Fast Envoys", max_level: 2],
      "caravan_power"                      => [ 0.1,   "dip", loc: "Trade Caravans"],
      "global_trade_income_modifier"       => [ 0.05,  "dip", loc: "Luxury Trade"],
      "improve_relation_modifier"          => [ 0.1,   "dip", loc: "Charming Diplomats"],
      "fabricate_claims_time"              => [-0.1,   "dip", loc: "Forgers Guild", max_level: 6],
      "imperial_authority"                 => [ 0.05,  "dip", loc: "Imperial Ambitions"],
      "naval_attrition"                    => [-0.05,  "dip", loc: "Naval Thriftiness"],
      "relations_decay_of_me"              => [ 0.1,   "dip", loc: "Let Bygones Be Bygones"],
      "papal_influence"                    => [ 0.1,   "dip", loc: "Papal Influence"],
      "rebel_support_efficiency"           => [ 0.2,   "dip", loc: "Rebel Relations"],
      "trade_range_modifier"               => [ 0.1,   "dip", loc: "Merchant Explorers"],
      "justify_trade_conflict_time"        => [-0.1,   "dip", loc: "Querrelsome Merchants", max_level: 6],
      "global_own_trade_power"             => [ 0.1,   "dip", loc: "Home Merchant Guild"],
      "global_foreign_trade_power"         => [ 0.1,   "dip", loc: "Foreign Merchant Guild"],
      "unjustified_demands"                => [-0.1,   "dip", loc: "Diplomatic Justifications", max_level: 6],
      "recover_navy_morale_speed"          => [ 0.025, "dip", loc: "Naval Enthusiasm"],
      "discovered_relations_impact"        => [-0.2,   "dip", loc: "Diplomatic Excuses", max_level: 3],
      "province_warscore_cost"             => [-0.025, "dip", loc: "Persuasive Diplomats"],
      "global_ship_repair"                 => [ 0.1,   "dip", loc: "Efficient Drydocks"],

      "mil_tech_cost_modifier"             => [-0.05,  "mil", loc: "Innovative Military"],
      "global_regiment_cost"               => [-0.05,  "mil", loc: "Army Provisioning"],
      "global_garrison_growth"             => [ 0.1,   "mil", loc: "Draft for Garrison Duty"],
      "land_attrition"                     => [-0.05,  "mil", loc: "Efficient Foraging"],
      "recover_army_morale_speed"          => [ 0.025, "mil", loc: "Military Enthusiasm"],
      "free_leader_pool"                   => [ 1,     "mil", loc: "Lower Class Officers", levels: [15, 50]],
    }

    ["adm", "dip", "mil"].each do |category|
      patch_mod_file!("common/custom_ideas/00_#{category}_custom_ideas.txt") do |node|
        ideas = node.values[0]

        # Support more more levels
        ideas.each do |idea_name, idea|
          next if idea_name == "category"
          level_costs = idea.keys.grep(/\Alevel_cost_\d+\z/).sort.map{|k| [k[/\d+/].to_i, idea[k]] }
          max_level   = idea["max_level"]
          case [max_level, *level_costs]
          when [nil]
            # OK, scale up to 10 for greater good
          when [nil, [2, 3], [3, 9], [4, 18]]
            # 60% cost ideas, scole up to level 10
            idea.add! "level_cost_5", 30
            idea.add! "level_cost_6", 45
            idea.add! "level_cost_7", 63
            idea.add! "level_cost_8", 84
            idea.add! "level_cost_9", 108
            idea.add! "level_cost_10", 135
          when [2, [1, 15], [2, 50]]
            idea.add! "level_cost_3", 105
            idea.add! "level_cost_4", 180
            idea["max_level"] = 4
          when [2, [1, 5], [2, 30]]
            idea.add! "level_cost_3", 75
            idea.add! "level_cost_4", 140
            idea.add! "level_cost_5", 225
            idea["max_level"] = 5
          when [2, [1, 3], [2, 18]]
            # 2n+1 * 60%, well, jusn following the formula
            idea.add! "level_cost_3", 45
            idea.add! "level_cost_4", 84
            idea.add! "level_cost_5", 135
            idea["max_level"] = 5
          when [2, [2, 15]]
            idea.add! "level_cost_3", 50
            idea.add! "level_cost_4", 105
            idea.add! "level_cost_5", 180
            idea["max_level"] = 5
          when [2, [1, 30], [2, 140]]
            # Extrapolating it level 3 would cost at level 12 which is out of scale
            # It's another issue if such high costs are really justified
          else
            idea.add! "max_level", 4 unless max_level
            p [idea_name, max_level, *level_costs]
          end
        end

        # New ideas
        extra_custom_ideas.each do |key, (val, cat, options)|
          next unless cat == category
          options ||= {}
          idea = PropertyList[key, val]
          if options[:max_level]
            idea.add! "max_level", options[:max_level]
          end
          if options[:levels]
            idea.add! "max_level", options[:levels].size
            options[:levels].each_with_index do |cost, i|
              idea.add! "level_cost_#{i+1}", cost
            end
          end
          ideas.add! "custom_idea_#{key}", idea
          if options[:loc]
            localization! "custom_ideas", "custom_idea_#{key}" => options[:loc], "custom_idea_#{key}_desc" => ""
          end
        end
      end
    end
  end

  def apply!
    fix_custom_idea_extra_governments!
    fix_custom_idea_extra_ideas!
  end
end

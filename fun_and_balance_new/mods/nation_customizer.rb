require_relative "base"

class NationCustomizerGameModification < EU4GameModification
  def fix_custom_idea_extra_ideas!
    # There used to be a list of extra custom ideas here, but all the meaningful ones are in game already anyway

    glob("common/custom_ideas/*.txt").each do |path|
      patch_mod_file!(path) do |node|
        node.each do |group_name, ideas|
          # Support more more levels
          ideas.each do |idea_name, idea|
            next if idea_name == "category"
            level_costs = idea.keys.grep(/\Alevel_cost_\d+\z/).sort.map{|k| [k[/\d+/].to_i, idea[k]] }
            max_level   = idea["max_level"]

            # Already maxed out
            next if max_level == 10

            # Just enabled something, so can't meaningfully scale it
            next if max_level == 1 and idea.values.include?(true)

            case [max_level, *level_costs]
            when [nil]
              # OK, scale up to 10 for greater good
            when [nil, [2, 5], [3, 15], [4, 30]]
              # This is same as default, shouldn't even be explicitly stated
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
              # 2n+1 * 60%, well, just following the formula
              idea.add! "level_cost_3", 45
              idea.add! "level_cost_4", 84
              idea.add! "level_cost_5", 135
              idea["max_level"] = 5
            when [2, [2, 10]]
              idea.add! "level_cost_3", 30
              idea.add! "level_cost_4", 60
              idea.add! "level_cost_5", 100
              idea.add! "level_cost_6", 150
              idea["max_level"] = 6
            when [2, [2, 15]]
              idea.add! "level_cost_3", 50
              idea.add! "level_cost_4", 105
              idea.add! "level_cost_5", 180
              idea["max_level"] = 4
            when [2, [2, 20]]
              idea.add! "level_cost_3", 60
              idea.add! "level_cost_4", 120
              idea["max_level"] = 4
            when [1, [1, 60]]
              idea.add! "level_cost_2", 120
              idea.add! "level_cost_3", 200
              idea["max_level"] = 3
            when [2, [1, 30], [2, 140]]
              # Extrapolating it level 3 would cost at level 12 which is out of scale
              # It's another issue if such high costs are really justified
            else
              # idea.add! "max_level", 4 unless max_level
              # warn "Not sure what to do with #{[idea_name, max_level, level_costs].inspect}"
            end
          end
        end
      end
    end
  end

  def apply!
    fix_custom_idea_extra_ideas!
  end
end

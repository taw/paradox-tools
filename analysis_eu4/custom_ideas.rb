require_relative "bonus_scoring"

# Shared helpers for reading and scoring custom ideas from common/custom_ideas/*
# Include into an EU4Analysis subclass (needs resolve/glob/parse from the base class).
module CustomIdeas
  def defines_lua
    @defines_lua ||= resolve("common/defines.lua").read.gsub(/--.*/, "").scan(/^\s+([A-Z0-9_]+)\s*=\s*(.*?)(?:\s*,|\s*$)/).to_h
  end

  def default_max_level
    @default_max_level ||= defines_lua["IDEAS_MAX_LEVEL"].to_i
  end

  def default_custom_idea_costs
    @default_custom_idea_costs ||= (1..default_max_level).map{|i|
      defines_lua["IDEAS_LEVEL_COST_#{i}"].to_i
    }
  end

  def idea_score(idea)
    BonusScoring.new.tap{|bs| idea.each{|k,v| bs.send(k,v) }}.score
  end

  def custom_ideas
    unless @custom_ideas
      @custom_ideas = []
      glob("common/custom_ideas/*").each do |path|
        parse(path).each do |subnode_name, subnode|
          category = subnode["category"]
          subnode.each do |idea_name, idea|
            next if idea_name == "category"
            idea = idea.to_h
            idea.delete "default"
            idea.delete "chance"
            idea.delete "enabled"
            max_level = idea.delete("max_level") || default_max_level
            levels = max_level.times.map do |i|
              idea.delete("level_cost_#{i+1}") || default_custom_idea_costs[i]
            end
            # Sometimes there are levels which are not reachable like custom_own_territory_dice_roll_bonus
            (1..10).each do |i|
              idea.delete("level_cost_#{i}")
            end
            @custom_ideas << [idea_name, idea, idea_score(idea), category, levels]
          end
        end
        @custom_ideas.sort_by!{|u| -u[2]}
      end
    end
    @custom_ideas
  end
end

require "pathname"
require "json"
require_relative "../../lib/paradox_game"

class Importer < ParadoxGame
  def initialize(*roots)
    super(*roots)
    @localization_export = {
      "tag" => "Country Tag",
      "TAG" => "Country Tag",
      "primary_culture" => "Primary Culture",
      "culture_group" => "Culture Group",
      "has_reform" => "Has Government Reform",
      "religion_group" => "Religion Group",
      "religion" => "Religion",
      "government" => "Government"
    }
    @basic = []
    @national = []
    @effects = {}
  end

  def each_idea_group(&blk)
    glob("common/ideas/*.txt").each do |path|
      parse(path).each(&blk)
    end
  end

  def ensure_loc(name)
    @localization_export[name] ||= localization(name)
  end

  def ensure_loc_plist(obj)
    case obj
    when PropertyList
      obj.each do |key, val|
        ensure_loc_plist(key)
        ensure_loc_plist(val)
      end
    when String
      ensure_loc(obj)
    when Numeric, TrueClass, FalseClass, Date
      # skip
    end
  end

  # There's no logic to that
  def ensure_effect_loc(name)
    @localization_export[name] ||= name.split("_").map(&:capitalize).join(" ")
  end

  def parse_idea(kind, group_name, name, idea)
    ensure_loc(name)
    result = {
      name: name,
      bonuses: [],
    }
    idea.each do |key, val|
      raise unless val.is_a?(Float) or val.is_a?(Integer) or val == true
      ensure_effect_loc(key)
      result[:bonuses] << [key, val]
      @effects[key] ||= []
      @effects[key] << [val, kind, group_name, name]
    end
    result
  end

  def parse_trigger(trigger)
    ensure_loc_plist(trigger)
    # We cound pre-parse plist nodes here
    trigger
  end

  def parse_national(name, group)
    result = {
      name: name,
      ideas: [],
      start: parse_idea("national", name, "start", group["start"]),
      bonus: parse_idea("national", name, "bonus", group["bonus"]),
      trigger: parse_trigger(group["trigger"]),
    }
    group.enum_for(:each).each_with_index do |(idea_name, idea), i|
      next if ["category", "start", "bonus", "free", "trigger"].include?(idea_name)
      result[:ideas] << parse_idea("national", name, idea_name, idea)
    end
    raise "National group #{name} has wrong size" unless result[:ideas].size == 7
    result
  end

  def parse_basic(name, group)
    result = {
      name: name,
      category: group["category"],
      ideas: [],
      bonus: parse_idea("basic", name, "bonus", group["bonus"]),
    }
    group.enum_for(:each).each_with_index do |(idea_name, idea), i|
      next if ["category", "bonus", "trigger"].include?(idea_name)
      result[:ideas] << parse_idea("basic", name, idea_name, idea)
    end
    raise "Basic group #{name} has wrong size" unless result[:ideas].size == 7
    result
  end

  def call
    each_idea_group do |name, group|
      next if name =~ /\Acompatibility_\d+\z/
      ensure_loc(name)
      group.delete! "ai_will_do"
      group.delete! "important"

      if group["category"]
        @basic << parse_basic(name, group)
      else
        @national << parse_national(name, group)
      end
    end

    data = {
      basic: @basic,
      national: @national,
      loc: @localization_export,
      effects: @effects,
    }
    puts JSON.pretty_generate(data)
  end

  def inspect
    "Importer"
  end
end

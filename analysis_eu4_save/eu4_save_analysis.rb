require_relative "../lib/paradox_game"
require_relative "eu4_save"

class EU4SaveAnalysis < ParadoxGame
  def initialize(save_game, *roots)
    super(*roots)
    @save = EU4Save.new(save_game)
  end

  def country_name(tag)
    @save.countries[tag]&.name || localization(tag)
  end

  def culture_to_culture_group
    @culture_to_culture_group ||= begin
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

  def religion_to_religion_group
    @religion_to_religion_group ||= begin
      map = {}
      glob("common/religions/*.txt").each do |path|
        parse(path).each do |group_name, group|
          group.each do |religion_name, religion|
            next unless religion.is_a?(PropertyList)
            map[religion_name] = group_name
          end
        end
      end
      map
    end
  end

  def country_sizes
    @country_sizes ||= begin
      totals = Hash.new(0)
      @save.provinces.each do |id, province|
        next unless province.city?
        if province.development == 0
          # warn "Zero development province #{province.id} #{province.name}"
          next
        end
        totals[province.owner] += province.development
      end
      totals
    end
  end

  def building_costs
    @building_costs ||= begin
      map = {}
      glob("common/buildings/*.txt").each do |path|
        parse(path).each do |name, building|
          if building["cost"]
            map[name] = building["cost"]
          elsif building["manufactory"]
            map[name] = map["manufactory"]
          else
            warn "No cost for building: #{name}"
          end
        end
      end
      map
    end
  end

  def self.new_from_argv
    unless ARGV.size >= 2
      STDERR.puts "Usage: #{$0} <save.eu4> <root> [<mod1> <mod2> ... ] # non-compressed save only"
      exit 1
    end
    new(*ARGV)
  end
end

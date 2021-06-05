require "set"
require_relative "character"
require_relative "dynasty"
require_relative "title"
require_relative "../lib/paradox"

module Ck2Analyses
  def default_map
    @default_map ||= parse("map/default.map")
  end

  def land_province_ids
    @land_province_ids ||= begin
      (1...default_map["max_provinces"]).to_a - sea_province_ids
    end
  end

  def sea_province_ids
    @sea_province_ids ||= begin
      default_map["major_rivers"] |
      default_map["externals"] |
      default_map.find_all("sea_zones").flat_map{|a,b| (a..b).to_a}
    end
  end

  def realm_name(title)
    @data["title"][title]["name"] || title
  rescue
    title
  end

  def valid_titles
    @valid_titles ||= Set[*@data["title"].keys]
  end

  def top_realm_by_id(id)
    titles = province_id_to_titles[id]
    results = titles.map{|title| top_realm_by_title(title, true)}.compact.uniq
    if results.uniq.size == 1
      results[0]
    else
      warn "Cannot find realm for province #{id} - #{titles} - #{results}"
      results[0]
    end
  end

  def top_realm_by_title(title, ignore_warnings=false)
    title_data = @data["title"][title]
    unless title_data
      warn "No such title `#{title}'" unless ignore_warnings
      return nil
    end
    liege = title_data["liege"]
    if liege
      # This double coding is 2.7.0 thing
      # Dynamic titles have complex coding
      liege = liege["title"] if liege.is_a?(PropertyList)
      top_realm_by_title(liege)
    else
      title
    end
  end

  def province_techs
    @province_techs ||= begin
      province_techs = []
      @data["provinces"].each do |id, province|
        # Ocean provinces now have flags (like disease)
        next if province == []
        name = province["name"]
        next unless name
        total_tech = province["technology"]["tech_levels"].sum.round(3)
        province_techs << {
          id: id,
          tech: total_tech,
          name: name,
        }
      end
      province_techs
    end
  end

  def province_tech_breakdown
    @province_tech_breakdown ||= begin
      province_tech_breakdown = []
      @data["provinces"].each do |id, province|
        # Ocean provinces now have flags (like disease)
        next if province == []
        name = province["name"]
        next unless name
        techs = province["technology"]["tech_levels"]
        province_tech_breakdown << {
          id: id,
          tech: techs,
          total: techs.sum.round(3),
          name: name,
        }
      end
      province_tech_breakdown
    end
  end

  def realm_techs
    @realm_techs ||= begin
      parts = {}
      province_techs.each do |info|
        province_realms = realms(info[:id]).map{|realm| realm_name(realm)}
        province_realms.each do |realm|
          parts[realm] ||= []
          parts[realm] << info[:tech]
        end
      end
      parts.map{|realm, xx|
        {
          name: realm,
          tech: (xx.inject(&:+) / xx.size).round(2),
          size: xx.size,
        }
      }
    end
  end

  # CK2 2.x
  def province_id_to_title_v2
    @province_id_to_title_v2 ||= begin
      map = {}
      node = parse("common/province_setup/00_province_setup.txt")
      node.each do |id, province|
        map[id] = province["title"]
      end
      map
    end
  end

  # CK2 3.x
  def province_id_to_title_v3
    @province_id_to_title_v3 ||= begin
      map = {}
      glob("history/provinces/*.txt").each do |path|
        id = path.basename.to_s.to_i
        title = parse(path)["title"]
        if map[id]
          warn "Multiple titles for id #{id} - #{map[id]} #{title}"
        end
        map[id] = title
      end
      map
    end
  end

  # Allows duplication, as game data is broken
  def province_id_to_titles
    @province_id_to_titles ||= begin
      map = {}
      glob("history/provinces/*.txt").each do |path|
        id = path.basename.to_s.to_i
        title = parse(path)["title"]
        map[id] ||= []
        map[id] << title
      end
      map
    end
  end

  def province_id_to_title
    @province_id_to_title ||= begin
      map = province_id_to_title_v2
      map = province_id_to_title_v3 if map.empty?
      map
    end
  end

  def realms(id)
    province = @data["provinces"][id]
    province_titles = valid_titles & province.keys
    top_realms = province_titles.map do |title|
      top_realm_by_title(title)
    end.uniq
    top_realms.sort
  end

  def player_id
    @data["player"]["id"]
  end

  def player
    Character[player_id]
  end

  def province_type(province)
    province[province["primary_settlement"]]["type"] || "unknown"
  rescue
    "unknown"
  end

  def load_characters!
    @data["dynasties"].each do |id, node|
      Dynasty.add id, node
    end
    @data["character"].each do |id, node|
      Character.add id, node
    end
    @data["title"].each do |id, node|
      Title.add id, node
    end
    Character.each do |id, character|
      character.link!
    end
    Title.each do |id, character|
      character.link!
    end
  end

  def title_paths
    @title_paths ||= begin
      map = {}
      deep_search(landed_titles) do |node, path|
        if path[-1].is_a?(String) and path[-1] =~ /\A[ekdcb]_/
          map[path[-1]] = path.reverse
        end
      end
      map
    end
  end

  def landed_titles
    @landed_titles ||= parse("common/landed_titles/landed_titles.txt")
  end

  def deep_search(node, path=[], &blk)
    node.each do |key, val|
      subpath =  [*path, key]
      if val.is_a?(PropertyList)
        deep_search(val, subpath, &blk)
      end
      yield(val, subpath)
    end
  end

  def traits
    @traits ||= begin
      map = {}
      glob("common/traits/*.txt").sort.each do |path|
        parse(path).each do |name, trait|
          map[map.size+1] = name
        end
      end
      map
    end
  end

  def historical_dynasty_religion
    @historical_dynasty_religion ||= begin
      map = {}
      glob("common/dynasties/*.txt").each do |path|
        parse(path).each do |id, dynasty|
          map[id] = dynasty["religion"] if dynasty["religion"]
        end
      end
      map
    end
  end

  def character_religion(character_id)
    character = @data["character"][character_id]
    religion = character["rel"]
    return religion if religion
    dynasty_id = character["dnt"]
    dynasty = @data["dynasties"][dynasty_id]
    historical_dynasty_religion[dynasty_id] || dynasty["religion"] || dynasty["coat_of_arms"]["religion"] || binding.pry
  end

  def historical_dynasty_culture
    @historical_dynasty_culture ||= begin
      map = {}
      glob("common/dynasties/*.txt").each do |path|
        parse(path).each do |id, dynasty|
          map[id] = dynasty["culture"] if dynasty["culture"]
        end
      end
      map
    end
  end

  def character_culture(character_id)
    character = @data["character"][character_id]
    culture = character["cul"]
    return culture if culture
    dynasty_id = character["dnt"]
    dynasty = @data["dynasties"][dynasty_id]
    historical_dynasty_culture[dynasty_id] || dynasty["culture"] || binding.pry
  end
end

class CK2SaveAnalysis
  include Ck2Analyses
  def initialize(*args)
    unless args.size == 1
      STDERR.puts "Usage: #{$0} <save.ck2> # non-compressed save only"
      exit 1
    end
    path, = *args
    @path = path
    @data = ParadoxModFile.new(path: @path).parse!
  end
end

class CK2GameAnalysis < ParadoxGame
  include Ck2Analyses
  def initialize(*args)
    unless args.size >= 1
      STDERR.puts "Usage: #{$0} <root> [<mod1> <mod2> ... ]"
      exit 1
    end
    super(*args)
  end
end

class CK2GameAndSaveAnalysis < ParadoxGame
  include Ck2Analyses
  def initialize(*args)
    unless args.size >= 2
      STDERR.puts "Usage: #{$0} <save.ck2> <root> [<mod1> <mod2> ... ] # non-compressed save only"
      exit 1
    end
    save_game, *roots = *args
    super(*roots)
    @path = save_game
    @data = ParadoxModFile.new(path: @path).parse!
  end
end

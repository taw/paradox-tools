require "set"
require_relative "character"
require_relative "dynasty"
require_relative "title"

module Ck2Analyses
  def realm_name(title)
    @data["title"][title]["name"] || title
  rescue
    title
  end

  def valid_titles
    @valid_titles ||= Set[*@data["title"].keys]
  end

  def top_realm_by_title(title)
    title_data = @data["title"][title]
    raise "No such title `#{title}'" unless title_data
    if title_data["liege"]
      top_realm_by_title(title_data["liege"]["title"])
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
        total_tech = province["technology"]["tech_levels"].inject(&:+).round(3)
        province_techs << {
          id: id,
          tech: total_tech,
          name: name,
        }
      end
      province_techs
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

  def province_id_to_title
    @province_id_to_title ||= begin
      map = {}
      node = parse("common/province_setup/00_province_setup.txt")
      node.each do |id, province|
        map[id] = province["title"]
      end
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
        if path[-1] =~ /\A[ekdcb]_/
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
      glob("common/traits/*").sort.each do |path|
        parse(path).each do |name, trait|
          map[map.size+1] = name
        end
      end
      map
    end
  end
end

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
end

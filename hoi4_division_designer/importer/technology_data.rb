class TechnologyData
  def initialize(game)
    @game = game
  end

  def each_technology
    @game.glob("common/technologies/*.txt").each do |path|
      @game.parse(path)["technologies"].each do |key, tech|
        next if key =~ /\A@\d+\z/ and tech.is_a?(Integer)
        yield(key, jsonify(tech).merge("name" => @game.localization(key)))
      end
    end
  end

  def data
    result = {}
    each_technology do |name, tech|
      ## Fixes for vanilla data
      case name
      when "gw_artillery"
        tech["start_year"] ||= 1934
      when "concentrated_industry", "dispersed_industry", "radio", "radio_detection", "mechanical_computing"
        tech["start_year"] ||= 1936
      end
      tech.delete "ai_will_do"
      tech.delete "folder"
      tech.delete "ai_research_weights"
      paths = tech.delete("path") || []
      paths = [paths] unless paths.is_a?(Array)
      # There's some nonsense in files with Excavation techs having path without destination
      tech["leads_to"] = paths.map{|t| t["leads_to_tech"]}.compact
      result[name] = tech
    end
    result
  end
end

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
      tech.delete "ai_will_do"
      tech.delete "folder"
      tech.delete "ai_research_weights"
      result[name] = tech
    end
    result
  end
end

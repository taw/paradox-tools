class DoctrineData
  def initialize(game)
    @game = game
    @technology = TechnologyData.new(@game).data
  end

  def land_doctrine_tech
    @land_doctrine_tech ||= begin
      @technology
        .select{|k,v| v["doctrine"] and v["categories"].include?("land_doctrine") }
    end
  end

  def dependencies
    @dependencies ||= begin
      result = []
      land_doctrine_tech.each do |k, v|
        v["leads_to"].each do |vv|
          result << [k, vv]
        end
      end
      result
    end
  end

  def roots
    @roots ||= (land_doctrine_tech.keys - dependencies.map(&:last))
  end

  def each_tree(choices, path, &blk)
    followers = dependencies.select{|k, v| k == path[-1]}.map(&:last)
    if followers.empty?
      yield(choices, path)
    elsif followers.size == 1
      each_tree(choices, [*path, followers[0]], &blk)
    else
      followers.each do |follower|
        each_tree([*choices, follower], [*path, follower], &blk)
      end
    end
  end

  def doctrines
    @doctrines ||= begin
      results = {}
      roots.each do |root|
        each_tree([root], [root]) do |names, doctrines|
          name = names.map{|n| @game.localization(n) }.join(" / ")
          results[name] = doctrines
        end
      end
      results
    end
  end

  def data
    doctrines
  end
end

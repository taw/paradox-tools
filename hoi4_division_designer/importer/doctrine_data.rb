class DoctrineData
  extend Memoist

  def initialize(game)
    @game = game
  end

  memoize def land_doctrine_tech
    @game.technology.land_doctrines
  end

  memoize def dependencies
    result = []
    land_doctrine_tech.each do |k, v|
      v["leads_to"].each do |vv|
        result << [k, vv]
      end
    end
    result
  end

  memoize def roots
    land_doctrine_tech.keys - dependencies.map(&:last)
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

  memoize def doctrines
    results = {}
    roots.each do |root|
      each_tree([root], [root]) do |names, doctrines|
        name = names.map{|n| @game.localization(n) }.join(" / ")
        results[name] = doctrines
      end
    end
    results
  end

  def data
    doctrines
  end
end

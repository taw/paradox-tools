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
        name = names.map{|n|
          doctrine_tech_name(n)
        }.join(" / ")
        results[name] = doctrines
      end
    end
    results
  end

  # Naming after first tech in branch works only sometimes
  def doctrine_tech_name(tech_name)
    {
      "armored_spearhead" => "Blitzkrieg",
      "volkssturm" => "Desperate Defense",
      "firebrigades" => "Modern Blitzkrieg",
      "concentrated_fire_plans" => "Airland Battle",
      "centralized_fire_control" => "Shock & Awe",
      "trench_warfare" => "Grand Battleplan",
      "grand_mechanized_offensive" => "Assault",
      "infantry_offensive" => "Infiltration",
      "large_front_operations" => "Deep Battle",
      "peoples_army" => "Mass Mobilization",
    }[tech_name] || @game.localization(tech_name)
  end

  def data
    doctrines
  end
end

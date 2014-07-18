class Pathname
  def glob(pattern)
    Dir.chdir(self){ Pathname::glob(pattern) }
  end
end

class ParadoxGame
  def initialize(*roots)
    raise "At least one root necessary" if roots.empty?
    @roots = roots.map{|r| Pathname(r)}.reverse
    @roots.each do |r|
      raise "#{r} doesn't exist" unless r.exist?
    end
    raise "Can't find common/ in the game" unless resolve("common").directory?
  end

  def parse(path)
    ParadoxModFile(path: resolve(path)).parse!
  end

  def resolve(path)
    @roots.map{|root| root + path}.find(&:exist?) or raise "Can't find #{path} in load path"
  end

  def glob(pattern)
    @roots.map{|root|
      root.glob(pattern).select{|p| (root+p).file?}
    }.flatten.uniq.sort.map{|path|
      resolve(path)
    }
  end
end

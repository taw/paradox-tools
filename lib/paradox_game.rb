require "yaml"
require "csv"
require_relative "paradox_mod_file"

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
    ParadoxModFile.new(path: resolve(path)).parse!
  end

  def parse_csv(path)
    CSV.parse(resolve(path).open("r:windows-1252:utf-8").read, col_sep: ";")
  end

  def resolve(path)
    @roots.map{|root| root + path}.find(&:exist?) or raise "Can't find #{path} in load path"
  end

  def glob(pattern)
    @roots.map{|root|
      root.glob(pattern).select{|p| (root+p).file?}
    }.flatten.uniq{|x| x.to_s.downcase}.sort
  end

  def localization_data
    @localization_data ||= glob("localisation/*_l_english.yml").map{|path|
      YAML.load(resolve(path).read)
    }.inject({}, &:merge)
  end

  def localization(key)
    localization_data[key.to_s] || key
  end
end

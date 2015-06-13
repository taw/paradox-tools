require "yaml"
require "csv"
require_relative "paradox_mod_file"

class Pathname
  def glob(pattern)
    Dir.chdir(self){ Pathname::glob(pattern) }
  end
end

class ParadoxGame
  # Root can be either directory or .mod file (with same name as directory in it)
  def initialize(*root_paths)
    raise "At least one root necessary" if root_paths.empty?
    @roots = []
    root_paths.each do |path|
      add_root!(Pathname(path))
    end
    raise "Can't find common/ in the game" unless resolve("common").directory?
  end

  def parse(path)
    ParadoxModFile.new(path: resolve(path)).parse!
  end

  def parse_csv(path)
    CSV.parse(resolve(path).open("r:windows-1252:utf-8").read, col_sep: ";")
  end

  # "foo/bar.txt"   !~ "foo/bar"
  # "foo/bar"       =~ "foo/bar"
  # "foo/bar/x.txt" =~ "foo/bar"
  def match_replace_path?(replace, path)
    replace == path or path.dirname.to_s.start_with?(replace.to_s)
  end

  def resolve(path)
    @roots.each do |root|
      path_in_mod = root[:path] + path
      return path_in_mod if path_in_mod.exist?
      break if root[:replace].any?{|replace| match_replace_path?(replace, Pathname(path)) }
    end
    raise "Can't find #{path} in load path"
  end

  def glob(pattern)
    excludes = []
    found    = []
    @roots.each do |root|
      root[:path].glob(pattern).each do |file|
        next unless (root[:path]+file).file?
        next if excludes.any?{|replace| match_replace_path?(replace, file) }
        found << file
      end
      excludes += root[:replace]
    end
    found.uniq{|file| file.to_s.downcase}.sort
  end

  def parse_localization_from_path(path)
    data = path.read
    YAML.load(data.gsub(/\uFEFF/, ""))["l_english"].tap do |parsed|
      raise "No Engish localization data in `#{path}'" unless parsed
    end
  end

  def localization_data
    @localization_data ||= glob("localisation/*_l_english.yml").map{|path|
      parse_localization_from_path(resolve(path))
    }.inject({}, &:merge)
  end

  def localization(key)
    localization_data[key.to_s] || key
  end

  private

  def add_root!(path)
    raise "#{path} doesn't exist" unless path.exist?
    if path.directory?
      @roots.unshift(path: path, replace: [])
    else
      mod_file = ParadoxModFile.new(path: path).parse!
      dir_path = path.dirname + File.basename(mod_file["path"])
      replaces = mod_file.find_all("replace_path").map{|path| Pathname(path) + "." }
      raise ".mod file and directory for it must be in same folder" unless dir_path.directory?
      @roots.unshift(path: dir_path, replace: replaces)
    end
  end
end

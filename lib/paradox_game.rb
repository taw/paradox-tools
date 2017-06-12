require "csv"
require_relative "fake_yaml"
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

  def localization(key, default=key)
    localization_data[key.to_s] || default
  end

  def localization_type
    yml = !glob("localisation/*_l_english.yml").empty?
    csv = !glob("localisation/*.csv").empty?
    raise "Not a clue" if yml and csv
    return :hoi4 if yml # Should work with EU4 as well
    return :ck2 if csv
    return :none
  end

  # If something is defined in multiple locations
  # for now we don't have any special handling
  def localization_data
    unless @localization_data
      @localization_data = {}
      glob("localisation/*_l_english.yml").each do |path|
        @localization_data.merge!(parse_localization_from_path_hoi4(resolve(path)) || {})
      end
      glob("localisation/*.csv").each do |path|
        @localization_data.merge!(parse_localization_from_path_ck2(resolve(path)) || {})
      end
    end
    @localization_data
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

  # It can handle EU4 format as well
  def parse_localization_from_path_hoi4(path)
    FakeYaml.load(path)
  end

  def parse_localization_from_path_ck2(path)
    # No idea WTF but some are UTF8 and some are not
    # WTF are files which are not UTF8? Sometimes they look iso-8859-1, sometimes windows-1252
    # It's all that miserable
    data = path.read
    unless data.valid_encoding?
      data = data.force_encoding("iso-8859-1").encode("UTF-8")
    end
    Hash[data.split("\n").grep(/\A[^#]/).map{|line| line.split(";")[0,2] }]
  end
end

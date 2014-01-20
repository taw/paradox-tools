require "pathname"
require "yaml"

@eu4_dir = Pathname("#{ENV['HOME']}/Library/Application Support/Steam/SteamApps/common/Europa Universalis IV")

def localization
  unless @localization
    @localization = {}
    (@eu4_dir+"localisation").each_child do |path|
      @localization.merge! YAML.load(path.read) if path.to_s =~ /_l_english\.yml\z/
    end
  end
  @localization
end

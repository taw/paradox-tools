require "pathname"
require "yaml"

module Localization
  class << self
    attr_accessor :eu4_dir
    def [](key)
      localization_data[key.to_s] || key
    end
    def localization_data
      unless @localization_data
        @localization_data = {}
        (eu4_dir+"localisation").each_child do |path|
          @localization_data.merge! YAML.load(path.read) if path.to_s =~ /_l_english\.yml\z/
        end
      end
      @localization_data
    end
  end
end

Localization.eu4_dir = Pathname("#{ENV['HOME']}/Library/Application Support/Steam/SteamApps/common/Europa Universalis IV")

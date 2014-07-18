# Temporary wrapper API

require_relative "lib/paradox_game"
require "pathname"
require "yaml"

module Localization
  class << self
    attr_accessor :eu4_dir
    def eu4
      @eu4 ||= ParadoxGame.new(@eu4_dir)
    end
    def [](key)
      eu4.localization(key)
    end
  end
end

Localization.eu4_dir = Pathname("#{ENV['HOME']}/Library/Application Support/Steam/SteamApps/common/Europa Universalis IV")

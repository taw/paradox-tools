#!/usr/bin/env ruby

require "RMagick"
require "pp"
require_relative "../lib/paradox"
require_relative "image_generation"
require_relative "game_map"
require_relative "world_history"

class TimelapseVisualization < ParadoxGame
  include ImageGeneration
  include GameMap

  def initialize(save_game, *roots)
    @world = WorldHistory.new(save_game)
    super(*roots)
  end

  def dates_to_generate(frequency=10)
    (@world.start_date.year...@world.current_date.year).step(frequency).map{|year|
      if year == @world.start_date.year
        @world.start_date
      else
        Date.new(year, 1, 1, Date::JULIAN)
      end
    } + [@world.current_date]
  end

  def generate_maps_for_date!(date)
    # let's start with religions
    province_map = Hash[
      land_province_ids.map{|id|
        religion = @world.province_state(id, date)["religion"]
        [id, religion_colors[religion]]
      }
    ]
    generate_map_image(build_color_map(province_map)).write("campaign/religion-#{date.year}-#{date.month}-#{date.day}.png")

    # and owner
    province_map = Hash[
      land_province_ids.map{|id|
        owner = @world.province_state(id, date)["owner"]
        [id, country_colors[owner]]
      }
    ]
    generate_map_image(build_color_map(province_map)).write("campaign/countries-#{date.year}-#{date.month}-#{date.day}.png")
  end

  def generate_maps!
    dates_to_generate.each do |date|
      generate_maps_for_date!(date)
    end
  end
end

if __FILE__ == $0
  vis = TimelapseVisualization.new(*ARGV)
  vis.generate_maps!
end

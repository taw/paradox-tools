#!/usr/bin/env ruby

require "RMagick"
require_relative "../lib/paradox"
require_relative "image_generation"
require_relative "game_map"

class Visualization < ParadoxGame
  include ImageGeneration
  include GameMap

  def generate_map_by_continent!
    continent_colors = {
      "europe"        => [181, 72, 106],
      "asia"          => [220, 138, 57],
      "africa"        => [63, 125, 214],
      "north_america" => [54, 167, 156],
      "south_america" => [219, 124, 139],
      "oceania"       => [57, 160, 101],
      nil             => [0, 0, 80],
    }
    province_map = Hash[
      land_province_ids.map{|id|
        [id, continent_colors[province_id_to_continent(id)]]
      }
    ]
    generate_map_image(build_color_map(province_map)).write("continents.png")
  end

  def generate_map_by_colonial_regions!
    province_map = Hash[
      land_province_ids.map{|id|
        [id, colonial_regions_colors[province_id_to_colonial_region(id)]]
      }
    ]
    generate_map_image(build_color_map(province_map)).write("colonial_regions.png")
  end
end

vis = Visualization.new(*ARGV)
vis.generate_map_by_continent!
vis.generate_map_by_colonial_regions!

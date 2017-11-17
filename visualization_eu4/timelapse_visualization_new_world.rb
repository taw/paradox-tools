#!/usr/bin/env ruby

require_relative "timelapse_visualization"

class TimelapseVisualizationNewWorld < TimelapseVisualization
  def initialize(save_game, new_world_base, *roots)
    @provinces_image = Magick::Image.read(new_world_base).first
    super(save_game, *roots)
  end

  def new_world_religion_color(i)
    r = 200
    g = i / 256
    b = i % 256
    [r,g,b]
  end

  # Only non-wasteland land provinces have any pixels, so we can ignore filtering
  # out sea and wasteland
  def province_ids
    @world.provinces.keys
  end

  def build_color_map_new_world(province_to_color, default_land_color=[107, 66, 38], sea_color=[0, 0, 80])
    Hash[
      province_ids.map{|id|
        color = new_world_religion_color(id).pack("C*")
        new_color = province_to_color[id] || default_land_color
        new_color = new_color.map{|e| e.is_a?(Float) ? (e*255).round : e }
        new_color = new_color.pack("C*")
        [color, new_color]
       } + [
        [[68, 107, 163].pack("C*"), sea_color.pack("C*")], # sea
        [[94, 94, 94].pack("C*"), default_land_color.pack("C*")], # wasteland
      ]
    ]
  end

  def generate_maps_for_date!(date)
    # let's start with religions
    province_map = Hash[
      land_province_ids.map{|id|
        religion = @world.province_state(id, date)["religion"]
        [id, religion_colors[religion]]
      }
    ]
    generate_map_image(build_color_map_new_world(province_map)).write("campaign/religion-#{date.year}-#{date.month}-#{date.day}.png")

    # and owner
    province_map = Hash[
      land_province_ids.map{|id|
        owner = @world.province_state(id, date)["owner"]
        [id, country_color_for(owner)]
      }
    ]
    generate_map_image(build_color_map_new_world(province_map)).write("campaign/countries-#{date.year}-#{date.month}-#{date.day}.png")
  end
end

vis = TimelapseVisualizationNewWorld.new(*ARGV)
vis.generate_maps!

#!/usr/bin/env ruby

require "RMagick"
require "pp"
require_relative "../lib/paradox"

# Some are [0..1], others are [0..255], we should probably standardize them here

class Visualization < ParadoxGame
  def provinces_image
    @provinces_image ||= Magick::Image.read(resolve("map/provinces.bmp")).first
  end

  def generate_map_image(color_map)
    black = [0,0,0].pack("CCC")
    pixels = provinces_image.export_pixels_to_str
    (0...pixels.size).step(3) do |i|
      current_color = pixels[i, 3]
      new_color     = color_map[current_color] || black
      pixels[i, 3]  = new_color
    end
    pixels
    img = Magick::Image.new(provinces_image.columns, provinces_image.rows){|info| info.depth=8}
    img.import_pixels(0, 0, img.columns, img.rows, "RGB", pixels)
    img
  end

  def province_definitions
    @province_definitions ||= begin
      defs = {}
      parse_csv("map/definition.csv")[1..-1].each do |id, r, g, b, name, _|
        defs[id.to_i] = [[r.to_i, g.to_i, b.to_i].pack("CCC"), name]
      end
      defs
    end
  end

  def provinces_by_continent
    @provinces_by_continent ||= parse("map/continent.txt").to_h
  end

  def religion_colors
    @religion_colors ||= begin
      colors = {}
      glob("common/religions/*.txt").each do |path|
        parse(path).each do |group_name, group|
          group.each do |name, religion|
            next if name == "defender_of_faith" or name == "crusade_name"
            colors[name] = religion["color"]
          end
        end
      end
      colors
    end
  end

  def region_colors
    @region_colors ||= begin
      colors = []
      glob("common/region_colors/*.txt").each do |path|
        colors += parse(path).find_all("color")
      end
      colors
    end
  end

  def country_colors
    @country_colors ||= begin
      colors = {}
      glob("common/country_tags/*.txt").each do |path|
        parse(path).each do |tag, path|
          colors[tag] = parse("common/#{path}")["color"]
        end
      end
      colors
    end
  end

  def natives_colors
    @natives_colors ||= begin
      colors = {}
      glob("common/natives/*.txt").each do |path|
        parse(path).each do |name, details|
          colors[name] = details["color"]
        end
      end
      colors
    end
  end

  def trade_companies_colors
    @trade_companies_colors ||= begin
      colors = {}
      glob("common/trade_companies/*.txt").each do |path|
        parse(path).each do |name, details|
          colors[name] = details["color"]
        end
      end
      colors
    end
  end

  def colonial_regions_colors
    @colonial_regions_colors ||= begin
      colors = {}
      glob("common/colonial_regions/*.txt").each do |path|
        parse(path).each do |name, details|
          colors[name] = details["color"]
        end
      end
      colors
    end
  end

  def trade_goods_colors
    tradegoods_colors ||= begin
      colors = {}
      glob("common/tradegoods/*.txt").each do |path|
        parse(path).each do |name, details|
          colors[name] = details["color"]
        end
      end
      colors
    end
  end

  # Not all of them have colors specified apparently
  def trade_node_colors
    @trade_node_colors ||= begin
      colors = {}
      glob("common/tradenodes/*.txt").each do |path|
        parse(path).each do |name, details|
          colors[name] = details["color"]
        end
      end
      colors
    end
  end

  def generate_map_by_continent!
    continent_colors = {
      "europe"        => [181, 72, 106].pack("C*"),
      "asia"          => [220, 138, 57].pack("C*"),
      "africa"        => [63, 125, 214].pack("C*"),
      "north_america" => [54, 167, 156].pack("C*"),
      "south_america" => [219, 124, 139].pack("C*"),
      "oceania"       => [57, 160, 101].pack("C*"),
      nil             => [160, 160, 255].pack("C*"),
    }
    color_map = Hash[province_definitions.map{|id,(color,name)|
      [
        color,
        continent_colors[(provinces_by_continent.find{|k,v| v.include?(id) }||[]).first],
      ]
    }]
    img = generate_map_image(color_map)
    img.write("continents.png")
  end
end

if __FILE__ == $0
  vis = Visualization.new(*ARGV)
  vis.generate_map_by_continent!
end

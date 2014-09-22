#!/usr/bin/env ruby

require "RMagick"
require "pp"
require_relative "../lib/paradox"
require_relative "image_generation"

class Visualization < ParadoxGame
  include ImageGeneration

  def provinces_image
    @provinces_image ||= Magick::Image.read(resolve("map/provinces.bmp")).first
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

  def default_map
    @default_map ||= parse("map/default.map")
  end

  def land_province_ids
    @land_province_ids ||= begin
      (1...default_map["max_provinces"]).to_a - sea_province_ids
    end
  end

  def sea_province_ids
    @sea_province_ids ||= begin
      default_map["lakes"] | default_map["sea_starts"]
    end
  end

  def provinces_by_continent
    @provinces_by_continent ||= parse("map/continent.txt").to_h
  end

  def provinces_by_colonial_region
    @provinces_by_colonial_region ||= begin
      map = {}
      glob("common/colonial_regions/*.txt").each do |path|
        parse(path).each do |region, details|
          map[region] = details["provinces"]
        end
      end
      map
    end
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

  #########################################################
  # Public interface

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
      sea_province_ids.map{|id| [id, continent_colors[nil]]} +
      land_province_ids.map{|id|
        continent = provinces_by_continent.find{|k,v| v.include?(id) } || []
        [id, continent_colors[continent.first]]
      }
    ]
    img = generate_map_image(build_color_map(province_map))
    img.write("continents.png")
  end

  def generate_map_by_colonial_regions!
    sea_color = [0, 0, 80]
    bg_color = [107, 66, 38]

    province_map = Hash[
      sea_province_ids.map{|id| [id, sea_color] } +
      land_province_ids.map{|id|
        colonial_region = provinces_by_colonial_region.find{|k,v| v.include?(id) } || []
        [id, colonial_regions_colors[colonial_region.first] || bg_color]
      }
    ]
    img = generate_map_image(build_color_map(province_map))
    img.write("colonial_regions.png")
  end
end

if __FILE__ == $0
  vis = Visualization.new(*ARGV)
  # vis.generate_map_by_continent!
  vis.generate_map_by_colonial_regions!
end

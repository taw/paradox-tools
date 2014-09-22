#!/usr/bin/env ruby

require "RMagick"
require "pp"
require_relative "../lib/paradox"

# Some are [0..1], others are [0..255], we should probably standardize them here

class Visualization < ParadoxGame
  def provinces_image
    @provinces_image ||= Magick::Image.read(resolve("map/provinces.bmp")).first
  end

  def province_definitions
    @province_definitions ||= parse_csv("map/definition.csv")
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
end

if __FILE__ == $0

  vis = Visualization.new(*ARGV)

  # pp vis.religion_colors
  # pp vis.region_colors
  # pp vis.country_colors
  # pp vis.natives_colors
  # pp vis.trade_companies_colors
  # pp vis.colonial_regions_colors
  # pp vis.trade_goods_colors
  # pp vis.trade_node_colors

  pp vis.province_definitions
  vis.provinces_image
end

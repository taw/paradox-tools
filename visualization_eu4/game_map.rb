module GameMap
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

  def provinces_image_pixels
    @provinces_image_pixels ||= provinces_image.export_pixels_to_str
  end

  def provinces_by_continent
    @provinces_by_continent ||= parse("map/continent.txt").to_h
  end

  def province_id_to_continent(id)
    provinces_by_continent.each{|k,v| return k if v.include?(id) }
    nil
  end

  def province_id_to_colonial_region(id)
    provinces_by_colonial_region.each{|k,v| return k if v.include?(id) }
    nil
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
end

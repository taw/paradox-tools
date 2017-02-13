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
      default_map["major_rivers"] |
      default_map["externals"] |
      default_map.find_all("sea_zones").flat_map{|a,b| (a..b).to_a}
    end
  end
end

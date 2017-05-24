require_relative "../lib/paradox"
require_relative "../lib/paradox_mod_builder"

class Image
  def initialize(builder, name)
    @name = name
    @builder = builder
    @data = @builder.resolve("map/#{name}").open("rb", &:read)
    @pixel_offset = @data[10,4].unpack("l")[0]
    @bits_per_pixel = @data[0x1c, 2].unpack("v")[0]
    raise unless @bits_per_pixel % 8 == 0
    @bytes_per_pixel = @bits_per_pixel / 8
    raise unless xsize == @data[0x12, 4].unpack("l")[0]
    raise unless ysize == @data[0x16, 2].unpack("v")[0]
  end

  def save!
    Pathname("output/#{@builder.mod_name}/map").mkpath
    open("output/#{@builder.mod_name}/map/#{@name}", "w") do |fh|
      fh.write @data
    end
  end

  def xsize
    5632
  end

  def ysize
    2048
  end

  def idx(x,y)
    @pixel_offset + ((ysize - 1 - y) * xsize + x) * @bytes_per_pixel
  end

  def [](x,y)
    @data[idx(x,y), @bytes_per_pixel]
  end

  def []=(x,y,v)
    raise unless v.size == @bytes_per_pixel
    @data[idx(x,y), @bytes_per_pixel] = v
  end
end

class HeightmapImage < Image
  def initialize(builder)
    super(builder, "heightmap.bmp")
  end
end

class TerrainImage < Image
  def initialize(builder)
    super(builder, "terrain.bmp")
  end
end

class ProvinceImage < Image
  def initialize(builder)
    super(builder, "provinces.bmp")
  end

  def [](x,y)
    px = super(x,y).reverse.b
    @builder.province_map[px] or raise
  end
end

module SimpleTerrainMapMod
  def xsize
    5632
  end

  def ysize
    2048
  end

  def each_tile
    xsize.times do |x|
      ysize.times do |y|
        yield(x, y)
      end
    end
  end

  def province_map
    @province_map ||= begin
      map = {}
      resolve("map/definition.csv").readlines.each do |line|
        parts = line.chomp.split(";")
        color = parts[1,3].map(&:to_i).pack("C*").b
        raise if map[color]
        map[color] = parts[0,1] + parts[4..-1]
      end
      map
    end
  end

  def victory_points
    @victory_points ||= begin
      vps = Set[]
      glob("history/states/*.txt").each do |path|
        vps += parse(path)["state"]["history"].find_all("victory_points").map(&:first)
      end
      vps
    end
  end

  def urban_province_types
    @urban_province_types ||= Set[*%W[
      algiers amsterdam ankara anzio athens auckland baltimore barcelona
      beijing belfast bergen berlin berne bombay bratislava bremen breslau
      bristol brno bruges brunei brussels budapest cairo calcutta capetown
      chicago copenhagen cordoba danzig daugavpils delhi denver detroit dresden
      edinburgh falun gibraltar glasgow goteburg graz guam hamburg havana
      hobart hull innsbruck istanbul izmir kaunas kobe kola konigsberg
      leipzig ljubljana lodz london luxembourg lyon madrid magdeburg malmo malta
      marseille mogadishu moscow munich namur newcastle newyork nurnberg orleans
      palawan paris pecs perth petrograd philadelphia pittsburgh plovdiv
      plymouth prague pyongyang riga rome rostock rotterdam salzburg samarkand
      sanaa sevastopol seville sion sofia spokane stalingrad stettin stlouis
      stockholm tallin tbilisi tirana tokyo trieste trondheim ulm vienna vlore
      warsaw wloclawek wurzburg zurich
    ]]
  end

  def apply_simple_terrain_map_mod!
    heightmap = HeightmapImage.new(self)
    terrain   = TerrainImage.new(self)
    provinces = ProvinceImage.new(self)

    each_tile do |x,y|
      current_province = provinces[x,y]
      raise unless current_province
      province_terrain = current_province[3]
      province_terrain = "urban" if urban_province_types.include?(province_terrain)
      # province_terrain = "urban" if victory_points.include?(current_province[0].to_i)

      # Game contains extra provinces which are urban in-game, but other in definition.csv
      # I can't figure out what's the rule

      # There's no deep reason to change height of seas
      next if current_province[1] == "sea"
      next if province_terrain == "lakes"

      if province_terrain == "mountain"
        heightmap[x,y] = "\x90".b
      elsif province_terrain == "hills"
        heightmap[x,y] = "\x80".b
      else
        heightmap[x,y] = "q".b
      end

      next if province_terrain == "unknown" # usually plains or forent, non special value here

      # Terrain fix here...
      map = {
        "plains"   => "\x00".b,
        "forest"   => "\x01".b,
        "hills"    => "\x02".b,
        "desert"   => "\x03".b,
        "marsh"    => "\x09".b,
        "mountain" => "\x0b".b,
        "urban"    => "\x0d".b,
        "jungle"   => "\x15".b,
      }
      terrain[x,y] = (map[province_terrain] or raise)
    end

    heightmap.save!
    terrain.save!
  end
end

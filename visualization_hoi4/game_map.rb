module GameMap
  def province_definitions
    @province_definitions ||= begin
      defs = {}
      parse_csv("map/definition.csv")[1..-1].each do |id, r, g, b, land_sea, *|
        defs[id.to_i] = [[r.to_i, g.to_i, b.to_i].pack("CCC"), land_sea]
      end
      defs
    end
  end

  def provinces_image_pixels
    @provinces_image_pixels ||= provinces_image.export_pixels_to_str
  end

  def xsize
    @xsize ||= provinces_image.columns
  end

  def ysize
    @ysize ||= provinces_image.rows
  end

  def generate_map_image_pixels(color_map)
    black = [0,0,0].pack("CCC")
    pixels = provinces_image_pixels.dup
    (0...pixels.size).step(3) do |i|
      current_color = pixels[i, 3]
      new_color     = color_map[current_color] || black
      pixels[i, 3]  = new_color
    end
    pixels
  end

  def pixels_to_img(pixels)
    img = Magick::Image.new(provinces_image.columns, provinces_image.rows){|info| info.depth=8}
    img.import_pixels(0, 0, img.columns, img.rows, "RGB", pixels)
    img
  end

  def generate_map_image(color_map)
    pixels_to_img(generate_map_image_pixels(color_map))
  end

  def provinces_image
    @provinces_image ||= Magick::Image.read(resolve("map/provinces.bmp")).first
  end

  def states_to_province_ids
    unless @states_to_province_ids
      @states_to_province_ids = {}
      glob("history/states/*.txt").each do |path|
        node = parse(path)["state"]
        id = node["id"]
        provinces = node["provinces"]
        @states_to_province_ids[id] = provinces
      end
    end
    @states_to_province_ids
  end

  def province_ids_to_states
    unless @province_ids_to_states
      @province_ids_to_states = {}
      states_to_province_ids.each do |state_id, provinces|
        provinces.each do |province_id|
          @province_ids_to_states[province_id] = state_id
        end
      end
    end
    @province_ids_to_states
  end

  def land_sea_color_map
    Hash[
      province_definitions.map do |id, (color, land_sea)|
        if land_sea == "land"
          new_color = [107, 66, 38]
        else
          new_color = [0, 0, 80]
        end
        [color, new_color.pack("C*")]
      end
    ]
  end
end

require "RMagick"

module ImageGeneration
  def province_definitions
    @province_definitions ||= begin
      defs = {}
      parse_csv("map/definition.csv")[1..-1].each do |id, r, g, b, name, _|
        defs[id.to_i] = [[r.to_i, g.to_i, b.to_i].pack("CCC"), name]
      end
      defs
    end
  end

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

  # By default force all sea provinces to sea color
  def build_color_map(province_to_color, default_land_color=[107, 66, 38], sea_color=[0, 0, 80])
    Hash[
      province_definitions.map{|id, (color, name)|
        if sea_province_ids.include?(id)
          new_color = sea_color
        else
          new_color = province_to_color[id] || default_land_color
        end
        new_color = new_color.map{|e| e.is_a?(Float) ? (e*255).round : e }
        new_color = new_color.pack("C*")
        [color, new_color]
      }
    ]
  end

  def religion_colors
    @religion_colors ||= begin
      map = {}
      parse("common/religions/00_religions.txt").each do |group_name, group|
        group.each do |religion_name, religion|
          next unless religion.is_a?(PropertyList)
          color = religion["color"]
          next unless color
          r, g, b = color
          color = color.map{|u| (u*255.0).round }
          map[religion_name] = color
        end
      end
      map
    end
  end
end

require "RMagick"
require_relative "../visualization_hoi4/blob_midpoint"

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

  def xsize
    @xsize ||= provinces_image.columns
  end

  def ysize
    @ysize ||= provinces_image.rows
  end

  def provinces_image
    @provinces_image ||= Magick::Image.read(resolve("map/provinces.bmp")).first
  end

  def province_color_to_id
    @province_color_to_state_id ||= Hash[
      province_definitions.map do |province_id, (color, name)|
        [color, province_id]
      end
    ]
  end

  def province_at(x,y)
    x %= provinces_image.columns
    return nil if y < 0 or y >= ysize
    pixel = provinces_image_pixels[3*(x + y * xsize), 3]
    province_color_to_id[pixel]
  end

  def province_midpoints
    unless @province_midpoints
      @province_midpoints = {}
      (0...provinces_image.columns).each do |x|
        (0...provinces_image.rows).each do |y|
          province_id = province_at(x,y)
          @province_midpoints[province_id] ||= BlobMidpoint.new
          @province_midpoints[province_id].add(x,y)
        end
      end
    end
    @province_midpoints
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
end

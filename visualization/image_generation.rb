module ImageGeneration
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

  def build_color_map(province_to_color)
    Hash[province_definitions.map{|id, (color, name)|
      new_color = province_to_color[id] || [0, 0, 0]
      new_color = new_color.map{|e| e.is_a?(Float) ? (e*255).round : e }
      new_color = new_color.pack("C*")
      [color, new_color]
    }]
  end

end

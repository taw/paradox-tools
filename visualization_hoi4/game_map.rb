# We assume there's no crossing x=0 line
class BlobMidpoint
  def initialize
    @x_total = 0.0
    @y_total = 0.0
    @samples = 0
  end

  def add(x,y)
    @x_total += x
    @y_total += y
    @samples += 1
  end

  def x
    return if @samples == 0
    (@x_total / @samples).round
  end

  def y
    return if @samples == 0
    (@y_total / @samples).round
  end

  def to_s
    "<#{x},#{y}>"
  end

  def inspect
    to_s
  end
end

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
      @province_to_victory_points = {}
      glob("history/states/*.txt").each do |path|
        node = parse(path)["state"]
        id = node["id"]
        provinces = node["provinces"]
        node["history"].find_all("victory_points").each do |vps_node|
          vps_node.each_slice(2) do |province_id, vps|
            @province_to_victory_points[province_id] = vps
          end
        end
        @states_to_province_ids[id] = provinces
      end
    end
    @states_to_province_ids
  end

  def state_to_vp_total
    unless @state_to_vp_total
      @state_to_vp_total = Hash.new(0)
      states_to_province_ids.each do |state_id, province_ids|
        total = province_ids.map{|i| @province_to_victory_points[i]}.compact.inject(0, &:+).round
        @state_to_vp_total[state_id] = total
      end
    end
    @state_to_vp_total
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

  def province_color_to_state_id
    @province_color_to_state_id ||= Hash[
      province_definitions.map do |province_id, (color, land_sea)|
        state_id = province_ids_to_states[province_id]
        if state_id
          # OK
        elsif land_sea == "land"
          state_id = -1
        else
          state_id = -2
        end
        [color, state_id]
      end
    ]
  end

  def state_at(x,y)
    x %= provinces_image.columns
    return nil if y < 0 or y >= ysize
    pixel = provinces_image_pixels[3*(x + y * xsize), 3]
    province_color_to_state_id[pixel]
  end

  def add_state_borders(pixels)
    border_color = [64,64,64].pack("C*")
    (0...provinces_image.columns).each do |x|
      (0...provinces_image.rows).each do |y|
        cc = state_at(x,y)
        cr = state_at(x+1,y)
        cl = state_at(x-1,y)
        cu = state_at(x,y-1)
        cd = state_at(x,y+1)
        border = false
        border = true if cr and cr != cc
        border = true if cl and cl != cc
        border = true if cu and cu != cc
        border = true if cd and cd != cc
        if border
          pixels[3*(x + y * xsize), 3] = border_color
        end
      end
    end
    pixels
  end

  def write_image(img, path)
    path = Pathname(path)
    path.parent.mkpath
    img.write(path.to_s)
  end

  def state_based_color_map
    Hash[
      province_definitions.map do |province_id, (color, land_sea)|
        state_id = province_ids_to_states[province_id]
        if land_sea != "land"
          new_color = [128, 255, 255]
        elsif state_id
          new_color = yield(state_id)
        else
          new_color = [107, 66, 38]
        end
        [color, new_color.pack("C*")]
      end
    ]
  end

  def state_midpoints
    unless @state_midpoints
      @state_midpoints = {}
      (0...provinces_image.columns).each do |x|
        (0...provinces_image.rows).each do |y|
          state_id = state_at(x,y)
          @state_midpoints[state_id] ||= BlobMidpoint.new
          @state_midpoints[state_id].add(x,y)
        end
      end
    end
    @state_midpoints
  end
end

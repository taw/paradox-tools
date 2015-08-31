require_relative "base"

class SuezCanalGameModification < CK2GameModification
  # Because it's a portage, only use with allow_everyone_river_access!
  def apply!
    # 1382 - Gulf of Suez
    #  939 - Nile Delta
    #  789 - Pelusia
    patch_file!("map/adjacencies.csv", reencode: "iso-8859-1") do |content|
      [
        content,
        "939;1382;portage;789;-1;-1;-1;-1;Suez Canal",
      ].join("\r\n")
    end
    # Merge both oceans
    patch_mod_file!("map/default.map") do |map|
      map.delete_if{|k,v|
        k == "ocean_region" and v == PropertyList["sea_zones", [5, 6, 7, 8]]
      }
      map["ocean_region"]["sea_zones"] = [1,2,3,4,5,6,7,8]
    end
  end
end

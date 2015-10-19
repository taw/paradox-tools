require_relative "base"

class BiggerWarsBoxGameModification < CK2GameModification
  def apply!
    patch_mod_file!("interface/waroverview.gui") do |node|
      waricon_box = node["guiTypes"].find_all("windowType").find{|n| n["name"] == "waricon_box"}
      waricon_box["position"]["x"] -= 400
      waricon_box["size"]["x"] += 400
      waricon_box["OverlappingElementsBoxType"]["size"]["x"] += 400
    end
  end
end

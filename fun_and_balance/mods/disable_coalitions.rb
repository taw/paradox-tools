require_relative "base"

class DisableCoalitionsGameModification < EU4GameModification
  def apply!
    patch_mod_file!("common/diplomatic_actions/00_diplomatic_actions.txt") do |node|
      node["form_coalition"]["condition"]["allow"] = PropertyList["always", false]
    end
  end
end

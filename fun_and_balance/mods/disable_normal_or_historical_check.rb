require_relative "base"

# This is a good change, but it conflicts with too many mods to be left as default

class DisableNormalOrHistoricalCheck < EU4GameModification
  def apply!
    # Hotfix 1.23 / 1.24
    patch_file!("missions/Coptic_Missions.txt") do |content|
      content.sub("yes'", "yes")
    end

    patch_files!("**/*.txt", reencode: true) do |content|
      next content unless content =~ /normal_or_historical_nations/
      content.gsub(/\bnormal_or_historical_nations\s+=\s+yes\b/, "")
    end
  end
end

require_relative "base"

class DisableNormalOrHistoricalCheck < EU4GameModification
  def apply!
    patch_files!("**/*.txt", reencode: true) do |content|
      next content unless content =~ /normal_or_historical_nations/                
      content.gsub("normal_or_historical_nations", "always")
    end
  end
end

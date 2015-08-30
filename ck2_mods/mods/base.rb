require_relative "../../lib/paradox_game_modification"

class CK2GameModification < ParadoxGameModification
  def cultures
    @cultures ||= begin
      culture_data = parse("common/cultures/00_cultures.txt")
      culture_data.keys +
      culture_data.values.map{|vs| vs.list.map{|k,v| k if v.is_a?(PropertyList)}.compact}.flatten
    end
  end

  def patch_localization!
    glob("localisation*/*.csv").each do |path|
      patch_file!(path, reencode: "iso-8859-1") do |content|
        content.split("\n").map do |line|
          yield(line)
        end.compact.map{|line| line+"\n"}.join
      end
    end
  end

  # read only version of patch_mod_files!
  def iterate_mod_files!(pattern)
    glob(pattern).each do |path|
      yield parse(path)
    end
  end
end

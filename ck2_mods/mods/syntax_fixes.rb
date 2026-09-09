require_relative "base"

class SyntaxFixesGameModification < CK2GameModification
  # Not really deletion
  def delete_file!(path)
    patch_file!(path) do |content|
      ""
    end
  end

  def patch_by_regexp!(path, rx, replacement)
    patch_file!(path, reencode: "iso-8859-1") do |content|
      content.gsub(rx, replacement)
    end
  end

  # Can't use parse_csv here, some rows have trailing comments with quotes in them
  # and Ruby's CSV refuses to parse that. It's just semicolons anyway.
  def province_names
    @province_names ||= begin
      data = resolve("map/definition.csv").open("r:windows-1252:utf-8").read
      rows = data.split("\n").map{|line| line.split(";")}
      Hash[rows.select{|row| row[0] =~ /\A\d+\z/}.map{|row| [row[0].to_i, row[4]]}]
    end
  end

  # Vanilla ships leftovers from old map layouts - when a province got renamed or
  # renumbered a history file under the new name was added and the old one was never
  # deleted. That leaves 21 province ids with two files, and 19 of the leftovers claim
  # counties that no longer exist in landed titles.
  # map/definition.csv is what the map itself goes by, so of the files sharing an id,
  # the ones whose name disagrees with it are the leftovers.
  def leftover_province_files
    by_id = glob("history/provinces/*.txt").group_by{|path| path.basename.to_s.to_i}
    by_id.flat_map do |id, paths|
      next [] if paths.size == 1
      leftovers = paths.reject{|path| path.basename(".txt").to_s.sub(/\A\d+\s*-\s*/, "") == province_names[id] }
      if leftovers.size == paths.size
        raise "None of the #{paths.size} history files for province #{id} matches its map/definition.csv name #{province_names[id].inspect}"
      end
      leftovers
    end
  end

  # Same story as the province files, except title history files are keyed by their
  # name rather than by anything inside them, so a leftover is simply one naming a
  # title landed titles no longer has.
  def leftover_title_files
    glob("history/titles/*.txt").reject{|path| landed_titles[path.basename(".txt").to_s] }
  end

  def apply!
    patch_by_regexp!("history/provinces/539 - Marmaros.txt", "895.1.1.", "895.1.1")
    patch_by_regexp!("history/titles/c_ragusa.txt", "936.1.1.", "936.1.1")
    patch_by_regexp!("history/titles/c_assab.txt", "936.1. ", "936.1.1 ")
    patch_by_regexp!("history/titles/c_galich_mersky.txt", "936.1. ", "936.1.1 ")
    patch_by_regexp!("history/titles/d_scholae_palatinae.txt", /\z/, "}")
    patch_by_regexp!("history/titles/d_varangian_guard.txt", /\z/, "}")

    (leftover_province_files + leftover_title_files).each do |path|
      delete_file!(path)
    end
  end
end

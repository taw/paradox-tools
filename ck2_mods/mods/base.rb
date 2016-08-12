require_relative "../../lib/paradox_game_modification"

class CK2GameModification < ParadoxGameModification
  def cultures
    @cultures ||= begin
      culture_data = parse("common/cultures/00_cultures.txt")
      culture_data.keys +
      culture_data.values.flat_map(&:to_a).select{|prop| prop.val.is_a?(PropertyList)}.map(&:key)
    end
  end

  def patch_localization!
    glob("localisation*/*.csv").each do |path|
      patch_file!(path, reencode: "iso-8859-1") do |content|
        content.split("\n").map do |line|
          if line.empty?
            line # z_alex.csv in CK2 2.5.1
          else
            yield(line)
          end
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

  def override_defines_lua!(name, overrides)
    create_file!(
      "common/defines/#{name}.lua",
      overrides.map{|key, val| "NDefines.#{key} = #{val}\n"}.join
    )
  end

  def code_warnings!
    base = Pathname(__dir__).parent
    files = $LOADED_FEATURES.select{|path| path.start_with?(base.to_s) }
    files.each do |path|
      next if path == __FILE__ # Otherwise it will add line below, and that would be silly
      Pathname(path).readlines.each_with_index do |line, i|
        next unless line =~ /TODO|FIXME/
        warn "#{Pathname(path).relative_path_from(base)}:#{i+1} #{line.strip}"
      end
    end
  end

  def religion_groups
    @religion_groups ||= glob("common/religions/*.txt").map do |path|
      parse(path).keys
    end.flatten
  end
end

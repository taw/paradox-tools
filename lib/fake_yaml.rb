require "pathname"
require "yaml"

class FakeYaml
  class << self
    # Mods are the worst, their files contain crazy number of errors
    # Game seems to be quite forgiving, but we need to clean that crap up

    def load(path)
      path = Pathname(path)
      data = path.read
      data = data.gsub(/\uFEFF/, "") # strip UTF8 BOM
      return if data !~ /\S/ # mod override
      # Cleanup spaces
      data = data
        .gsub(/\r/, "")
        .gsub(/\n+/, "\n")
        .gsub(/^\s*/, " ")
        .gsub(/[ \t]*$/, "")
        .gsub(/^ +/, " ")
        .sub(/\A\s*/, "")
        .sub(/\s*\z/, "\n")
        .gsub(/^\s+#.*\n/, "")

      data = data.gsub(/^ *\S+?:\K\d+ ?/){ " " } # strip version codes

      data = data.lines[0] + data.lines[1..-1].join.gsub(/"?\n/, "\"\n")
      data = data.gsub(/^ *\S+?:[ \t]"\K(.*)(?="$)/){ fix_quotes($1) }

      # Just commented out body
      return if data.lines.size == 1

      YAML.load(data)["l_english"].tap do |parsed|
        raise "No Engish localization data in `#{path}'" unless parsed
        raise "Not a Hash" unless parsed.is_a?(Hash)
      end
    rescue
      bad_line = (1...data.lines.size).bsearch{|x| !(YAML.load(data.lines[0,x].join) rescue false) }
      binding.pry
      warn "#{path}:#{bad_line}: #{$!}"
      {}
    end

    private

    def fix_quotes(str)
      str.gsub(/\\"|"/, '\"')
    end
  end
end

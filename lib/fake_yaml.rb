require "pathname"
require "yaml"

class FakeYaml
  class << self
    def load(path)
      path = Pathname(path)
      data = path.read
      data = data.gsub(/\uFEFF/, "") # strip UTF8 BOM
      data = data.gsub(/^ \S+?:\K\d(?=[ \t])/){ "" } # strip version codes
      data = data.gsub(/^ \S+?:[ \t]"\K(.*)(?="$)/){ fix_quotes($1) }
      YAML.load(data)["l_english"].tap do |parsed|
        raise "No Engish localization data in `#{path}'" unless parsed
      end
    rescue
      warn "#{path}: #{$!}"
      {}
    end

    private

    def fix_quotes(str)
      str.gsub(/\\"|"/, '\"')
    end
  end
end

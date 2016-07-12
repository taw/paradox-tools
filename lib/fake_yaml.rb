require "pathname"
require "yaml"

class FakeYaml
  def self.load(path)
    path = Pathname(path)
    data = path.read
    YAML.load(data.gsub(/\uFEFF/, "").gsub(/^ (\S+?):\d /){ " #{$1}: " })["l_english"].tap do |parsed|
      raise "No Engish localization data in `#{path}'" unless parsed
    end
  rescue
    warn "#{path}: #{$!}"
    {}
  end
end

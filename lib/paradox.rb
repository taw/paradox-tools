require "pp"
require "date"
require "pathname"
require_relative "property"
require_relative "property_list"
require_relative "paradox_game"
require_relative "paradox_mod_file"
require_relative "paradox_mod_builder"
require_relative "multi_range"

class Date
  # Default inspect is just really stupid
  def inspect
    "Date.new(#{year}, #{month}, #{day})"
  end

  def to_s_px
    "%d.%d.%d" % [year, month, day]
  end
  # Default is dumb anyway
  def to_s
    to_s_px
  end
end

class Pathname
  alias_method :to_str, :to_s
end

require "pp"
require "date"
require "pathname"
require_relative "paradox_game"
require_relative "paradox_mod_file"
require_relative "paradox_mod_builder"
require_relative "property_list"

class Date
  # Default inspect is just really stupid
  def inspect
    "Date.new(#{year}, #{month}, #{day})"
  end
end

class Pathname
  alias_method :to_str, :to_s
end

require "pathname"
require "json"
require_relative "country"
require_relative "database"
require_relative "division"
require_relative "equipment"
require_relative "technology"
require_relative "unit_type"
require_relative "unit"

module Enumerable
  def avg
    return if empty?
    sum.to_f / size
  end
end

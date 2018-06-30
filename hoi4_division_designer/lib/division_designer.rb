require "pathname"
require "json"
require "memoist"
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

class Hash
  def recursively_merge!(other, &block)
    other.each do |key, val|
      if self[key]
        if val.is_a?(Hash)
          raise "Incompatible merge" unless self[key].is_a?(Hash)
          self[key].recursively_merge!(val, &block)
        elsif val.is_a?(Numeric)
          raise "Incompatible merge" unless self[key].is_a?(Numeric)
          self[key] = block[self[key], val]
        else
          raise "Not sure how to merge #{val.class}"
        end
      else
        if val.is_a?(Hash)
          self[key] = {}
          self[key].recursively_merge!(val, &block)
        elsif val.is_a?(Numeric)
          self[key] = val
        else
          raise "Not sure how to merge #{val.class}"
        end
      end
    end
  end
end

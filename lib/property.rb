class Property
  attr_reader :key, :val
  def initialize(key, val)
    @key = key
    @val = val
  end

  def self.[](key, val)
    new(key, val)
  end

  def eql?(other)
    other.is_a?(Property) and key == other.key and val == other.val
  end

  def hash
    [self.class, key, val].hash
  end

  module OR
    def self.[](*args)
      Property["OR", PropertyList[*args]]
    end
  end

  module AND
    def self.[](*args)
      Property["AND", PropertyList[*args]]
    end
  end

  module NOT
    def self.[](*args)
      Property["NOT", PropertyList[*args]]
    end
  end

  def <=>(other)
    return nil unless other.is_a?(Property)
    [key, val] <=> [other.key, other.val]
  end
  include Comparable
end

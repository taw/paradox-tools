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

  def inspect_for_plist
    if val.is_a?(Property::SpecialValue)
      "#{key.inspect}, #{val.inspect_for_plist}"
    else
      "#{key.inspect}, #{val.inspect}"
    end
  end

  class SpecialValue
    attr_reader :val
    def initialize(val)
      @val = val
    end

    def inspect_for_plist
      "#{self.class}[#{val.inspect}]"
    end

    def self.[](arg)
      new(arg)
    end

    def ==(other)
      self.class == other.class and @val == other.val
    end

    def eql?(other)
      self.class == other.class and @val.eql?(other.val)
    end

    def hash
      [self.class, @val].hash
    end
  end

  class GT < SpecialValue
    def op
      ">"
    end
  end

  class LT < SpecialValue
    def op
      "<"
    end
  end
  class GE < SpecialValue
    def op
      ">="
    end
  end

  class LE < SpecialValue
    def op
      "<="
    end
  end

  class EQEQ < SpecialValue
    def op
      "=="
    end
  end
end

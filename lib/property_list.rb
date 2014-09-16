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
end

class PropertyList
  def initialize
    @list = []
  end

  def add!(key, val=nil)
    if key.is_a?(Property) and val == nil
      @list << [key.key, key.val]
    elsif val == nil or key.is_a?(Property) and val.is_a?(Property)
      raise ArgumentError, "Wrong use of #add! interface"
    else
      @list << [key, val]
    end
  end

  def [](key)
    @list.each{|k,v| return v if key == k}
    return nil
  end

  def []=(key, val)
    cnt = @list.count{|k,v| k == key}
    if cnt == 1
      @list.find{|k,v| k == key}[1] = val
    elsif cnt == 0
      @list << [key, val]
    else
      raise "Expected 0 or 1 property with value #{key}, found #{cnt}" unless cnt == 1
    end
  end

  def each(&blk)
    @list.each(&blk)
  end

  def each_value
    @list.each do |k,v|
      yield(v)
    end
  end

  # Unlike .to_h[key] it reliably return an array, not nil/x/[x,y]
  def find_all(key)
    rv = []
    @list.each{|k,v| rv << v if k == key}
    rv
  end

  # What should it return?
  def delete(key)
    @list = @list.select{|k,v| k != key}
    nil
  end

  def delete_if
    @list = @list.select{|k,v| !yield(k,v)}
    nil
  end

  def to_h
    rv = {}
    cast_to_array = {}
    @list.each do |k,v|
      if cast_to_array[k]
        rv[k] << v
      elsif rv.has_key?(k)
        cast_to_array[k] = true
        rv[k] = [rv[k], v]
      else
        rv[k] = v
      end
    end
    rv
  end

  def normalize
    new_list = @list.map do |k,v|
      v = v.normalize if v.is_a? PropertyList
      v = v.sort if v.is_a? Array
      [k, v]
    end
    new_list.sort_by!{|k,v| [k.class.to_s, k, v.class.to_s, v] }
    PropertyList[*new_list.flatten(1)]
  end

  def inspect
    case @list.size
    when 0
      "PropertyList[]"
    when 1
      k, v = @list[0]
      "PropertyList[#{k.inspect}, #{v.inspect}]"
    else
      "PropertyList[\n" + @list.map{|k,v| "#{k.inspect}, #{v.inspect},\n"}.join.gsub(/^/, "  ") + "]"
    end
  end

  alias_method :to_s, :inspect

  def to_json(*args)
    @list.to_json(*args)
  end

  def ==(other)
    return false unless other.is_a?(PropertyList)
    @list == other.instance_eval{ @list }
  end

  def eql?(other)
    return false unless other.is_a?(PropertyList)
    @list.eql?(other.instance_eval{ @list })
  end

  def hash
    [self.class, @list].hash
  end

  def self.[](*args)
    rv = PropertyList.new
    until args.empty?
      if args[0].is_a?(Property)
        rv.add! args.shift
      elsif args.size == 1
        raise "Even number of non-Property arguments expected"
      elsif args[1].is_a?(Property)
        raise "Property argument in unexpected location"
      else
        rv.add! args.shift, args.shift
      end
    end
    rv
  end

  def <=>(other)
    return nil unless other.is_a?(PropertyList)
    @list <=> other.instance_eval{ @list }
  end
  include Comparable
end

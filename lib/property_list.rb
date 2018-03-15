class PropertyList
  def initialize
    @entries = []
  end

  def size
    @entries.size
  end

  def empty?
    @entries.empty?
  end

  def each_property(&blk)
    @entries.each(&blk)
  end

  def each(&blk)
    @entries.each do |prop|
      yield prop.key, prop.val
    end
  end

  def each_value(&blk)
    @entries.each do |prop|
      yield prop.val
    end
  end

  def add!(key, val=nil)
    if key.is_a?(Property) and val == nil
      @entries << key
    elsif key == nil or val == nil or key.is_a?(Property) or val.is_a?(Property)
      raise ArgumentError, "Wrong use of #add! interface"
    else
      @entries << Property.new(key, val)
    end
  end

  def add_many!(*args)
    until args.empty?
      if args[0].is_a?(Property)
        add! args.shift
      elsif args.size == 1
        raise "Even number of non-Property arguments expected"
      elsif args[1].is_a?(Property)
        raise "Property argument in unexpected location"
      else
        add! args.shift, args.shift
      end
    end
  end

  def map!(&blk)
    @entries = @entries.map do |prop|
      prop = yield(prop)
      raise "#map block must return Property objects" unless prop.is_a?(Property)
      prop
    end
  end

  def uniq!
    @entries = @entries.uniq
  end

  def prepend!(key, val=nil)
    if key.is_a?(Property) and val == nil
      @entries.unshift key
    elsif val == nil or key.is_a?(Property) and val.is_a?(Property)
      raise ArgumentError, "Wrong use of #add! interface"
    else
      @entries.unshift Property[key, val]
    end
  end

  # What should it return?
  def delete!(key=nil, &block)
    if block_given?
      raise "Both key and block given" if key
      @entries =  @entries.reject(&block)
    else
      raise "Either key or block required" unless key
      if key.is_a?(Property)
        @entries = @entries.reject{|prop| prop == key}
      else
        @entries = @entries.reject{|prop| prop.key == key}
      end
    end
    nil
  end

  def self.[](*args)
    rv = PropertyList.new
    rv.add_many! *args
    rv
  end

  def []=(key, val)
    cnt = @entries.count{|prop| prop.key == key}
    if cnt == 1
      i = @entries.index{|prop| prop.key == key}
      @entries[i] = Property[key, val]
    elsif cnt == 0
      @entries << Property[key, val]
    else
      raise "Expected 0 or 1 property with value #{key}, found #{cnt}"
    end
  end

  def [](key)
    @entries.each{|prop| return prop.val if prop.key == key}
    nil
  end

  def ==(other)
    return false unless other.is_a?(PropertyList)
    @entries == other.send(:entries)
  end

  def eql?(other)
    return false unless other.is_a?(PropertyList)
    @entries.eql?(other.send(:entries))
  end

  def hash
    [self.class, @entries].hash
  end

  def keys
    @entries.map(&:key)
  end

  def values
    @entries.map(&:val)
  end

  def normalize
    new_entries = @entries.map do |prop|
      if prop.val.is_a?(PropertyList)
        Property[prop.key, prop.val.normalize]
      elsif prop.val.is_a?(Array)
        Property[prop.key, prop.val.sort]
      else
        prop
      end
    end
    new_entries.sort_by!{|prop| [prop.key.class.to_s, prop.key, prop.val.class.to_s, prop.val] }
    PropertyList[*new_entries]
  end

  def to_h
    rv = {}
    cast_to_array = {}
    each do |k,v|
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

  # Unlike .to_h[key] it reliably return an array, not nil/x/[x,y]
  def find_all(key)
    rv = []
    @entries.each do |prop|
      rv << prop.val if prop.key == key
    end
    rv
  end

  def inspect
    case @entries.size
    when 0
      "PropertyList[]"
    when 1
      prop = @entries[0]
      "PropertyList[#{prop.inspect_for_plist}]"
    else
      "PropertyList[\n#{
        @entries.map{|prop| "#{prop.inspect_for_plist},\n" }.join.gsub(/^/, "  ")
      }]"
    end
  end

  alias_method :to_s, :inspect

  def <=>(other)
    return nil unless other.is_a?(PropertyList)
    @entries <=> other.send(:entries)
  end
  include Comparable

  def to_a
    @entries.dup
  end

  def sort!
    @entries.sort!
  end

  def sort_by!(&blk)
    @entries.sort_by!(&blk)
  end

  def deep_copy
    Marshal.load(Marshal.dump(self))
  end

  def select!(&blk)
    @entries.select!(&blk)
    self
  end

  attr_reader :entries
  private :entries
end

class Hash
  def to_plist
    result = PropertyList[]
    each do |k,v|
      result.add! k, v
    end
    result
  end
end

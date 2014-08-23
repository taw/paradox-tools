class PropertyList
  def initialize
    @list = []
  end

  def add!(key, val)
    @list << [key, val]
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

  def self.[](*args)
    raise "Even number of arguments expected" unless args.size % 2 == 0
    rv = PropertyList.new
    until args.empty?
      rv.add! args.shift, args.shift
    end
    rv
  end
end

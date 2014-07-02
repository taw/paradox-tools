require "pp"
require "date"
require "pathname"

class Date
  # Default inspect is just really stupid
  def inspect
    "Date.new(#{year}, #{month}, #{day})"
  end
end

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

  def each(&blk)
    @list.each(&blk)
  end

  def inspect
    case @list.size
    when 0
      "PropertyList[]"
    when 1
      k, v = @list[0]
      "PropertyList[#{k.inspect}, #{v.inspect}]"
    else
      "PropertyList[\n" + @list.map{|k,v| "#{k.inspect}, #{v.inspect},\n"}.join + "]"
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

class ParadoxModFile
  attr_reader :path
  def initialize(path)
    @path = Pathname(path)
  end

  def valid?
    parse!
    true
  rescue
    false
  end

  def parse!
    @data = @path.open("r:windows-1252:utf-8").read
    tokenize!
    rv = parse_obj
    raise "Parse error - leftover tokens #{@tokens[0,30].inspect}..." unless @tokens.empty?
    rv
  end

  private

  def each_token
    data = @data.dup
    data.gsub!(/#.*\n/, "\n")
    until data.empty?
      if data.sub!(/\A\s+/, "")
        # next
      elsif data.sub!(/\A(\d+)\.(\d+)\.(\d+)\b/, "")
        date = Date.new($1.to_i, $2.to_i, $3.to_i)
        yield date
      elsif data.sub!(/\A(-?\d+\.\d+)(?!\S)/, "")
        yield $1.to_f
      elsif data.sub!(/\A(-?\d+)(?!\S)/, "")
        yield $1.to_i
      elsif data.sub!(/\A([=\{\}])/, "")
        yield({"{" => :open, "}" => :close, "=" => :eq}[$1])
      elsif data.sub!(/\A([a-zA-Z][a-zA-Z0-9_]*)/, "")
        if $1 == "yes"
          yield true
        elsif $1 == "no"
          yield false
        else
          yield $1
        end
      elsif data.sub!(/\A"([^"]*)"/, "")
        # Is there ever any weird escaping here?
        yield $1
      else
        raise "Tokenizer error in #{path}: #{data[0, 100]}..."
      end
    end
  end

  def parse_error!
    raise "Parse error in #{path}: #{@tokens.inspect}"
  end

  def tokenize!
    unless @tokens
      @tokens = []
      each_token{|tok| @tokens << tok}
    end
  end

  def parse_primitive
    case @tokens[0]
    when Integer, Float, String, Date, TrueClass, FalseClass
      @tokens.shift
    else
      parse_error!
    end
  end

  def parse_close
    parse_error! unless @tokens[0] == :close
    @tokens.shift
  end

  def parse_array
    rv = []
    while @tokens[0] != :close
      case @tokens[0]
      when Integer, Float, String, Date, TrueClass, FalseClass
        rv << @tokens.shift
      else
        parse_error!
      end
    end
    @tokens.shift
    rv
  end

  def parse_val
    if @tokens[0] == :open
      @tokens.shift
      if @tokens[1] == :eq
        parse_obj.tap{
          parse_close
        }
      else
        parse_array
      end
    else
      parse_primitive
    end
  end

  # Presumably every primitive can be a key
  def key_token_zero?
    case @tokens[0]
    when String, Integer, Date
      true
    else
      false
    end
  end

  def parse_attr
    if key_token_zero? and @tokens[1] == :eq
      key = @tokens.shift
      @tokens.shift
      val = parse_val
      [key, val]
    else
      nil
    end
  end

  def parse_obj
    rv = PropertyList.new
    while true
      a = parse_attr
      break unless a
      rv.add!(*a)
    end
    rv
  end
end

require "date"
require "pathname"
require_relative "property_list"

class ParadoxModFile
  attr_reader :path
  def initialize(string: nil, path: nil)
    if path
      @path = Pathname(path)
    elsif string
      @data = string
    else
      raise "You must pass eithier path: or string: argument"
    end
  end

  def valid?
    parse!
    true
  rescue
    false
  end

  def parse!
    if @path
      @data = @path.open("r:windows-1252:utf-8").read
    end
    tokenize!
    rv = parse_obj
    raise "Parse error - leftover tokens #{@tokens[0,30].inspect}..." unless @tokens.empty?
    rv
  end

  private

  def each_token
    data = @data.gsub("\r\n", "\n")
    until data.empty?
      if data.sub!(/\A(\p{Space})+/, "")
        # next
      elsif data.sub!(/\A#.*$/, "\n")
        next
      elsif data.sub!(/\A(\d+)\.(\d+)\.(\d+)\b/, "")
        date = Date.new($1.to_i, $2.to_i, $3.to_i)
        yield date
      elsif data.sub!(/\A(-?\d+\.\d+)(?![^}=\s])/, "")
        yield $1.to_f
      elsif data.sub!(/\A(-?\d+)(?![^}=\s])/, "")
        yield $1.to_i
      elsif data.sub!(/\A([=\{\}])/, "")
        yield({"{" => :open, "}" => :close, "=" => :eq}[$1])
      elsif data.sub!(/\A(
                          (?:_|\.|\-|'|’|\p{Letter}|\p{Digit})+
                         )/x, "")
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
        raise "Tokenizer error in #{path || 'passed string'}: #{data[0, 100].inspect}..."
      end
    end
  end

  def parse_error!
    raise "Parse error in #{path || 'passed string'}: #{@tokens.inspect}"
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

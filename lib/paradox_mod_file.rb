require "strscan"
require "date"
require "pathname"
require_relative "property"
require_relative "property_list"

class ParadoxModFile
  attr_reader :path
  def initialize(string: nil, path: nil)
    if string
      @data = string
      if path
        @path = Pathname(path) # Just for better exception message
      else
        @path = "<string>"
      end
    elsif path
      @path = Pathname(path)
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

  def load_data!
    return if @data
    raise "No path" unless @path
    @data = @path.open("rb").read
    if @data[0,4] == "PK\x03\x04"
      raise "Compressed save games are not supported yet"
    end
    if @data[0,3] ==  "\u{FEFF}".b
      # HOI4 files often have abomination which is UTF8 BOM
      @data = @data[3..-1].force_encoding("utf-8")
    else
      # Most older games are fairly inconsistent about encoding used
      @data = @data.force_encoding("windows-1252").encode("utf-8", undef: :replace)
    end
  end

  def parse!
    load_data!
    tokenize!
    rv = parse_obj
    raise "Parse error in #{path || 'passed string'} - leftover tokens #{@tokens[0,30].inspect}..." unless @tokens.empty?
    rv
  end

  private

  def parse_error!
    raise "Parse error in #{path || 'passed string'}: #{@tokens[0,50].inspect}..."
  end

  def tokenize!
    unless @tokens
      @tokens = []
      str = @data
        .gsub("\r\n", "\n")
        .sub(/\AEU4txt/, "")
        .sub(/\AHOI4txt/, "")
        .sub(/\ACK2txt(.*)\}\s*\z/m){$1} # CK2 saves have unbalanced {}s
        .sub(/\ACK2txt(.*)\}\s*(checksum.*\s*)\z/m){$1 + "\n" + $2} # even worse at some point they added checksum after the broken }
        .sub("map_area_data{", "map_area_data={") # EU4 1.23 save bugfix
      s = StringScanner.new(str)
      date_cache = {}
      # Dispatch on first byte for common cases, as trying every regexp in turn is slow
      # Small integer case/when compiles to a jump table, so it's faster than using ranges
      until s.eos?
        case BYTE_CLASS[s.peek_byte]
        when 1 # ASCII whitespace
          s.skip(ASCII_SPACE_RE)
        when 2 # {
          s.scan_byte
          @tokens << :open
        when 3 # }
          s.scan_byte
          @tokens << :close
        when 4 # =
          s.scan_byte
          if s.peek_byte == 61
            s.scan_byte
            @tokens << :eqeq
          else
            @tokens << :eq
          end
        when 5 # a-z A-Z _
          str = s.scan(IDENTIFIER_RE)
          if str == "yes"
            @tokens << true
          elsif str == "no"
            @tokens << false
          else
            @tokens << str
          end
        when 6 # 0-9 -
          # Same result as trying date, float, integer in order, as lookaheads exclude following "."
          if (str = s.scan(INTEGER_FAST_RE))
            @tokens << str.to_i
          elsif (str = s.scan(FLOAT_FAST_RE))
            @tokens << str.to_f
          elsif s.scan(DATE_RE)
            tokenize_date!(s, date_cache)
          else
            tokenize_slow!(s, date_cache)
          end
        when 7 # "
          if s.scan(QUOTED_STRING_RE)
            @tokens << s[1]
          else
            tokenize_slow!(s, date_cache)
          end
        else
          tokenize_slow!(s, date_cache)
        end
      end
    end
  end

  BYTE_CLASS = Array.new(256, 0).tap do |table|
    [32, 9, 10, 13].each{|b| table[b] = 1 }
    table[123] = 2
    table[125] = 3
    table[61] = 4
    [*97..122, *65..90, 95].each{|b| table[b] = 5 }
    [*48..57, 45].each{|b| table[b] = 6 }
    table[34] = 7
  end.freeze

  SPACE_RE = /(\p{Space})+|#.*$/
  QUOTED_STRING_RE = /"((?:[^"\\]|\\n)*)"/
  ASCII_SPACE_RE = /[ \t\r\n]+/
  DATE_RE = /(\d+)\.(\d+)\.(\d+)\b\.?/
  FLOAT_RE = /([\-\+]?\d+\.\d+)(?![^}=\s])/
  INTEGER_RE = /([\-\+]?\d+)(?![^}=\s])/
  FLOAT_FAST_RE = /[\-\+]?\d+\.\d+(?![^}=\s])/
  INTEGER_FAST_RE = /[\-\+]?\d+(?![^}=\s])/
  OPERATOR_RE = /(>=|<=|==|[=\{\}<>])/
  IDENTIFIER_RE = /([_.\-–'’\[\]:@?+$\/!\p{Letter}\p{Digit}\u{FFFD}]+)/
  OPERATORS = {
    "{" => :open,
    "}" => :close,
    "=" => :eq,
    ">" => :gt,
    "<" => :lt,
    "<=" => :le,
    ">=" => :ge,
    "==" => :eqeq,
  }.freeze

  def tokenize_identifier!(str)
    if str == "yes"
      @tokens << true
    elsif str == "no"
      @tokens << false
    else
      @tokens << str
    end
  end

  # That extra "." in some CK2 province history files
  # Date objects are immutable, so they can be shared
  def tokenize_date!(s, date_cache)
    date = date_cache[s.matched] ||= begin
      Date.new(s[1].to_i, s[2].to_i, s[3].to_i, Date::JULIAN)
    rescue ArgumentError
      nil
    end
    @tokens << (date || s.matched)
  end

  def tokenize_slow!(s, date_cache)
    if s.skip(SPACE_RE)
      # pass
    elsif s.scan(DATE_RE)
      tokenize_date!(s, date_cache)
    elsif s.scan(FLOAT_RE)
      @tokens << s[1].to_f
    elsif s.scan(INTEGER_RE)
      @tokens << s[1].to_i
    elsif s.scan(OPERATOR_RE)
      @tokens << OPERATORS[s[1]]
    elsif s.scan(/\[\[(\S+?)\]/)
      @tokens << :sqdef << s[1]
    elsif s.scan(IDENTIFIER_RE)
      tokenize_identifier!(s[1])
    elsif s.scan(QUOTED_STRING_RE)
      # Is there ever any weird escaping here?
      # EU4 saves have some "Italian Aristocracy: §G+25.0%§!\n"
      @tokens << s[1]
    elsif s.scan(/"(([^"\\]|\\"|\\\\)*)"/)
      # There is some escaping
      # \" seen in some modded HOI4 saves
      # \\ seen in windows paths in Steam-generated .mod files
      @tokens << s[1].gsub('\\"', '"')
    elsif s.scan(/,/)
      # Seen in some array definitions, pass
    else
      tok = s.scan(/\S+/)
      warn "Irregular token in #{path || 'passed string'} at #{s.pos}: `#{tok.inspect}...'"
      @tokens << tok
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
    parse_error! unless :close == @tokens[0]
    @tokens.shift
  end

  def parse_array
    rv = []
    until :close == @tokens[0]
      case @tokens[0]
      when Integer, Float, String, Date, TrueClass, FalseClass
        rv << @tokens.shift
      when :open
        # Happens in save games with attachments=
        rv << parse_val
      else
        parse_error!
      end
    end
    @tokens.shift
    # {} could be empty array or empty object, but code is simpler to assume object
    if rv == []
      PropertyList.new
    else
      rv
    end
  end

  def parse_val
    if :open == @tokens[0]
      @tokens.shift
      if :open == @tokens[0] and :close == @tokens[1]
        # Nonsense from CK2 saves
        # warn "{} found in wrong context"
        @tokens.shift
        @tokens.shift
      end

      if [:eq, :lt, :le, :gt, :ge, :eqeq].include?(@tokens[1]) or :sqdef == @tokens[0]
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
    when String, Integer, Float, Date, TrueClass, FalseClass
      true
    else
      false
    end
  end

  SPECIAL_OPERATORS = {
    gt: Property::GT,
    lt: Property::LT,
    le: Property::LE,
    ge: Property::GE,
    eqeq: Property::EQEQ,
  }.freeze

  def parse_attr
    # WTF is this? It happens in save files but it makes no sense. For now I'm skipping it, but that's probably invalid
    while :open == @tokens[0] and :close == @tokens[1]
      @tokens.shift
      @tokens.shift
    end

    op = @tokens[1]
    # Symbol on the left, as Date#== is slow
    if :eq == op and key_token_zero?
      key = @tokens.shift
      @tokens.shift
      val = parse_val
      [key, val]
    elsif op.is_a?(Symbol) and SPECIAL_OPERATORS.key?(op) and key_token_zero?
      key = @tokens.shift
      @tokens.shift
      val = parse_val
      [key, SPECIAL_OPERATORS[op][val]]
    elsif :eq == @tokens[0]
      # This is stupid thing found in ck2 saves
      key = ""
      @tokens.shift
      val = parse_val
      [key, val]
    elsif :sqdef == @tokens[0]
      @tokens.shift
      key = @tokens.shift
      val = PropertyList.new
      while true
        if "]" == @tokens[0]
          @tokens.shift
          break
        end
        a = parse_attr
        raise "Expected ]" unless a
        val.add!(*a)
      end
      [key, Property::SQDEF[val]]
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

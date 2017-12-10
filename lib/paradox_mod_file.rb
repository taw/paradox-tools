require "date"
require "pathname"
require_relative "property"
require_relative "property_list"

class ParadoxModFile
  attr_reader :path
  def initialize(string: nil, path: nil)
    if string
      @data = string
      @path = Pathname(path) # Just for better exception message
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
    raise "Parse error - leftover tokens #{@tokens[0,30].inspect}..." unless @tokens.empty?
    rv
  end

  private

  def parse_error!
    raise "Parse error in #{path || 'passed string'}: #{@tokens[0,50].inspect}..."
  end

  def tokenize!
    unless @tokens
      @tokens = []
      s = StringScanner.new(
        @data
          .gsub("\r\n", "\n")
          .sub(/\AEU4txt/, "")
          .sub(/\AHOI4txt/, "")
          .sub(/\ACK2txt(.*)\}\s*\z/m){$1} # CK2 saves have unbalanced {}s
          .sub("map_area_data{", "map_area_data={") # EU4 1.23 save bugfix
      )
      until s.eos?
        if s.scan(/(\p{Space})+|#.*$/)
          # pass
        elsif s.scan(/(\d+)\.(\d+)\.(\d+)\b/)
          begin
            @tokens << Date.new(s[1].to_i, s[2].to_i, s[3].to_i, Date::JULIAN)
          rescue ArgumentError
            @tokens << s[0]
          end
        elsif s.scan(/([\-\+]?\d+\.\d+)(?![^}=\s])/)
          @tokens << s[1].to_f
        elsif s.scan(/([\-\+]?\d+)(?![^}=\s])/)
          @tokens << s[1].to_i
        elsif s.scan(/(>=|<=|==|[=\{\}<>])/)
          @tokens << ({
            "{" => :open,
            "}" => :close,
            "=" => :eq,
            ">" => :gt,
            "<" => :lt,
            "<=" => :le,
            ">=" => :ge,
            "==" => :eqeq,
          }[s[1]])
        elsif s.scan(/((?:_|\.|\-|\–|'|’|\[|\]|:|@|\?|\p{Letter}|\p{Digit})+)/)
          if s[1] == "yes"
            @tokens << true
          elsif s[1] == "no"
            @tokens << false
          else
            @tokens << s[1]
          end
        elsif s.scan(/"([^"\\]*)"/)
          # Is there ever any weird escaping here?
          @tokens << s[1]
        elsif s.scan(/"(([^"\\]|\\"|\\\\)*)"/)
          # There is some escaping
          # \" seen in some modded HOI4 saves
          # \\ seen in windows paths in Steam-generated .mod files
          @tokens << s[1].gsub('\"', '"')
        elsif s.scan(/,/)
          # Seen in some array defintions, pass
        else
          require "pry"
          binding.pry
          raise "Tokenizer error in #{path || 'passed string'} at #{s.pos}: `#{s.rest[0,20]}...'"
        end
      end
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
    if @tokens[0] == :open
      @tokens.shift
      if @tokens[0] == :open and @tokens[1] == :close
        # Nonsense from CK2 saves
        # warn "{} found in wrong context"
        @tokens.shift
        @tokens.shift
      end

      if [:eq, :lt, :le, :gt, :ge, :eqeq].include?(@tokens[1])
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
    when String, Integer, Date, TrueClass, FalseClass
      true
    else
      false
    end
  end

  def parse_attr
    # WTF is this? It happens in save files but it makes no sense. For now I'm skipping it, but that's probably invalid
    while @tokens[0] == :open and @tokens[1] == :close
      @tokens.shift
      @tokens.shift
    end

    if key_token_zero? and @tokens[1] == :eq
      key = @tokens.shift
      @tokens.shift
      val = parse_val
      [key, val]
    elsif key_token_zero? and @tokens[1] == :gt
      key = @tokens.shift
      @tokens.shift
      val = parse_val
      [key, Property::GT[val]]
    elsif key_token_zero? and @tokens[1] == :lt
      key = @tokens.shift
      @tokens.shift
      val = parse_val
      [key, Property::LT[val]]
    elsif key_token_zero? and @tokens[1] == :le
      key = @tokens.shift
      @tokens.shift
      val = parse_val
      [key, Property::LE[val]]
    elsif key_token_zero? and @tokens[1] == :ge
      key = @tokens.shift
      @tokens.shift
      val = parse_val
      [key, Property::GE[val]]
    elsif key_token_zero? and @tokens[1] == :eqeq
      key = @tokens.shift
      @tokens.shift
      val = parse_val
      [key, Property::EQEQ[val]]
    elsif @tokens[0] == :eq
      # This is stupid thing found in ck2 saves
      key = ""
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

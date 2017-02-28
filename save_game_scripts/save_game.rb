require "strscan"

class Node
  include Enumerable
  attr_reader :key, :content
  def initialize(key, content)
    @key = key
    @content = content
  end
  def [](key)
    return nil unless @content.is_a?(Array)
    @content.each do |n|
      return n if n.is_a?(Node) and n.key == key
    end
    nil
  end
  def inspect
    "Node(#{key}: #{content.inspect})"
  end
  def each(&blk)
    content.each(&blk) if content.is_a?(Array)
    self
  end
  def to_s
    "Node(#{key})"
  end
end

class SaveGame
  def initialize(path)
    @path = path
    @data = File.read(path).encode("UTF-8", "ISO-8859-1")
    start_tokenizer!
  end

  def start_tokenizer!
    @tokenizer = to_enum(:each_token)
    @tokenbuf = []
  end

  def each_token
    s = StringScanner.new(@data)
    raise "Not a save game" unless s.scan(/EU4txt|CK2txt/)
    until s.eos?
      next if s.scan(/\s+/)
      if s.scan(/"(.*?)"/)
        yield([:value, s[1]])
      elsif s.scan(/(\d+)\.(\d+)\.(\d+)/)
        yield([:value, [:date, s[1], s[2], s[3]]])
      elsif s.scan(/(-?\d+\.\d+)/)
        yield([:value, s[0].to_f])
      elsif s.scan(/\b(yes|no)\b/)
        yield([:value, s[0] == "yes"])
      elsif s.scan(/(-?\d+)/)
        yield([:value, s[0].to_i])
      elsif s.scan(/[a-zA-Z_\-][a-zA-Z_.0-9\-]*/)
        yield([:value, s[0].to_sym])
      elsif s.scan(/\{/)
        yield([:start])
      elsif s.scan(/\}/)
        yield([:end])
      elsif s.scan(/\=/)
        yield([:eq])
      else
        raise "Parse error at position #{s.pos}}"
      end
    end
  end

  def fetch_next_token
    @tokenizer.next
  rescue StopIteration
    nil
  end

  def token(i)
    return @tokenbuf[i] if @tokenbuf[i]
    @tokenbuf << fetch_next_token while i >= @tokenbuf.size
    @tokenbuf[i]
  end

  def token_type(i)
    (token(i) || [])[0]
  end

  def shift(n=1)
    n.times{ @tokenbuf.shift }
  end

  def eof?
    !token(0)
  end

  def parse_error!
    raise "Parse error: #{token(0).inspect} #{token(1).inspect} #{token(2).inspect}..."
  end

  def parse_value
    if token_type(0) == :value and token_type(1) == :eq
      key = token(0)[1]
      shift(2)
      val = parse_value
      Node.new(key, val)
    elsif token_type(0) == :value
      val = token(0)[1]
      shift
      val
    elsif token_type(0) == :start
      shift
      val = []
      while !eof? and token_type(0) != :end
        val << parse_value
      end
      shift
      val
    else
      parse_error!
    end
  end

  def parse
    until eof?
      yield parse_value
    end
  end

  def [](key)
    parse do |n|
      return n if n.key == key
    end
    nil
  end
end

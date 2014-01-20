require "strscan"

class SaveGame
  def initialize(path)
    @path = path
    @data = File.read(path).encode("UTF-8", "ISO-8859-1")
  end

  def each_token
    s = StringScanner.new(@data)
    raise "Not a save game" unless s.scan(/EU4txt/)
    until s.eos?
      next if s.scan(/\s+/)
      if s.scan(/"(.*?)"/)
        yield(:string, s[1])
      elsif s.scan(/(\d+\.\d+\.\d+)/)
        yield(:date, s[0])
      elsif s.scan(/(-?\d+\.\d+)/)
        yield(:float, s[0])
      elsif s.scan(/(-?\d+)/)
        yield(:int, s[0])
      elsif s.scan(/[a-zA-Z_\-][a-zA-Z_.0-9\-]*/)
        yield(:symbol, s[0])
      elsif s.scan(/\{/)
        yield(:start)
      elsif s.scan(/\}/)
        yield(:end)
      elsif s.scan(/=/)
        yield(:eq)
      else
        raise "Parse error at position #{s.pos}}"
      end
    end
  end
end

class MultiRange
  def initialize(*args)
    points = []
    args.each do |arg|
      parse_arg(arg) do |s,e|
        raise ArgumentError, "MultiRange start #{s} > #{e}" if s and e and s > e
        next if s == e # Just fast skip, would get filtered later anyway
        points << [s ? 0 : -1, s,  1]
        points << [e ? 0 :  1, e, -1]
      end
    end
    yield(points) if block_given?
    build!(points)
  end
  def |(other)
    MultiRange.new(self, other)
  end
  def +(other)
    MultiRange.new(self, other)
  end
  def &(other)
    other = other.to_multi_range
    MultiRange.new do |points|
      points << [-1, nil, -1]
      points << [ 1, nil,  1]
      to_list.each do |s,e|
        points << [s ? 0 : -1, s,  1]
        points << [e ? 0 :  1, e, -1]
      end
      other.to_list.each do |s,e|
        points << [s ? 0 : -1, s,  1]
        points << [e ? 0 :  1, e, -1]
      end
    end
  end
  def -(other)
    other = other.to_multi_range
    MultiRange.new do |points|
      to_list.each do |s,e|
        points << [s ? 0 : -1, s,  1]
        points << [e ? 0 :  1, e, -1]
      end
      other.to_list.each do |s,e|
        points << [s ? 0 : -1, s, -1]
        points << [e ? 0 :  1, e,  1]
      end
    end
  end

  # This only works for finite values
  def to_ranges
    @points.each_slice(2).map{|a,b| a..b}
  end

  def to_list
    @points.each_slice(2).to_a
  end

  def to_multi_range
    self
  end

  def ==(other)
    other = other.to_multi_range
    to_list == other.to_list
  end

  def empty?
    @points.empty?
  end

  def to_s
    to_list.map{|a,b| "#{a}..#{b}"}.join(" ")
  end

  def inspect
    "MultiRange.new(#{ to_list.map{|a,b| "#{a}..#{b}"}.join(", ") })"
  end

private
  def build!(points)
    cuts  = []
    cover = 0
    point_totals = Hash.new(0)
    points.each do |c, v, diff|
      point_totals[[c,v]] += diff
    end
    point_totals.sort.each do |(c,v), diff|
      next if diff == 0
      cuts << [c,v] if diff > 0 and cover <= 0 and cover + diff >  0
      cuts << [c,v] if diff < 0 and cover >  0 and cover + diff <= 0
      cover += diff
    end
    @points = cuts.map{|(_,v)| v}
  end

  def parse_arg(arg)
    case arg
    when Range
      if arg.exclude_end?
        yield(arg.begin, arg.to_a.last)
      else
        yield(arg.begin, arg.end)
      end
    when MultiRange
      arg.to_list.each do |s,e|
        yield(s,e)
      end
    when Array
      raise ArgumentError unless arg.size == 2
      yield(*arg)
    else
      raise ArgumentError
    end
  end
end

class Range
  def to_multi_range
    MultiRange.new(self)
  end
end

# We assume there's no crossing x=0 line
class BlobMidpoint
  def initialize
    @x_total = 0.0
    @y_total = 0.0
    @samples = 0
  end

  def add(x,y)
    @x_total += x
    @y_total += y
    @samples += 1
  end

  def x
    return if @samples == 0
    (@x_total / @samples).round
  end

  def y
    return if @samples == 0
    (@y_total / @samples).round
  end

  def to_s
    "<#{x},#{y}>"
  end

  def inspect
    to_s
  end
end

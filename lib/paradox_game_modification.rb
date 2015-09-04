require_relative "paradox"

class ParadoxGameModification
  def initialize(builder)
    @builder = builder
  end
  def apply!
    raise "SubclassResponsibility"
  end
  def method_missing(*args, &blk)
    @builder.send(*args, &blk)
  end
end

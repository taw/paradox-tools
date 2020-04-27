require_relative "paradox"

class ParadoxGameModification
  def initialize(builder)
    @builder = builder
  end
  def apply!
    raise "SubclassResponsibility"
  end
  def method_missing(*args, **kwargs, &blk)
    @builder.send(*args, **kwargs, &blk)
  end
end

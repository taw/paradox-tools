class FocusTreeBuilder
  def initialize(name, tag, &block)
    @name = name
    @tag = tag
    @focuses = []
    instance_eval(&block)
  end

  def focus(*args, &block)
    @focuses << FocusBuilder.new(@tag, *args, &block).build
  end

  def build
    FocusTree.new(@name, @tag, @focuses)
  end
end

def focus_tree(name, tag, &block)
  FocusTree[name] = FocusTreeBuilder.new(name, tag, &block).build
end

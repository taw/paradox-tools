class FocusTreeBuilder
  def initialize(name, tag, &block)
    @name = name
    @tag = tag
    @focuses = []
    instance_eval(&block)
  end

  def focus(name, &block)
    @focuses << FocusBuilder.new(@tag, name, &block).build
  end

  def build
    FocusTree.new(@name, @tag, @focuses)
  end
end

def focus_tree(name, tag, &block)
  FocusTree[name] = FocusTreeBuilder.new(name, tag, &block).build
end

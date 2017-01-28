class Title
  attr_reader :id, :node, :liege, :holder, :vassals

  def initialize(id, node)
    @id = id
    @node = node
    @vassals = []
  end

  def to_s
    @node["name"] || @id
  end

  def inspect
    "Title<#{to_s}>"
  end

  def link!
    if @node["liege"]
      liege_title = @node["liege"]["title"]
      @liege = Title[liege_title]
    end
    @liege.vassals << self if @liege
    @holder = Character[@node["holder"]]
    @holder.titles << self if @holder
  end

  class << self
    def each(&block)
      @db.each(&block)
    end

    def [](id)
      @db[id]
    end

    def add(id, node)
      @db ||= {}
      @db[id] = Title.new(id, node)
    end
  end
end

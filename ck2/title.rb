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

  def tier
    unless @tier
      t = %W[b c d k e].index(@id[0])
      if t
        @tier = t + 1
      else
        raise "Wrong title tier #{@id}"
      end
    end
    @tier
  end

  def link!
    if @node["liege"]
      if @node["liege"].is_a?(String)
        liege_title = @node["liege"]
      else
        liege_title = @node["liege"]["title"]
      end
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

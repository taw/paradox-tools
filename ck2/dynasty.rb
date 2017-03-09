class Dynasty
  attr_reader :node, :name, :culture, :religion
  def initialize(node)
    @node = node
    @name = node["name"]
    @culture = node["culture"]
    @religion = node["religion"]
  end

  def to_s
    "#{name}"
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
      @db[id] = Dynasty.new(node)
    end
  end
end

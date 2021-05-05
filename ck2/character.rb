class Character
  attr_reader :id, :node, :father, :mother, :dynasty, :spouses
  attr_reader :children, :titles
  def initialize(id, node)
    @id = id
    @node = node
    @children = []
    @titles = []
  end

  def link!
    @father = Character[@node["fat"]]
    @mother = Character[@node["mot"]]
    @father.children << self if @father
    @mother.children << self if @mother
    @dynasty = Dynasty[@node["dnt"]]
    @spouses = @node.find_all("spouse").map{|i| Character[i]}
  end

  def full_name
    [name, dynasty].compact.join(" ")
  end

  def to_s
    full_name
  end

  def inspect
    "Character<#{id}, #{to_s}>"
  end

  def culture
    @node["cul"] || dynasty&.culture
  end

  def religion
    @node["rel"] || dynasty&.religion
  end

  def name
    @node["bn"]
  end

  def dynasty_name
    @dynasty.name
  end

  def trait_ids
    @node["traits"] || []
  end

  def dead?
    !!@node["d_d"]
  end

  def alive?
    !@node["d_d"]
  end

  def vassals
    titles.flat_map(&:vassals).map(&:holder).uniq - [self]
  end

  def tier
    @tier ||= (titles.map(&:tier).max || 0)
  end

  def top_tier_titles
    @titles.select{|t| t.tier == tier}
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
      @db[id] = Character.new(id, node)
    end
  end
end

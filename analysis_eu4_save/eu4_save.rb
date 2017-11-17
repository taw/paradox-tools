class Country
  def initialize(tag, node)
    @tag = tag
    @node = node
  end

  def primary_culture
    @node["primary_culture"]
  end

  def accepted_cultures
    @node.find_all("accepted_culture")
  end

  def government_rank
    @node["government_rank"]
  end

  def to_s
    "Country<#{@tag}>"
  end
  alias_method :to_s, :inspect
end

class Province
  def initialize(id, node)
    @id = id
    @node = node
  end

  def city?
    @node["is_city"]
  end

  def development
    (@node["base_tax"] || 0) +
    (@node["base_production"] || 0) +
    (@node["base_manpower"] || 0)
  end

  def owner
    @node["owner"]
  end

  def culture
    @node["culture"]
  end

  def to_s
    "Province<#{@id}>"
  end
  alias_method :to_s, :inspect
end

class EU4Save
  attr_reader :path
  def initialize(path)
    @path = path
    @data = ParadoxModFile.new(path: @path).parse!
  end

  def countries
    @countries ||= begin
      @data["countries"]
        .enum_for(:each)
        .map{|tag, node| [tag, Country.new(tag, node)] }
        .to_h
    end
  end

  def provinces
    @provinces ||= begin
      @data["provinces"]
        .enum_for(:each)
        .map{|id, node| [-id, Province.new(-id, node)] }
        .to_h
    end
  end

  def to_s
    "EU4Save<#{@path}>"
  end
  alias_method :to_s, :inspect
end

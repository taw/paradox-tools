class Equipment < OpenStruct
  def initialize(key, stats)
    super(stats.merge("key" => key))
  end

  def inspect
    "Equipment<#{key}>"
  end
end

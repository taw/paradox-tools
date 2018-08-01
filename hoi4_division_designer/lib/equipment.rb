class Equipment < OpenStruct
  def initialize(database, key, stats)
    @database = database
    super(stats.merge("key" => key))
  end

  def inspect
    "Equipment<#{key}>"
  end

  def available_upgrades
    return unless upgrades
    @database.upgrades.select{|k,v| upgrades.include?(k)}
  end
end

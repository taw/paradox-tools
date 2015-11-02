class Character
  attr_reader :id, :historical_id, :name, :female, :birth, :death, :health,
              :father, :mother, :dynasty, :events, :culture,
              :religion, :culture, :traits, :events

  def initialize(**args)
    args.each do |k,v|
      send(:"#{k}=", v)
    end
    @traits = (@traits || []).to_set
    @events ||= []
    add_automatic_traits!
  end

  def to_plist
    result = PropertyList.new
    result.add! "name", @name
    result.add! "religion", @religion
    result.add! "culture", @culture
    result.add! "dynasty", @dynasty if @dynasty
    result.add! "father", @father.id if @father
    result.add! "mother", @mother.id if @mother
    result.add! "female", true if @female
    @traits.each do |trait|
      result.add! "trait", trait
    end
    result.add! "health", @health if @health
    result.add! @birth, PropertyList["birth", true]
    @events.each do |date, event|
      result.add! date, event
    end
    result.add! @death, PropertyList["death", true] if @death
    result
  end

  private

  attr_writer :id, :historical_id, :name, :female, :birth, :death, :health,
              :father, :mother, :dynasty, :events, :culture, :traits, :events

  # This is more just a test than any well thought out system
  # This would be more fun with political traits like Communist etc.
  def add_automatic_traits!
    rng = Random.keyed("character-traits-#{@id}")
    case religion
    when *%W[hindu buddhist jain]
      # 80% right caste
      # 10% for each wrong caste
      traits << (["brahmin", "vaishya"][rng.rand(10)] || "kshatriya")
    when "jewish"
      traits << "greedy" if rng.rand < 0.33
    end
    case culture
    when "russian"
      traits << "drunkard" if rng.rand < 0.33
    when "finnish"
      traits << "winter_soldier" if rng.rand < 0.10
    when "polish"
      traits << "brave" if rng.rand < 0.20
    when "italian"
      traits << "gregarious" if rng.rand < 0.20
    when "frankish"
      traits << "lustful" if rng.rand < 0.20
    when "german"
      traits << "diligent" if rng.rand < 0.20
    when "bohemian"
      traits << "content" if rng.rand < 0.20
    when "greek"
      traits << "proud" if rng.rand < 0.20
    when "bedouin_arabic"
      traits << "zealous" if rng.rand < 0.33
    when "turkish"
      traits << "wroth" if rng.rand < 0.20
    when "swedish"
      traits << "fair" if rng.rand < 0.20
    end
  end

  def parent=(parent)
    if parent.female
      self.mother = parent
    else
      self.father = parent
    end
  end

  def culture=(culture)
    @culture = culture.to_s
  end

  def religion=(religion)
    @religion = religion.to_s
  end
end

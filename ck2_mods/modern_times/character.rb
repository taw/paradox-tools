class Character
  attr_accessor :id, :historical_id, :name, :female, :birth, :death, :health,
                :father, :mother, :dynasty, :events, :culture
  attr_reader :religion, :culture, :traits, :events

  def initialize(**args)
    @traits = []
    @events = []
    args.each do |k,v|
      send(:"#{k}=", v)
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
    if %W[hindu buddhist jain].include?(religion)
      @traits << "kshatriya"
    end
  end

  # This interface is pretty dreadful
  def traits=(extra_traits)
    @traits += extra_traits if extra_traits
  end

  def events=(extra_events)
    @events += extra_events if extra_events
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
end

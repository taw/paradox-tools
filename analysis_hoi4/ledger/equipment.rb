class Equipment
  attr_reader :name, :archetype
  def initialize(name, archetype)
    @name = name
    @archetype = archetype
  end

  def inspect
    "Equipment<#{@name} : #{@archetype.name}>"
  end
end

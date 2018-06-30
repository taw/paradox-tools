class Technology
  attr_reader :name
  def initialize(name, effects)
    @name = name
    @effects = effects
  end

  def enable_subunits
    @effects["enable_subunits"] || []
  end
end

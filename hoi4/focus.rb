class Focus
  attr_reader :id, :name
  def initialize(name, id, x:, y:, reward:, prerequisites:, icon:, mutually_exclusive:, available:, bypass:, ai:)
    @name = name
    @id = id
    @x = x
    @y = y
    @available = available
    @reward = reward
    @prerequisites = prerequisites
    @icon = icon
    @mutually_exclusive = mutually_exclusive
    @ai = ai
  end

  def to_plist
    PropertyList[
      "id", @id,
      "icon", @icon,
      *(@available ? Property["available", @available] : nil),
      *@prerequisites.map{|req| Property["prerequisite", req]},
      *@mutually_exclusive.map{|f| Property["mutually_exclusive", PropertyList["focus", f]]},
      *(@bypass ? Property["bypass", @bypass] : nil),
      "x", @x,
      "y", @y,
      "cost", 10,
      *(@ai ? Property["ai_will_do", @ai] : nil),
      "completion_reward", @reward,
    ]
  end
end

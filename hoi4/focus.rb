class Focus
  attr_reader :id, :name
  def initialize(name, id, x:, y:, reward:, prerequisites:, icon:, mutually_exclusive:)
    @name = name
    @id = id
    @x = x
    @y = y
    @reward = reward
    @prerequisites = prerequisites
    @icon = icon
    @mutually_exclusive = mutually_exclusive
  end

  def to_plist
    PropertyList[
      "id", @id,
      "icon", @icon,
      *@prerequisites.map{|req| Property["prerequisite", req]},
      *@mutually_exclusive.map{|f| Property["mutually_exclusive", PropertyList["focus", f]]},
      "x", @x,
      "y", @y,
      "cost", 10,
      "completion_reward", @reward,
    ]
  end
end

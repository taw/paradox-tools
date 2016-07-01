class Focus
  attr_reader :id, :name
  def initialize(name, id, x, y, reward, prerequisites, icon)
    @name = name
    @id = id
    @x = x
    @y = y
    @reward = reward
    @prerequisites = prerequisites
    @icon = icon
  end

  def to_plist
    PropertyList[
      "id", @id,
      "icon", @icon,
      *@prerequisites.map{|req| Property["prerequisite", req]},
      "x", @x,
      "y", @y,
      "cost", 10,
      "completion_reward", @reward,
    ]
  end
end

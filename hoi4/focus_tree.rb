class FocusTree
  attr_reader :focuses
  def initialize(name, tag, focuses)
    @name = name
    @tag = tag
    @focuses = focuses
  end

  def self.[](name)
    @repo ||= {}
    @repo[name]
  end

  def self.[]=(name, val)
    @repo ||= {}
    @repo[name] = val
  end

  def focus_tree_id
    @name.downcase.gsub(" ", "_") + "_focus"
  end

  def to_plist
    PropertyList["focus_tree", PropertyList[
        "id", focus_tree_id,
        "country", PropertyList[
      		"factor", 0,
          "modifier", PropertyList[
            "add", 10,
            "tag", @tag,
          ],
      	],
        "default", false,
      	# "reset_on_civilwar", false, ?
        *@focuses.map{|focus| Property["focus", focus.to_plist]},
      ]
    ]
  end
end

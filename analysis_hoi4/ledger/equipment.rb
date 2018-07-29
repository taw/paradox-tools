class Equipment
  attr_reader :name, :archetype, :cost, :category
  def initialize(name, archetype, node, archetype_node)
    @name = name
    @archetype = archetype
    @cost = node["build_cost_ic"] || archetype_node["build_cost_ic"]
    interface_category = node["interface_category"] || archetype_node["interface_category"]
    case interface_category
    when /_ships\z/
      @category = "navy"
    when "interface_category_air"
      @category = "planes"
    when "interface_category_armor"
      @category = "tanks"
    when "interface_category_land"
      case archetype.name
      when /\A(anti_air|anti_tank|artillery|rocket_artillery|motorized_rocket)_equipment\z/
        @category = "artillery"
      when /\A(infantry|mechanized|motorized|support)_equipment\z/
        @category = "army"
      end
    end
    @category = "tanks" if name == "gw_tank_equipment" # fake category we made up
    unless @category
      warn "Unknown equipment category for #{name}"
      @category = archetype.name
    end
  end

  def inspect
    "Equipment<#{@name} : #{@archetype.name}>"
  end
end

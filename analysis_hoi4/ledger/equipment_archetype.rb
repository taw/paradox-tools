class EquipmentArchetype
  attr_reader :name
  def initialize(name)
    @name = name
    @equipment = {}
    @lookup = {}
  end

  def add!(equipment, subgroup)
    @equipment[subgroup] ||= []
    @equipment[subgroup] << equipment
    @lookup[equipment] = [subgroup, @equipment[subgroup].size-1]
  end

  def default_level
    @equipment[nil][0]
  end

  def default_only?
    @lookup.values == [[nil, 0]]
  end

  def inspect
    "EquipmentArchetype<#{@name}>"
  end

  def format_equipment_details(details)
    total = adjust_precision(details.values.inject(0, &:+))
    result = "#{total}"
    unless default_only?
      subgroups = {}
      details.each do |equipment, amount|
        subgroup, level = @lookup[equipment]
        subgroups[subgroup] ||= []
        raise if subgroups[subgroup][level]
        subgroups[subgroup][level] = adjust_precision(amount)
      end
      # Fill with zeroes if only new equipment present
      subgroups.sort_by{|k,_| k||""}.each do |subgroup, counts|
        subtotals = counts.map{|c| c || 0}.join(" ")
        if subgroup
          result << " #{subgroup}:[#{subtotals}]"
        else
          result << " [#{subtotals}]"
        end
      end
    end
    result
  end

  private

  def adjust_precision(x)
    x = x.round(3)
    return x.to_i if x == x.to_i
    x
  end
end

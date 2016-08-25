class InformationTables
  def summarize_equipment_table
    Hash[
      @equipment.map do |archetype, details|
        [@ledger.localization(archetype.name), archetype.format_equipment_details(details)]
      end.sort
    ]
  end

  def equipment_categories
    result = {}
    @equipment.each do |archetype, details|
      details.each  do |equipment, amount|
        result[equipment.category] ||= [0, 0]
        result[equipment.category][0] += amount
        result[equipment.category][1] += amount * equipment.cost
      end
    end
    Hash[result.map{|k,(a,c)|
      a = a.round
      c = c.round
      [k, "#{a} [#{c} ic]"]
    }.sort]
  end
end

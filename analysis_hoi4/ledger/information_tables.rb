class InformationTables
  def summarize_equipment_table
    Hash[
      @equipment.map do |archetype, details|
        [@ledger.localization(archetype.name), archetype.format_equipment_details(details)]
      end.sort
    ]
  end
end

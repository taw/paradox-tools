class EquipmentData
  extend Memoist

  def initialize(game)
    @game = game
  end

  def each_equipment
    @game.glob("common/units/equipment/*.txt").each do |path|
      @game.parse(path)["equipments"].each do |name, equipment|
        yield(name, jsonify(equipment).merge("name" => name_for(name)))
      end
    end
  end

  def name_for(key)
    @game.localization(key)
      .gsub("Main Battle Tank", "MBT")
  end

  memoize def raw_data
    enum_for(:each_equipment).to_a
  end

  memoize def archetype_names
    data.map{|name, eq| eq["archetype"]}.uniq
  end

  memoize def equipment_names
    raw_data.map(&:first)
  end

  memoize def data
    valid_keys = %W[
      soft_attack hard_attack air_attack
      defense breakthrough ap_attack armor_value
      build_cost_ic maximum_speed archetype hardness
      resources reliability type
      name archetype
    ]
    # Mostly visual stuff
    ignore_keys = %W[
      visual_level picture priority lend_lease_cost interface_category
      can_convert_from sprite group_by
    ]
    result = {}
    archetypes = {}
    raw_data.each do |name, equipment|
      equipment = equipment.to_h
      if equipment["is_archetype"]
        equipment.delete("is_archetype")
        raise "Archetype is buildable" if equipment.delete("is_buildable")
        archetypes[name] = equipment
      elsif equipment["active"] or @game.technology.enabled_equipments.include?(name)
        if equipment["archetype"]
          archetype = archetypes[equipment["archetype"]] or raise
          equipment = archetype.merge(equipment)
        end
        # Guided missiles - not buildable, but pass them through anyway
        # next if equipment["is_buildable"] == false
        result[name] = equipment
        ignore_keys.each do |key|
          equipment.delete(key)
        end
        # There's still a lot of keys we copy without using
        # Mostly air/naval stuff
      else
        # warn "Equipment #{name} is #{@game.mod} is never enabled"
      end
    end
    result
  end
end

class UpgradeData
  extend Memoist

  def initialize(game)
    @game = game
  end

  def each_upgrade
    @game.glob("common/units/equipment/upgrades/*.txt").each do |path|
      data = @game.parse(path)
      next unless data["upgrades"]
      data["upgrades"].each do |key, upgrade|
        yield key, jsonify(upgrade).merge("name" => @game.localization(key))
      end
    end
  end

  memoize def data
    result = {}
    each_upgrade do |key, upgrade|
      result[key] = upgrade
    end
    result
  end
end

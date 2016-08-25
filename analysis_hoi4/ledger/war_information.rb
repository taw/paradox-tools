class WarInformation
  def initialize(ledger, war)
    @ledger = ledger
    @name = war["name"]
    @attackers = war["attackers"]
    @defenders = war["defenders"]
    @attacker_casualties = 0
    @defender_casualties = 0
    war["casualties"].each do |tag, count|
      if @attackers.include?(tag)
        @attacker_casualties += count
      elsif @defenders.include?(tag)
        @defender_casualties += count
      else
        binding.pry
      end
    end
  end

  def to_json
    {
      name: @name,
      attackers: @attackers,
      defenders: @defenders,
      attacker_casualties: @attacker_casualties,
      defender_casualties: @defender_casualties,
    }
  end
end

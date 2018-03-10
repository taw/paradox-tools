class WarInformation
  attr_reader :name

  def initialize(ledger, war)
    @ledger = ledger
    @attackers = war["attackers"]
    @defenders = war["defenders"]
    @attacker_casualties = 0
    @defender_casualties = 0
    # Removed in 1.5.0, use ID so at least file names differ
    @name = war["name"] || war["id"]["id"]
  # Removed in 1.5.0, might be possible to infer from other sources?
    casualties = war["casualties"] || []
    casualties.each do |tag, count|
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

class Random
  def sample(ary)
    ary[rand(ary.size)]
  end
end

class CultureManager
  def initialize(builder)
    @builder = builder
    @male_names = {}
    @female_names = {}
    @dynasties = {}

    @builder.parse("common/cultures/00_cultures.txt").each do |group_name, group|
      group.each do |name, culture|
        next unless culture.is_a?(PropertyList)
        @male_names[name]   = culture["male_names"].map{|n| n.sub(/_.*/, "")}
        @female_names[name] = culture["female_names"].map{|n| n.sub(/_.*/, "")}
        @dynasties[name]    = []
      end
    end
    @builder.parse("common/dynasties/00_dynasties.txt").each do |id, dynasty|
      culture = dynasty["culture"] or next
      @dynasties[culture] << id
    end
  end

  def random_name(culture, female, rng)
    rng.sample(name_pool(culture, female))
  end

  def random_dynasty(culture, rng)
    rng.sample(@dynasties[culture])
  end

private

  def name_pool(culture, female)
    if female
      @female_names[culture]
    else
      @male_names[culture]
    end
  end
end

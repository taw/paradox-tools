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

    @builder.glob("common/cultures/*.txt").each do |path|
      @builder.parse(path).each do |group_name, group|
        group.each do |name, culture|
          next unless culture.is_a?(PropertyList)
          @male_names[name]   = culture["male_names"].map{|n| n.sub(/_.*/, "")}
          @female_names[name] = culture["female_names"].map{|n| n.sub(/_.*/, "")}
          @dynasties[name]    = []
        end
      end
    end
    @builder.glob("common/dynasties/*.txt").each do |path|
      @builder.parse(path).each do |id, dynasty|
        culture = dynasty["culture"] or next
        @dynasties[culture] << id
      end
    end
  end

  def random_name(culture, female, rng)
    rng.sample(name_pool(culture, female))
  end

  def random_dynasty(culture, rng)
    culture = "volhynian" if culture == "ukrainian"
    culture = "severian" if culture == "belarusian"
    rng.sample(@dynasties.fetch(culture))
  end

private

  def name_pool(culture, female)
    if female
      @female_names.fetch(culture)
    else
      @male_names.fetch(culture)
    end
  end
end

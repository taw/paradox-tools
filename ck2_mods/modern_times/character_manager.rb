# This class is one of the most painful parts of the code and desperately
# needs refactoring

class CharacterManager
  def initialize(builder)
    @main_namespace  = 110_000_000
    @reset_namespace = 100_000_000
    @ruler_counts = Hash.new(0)
    @characters = {}
    @builder    = builder
    @reset_date = builder.reset_date
    @historical = {} # This needs to die
  end

  def allocate_id(key, is_reset=false)
    namespace = is_reset ? @reset_namespace : @main_namespace
    space_size = 10_000_000
    base_shift = Digest::MD5.hexdigest(key).to_i(16)
    id = namespace + (base_shift % space_size)
    while @characters.has_key?(id)
      base_shift += 1
      id = namespace + (base_shift % space_size)
    end
    @characters[id] = :placeholder
    rng = Random.keyed("#{key}-#{id}")
    [id, rng]
  end

  def allocate_historical_id(title, name)
    i = (@ruler_counts[[title, name]] += 1)
    [title, name, i].join(" ")
  end

  def create_reset_character(title)
    id, rng = allocate_id("reset-#{title}", true)
    add_character! Character.new(
      name: "Bob",
      religion: "cathar",
      culture: "bohemian",
      birth: @reset_date,
      death: @reset_date,
      id: id,
    )
  end

  # FIXME: This is fairly silly leftover
  def lookup_character_id(description)
    return description if description.is_a?(Integer)
    @historical.fetch(description)
  end

  def add_ruler(**args)
    key = args[:key]
    crowning = key[:crowning]
    id, rng = allocate_id("ruler-#{key[:title]}-#{key[:crowning].to_s_px}")

    culture  = args[:culture].to_s or raise
    religion = args[:religion].to_s or raise
    female = args[:female]
    if female == :maybe
      if muslim?(religion) or title_only_allows_males?(key[:title])
        female = false
      else
        female = (rng.rand < 0.2)
      end
    end
    if args[:birth]
      birth = args[:birth]
    else
      # Any age from 25 to 40
      birth = crowning - rng.rand(365*25..365*40)
    end
    case args[:death]
    when :never
      death = nil
    when Date
      death = args[:death]
    when nil
      # Random rulers all die at age of 80 to 90
      death = birth + rng.rand(365*80..365*90)
    else
      raise
    end

    if args[:dynasty]
      dynasty = @builder.new_dynasty(args[:dynasty], culture)
    else
      dynasty = @builder.cultures.random_dynasty(culture, rng)
    end

    father = args[:father] && lookup_character_id(args[:father])
    mother = args[:mother] && lookup_character_id(args[:mother])

    add_character! Character.new(
      name: args[:name] || @builder.cultures.random_name(culture, female, rng),
      religion: religion,
      culture: culture,
      dynasty: dynasty,
      female: female,
      father: father,
      mother: mother,
      health: args[:health],
      traits: args[:traits],
      birth: birth,
      events: args[:events],
      death: death,
      id: id,
      historical_id: args[:historical_id],
    )
  end

  # The game is much more fun if dynastic games start right away
  def generate_family!(id)
    parent = @characters[id]
    rng = Random.keyed("family-#{id}")
    birth = parent.birth
    death = parent.death

    # 10 20% shots, 15 10% shots, for EV=3.5
    (20..44).each do |age|
      child_birth = birth >> (12*age)
      break if death and child_birth > death
      fertility = 0.2
      fertility = 0.1 if age >= 30
      if rng.rand < fertility
        add_child!(id, child_birth)
      end
    end
  end

  def reset_plist
    result = PropertyList[]
    @characters.sort.each do |k,v|
      result.add! k, v.to_plist if k < @main_namespace
    end
    result
  end

  def main_plist
    result = PropertyList[]
    @characters.sort.each do |k,v|
      result.add! k, v.to_plist if k >= @main_namespace
    end
    result
  end

private

  def add_child!(parent_id, birth)
    parent = @characters.fetch(parent_id)
    id, rng = allocate_id("child-#{parent_id}-#{birth.to_s_px}")
    female = (rng.rand < 0.5)
    death = birth >> (90*12)
    add_character! Character.new(
      id: id,
      name: @builder.cultures.random_name(parent.culture, female, rng),
      religion: parent.religion,
      culture: parent.culture,
      dynasty: parent.dynasty,
      parent: parent,
      female: female,
      birth: birth,
      death: death,
    )
  end

  def add_character!(character)
    id = character.id
    historical_id = character.historical_id
    @characters[id] = character
    @historical[character.historical_id] = character if historical_id
    id
  end

  def muslim?(religion)
    %W[sunni shiite ibadi].include?(religion)
  end

  def title_only_allows_males?(title)
    @builder.db.titles.fetch(title, {})[:male]
  end
end

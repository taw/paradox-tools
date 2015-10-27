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
    @characters[id] = PropertyList[
      "name", "Bob",
      "religion", "cathar",
      "culture", "bohemian",
      @reset_date, PropertyList["birth", true],
      @reset_date, PropertyList["death", true],
    ]
    id
  end

  # FIXME: This is fairly silly leftover
  def lookup_character_id(description)
    return description if description.is_a?(Integer)
    @historical.fetch(description)
  end

  def add_ruler(**args)
    crowning = args[:key][:crowning]
    id, rng = allocate_id("ruler-#{args[:key][:title]}-#{args[:key][:crowning].to_s_px}")

    culture  = args[:culture] or raise
    religion = args[:religion] or raise
    female = args[:female]
    if female == :maybe
      if %W[sunni shiite ibadi].include?(religion) or @builder.db.titles[args[:key][:title]][:male]
        female = false
      else
        female = (rng.rand < 0.2)
      end
    end
    birth = args[:birth] || (crowning << 12*35)
    case args[:death]
    when :never
      death = nil
    when Date
      death = args[:death]
    when nil
      # Random rulers all die at age of 90
      death = (birth >> 12*90)
    else
      raise
    end

    name = args[:name] || @builder.cultures.random_name(culture, female, rng)

    if args[:dynasty]
      dynasty = @builder.new_dynasty(args[:dynasty], culture)
    else
      dynasty = @builder.cultures.random_dynasty(culture, rng)
    end

    character = PropertyList[
      "name", name,
      "religion", religion,
      "culture", culture,
      "dynasty", dynasty,
    ]
    character.add! "female", true if female
    character.add! "father", lookup_character_id(args[:father]) if args[:father]
    character.add! "mother", lookup_character_id(args[:mother]) if args[:mother]
    character.add! "health", args[:health] if args[:health]
    if args[:traits]
      args[:traits].each do |t|
        character.add! "trait", t
      end
    end
    character.add! birth, PropertyList["birth", birth]
    if args[:events]
      args[:events].each do |date, ev|
        character.add! date, ev
      end
    end
    character.add! death, PropertyList["death", death] if death

    @historical[args[:historical_id]] = id if args[:historical_id]
    @characters[id] = character
    id
  end

  # The game is much more fun if dynastic games start right away
  def generate_family!(id)
    parent = @characters[id]
    rng = Random.keyed("family-#{id}")
    birth = parent.keys.grep(Date).find{|k| parent[k]["birth"]}
    death = parent.keys.grep(Date).find{|k| parent[k]["death"]}

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
      result.add! k, v if k < @main_namespace
    end
    result
  end

  def main_plist
    result = PropertyList[]
    @characters.sort.each do |k,v|
      result.add! k, v if k >= @main_namespace
    end
    result
  end

private

  def add_child!(parent_id, birth)
    parent = @characters[parent_id]
    id, rng = allocate_id("child-#{parent_id}-#{birth.to_s_px}")
    female = (rng.rand < 0.5)
    death = birth >> (90*12)
    if parent["female"] == true
      parent_type = "mother"
    else
      parent_type = "father"
    end
    character = PropertyList[
      "name", @builder.cultures.random_name(parent["culture"], female, rng),
      "religion", parent["religion"],
      "culture", parent["culture"],
      "dynasty", parent["dynasty"],
      parent_type, parent_id,
    ]
    character.add! "female", true if female
    character.add! birth, PropertyList["birth", birth]
    character.add! death, PropertyList["death", death]
    @characters[id] = character
  end
end

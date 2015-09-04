require "digest"

Pathname(__dir__).glob("../modern_times/*.rb").each{|rb| require_relative rb}

class Random
  def sample(ary)
    ary[rand(ary.size)]
  end
end

class CharacterManager
  def initialize(builder, namespace)
    @builder = builder
    @characters = {}
    @by_description = {}
    @namespace = namespace
  end

  def name_pool(culture, female)
    if female
      @builder.culture_names[culture][:male]
    else
      @builder.culture_names[culture][:female]
    end
  end

  def dynasty_pool(culture)
    @builder.culture_names[culture][:dynasties]
  end

  def allocate_id(id)
    id += 1 while @characters.has_key?(id)
    id
  end

  def add_reset(title)
    id = allocate_id(@namespace + Digest::MD5.hexdigest(title).to_i(16) % 5_000_000)
    @characters[id] = PropertyList[
      "name", "Bob",
      "religion", "cathar",
      "culture", "bohemian",
      Date.parse("1700.1.1"), PropertyList["birth", Date.parse("1700.1.1")],
      Date.parse("1701.1.1"), PropertyList["death", Date.parse("1701.1.1")],
    ]
    id
  end

  def lookup_character_id(description)
    if description.is_a?(Integer)
      description
    else
      id = @by_description[description]
      raise "Can't find character `#{description}'" unless id
      raise "Can't find character `#{description}'" if id == :ambiguous
      id
    end
  end

  def add_ruler(**args)
    crowning = args[:key][:crowning]
    id = allocate_id(@namespace + ((args[:key][:crowning] - Date.parse("1900.1.1")) * 100).to_i)
    rng = Random.new(id)

    culture  = args[:culture].to_s
    religion = args[:religion].to_s
    female = args[:female]
    female = (rng.rand < 0.05) if female == :maybe # Less for Muslims?
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

    name = args[:name] || rng.sample(name_pool(culture, female))
    description = "#{name} #{birth.to_s_px}"

    if args[:dynasty]
      dynasty = @builder.new_dynasty(args[:dynasty], culture)
    else
      dynasty = rng.sample(dynasty_pool(culture))
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
    character.add! birth, PropertyList["birth", birth]
    character.add! death, PropertyList["death", death] if death

    @characters[id] = character
    if @by_description[description]
      @by_description[description] = :ambiguous
    else
      @by_description[description] = id
    end
    id
  end

  def to_plist
    result = PropertyList[]
    @characters.sort.each do |k,v|
      result.add! k, v
    end
    result
  end
end

# No idea if anything will ever come out of this
class ModernTimesGameModification < CK2GameModification
  def deep_search(node, path=[], &blk)
    node.each do |key, val|
      if val.is_a?(PropertyList)
        deep_search(val, [*path, key], &blk)
      end
      yield(node, [*path, key])
    end
  end

  def landed_titles_lookup
    unless @landed_titles_lookup
      @landed_titles_lookup = {}
      landed_titles = parse("common/landed_titles/landed_titles.txt")
      deep_search(landed_titles) do |node, path|
        next unless path[-1] =~ /\A[cb]_/
        @landed_titles_lookup[path[-1]] = path.reverse
      end
    end
    @landed_titles_lookup
  end

  def deep_search_direct(node, path=[], &blk)
    node.each do |key, val|
      subpath =  [*path, key]
      if val.is_a?(PropertyList)
        deep_search_direct(val, subpath, &blk)
      end
      yield(val, subpath)
    end
  end

  def province_id_to_title
    unless @province_id_to_title
      @province_id_to_title = Hash.new do |ht,k|
        paths = glob("history/provinces/#{k} *.txt")
        raise unless paths.size == 1
        ht[k] = parse(paths[0])["title"]
      end
    end
    @province_id_to_title
  end

  def title_capitals
    unless @title_capitals
      @title_capitals = {}
      landed_titles = parse("common/landed_titles/landed_titles.txt")
      deep_search_direct(landed_titles) do |node, path|
        next unless path[-1] == "capital"
        title = path[-2]
        @title_capitals[title] = province_id_to_title[node]
      end
    end
    @title_capitals
  end

  # This might be no longer necessary now that all provinces are some character's
  def new_throwaway_character(title)
    @characters_reset.add_reset(title)
  end

  # Assume same name in different cultures are separate dynasties
  def new_dynasty(name, culture)
    key = [name, culture]
    unless @dynasties[key]
      id = 100_000_000 + @dynasties.size
      @dynasties[key] = {name: name, culture: culture, id: id}
    end
    @dynasties[key][:id]
  end

  def add_holders!(node, holders, min_date=nil, max_date=nil)
    # max date is time when next country gets it so strict <
    holders = holders.select{|d,id| d < max_date} if max_date
    # min date is when this country gets it so >=
    # If multiple characters with same date (due to date compression, take the last one)
    holders = holders.map{|d,id| [[d,min_date].max, id]}.reverse.uniq(&:first).reverse if min_date
    holders.each do |date, id|
      node.add! date, PropertyList["holder", id]
    end
  end

  def setup_county_history!(title, node)
    node.add! Date.parse("1500.1.1"), PropertyList["liege", 0]
    node.add! Date.parse("1500.1.1"), PropertyList["holder", new_throwaway_character(title)]

    land = landed_titles_lookup[title].map{|t| @land[t]}.find(&:itself)

    unless land
      # This is really a bug, warn here once we get nontrivial amount of land covered
      puts "No idea what to do with #{landed_titles_lookup[title].reverse.join(" / ")}"
      return
    end

    land.size.times do |i|
      start_date, liege = land[i]
      end_date = land[i+1] && land[i+1][0]

      case liege
      when /\A[cd]_/
        # Counts and dukes hold all land directly
        node.add! start_date, PropertyList["liege", 0]
        add_holders! node, @holders[liege], start_date, end_date
      else
        capital_duchy = landed_titles_lookup[@capitals[liege]].find{|t| t =~ /\Ad_/ }
        this_duchy    = landed_titles_lookup[title].find{|t| t =~ /\Ad_/ }

        if capital_duchy == this_duchy
          add_holders! node, @holders[liege], start_date, end_date
        else
          # TODO: Hand it over to someone local vassal...
          node.add! start_date, PropertyList["holder", 0]
        end
        node.add! start_date, PropertyList["liege", liege]
      end
    end
  end

  def setup_major_title_history!(title, node)
    node.add! Date.parse("1500.1.1"), PropertyList["liege", 0]
    node.add! Date.parse("1500.1.1"), PropertyList["holder", 0]
  end

  def setup_province_history!
    glob("history/titles/*.txt").each do |path|
      title = path.basename(".txt").to_s
        patch_mod_file!(path) do |node|
        if title =~ /\Ab_/
          # Baronies not belonging to counties like partician houses can be ignored
          county = landed_titles_lookup[title].find{|t| t =~ /\Ac_/}
          if county
            node.add! Date.parse("1500.1.1"), PropertyList["liege", county]
          else
            node.add! Date.parse("1500.1.1"), PropertyList["liege", 0]
          end
          node.add! Date.parse("1500.1.1"), PropertyList["holder", 0]
        elsif title =~ /\Ac_/
          setup_county_history!(title, node)
        else
          setup_major_title_history!(title, node)
          @seen_title[title] = true
        end
      end
    end
    # This is a silly trick of creating node if it doesn't exist, reusing it otherwise
    @holders.each do |title, holders|
      begin
        node = parse("history/titles/#{title}.txt")
      rescue
        node = PropertyList[]
      end
      add_holders!(node, holders)
      create_mod_file!("history/titles/#{title}.txt", node)
    end
  end

  def save_characters!
    create_mod_file! "history/characters/modern_times_throwaways.txt", @characters_reset.to_plist
    create_mod_file! "history/characters/modern_times.txt", @characters.to_plist
  end

  def resolve_date(date)
    ModernTimes::Dates[date]
  end

  def preprocess_land_mapping!
    @land = {}
    ModernTimes::LAND.each do |title, ownership|
      @land[title.to_s] = ownership.map{|k,v| [resolve_date(k),v] }
    end
  end

  def merge_time_ranges(ranges)
    ranges = ranges.map{|s,e| [s,e||resolve_date(:end_of_times)]}

    # Premerge - simplifies things, but algorithm doesn't really care anyway
    # ranges = ranges.group_by(&:first).map{|s,rr| [s, rr.map(&:last).max] }.sort
    # ranges = ranges.group_by(&:last).map{|e,rr| [rr.map(&:first).min,e] }.sort

    dates = ranges.map{|s,e| [[s,1], [e,-1]]}.flatten(1).group_by(&:first)
                  .map{|d,vs| [d, vs.map(&:last).inject(&:+)]}.sort

    cut_dates = []
    cover = 0
    ranges.map{|s,e| [[s,1], [e,-1]]}.flatten(1).sort.each do |day,diff|
      cut_dates << day if cover == 0
      cover += diff
      cut_dates << day if cover == 0
      raise if cover < 0
    end

    cut_dates.map{|d| d == resolve_date(:end_of_times) ? nil : d}.each_slice(2).map(&:itself)
  end

  def preprocess_time_active!
    @time_active = {}
    # We don't care what they own, just when they own nonzero amount of land
    # Assume all titles actually resolve, and aren't shadowed by lower level titles or anything like that
    @land.each do |area, ownership|
      ownership.size.times do |i|
        start_date, start_owner = ownership[i]
        @time_active[start_owner] ||= []
        if i == ownership.size - 1
          @time_active[start_owner] << [start_date, nil]
        else
          @time_active[start_owner] << [start_date, ownership[i+1][0]]
        end
      end
    end
    @time_active.each do |title, ranges|
      @time_active[title] = merge_time_ranges(ranges)
    end
  end

  def culture_names
    unless @culture_names
      @culture_names = {}
      parse("common/cultures/00_cultures.txt").each do |group_name, group|
        group.each do |name, culture|
          next unless culture.is_a?(PropertyList)
          @culture_names[name] = {
            male:   culture["male_names"].map{|n| n.sub(/_.*/, "")},
            female: culture["male_names"].map{|n| n.sub(/_.*/, "")},
            dynasties: [],
          }
        end
      end
      parse("common/dynasties/00_dynasties.txt").each do |id, dynasty|
        culture = dynasty["culture"] or next
        @culture_names[culture][:dynasties] << id
      end
    end
    @culture_names
  end

  def preprocess_data!
    # ModernTimes module holds data in format convenient for human writing,
    # it needs to be converted to something sensibler
    preprocess_land_mapping!
    preprocess_time_active!

    @capitals = {}
    @holders  = {}
    @title_names = {}
    ModernTimes::TITLES.each do |title, data|
      title    = title.to_s
      if data[:capital]
        capital = data[:capital].to_s
      elsif title =~ /\Ac_/
        capital = title
      else
        capital = title_capitals[title] or raise "Can't autodetect capital for #{title}"
      end
      culture  = data[:culture].to_s
      religion = data[:religion].to_s
      holders  = ModernTimes::HOLDERS[title.to_sym]
      unless holders
        unless @time_active[title]
          raise "Title #{title} is not active in any era. You need to specify its holders manually in such case"
        end
        holders = []
        # We need to break long stretches of time into 15 year fragments
        @time_active[title].each do |s,e|
          xe = e || resolve_date(:title_holders_until)
          while true
            holders << [s, {}]
            s >>= (12*15)       # 40..55 years
            break if s >= xe
          end
          holders << [e, nil] if e
        end
      end

      if data[:name]
        data[:name] = {:start => data[:name]} if data[:name].is_a?(String)
        @title_names[title] = data[:name].map{|d,n| [resolve_date(d), n] }
      end

      @capitals[title] = capital
      @holders[title] = []
      @seen_title = {}
      holders.each do |date, holder|
        date  = resolve_date(date)
        if holder.nil?
          @holders[title] << [date, 0]
        else
          id = @characters.add_ruler(
            culture: holder.fetch(:culture, culture),
            religion: holder.fetch(:religion, religion),
            female: holder.fetch(:female, :maybe),
            birth: resolve_date(holder[:birth]),
            death: resolve_date(holder[:death]),
            name: holder[:name],
            dynasty: holder[:dynasty],
            father: holder[:father],
            mother: holder[:mother],
            key: {
              crowning: date,
              title: title,
            },
          )
          @holders[title] << [date, id]
        end
      end
    end
  end

  def setup_bookmarks!
    bookmarks = [
      "1900.1.1",   # earliest date
      "1914.6.28",  # assassination of archduke Franz Ferdinand
      "1920.8.10",  # treaty of Sevres
      "1938.3.12",  # aschluss of Austria
      "1945.5.8",   # cold war begins
      "1967.6.10",  # six day war
      "1975.1.1",   # nothing special
      "1991.12.26", # fall of Soviet Union
      "1999.12.31", # nothing special
      "2015.9.1",   # today
    ]

    # Bookmark tags are unfortunately magical
    patch_mod_file!("common/bookmarks/00_bookmarks.txt") do |node|
      node.each do |_, bookmark|
        bookmark.delete "character"
        bookmark["date"] = Date.parse(bookmarks.shift) unless bookmarks.empty?
      end
    end
  end

  def setup_defines!
    patch_mod_file!("common/defines.txt") do |node|
      node["start_date"]      = Date.parse("1900.1.1")
      node["last_start_date"] = Date.parse("2015.12.31")
      node["end_date"]        = Date.parse("2999.12.31")
    end
  end

  def setup_technology!
    # Smarter assignment later, for now just something not totally silly
    patch_mod_files!("history/technology/*.txt") do |node|
      node.each do |_, techs|
        techs.delete 769
        techs.delete 1337
        techs.add! 1900, PropertyList[
          "military", 4.0,
          "economy", 4.0,
          "culture", 4.0,
        ]
        techs.add! 2015, PropertyList[
          "military", 7.0,
          "economy", 7.0,
          "culture", 7.0,
        ]
      end
    end
    override_defines_lua!("modern_times",
      "NTechnology.DONT_EXECUTE_TECH_BEFORE" => 1900,
      "NEngine.MISSING_SCRIPTED_SUCCESSOR_ERROR_CUTOFF_YEAR" => 1900,
      "NEngine.MISSING_SCRIPTED_SUCCESSOR_ERROR_CUTOFF_MONTH" => 1,
      "NEngine.MISSING_SCRIPTED_SUCCESSOR_ERROR_CUTOFF_DAY" => 1,
    )
  end

  def cleanup_history_node!(node)
    # Presumably not needed but for sake of convention
    # Maybe merge nodes with same date?
    raise unless node.keys.all?{|k| k.is_a?(Date)}
    node.instance_eval{ @list = @list.select{|k,v| v != [] }.sort }
  end

  def setup_title_names!
    @title_names.each do |title, names|
      patch_mod_file!("history/titles/#{title}.txt") do |node|
        names.each do |date, name_adj|
          if name_adj
            name, adj = name_adj.split(" / ")
            node.add!(date, PropertyList["name", name, "adjective", adj])
          else
            node.add!(date, PropertyList["reset_name", true, "reset_adjective", true])
          end
        end
        cleanup_history_node!(node)
      end
    end
  end

  # Some sensible baseline for everyone
  def setup_title_laws!
    patch_mod_files!("history/titles/[dke]_*.txt") do |node|
      node.add! resolve_date(:start), PropertyList[
        "law", "succ_primogeniture",
        "law", "investiture_law_0",
        "law", "cognatic_succession",
        "law", "feudal_tax_1",
      ]
      cleanup_history_node!(node)
    end
  end

  def save_dynasties!
    create_mod_file!("common/dynasties/01_modern_times.txt", PropertyList[
      *@dynasties.values.map{|d|
        Property[d[:id], PropertyList["name", d[:name], "culture", d[:culture]]]
      }.sort
    ])
  end

  def apply!
    # TODO:
    # - province religions
    # - province cultures
    # - characters leading major empires
    # - etc.

    @characters_reset = CharacterManager.new(self, 100_000_000)
    @characters       = CharacterManager.new(self, 110_000_000)
    @dynasties        = {}
    preprocess_data!
    setup_province_history!
    setup_title_names!
    setup_title_laws! # Run after other title history changes, to make sure any new titles get covered
    save_characters!
    setup_defines!
    setup_bookmarks!
    setup_technology!
    save_dynasties!
  end
end

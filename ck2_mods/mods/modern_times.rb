require "digest"

Pathname(__dir__).glob("../modern_times/*.rb").each{|rb| require_relative rb}

class CharacterManager
  def initialize(builder, namespace)
    @builder = builder
    @characters = {}
    @by_description = {}
    @namespace = namespace
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

    culture  = args[:culture]
    religion = args[:religion]
    female = args[:female]
    if female == :maybe
      if religion == "sunni" or religion == "shiite" or args[:key][:title] == "k_papal_state"
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
    description = "#{name} #{birth.to_s_px}"

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
  attr_reader :map

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

  # If no dominant culture, choose liege_culture, or else just largest one
  #
  # TODO:
  # This should maybe choose liege culture anyway in some cases of conflicts,
  # like if duchy is next to one with liege's culture
  # So Wales would be ruled by Englishmen, but English colonies in India wouldn't
  # It's messier query to check neighbouring duchies, so it should only be done
  # once map manager of some kind is refactored out of this blob of code
  #
  # FIXME:
  # This checks cultures in whole duchy, but we're only interested in part of the duchy
  # in actual realm. Might be problematic in case of border changes,
  # as we don't replace vassal on border change.
  def dominant_culture_in_duchy(duchy, liege_culture)
    cultures = @map.cultures_in_duchy(duchy)
    # If duchy is one culture, choose it
    return cultures[0] if cultures.uniq.size == 1
    # If liege's culture is in the duchy even as minority, choose it
    return liege_culture if cultures.include?(liege_culture)
    # Else choose dominant culture
    cultures.group_by(&:itself).map{|c,xx| [-xx.size, c]}.sort[0][1]
  end

  def regional_vassals(liege, duchy)
    unless @regional_vassals[[liege, duchy]]
      @regional_vassals[[liege, duchy]] = []
      # We need to break long stretches of time into 15 year fragments
      @db.liege_has_land_in_active(liege, duchy).each do |s,e|
        xe = e || @db.resolve_date(:title_holders_until)
        while true
          # Always liege religion but could be local culture
          culture = dominant_culture_in_duchy(duchy, @db.titles[liege][:culture])
          id = @characters.add_ruler(
            culture: culture,
            religion: @db.titles[liege][:religion],
            key: {
              crowning: s,
              title: duchy,
            },
          )
          @regional_vassals[[liege, duchy]] << [s, id]
          s >>= (12*15)  # 40..55 years
          break if s >= xe
        end
        @regional_vassals[[liege, duchy]] << [e, 0] if e
      end
    end
    @regional_vassals[[liege, duchy]]
  end

  def setup_county_history!(title, node)
    node.add! Date.parse("1500.1.1"), PropertyList["liege", 0]
    node.add! Date.parse("1500.1.1"), PropertyList["holder", @characters_reset.add_reset(title)]

    land = @db.county_ownership(title)

    unless land
      # This is really a bug, warn here once we get nontrivial amount of land covered
      puts "No idea what to do with #{@map.landed_titles_lookup[title].reverse.join(" / ")}"
      return
    end

    land.size.times do |i|
      start_date, liege = land[i]
      end_date = land[i+1] && land[i+1][0]

      case liege
      when /\A[cd]_/
        # Counts and dukes hold all land directly
        node.add! start_date, PropertyList["liege", 0]
        add_holders! node, holders[liege], start_date, end_date
      else
        capital_duchy = @db.capital_duchy(liege)
        this_duchy    = @map.duchy_for_county(title)

        if capital_duchy == this_duchy
          add_holders! node, holders[liege], start_date, end_date
        else
          add_holders! node, regional_vassals(liege, this_duchy), start_date, end_date
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
          county = @map.landed_titles_lookup[title].find{|t| t =~ /\Ac_/}
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
        end
      end
    end
    # This is a silly trick of creating node if it doesn't exist, reusing it otherwise
    holders.each do |title, holders|
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

  # TODO: move most of it to Database class
  def holders
    unless @holders
      @holders  = {}
      @db.titles.each do |title, data|
        title    = title
        holders  = @db.holders[title]
        unless holders
          unless @db.time_active[title]
            raise "Title #{title} is not active in any era. You need to specify its holders manually in such case"
          end
          holders = []
          # We need to break long stretches of time into 15 year fragments
          @db.time_active[title].each do |s,e|
            xe = e || @db.resolve_date(:title_holders_until)
            while true
              holders << [s, {}]
              s >>= (12*15)       # 35..50 years
              break if s >= xe
            end
            holders << [e, nil] if e
          end
        end

        @holders[title] = []
        holders.each do |date, holder|
          if holder.nil?
            @holders[title] << [date, 0]
          else
            id = @characters.add_ruler(
              culture: holder[:culture] || data[:culture],
              religion: holder[:religion] || data[:religion],
              female: holder.fetch(:female, :maybe), # Historical rulers always have it set by db
              birth: holder[:birth],
              death: holder[:death],
              name: holder[:name],
              dynasty: holder[:dynasty],
              father: holder[:father],
              mother: holder[:mother],
              traits: holder[:traits],
              events: holder[:events],
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
    @holders
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
    tech_levels = {
      ["africa", 0]         => [2,3], # Ethiopia
      ["africa", 1]         => [3,4], # Egypt
      ["africa", 2]         => [3,4], # Tunis
      ["africa", 3]         => [2,3], # West Africa
      ["byzantium", 0]      => [4,5], # Byzantium
      ["byzantium", 1]      => [4,5], # Thrace
      ["eastern_europe", 0] => [4,5],
      ["india", 0]          => [2,3],
      ["middle_east", 0]    => [3,4],
      ["scandinavia", 0]    => [5,6],
      ["the_steppes", 0]    => [2,3],
      ["the_steppes", 1]    => [2,3],
      ["the_steppes", 2]    => [2,3],
      ["western_europe", 0] => [5,7], # France / Germany - catch up with UK
      ["western_europe", 1] => [5,6], # Italy
      ["western_europe", 2] => [6,7], # UK
      ["western_europe", 3] => [5,6], # North Spain
      ["western_europe", 4] => [5,6], # South Spain
    }
    glob("history/technology/*.txt").each do |path|
      group = path.basename(".txt").to_s
      patch_mod_file!(path) do |node|
        node.find_all("technology").each_with_index do |techs, i|
          (a, b) = tech_levels.fetch([group, i])
          # p node
          techs.delete 769
          techs.delete 1337
          techs.add! 1900, PropertyList[
            "military", a,
            "economy", a,
            "culture", a,
          ]
          techs.add! 2015, PropertyList[
            "military", b,
            "economy", b,
            "culture", b,
          ]
        end
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
    @db.titles.each do |title, data|
      next unless data[:name]
      patch_mod_file!("history/titles/#{title}.txt") do |node|
        data[:name].each do |date, name_adj|
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
      node.add! @db.resolve_date(:start), PropertyList[
        "law", "investiture_law_0",
        "law", "cognatic_succession",
        "law", "centralization_2",
      ]
      cleanup_history_node!(node)
    end
    create_mod_file! "common/on_actions/10_modern_times.txt", PropertyList[
      "on_startup", PropertyList[
        "events", ["modern_times_setup.1"],
      ],
    ]
    create_mod_file! "events/modern_times_setup.txt", PropertyList[
      "namespace", "modern_times_setup",
      "character_event", PropertyList[
        "id", "modern_times_setup.1",
        "hide_window", true,
        "is_triggered_only", true,
        "only_rulers", true,
        "trigger", PropertyList[
          "is_feudal", true,
          "NOT", PropertyList["religion_group", "muslim"],
        ],
        "immediate", PropertyList[
          "primary_title", PropertyList[
            "succession", "primogeniture",
            "add_law", "feudal_tax_2",
          ],
        ],
      ],
    ]
  end

  # We need to remove county-level bishops as game will make them duchy-level bishops
  # with current automatic vassal creation system
  # Might get them back if we switch to a different system
  def setup_province_holdings!
    patch_mod_files!("history/provinces/*.txt") do |node|
      title = node["title"]
      holdings = {}
      capital = nil
      node.each do |k, v|
        if k =~ /\Ab_/ and v =~ /\A(city|castle|temple|tribal)\z/
          holdings[k] = v
          capital ||= k
        end
        raise if k == "capital"
        if k.is_a?(Date)
          v.each do |kk, vv|
            holdings[kk] = vv if kk =~ /\Ab_/ and vv =~ /\A(city|castle|temple|tribal)\z/
            capital = vv if kk == "capital"
          end
        end
      end
      case holdings[capital]
      when "castle", "city"
        # OK
      when "temple"
        next if title == "c_roma"
        first_castle = holdings.keys.find{|c| holdings[c] == "castle"}
        unless first_castle
          # warn "No castle in #{title}"
          next
        end
        node.add! @db.resolve_date(:start), PropertyList["capital", first_castle]
        # p [title, holdings[capital], capital, holdings]
      when "tribal"
        # p [title, holdings[capital], capital, holdings, @map.landed_titles_lookup[title]]
      else
        raise
      end
    end
  end

  # 14th century map is mostly reasonable, but there's a bit of crazy we need to fix
  #
  # current dynastic conflict count is 6441, that's silly
  def setup_province_population!
    # https://en.wikipedia.org/wiki/Karluk_languages
    # https://en.wikipedia.org/wiki/Kipchak_languages
    # uzbeks -> karluk
    # kazakhs -> cuman
    # tatars -> bolghar

    # k_persia -> shiite
    patch_mod_files!("history/provinces/*.txt") do |node|
      title = node["title"]
      orig_culture  = culture  = [node["culture"], *node.list.map{|_,v| v["culture"] if v.is_a?(PropertyList)}].compact.last
      orig_religion = religion = [node["religion"], *node.list.map{|_,v| v["religion"] if v.is_a?(PropertyList)}].compact.last
      county, duchy, kingdom, empire = @map.landed_titles_lookup[title]

      if empire == "e_persia" or ["d_basra", "d_tigris", "d_baghdad", "c_kermanshah", "d_tripoli"].include?(duchy)
        religion = "shiite"
      end
      if culture == "mongol"
        if kingdom == "k_mongolia"
          # Mongols in Mongolia are OK
        elsif kingdom == "k_taurica" or kingdom == "k_ruthenia"
          culture = "bolghar"
        elsif kingdom == "k_khiva"
          culture = "karluk"
        elsif kingdom == "k_alania"
          culture = "alan"
        else
          # Too many
          culture = "cuman"
        end
      end
      if duchy == "k_khiva"
        culture = "karluk"
      end
      if duchy == "d_nyitra" or county == "c_pressburg"
        culture = "bohemian"
      end
      if duchy == "d_carinthia" or county == "c_steiermark"
        culture = "croatian"
      end
      if duchy == "d_armenia"
        culture = "armenian"
      end
      if kingdom == "k_england"
        religion = "fraticelli"
      end
      if duchy == "d_holland" or duchy == "d_gelre"
        religion = "waldensian"
      end
      if culture == "andalusian_arabic"
        if county == "c_algeciras"
          culture = "english"
        else
          culture = "castillan"
        end
      end
      if duchy == "d_ascalon"
        culture = "ashkenazi"
        religion = "jewish"
      end

      # p [title, {orig_culture => culture}, {orig_religion => religion}, @map.landed_titles_lookup[title]]
      if culture != orig_culture
        node.add! @db.resolve_date(:start), PropertyList["culture", culture]
        # p [title, {orig_culture => culture}, orig_religion, @map.landed_titles_lookup[title]]
      end
      if religion != orig_religion
        node.add! @db.resolve_date(:start), PropertyList["religion", religion]
        # p [title, orig_culture, {orig_religion => religion}, @map.landed_titles_lookup[title]]
      end
    end
  end

  def setup_nomad_flag!
    patch_mod_file!("history/titles/d_moldau.txt") do |node|
      node.add! @db.resolve_date(:start), PropertyList["historical_nomad", false]
    end
  end

  def save_dynasties!
    create_mod_file!("common/dynasties/01_modern_times.txt", PropertyList[
      *@dynasties.values.map{|d|
        Property[d[:id], PropertyList["name", d[:name], "culture", d[:culture]]]
      }.sort
    ])
  end

  # Debug method until I figure out how to fix the issue
  def report_dynasty_conflict_stats!
    stats = {}
    conflicts = Hash.new(0)
    @characters.to_plist.each do |id, character|
      c = character["culture"]
      d = character["dynasty"]
      (stats[[c,d]] ||= []) << id
    end
    stats.sort_by{|_, ids| -ids.size}.each do |(c,d),ids|
      i = ids.size
      # puts "#{c} #{d} - #{i}" if i > 1
      conflicts[c] += (i+1)*i/2
    end
    pp conflicts.values.inject(&:+)
    pp conflicts.sort_by{|k,v| -v}

    cultures = {}
    @builder.parse("common/cultures/00_cultures.txt").each do |group_name, group|
      group.each do |name, culture|
        next unless culture.is_a?(PropertyList)
        cultures[name] = 0
      end
    end
    @builder.glob("history/provinces/*.txt").each do |path|
      node = @builder.parse(path)
      culture =  [node["culture"], *node.list.map{|_,v| v["culture"] if v.is_a?(PropertyList)}].compact.last
      cultures[culture] += 1
    end
    pp cultures.sort_by{|k,v| -v}
  end

  def apply!
    # Order of transformations matters

    setup_defines!
    setup_bookmarks!
    setup_technology!

    @map = MapManager.new(self)
    @db = ModernTimesDatabase.new(self)

    setup_province_holdings!
    setup_province_population!
    setup_nomad_flag!

    @cultures = CultureManager.new(self)
    @characters_reset = CharacterManager.new(self, 100_000_000)
    @characters       = CharacterManager.new(self, 110_000_000)
    @regional_vassals = {}
    @dynasties        = {}
    setup_province_history!
    setup_title_names!
    setup_title_laws! # Run after other title history changes, to make sure any new titles get covered
    save_characters!
    save_dynasties!

    # report_dynasty_conflict_stats!
  end
end

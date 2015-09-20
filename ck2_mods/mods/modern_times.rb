require "digest"

Pathname(__dir__).glob("../modern_times/*.rb").each{|rb| require_relative rb}

class Random
  def self.keyed(key)
    new(Digest::MD5.hexdigest(key).to_i(16))
  end
end

class CharacterManager
  def initialize(builder, namespace)
    @builder = builder
    @characters = {}
    @namespace = namespace
    @historical = {}
  end

  def allocate_id(key)
    space_size = 10_000_000
    base_shift = Digest::MD5.hexdigest(key).to_i(16)
    id = @namespace + (base_shift % space_size)
    while @characters.has_key?(id)
      base_shift += 1
      id = @namespace + (base_shift % space_size)
    end
    @characters[id] = :placeholder
    rng = Random.keyed("#{key}-#{id}")
    [id, rng]
  end

  def add_reset(title)
    id, rng = allocate_id("reset-#{title}")
    @characters[id] = PropertyList[
      "name", "Bob",
      "religion", "cathar",
      "culture", "bohemian",
      Date.parse("1600.1.1"), PropertyList["birth", Date.parse("1600.1.1")],
      Date.parse("1601.1.1"), PropertyList["death", Date.parse("1601.1.1")],
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

  def to_plist
    result = PropertyList[]
    @characters.sort.each do |k,v|
      result.add! k, v
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
      @db.liege_has_land_in_active(liege, duchy).to_list.each do |s,e|
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
          @characters.generate_family!(id)
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
    land_start = land && land[0][0]

    unless land
      # This is really a bug, warn here once we get nontrivial amount of land covered
      warn "No idea what to do with #{@map.landed_titles_lookup[title].reverse.join(" / ")}"
      return
    end
    if land_start > @db.min_date
      warn "History for #{@map.landed_titles_lookup[title].reverse.join(" / ")} only from #{land_start.to_s_px}"
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
    if @map.landless_title?(title)
      case title
      when "e_golden_horde", "e_il-khanate"
        node.add! Date.parse("1500.1.1"), PropertyList["liege", 0]
        node.add! Date.parse("1500.1.1"), PropertyList["holder", 0]
      when "d_zealots"
        # Israel restores Zealots
        node.add! @db.resolve_date(:israel_independence), PropertyList[
          "active", true,
          "liege", "k_israel"
        ]
        node.add! @db.resolve_date(:israel_independence), PropertyList[]
      when "d_hashshashin"
        # We really want to resurrect assassins, dated at Iranian Revolution
        node.add! @db.resolve_date(:iranian_revolution), PropertyList[
          "active", true,
          "liege", "e_persia",
          "clr_global_flag", "assassins_destroyed",
        ]
      when "d_knights_templar"
        # Every conspiracy site will tell you templars were never really destroyed
        node.list[-1][1].delete "active"
        node.list[-1][1].delete "holder"
      else
        # info = parse("common/landed_titles/landed_titles.txt")[title]
        # active = node.values.map{|v| v["active"]}.compact.last
        # p [:landless_title, title, active]
        # puts info
        # puts node
        # puts ""

        # OK
      end
    else
      node.add! Date.parse("1500.1.1"), PropertyList["liege", 0]
      node.add! Date.parse("1500.1.1"), PropertyList["holder", 0]
    end
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
        holders  = @db.holders[title] || {}
        unless @db.title_needs_extra_holders[title].empty?
          warn "Needs extra holders: #{title} #{@db.title_needs_extra_holders[title]}"
          @db.title_needs_extra_holders[title].to_list.each do |s,e|
            xe = e || @db.resolve_date(:title_holders_until)
            while true
              holders[s] = {
                culture: data[:culture],
                religion: data[:religion],
                female: :maybe,
              }
              s >>= (12*15) # 35..50 years
              break if s >= xe
            end
            # This can mean two things:
            # * title ends (set to nil)
            # * historical rulers begin (don't set to nil)
            holders[e] ||= nil if e
          end
        end
        @holders[title] = []
        holders.sort.each do |date, holder|
          if holder.nil?
            @holders[title] << [date, 0]
          elsif holder[:use]
            id = @characters.lookup_character_id(holder[:use])
            @holders[title] << [date, id]
          else
            id = @characters.add_ruler(holder.merge(key: {
              crowning: date,
              title: title,
            }))
            @characters.generate_family!(id) unless title == "k_papal_state"
            @holders[title] << [date, id]
          end
        end
      end
    end
    @holders
  end

  def setup_defines!
    patch_mod_file!("common/defines.txt") do |node|
      if ENV["DEBUG_HISTORY"]
        ### History testing
        node["start_date"]    = Date.parse(ENV["DEBUG_HISTORY"])
      else
        ### Actual start
        node["start_date"]    = Date.parse("1900.1.1")
      end
      node["last_start_date"] = Date.parse("2015.12.31")
      node["end_date"]        = Date.parse("2999.12.31")
    end
  end

  # TODO: tech for 1700+
  def setup_technology!
    tech_levels = {
      ["africa", 0]         => [1,2,3], # Ethiopia
      ["africa", 1]         => [2,3,4], # Egypt
      ["africa", 2]         => [2,3,4], # Tunis
      ["africa", 3]         => [1,2,3], # West Africa
      ["byzantium", 0]      => [3,4,5], # Byzantium
      ["byzantium", 1]      => [3,4,5], # Thrace
      ["eastern_europe", 0] => [3,4,5],
      ["india", 0]          => [1,2,3],
      ["middle_east", 0]    => [2,3,4],
      ["scandinavia", 0]    => [4,5,6],
      ["the_steppes", 0]    => [1,2,3],
      ["the_steppes", 1]    => [1,2,3],
      ["the_steppes", 2]    => [1,2,3],
      ["western_europe", 0] => [4,5,7], # France / Germany - catch up with UK
      ["western_europe", 1] => [4,5,6], # Italy
      ["western_europe", 2] => [4,6,7], # UK
      ["western_europe", 3] => [4,5,6], # North Spain
      ["western_europe", 4] => [4,5,6], # South Spain
    }
    glob("history/technology/*.txt").each do |path|
      group = path.basename(".txt").to_s
      patch_mod_file!(path) do |node|
        node.find_all("technology").each_with_index do |techs, i|
          (a, b, c) = tech_levels.fetch([group, i])
          # p node
          techs.delete 769
          techs.delete 1337
          techs.add! 1700, PropertyList[
            "military", a,
            "economy", a,
            "culture", a,
          ]
          techs.add! 1900, PropertyList[
            "military", b,
            "economy", b,
            "culture", b,
          ]
          techs.add! 2015, PropertyList[
            "military", c,
            "economy", c,
            "culture", c,
          ]
        end
      end
    end
    override_defines_lua!("modern_times",
      "NTechnology.DONT_EXECUTE_TECH_BEFORE" => 1700,
      "NEngine.MISSING_SCRIPTED_SUCCESSOR_ERROR_CUTOFF_YEAR" => 1700,
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
    # d_sunni is supposed to have priority over d_syria etc. (dignity=100) but it doesn't work.
    # Setting d_sunni as primary=true would completely ban creation of any high level titles
    # which is wrong as caliphs held kingdoms and empires.
    # So we'll just need to live with this bug.
  end

  # Some sensible baseline for everyone
  def setup_title_laws!
    glob("history/titles/[dke]_*.txt").each do |path|
      title = path.basename(".txt").to_s
      patch_mod_file!(path) do |node|
        node.add! @db.resolve_date(:forever_ago), PropertyList[
          "law", "investiture_law_0",
          "law", "cognatic_succession",
          # Empire start decentralized, lower titles at medium
          "law", (title =~ /\Ae_/ ? "centralization_0" : "centralization_2"),
        ]
        cleanup_history_node!(node)
      end
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
          "holy_order", false,
          "NOT", PropertyList["religion_group", "muslim"],
        ],
        "immediate", PropertyList[
          "primary_title", PropertyList[
            "succession", "primogeniture",
            "add_law", "feudal_tax_2",
            "add_law", "city_tax_2",
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
        node.add! @db.resolve_date(:forever_ago), PropertyList["capital", first_castle]
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

      if kingdom == "k_persia" or ["d_basra", "d_tigris", "d_baghdad", "d_kermanshah", "d_tripoli"].include?(duchy)
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
      if duchy == "d_holland" or duchy == "d_gelre" or empire == "e_scandinavia"
        religion = "waldensian"
      end
      if duchy == "d_crimea"
        religion = "orthodox"
        culture = "russian"
      end
      if duchy == "d_armenia"
        religion = "orthodox"
      end
      if culture == "andalusian_arabic"
        if county == "c_algeciras"
          culture = "english"
        else
          culture = "castillan"
        end
        religion = "catholic"
      end
      if duchy == "d_ascalon"
        culture = "ashkenazi"
        religion = "jewish"
      end

      # p [title, {orig_culture => culture}, {orig_religion => religion}, @map.landed_titles_lookup[title]]
      if culture != orig_culture
        node.add! @db.resolve_date(:forever_ago), PropertyList["culture", culture]
        # p [title, {orig_culture => culture}, orig_religion, @map.landed_titles_lookup[title]]
      end
      if religion != orig_religion
        node.add! @db.resolve_date(:forever_ago), PropertyList["religion", religion]
        # p [title, orig_culture, {orig_religion => religion}, @map.landed_titles_lookup[title]]
      end
    end
  end

  def setup_nomad_flag!
    patch_mod_file!("history/titles/d_moldau.txt") do |node|
      node.add! @db.resolve_date(:forever_ago), PropertyList["historical_nomad", false]
    end
  end

  def setup_de_jure_map!
    {
      "k_venice"    => "e_italy",
      "k_sicily"    => "e_italy",
      "d_aragon"    => "k_aragon",
      "d_granada"   => "k_castille",
      "d_brandenburg" => "k_pomerania",
      "d_prussia"   => "k_pomerania",
      "k_ruthenia"  => "e_wendish_empire",
      "k_croatia"   => "e_carpathia",
      "d_ryazan"    => "k_rus",
      "d_livonia"   => "k_lithuania",
      "k_prussia"   => { hre_disbanded: "e_germany" },
      "k_frisia"    => { hre_disbanded: "e_germany" },
      "k_germany"   => { hre_disbanded: "e_germany" },
      "k_lotharingia" => { hre_disbanded: "e_germany" },
      "k_bavaria"   => { hre_disbanded: "e_carpathia" },
      "k_bohemia"   => { hre_disbanded: "e_carpathia" },
    }.each do |title, liege|
      # FIXME: This is horrible hack
      path = "history/titles/#{title}.txt"
      if glob(path) == []
        create_mod_file!(path, PropertyList[])
      end

      patch_mod_file!(path) do |node|
        if liege.is_a?(String)
          liege = {:forever_ago => liege}
        end
        liege.each do |date, title|
          node.add! @db.resolve_date(date), PropertyList["de_jure_liege", title]
        end
      end
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

  def setup_bookmarks!
    # Sadly can't be modded and first two are DLC-locked
    key_bookmarks = [
      "BM_CHARLEMAGNE", "DARK_AGES",
      "BM_THE_OLD_GODS", "VIKING_ERA",
      "BM_FATE_OF_ENGLAND", "EARLY_MED_INFO",
      "BM_THE_MONGOLS", "HIGH_MED",
      "BM_100_YEARS_WAR", "LATE_MED",
    ]

    bookmarks = [
      ### History files testing:
      ["1700.1.1", "Test 1700"],
      ["1750.1.1", "Test 1750"],
      ["1780.1.1", "Test 1780"],
      ["1815.6.9", "Congress of Vienna"],
      ["1840.1.1", "Test 1840"],
      ["1861.3.17", "Kingdom of Italy"],

      ### Actual bookmarks, must have 5 key bookmarks
      ["1871.1.18", "German Empire", true],
      ["1900.1.1",   "New Century"],
      ["1914.6.28",  "The Great War"],
      ["1920.8.10",  "Treaty of Sevres", true],
      ["1939.8.31",  "The Greater War"],
      ["1945.5.8",   "Cold War", true],
      ["1975.1.1",   "Decolonization", true],
      ["1991.12.26", "Fall of Soviet Union"],
      ["2015.9.1",   "Modern Times", true],
    ]
    # Bookmark tags are unfortunately magical
    patch_mod_file!("common/bookmarks/00_bookmarks.txt") do |node|
      node.delete_if{true}
      bookmarks.each do |date, name, key|
        date = Date.parse(date)
        next unless date >= @db.min_date
        if key
          bm_code, splash_code = key_bookmarks.shift
        else
          bm_code, splash_code = date.strftime("BM_%Y_%m_%d"), nil
        end
        bm_desc = "#{bm_code}_DESC"
        node.add! "bookmark", PropertyList[
          "name", bm_code,
          "desc", bm_desc,
          "date", date,
        ]
        localization!("ZZ vanilla overrides",
          bm_code => name,
          bm_desc => "",
        )
        if splash_code
          localization!("ZZ vanilla overrides",
            splash_code => name,
            "#{splash_code}_INFO" => "",
          )
        end
      end
    end
  end

  def change_localization!
    localization!("ZZ vanilla overrides",
      "romanian" => "Romanian", # Not Vlach
      )
  end

  def warn(msg)
    @warnings << msg
  end

  def apply!
    @warnings = []

    # Order of transformations matters
    setup_defines!
    setup_technology!

    @map = MapManager.new(self)
    @db = ModernTimesDatabase.new(self)

    setup_province_holdings!
    setup_province_population!
    setup_nomad_flag!
    setup_de_jure_map!

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
    change_localization!

    # report_dynasty_conflict_stats!
    @warnings.sort.each_with_index do |w,i|
      puts "% 3d %s" % [i+1,w]
    end

    setup_bookmarks!
  end
end

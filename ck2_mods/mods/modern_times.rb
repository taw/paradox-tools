require "digest"
require_relative "../modern_times/database"

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

  def reset_date
    @reset_date ||= @builder.reset_date
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
      reset_date, PropertyList["birth", true],
      reset_date, PropertyList["death", true],
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

  def reset_date
    @reset_date ||= @db.resolve_date(:reset_date)
  end

  def new_dynasty(name, culture)
    # Cultural overrides, many European royal dynasties were cross-cultural
    # I'm not even sure if it does anything
    case name
    when "Hesse", "Habsburg"
      culture = "german"
    when "Bonaparte", "Bourbon"
      culture = "frankish"
    when "Schleswig-Holstein-Sonderburg-Glücksburg"
      culture = "danish"
    when "Windsor"
      culture = "english"
    when "Savoy"
      culture = "italian"
    end

    if @dynasties[name]
      existing_culture = @dynasties[name][:culture]
      if culture != existing_culture
        warn "Dynasty `#{name}' has multiple cultures #{culture}, #{existing_culture}"
      end
    else
      id = 100_000_000 + @dynasties.size
      @dynasties[name] = {name: name, culture: culture, id: id}
    end
    @dynasties[name][:id]
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
  # This could be a lot fancier, like maybe only checking parts of duchy owned
  # by liege, not all of it, or it could enforce liege culture in duchies neighbouring
  # land of liege's culture (like Englishmen running Wales)
  # as that's how culture conversions happen. It's not high priority.
  def dominant_culture_in(duchy, liege_culture)
    cultures = @map.cultures_in(duchy)
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
          culture = dominant_culture_in(duchy, @db.titles[liege][:culture])
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

  def allocate_title!(title, node, liege, start_date, end_date)
    case liege
    # Counts and dukes hold all land directly
    # 0 works but it does weird on campaign map
    when /\Ac_/
      node.add! start_date, PropertyList["liege", 0]
      raise "No lieges for #{liege}" unless holders[liege]
      add_holders! node, holders[liege], start_date, end_date
    when /\Ad_/
      node.add! start_date, PropertyList["liege", liege]
      raise "No lieges for #{liege}" unless holders[liege]
      add_holders! node, holders[liege], start_date, end_date
    else
      capital_duchy = @db.capital_duchy(liege)
      this_duchy    = @map.duchy_for_county(title)
      this_kingdom  = @map.landed_titles_lookup[title][-2]
      this_empire   = @map.landed_titles_lookup[title][-1]

      if capital_duchy == this_duchy
        add_holders! node, holders[liege], start_date, end_date
      # elsif liege == "e_britannia" and ["e_rajastan", "e_bengal", "e_deccan"].include?(this_empire)
      #   add_holders! node, regional_vassals(liege, this_kingdom), start_date, end_date
      # elsif this_kingdom != "k_delhi" and liege == "e_india"
      #   add_holders! node, regional_vassals(liege, this_kingdom), start_date, end_date
      else
        add_holders! node, regional_vassals(liege, this_duchy), start_date, end_date
      end
      node.add! start_date, PropertyList["liege", liege]
    end
  end

  def setup_county_history!(title, node)
    node.add! reset_date, PropertyList["liege", 0]
    node.add! reset_date, PropertyList["holder", @characters_reset.add_reset(title)]

    land = @db.county_ownership(title)
    land_start = land && land[0][0]

    unless land
      warn "No idea what to do with #{@map.landed_titles_lookup[title].reverse.join(" / ")}"
      return
    end
    if land_start > @db.min_date
      warn "History for #{@map.landed_titles_lookup[title].reverse.join(" / ")} only from #{land_start.to_s_px}"
    end

    land.size.times do |i|
      start_date, liege = land[i]
      end_date = land[i+1] && land[i+1][0]
      allocate_title!(title, node, liege, start_date, end_date)
    end
  end

  def setup_major_title_history!(title, node)
    if @map.landless_title?(title)
      case title
      when "e_golden_horde", "e_il-khanate"
        node.add! reset_date, PropertyList["liege", 0]
        node.add! reset_date, PropertyList["holder", 0]
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
        # OK
      end
    else
      node.add! reset_date, PropertyList["liege", 0]
      node.add! reset_date, PropertyList["holder", 0]
    end
  end

  def setup_title_history!
    # This is a silly trick of creating node if it doesn't exist, reusing it otherwise
    @db.titles.keys.each do |title|
      begin
        parse("history/titles/#{title}.txt")
      rescue
        create_mod_file! "history/titles/#{title}.txt", PropertyList[]
      end
    end

    glob("history/titles/*.txt").each do |path|
      title = path.basename(".txt").to_s
      patch_mod_file!(path) do |node|
        if title =~ /\Ab_/
          # Baronies not belonging to counties like partician houses can be ignored
          county = @map.landed_titles_lookup[title].find{|t| t =~ /\Ac_/}
          if county
            node.add! reset_date, PropertyList["liege", county]
          else
            node.add! reset_date, PropertyList["liege", 0]
          end
          node.add! reset_date, PropertyList["holder", 0]
        elsif title =~ /\Ac_/
          setup_county_history!(title, node)
        else
          setup_major_title_history!(title, node)
          add_holders!(node, holders[title]) if holders[title]
        end
        if @db.titles[title] and @db.titles[title][:liege]
          @db.titles[title][:liege].each do |date, liege|
            node.add! date, PropertyList["liege", liege || 0]
          end
        end
      end
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
        autoholders = @db.titles[title][:autoholders]
        if autoholders and @db.holders[title]
          warn "Title has holders but specified as automatic: #{title}"
        end
        unless @db.title_needs_extra_holders[title].empty?
          if autoholders
            # OK
          elsif @db.holders[title]
            warn "Needs more holders: #{title} #{@db.title_needs_extra_holders[title]}"
          else
            warn "Needs holders: #{title} #{@db.title_needs_extra_holders[title]}"
          end
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
      node["start_date"]      = @db.min_date
      node["last_start_date"] = @db.resolve_date(:today)
      node["end_date"]        = @db.resolve_date(:game_end)
    end
  end

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
    unless node.keys.all?{|k| k.is_a?(Date)}
      node.instance_eval do
        @list = @list.map do |k,v|
          case k
          when Date
            [k, v]
          when "1127.12."
            [Date.parse("1127.12.1"), v]
          else
            raise "Expected key to be a date, got: `#{k.inspect}'"
          end
        end
      end
    end
    node.instance_eval do
      @list = @list.select{|k,v| v != [] }.sort
    end
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
      end
    end
    # d_sunni is supposed to have priority over d_syria etc. (dignity=100) but it doesn't work.
    # Setting d_sunni as primary=true would completely ban creation of any high level titles
    # which is wrong as caliphs held kingdoms and empires.
    # So we'll just need to live with this bug.
  end

  # Some sensible baseline for everyone
  # TODO: Lower number of vassals India, UK, and Ottomans have so it's no longer necessary
  #       to give them imperial administration
  def setup_title_laws!
    glob("history/titles/[dke]_*.txt").each do |path|
      title = path.basename(".txt").to_s
      patch_mod_file!(path) do |node|
        laws = PropertyList[
          "vice_royalty", false,
          "law", "investiture_law_0",
          "law", "cognatic_succession",
        ]
        if title =~ /\A[ke]_/
          laws.add! "law", "crown_authority_1"
        end
        # Empire start decentralized, lower titles at medium
        if title =~ /\Ae_/
          laws.add! "law", "centralization_0"
        else
          laws.add! "law", "centralization_2"
        end
        if title == "e_britannia" or title == "e_seljuk_turks" or title == "e_india"
          laws.add! "law", "imperial_administration"
          laws.add! "law", "vice_royalty_0"
        end
        node.add! @db.resolve_date(:forever_ago), laws
        if title == "e_britannia"
          node.add! @db.resolve_date(:india_independence), PropertyList["law", "feudal_administration"]
        end
        if title == "e_seljuk_turks"
          node.add! @db.resolve_date(:end_ww1), PropertyList["law", "feudal_administration"]
        end
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
  # https://en.wikipedia.org/wiki/Karluk_languages
  # https://en.wikipedia.org/wiki/Kipchak_languages
  # uzbeks -> karluk
  # kazakhs -> cuman
  # tatars -> bolghar
  def setup_province_population!
    patch_mod_files!("history/provinces/*.txt") do |node|
      title = node["title"]
      changes = node.values.grep(PropertyList)
      culture  = [node["culture"], *changes.map{|v| v["culture"] }].compact.last
      religion = [node["religion"], *changes.map{|v| v["religion"] }].compact.last

      new_religion = @db.province_religion(title) || :keep
      new_culture  = @db.province_culture(title) || :keep

      if new_culture != culture and new_culture != :keep
        node.add! @db.resolve_date(:forever_ago), PropertyList["culture", new_culture]
      end
      if new_religion != religion and new_religion != :keep
        node.add! @db.resolve_date(:forever_ago), PropertyList["religion", new_religion]
      end
    end
  end

  def setup_nomad_flag!
    patch_mod_file!("history/titles/d_moldau.txt") do |node|
      node.add! @db.resolve_date(:forever_ago), PropertyList["historical_nomad", false]
    end
  end

  def setup_de_jure_map!
    @db.de_jure.each do |title, liege|
      patch_mod_file!("history/titles/#{title}.txt", autocreate: true) do |node|
        liege.each do |date, title|
          node.add! date, PropertyList["de_jure_liege", title]
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

  def setup_bookmarks!
    # Sadly can't be modded and first two are DLC-locked
    key_bookmarks = [
      ["BM_CHARLEMAGNE", "DARK_AGES"],
      ["BM_THE_OLD_GODS", "VIKING_ERA"],
      ["BM_FATE_OF_ENGLAND", "EARLY_MED_INFO"],
      ["BM_THE_MONGOLS", "HIGH_MED"],
      ["BM_100_YEARS_WAR", "LATE_MED"],
    ]

    bookmarks = [
      ### History files testing:
      ["1600.1.1", "Test 1600"],
      ["1648.10.24", "Peace of Westphalia"],
      ["1700.1.1", "Test 1700"],
      ["1750.1.1", "Test 1750"],
      ["1780.1.1", "Test 1780"],
      ["1815.6.9", "Congress of Vienna"],
      ["1818.6.3", "Fall of Marathas"],

      ### Actual bookmarks, must have 5 key bookmarks
      ["1837.6.20", "Victorian Era", true],
      ["1861.3.17", "Kingdom of Italy"],
      ["1871.1.18",  "German Empire", true],
      ["1900.1.1",   "New Century"],
      ["1914.6.28",  "The Great War"],
      ["1920.8.10",  "Treaty of Sevres", true],
      ["1939.8.31",  "The Greater War"],
      ["1945.5.8",   "Cold War", true],
      ["1975.1.1",   "Decolonization"],
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

  def setup_vassal_dukes!
    duchy_controllers = {}
    @regional_vassals.each do |(liege, duchy), vassals|
      # Don't use independent titles as vassals
      # This awkwardly doesn't recognize titles outside timeframe like d_venice
      next if @db.title_has_land[duchy]
      liege_duchy_control = @db.title_de_facto_control[duchy][liege]
      next unless liege_duchy_control
      vassals.size.times do |i|
        sd, sv = vassals[i]
        ed, ev = vassals[i+1]
        vassal_reign_dates = MultiRange.new([sd, ed])
        vassal_gets_duchy = vassal_reign_dates & liege_duchy_control
        next if vassal_gets_duchy.empty?
        vassal_gets_duchy.to_list.each do |sd, ed|
          duchy_controllers[duchy] ||= []
          duchy_controllers[duchy] << [sd, sv, liege]
          duchy_controllers[duchy] << [ed, 0, 0]
        end
      end
    end
    duchy_controllers.each do |title, vassals|
      vassals = vassals.sort.reverse.uniq(&:first).reverse
      patch_mod_file!("history/titles/#{title}.txt", autocreate: true) do |node|
        vassals.each do |date, id, liege|
          node.add! date, PropertyList["holder", id, "liege", liege]
        end
      end
    end
  end

  def setup_protestantism!
    %W[religion_icon_strip.dds religion_icon_strip_small.dds religion_icon_strip_big.dds].each do |name|
      create_file! "gfx/interface/#{name}", open("data/modern_times/#{name}", "rb", &:read)
    end
    generalstuff = ParadoxModFile.new(path: "data/vanilla/generalstuff.gfx").parse!
    generalstuff["spriteTypes"].find_all("spriteType").each do |data|
      next unless data["name"] =~ /\AGFX_religion_icon_strip/
      raise unless data["noOfFrames"] = 52
      data["noOfFrames"] = 54
    end
    create_mod_file! "interface/generalstuff.gfx", generalstuff

    create_mod_file! "history/titles/d_protestant.txt", PropertyList[
      Date.parse("0020.1.1"), PropertyList["active", false],
    ]
    create_file! "common/landed_titles/modern_times.txt",
    'd_protestant = {
      color={ 180 137 97 }
      color2={ 220 220 0 }
      capital = 333 # Rome
      title = "PROTESTANT_PRIMATE"
      foa = "POPE_FOA"
      short_name = yes
      # Always exists
      landless = yes
      # Controls a religion
      controls_religion = protestant
      religion = protestant
      # Cannot be held as a secondary title
      primary = yes
      dynasty_title_names = no # Will not be named "Seljuk", etc.
    }'
    create_mod_file! "common/religions/01_modern_times.txt", PropertyList[
      "christian", PropertyList[
        "protestant", PropertyList[
          "graphical_culture", "westerngfx",
          "icon", 53,
          "heresy_icon", 54,
          "color", [0.7, 0.7, 0.8],
          "crusade_name", "CRUSADE",
          "scripture_name", "THE_BIBLE",
          "priest_title", "PRIEST",
          "high_god_name", "GOD_GOD",
          "god_names", ["GOD_GOD", "GOD_THE_LORD", "GOD_JESUS", "GOD_THE_BLESSED_VIRGIN"],
          "evil_god_names", ["SATAN", "LUCIFER", "THE_DEVIL"],
          "autocephaly", true,
          "can_call_crusade", false,
          "can_grant_divorce", true,
          "priests_can_inherit", false,
          "priests_can_marry", true,
          "religious_clothing_head", 0,
          "religious_clothing_priest", 1,
        ],
        "reformed", PropertyList[
          "graphical_culture", "westerngfx",
          "icon", 53,
          "heresy_icon", 54,
          "color", [0.4, 0.4, 0.6],
          "crusade_name", "CRUSADE",
          "scripture_name", "THE_BIBLE",
          "priest_title", "PRIEST",
          "high_god_name", "GOD_GOD",
          "god_names", ["GOD_GOD", "GOD_THE_LORD", "GOD_JESUS", "GOD_THE_BLESSED_VIRGIN"],
          "evil_god_names", ["SATAN", "LUCIFER", "THE_DEVIL"],
          # Protestant Work Ethic
          "character_modifier", PropertyList["stewardship", 2],
          "priests_can_inherit", false,
          "priests_can_marry", true,
          "religious_clothing_head", 0,
          "religious_clothing_priest", 1,
          "parent", "protestant",
        ],
      ],
    ]
    localization! "modern_times_religions",
      "protestant" => "Protestant",
      "protestant_DESC" => "Lutheran/Anglican branch of Protestantism",
      "d_protestant" => "Ecumenical Primacy",
      "d_protestant_adj" => "Primatial",
      "PROTESTANT_PRIMATE" => "Ecumenical Primate",
      "reformed" => "Reformed",
      "reformed_DESC" => "Reformed/Calvinist branch of Protestantism"
  end

  def apply!
    @warnings = []

    @map = MapManager.new(self)
    @db = ModernTimesDatabase.new(self)

    setup_province_holdings!
    setup_province_population!
    setup_nomad_flag!
    setup_de_jure_map!
    setup_protestantism!

    @cultures = CultureManager.new(self)
    @characters_reset = CharacterManager.new(self, 100_000_000)
    @characters       = CharacterManager.new(self, 110_000_000)
    @regional_vassals = {}
    @dynasties        = {}
    setup_title_history!
    setup_title_names!
    setup_title_laws! # Run after other title history changes, to make sure any new titles get covered
    setup_vassal_dukes!
    save_characters!
    save_dynasties!
    patch_mod_files!("history/titles/*.txt") do |node|
      cleanup_history_node!(node)
    end

    @warnings.sort.each_with_index do |w,i|
      puts "% 3d %s" % [i+1,w]
    end

    # Order of transformations matters
    setup_technology!
    setup_bookmarks!
    setup_defines!
    change_localization!
  end
end

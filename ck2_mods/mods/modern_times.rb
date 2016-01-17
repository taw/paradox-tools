require "digest"
require_relative "../modern_times/database"

class Random
  def self.keyed(key)
    new(Digest::MD5.hexdigest(key).to_i(16))
  end
end

# No idea if anything will ever come out of this
class ModernTimesGameModification < CK2GameModification
  attr_reader :map, :character_manager, :db

  def reset_date
    @reset_date ||= @db.resolve_date(:reset_date)
  end

  def new_dynasty(name, culture)
    # Cultural overrides, many European royal dynasties were cross-cultural
    # I'm not even sure if it does anything
    case name
    when "Hesse", "Habsburg", "Wittelsbach", "Holstein-Gottorp"
      culture = "german"
    when "Bonaparte", "Bourbon"
      culture = "frankish"
    when "Schleswig-Holstein-Sonderburg-Glücksburg"
      culture = "danish"
    when "Windsor"
      culture = "english"
    when "Savoy"
      culture = "italian"
    when "Singh"
      culture = "panjabi"
    when "Hashemite", "Muhammad"
      culture = "bedouin_arabic"
    when "Saxe-Coburg and Gotha"
      culture = "dutch"
    when "Gikalo"
      # FIXME: This isn't even separate dynasties, just one vassal who got moved around Soviet Union a lot
      culture = "russian"
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
          id = @character_manager.add_ruler(
            culture: culture,
            religion: @db.titles[liege][:religion],
            female: :maybe,
            key: {
              crowning: s,
              title: duchy,
            },
          )
          @character_manager.generate_family!(id)
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
      this_duchy = @map.duchy_for_county(title)
      if @db.in_historical_demesne?(liege, title)
        add_holders! node, holders[liege], start_date, end_date
      else
        add_holders! node, regional_vassals(liege, this_duchy), start_date, end_date
      end
      node.add! start_date, PropertyList["liege", liege]
    end
  end

  def setup_county_history!(title, node)
    reset_character = @character_manager.create_reset_character(title)
    node.add! reset_date, PropertyList["liege", 0]
    node.add! reset_date, PropertyList["holder", reset_character]

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
      when "d_mamluks"
        node.add! @db.resolve_date(:times_immemorial), PropertyList[
          "liege", "e_arabia"
        ]
        node.add! @db.resolve_date(:end_of_ottoman_empire), PropertyList[
          "liege", "k_egypt"
        ]
      when "d_hashshashin"
        # We really want to resurrect assassins, dated at Iranian Revolution
        node.add! @db.resolve_date(:iranian_revolution), PropertyList[
          "active", true,
          "liege", "k_persia",
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

  def setup_barony!(title, node)
    county = @map.landed_titles_lookup[title].find{|t| t =~ /\Ac_/}
    # No actual holders, just set lieges and let game automatically fill in
    node.add! reset_date, PropertyList["holder", 0]
    if @db.land[title]
      # Holy order baronies need to be setup
      # But first, do a reset
      node.add! reset_date, PropertyList["liege", county]
      land = @db.land[title]
      land.size.times do |i|
        start_date, liege = land[i]
        end_date = land[i+1] && land[i+1][0]
        add_holders! node, holders[liege], start_date, end_date
      end
      # @db.land[title].each do |date, liege|
      #   node.add! date, PropertyList["liege", liege || 0]
      # end
    elsif county
      # Regular baronies are under county
      node.add! reset_date, PropertyList["liege", county]
    else
      # Baronies not belonging to counties like partician houses can be ignored
      node.add! reset_date, PropertyList["liege", 0]
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
          setup_barony!(title, node)
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
    create_mod_file! "history/characters/modern_times_throwaways.txt", @character_manager.reset_plist
    create_mod_file! "history/characters/modern_times.txt", @character_manager.main_plist
  end

  # This only generates warnings, it doesn't affect execution
  def check_if_automatic_holders_ok!(title)
    autoholders = @db.titles[title][:autoholders]
    no_holders  = (@db.holders[title] || {}).empty?
    has_holders         = autoholders & @db.title_has_holder[title]
    needs_extra_holders = @db.title_needs_extra_holders[title]

    case autoholders
    when true
      warn "Title has holders but specified as automatic: #{title}" unless no_holders
    when false
      unless needs_extra_holders.empty?
        if no_holders
          warn "Needs holders: #{title} #{needs_extra_holders}"
        else
          warn "Needs more holders: #{title} #{needs_extra_holders}"
        end
      end
    else # Sometimes - generally for titles which was autovassal for a while, then became independent
      unless (has_holders & autoholders).empty?
        warn "Has holders where autoholders are specified: #{has_holders & autoholders}"
      end
      unless (needs_extra_holders - autoholders).empty?
        warn "Needs extra holders outside autoholders range: #{needs_extra_holders - autoholders}"
      end
    end
  end

  # TODO: move most of it to Database class
  def holders
    unless @holders
      @holders  = {}
      @db.titles.each do |title, data|
        rng = Random.keyed("vassal terms: #{title}")
        title    = title
        holders  = @db.holders[title] || {}
        check_if_automatic_holders_ok!(title)
        unless @db.title_needs_extra_holders[title].empty?
          @db.title_needs_extra_holders[title].to_list.each do |s,e|
            xe = e || @db.resolve_date(:title_holders_until)
            while true
              holders[s] = {
                culture: data[:culture],
                religion: data[:religion],
                female: :maybe,
              }
              s += rng.rand(5*365..20*365) # start at 25..40, term 5..20, end at 30..60
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
            id = @character_manager.lookup_character_id(holder[:use]).id
            @holders[title] << [date, id]
          else
            id = @character_manager.add_ruler(holder.merge(key: {
              crowning: date,
              title: title,
            }))
            @character_manager.generate_family!(id) unless title == "k_papal_state"
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
    duchies = []
    patch_mod_files!("history/technology/*.txt") do |node|
      # Could get them from map, just sanity check to get them here
      duchies += node.find_all("technology").map{|x| x["titles"]}.flatten
      node.delete_if{true}
    end

    tech_groups = {}

    duchies.sort.each do |title|
      tech_levels = @db.title_technology(title)
      if tech_levels
        (tech_groups[tech_levels] ||= []) << title
      else
        warn "No tech for #{title} - #{map.landed_titles_lookup[title]}"
      end
    end

    plist = tech_groups.sort.map do |(m1,e1,c1,m2,e2,c2,m3,e3,c3), titles|
      Property["technology", PropertyList[
          "titles", titles,
          1700, PropertyList[
            "military", m1,
            "economy", e1,
            "culture", c1,
          ],
          1900, PropertyList[
            "military", m2,
            "economy", e2,
            "culture", c2,
          ],
          2016, PropertyList[
            "military", m3,
            "economy", e3,
            "culture", c3,
          ],
        ]
      ]
    end

    create_mod_file! "history/technology/modern_times.txt", PropertyList[*plist]

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
        if title == "e_britannia" or title == "e_arabia" or title == "e_india"
          laws.add! "law", "imperial_administration"
          laws.add! "law", "vice_royalty_0"
        end
        # Secondary same-level titles all need to go here :-/
        if title == "e_india" or title == "k_norway"
          laws.add! "law", "succ_primogeniture"
        end
        node.add! @db.resolve_date(:forever_ago), laws
        if title == "e_britannia"
          node.add! @db.resolve_date(:india_independence), PropertyList["law", "feudal_administration"]
        end
      end
    end
    create_mod_file! "common/on_actions/10_modern_times.txt", PropertyList[
      "on_chronicle_start", PropertyList[
        "events", ["modern_times_setup.1"],
      ],
    ]
    create_mod_file! "events/modern_times_setup.txt", PropertyList[
      "namespace", "modern_times_setup",
      # Trigger
      "character_event", PropertyList[
        "id", "modern_times_setup.1",
        "hide_window", true,
        "is_triggered_only", true,
        "only_rulers", true,
        "trigger", PropertyList["ai", false],
        "immediate", PropertyList[
          "character_event", PropertyList["id", "modern_times_setup.11"],
          # Player is exempt from content law
          # "character_event", PropertyList["id", "modern_times_setup.12"],
          "character_event", PropertyList["id", "modern_times_setup.13"],
          "any_playable_ruler", PropertyList[
            "character_event", PropertyList["id", "modern_times_setup.11"],
            "character_event", PropertyList["id", "modern_times_setup.12"],
            "character_event", PropertyList["id", "modern_times_setup.13"],
          ],
        ],
      ],
      # Law setup
      "character_event", PropertyList[
        "id", "modern_times_setup.11",
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
      # Indian vassals should be content by law of British Empire
      # This just delays rebellion a generation, but that's exactly what we want
      "character_event", PropertyList[
        "id", "modern_times_setup.12",
        "hide_window", true,
        "is_triggered_only", true,
        "only_rulers", true,
        "trigger", PropertyList[
          "tier", "KING",
          "top_liege", PropertyList["primary_title", PropertyList["title", "e_britannia"]],
        ],
        "immediate", PropertyList[
          "add_trait", "content",
          "remove_trait", "zealous",
        ],
      ],
      "character_event", PropertyList[
        "id", "modern_times_setup.13",
        "hide_window", true,
        "is_triggered_only", true,
        "only_rulers", true,
        "trigger", PropertyList[
          "independent", true,
        ],
        "immediate", PropertyList[
          "if", PropertyList[
            "limit", PropertyList["tier", "EMPEROR"],
            "wealth", 2000,
          ],
          "if", PropertyList[
            "limit", PropertyList["tier", "KING"],
            "wealth", 1000,
          ],
        ],
      ],
    ]
  end

  # We need to remove county-level bishops as game will make them duchy-level bishops
  # with current automatic vassal creation system
  # Might get them back if we switch to a different system
  def setup_province_holdings!(node)
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
          holdings.delete(vv) if kk == "remove_settlement"
        end
      end
    end

    # If a tribe, we really don't care
    return if holdings[capital] == "tribal"

    add_me = node["max_settlements"] - holdings.size
    if add_me < 0
      # warn "#{title} has #{holdings.size} holdings but only #{node["max_settlements"]} slots"
      holdings_to_add = []
    else
      holdings_to_add = (map.baronies_in[title] - holdings.keys)[0, add_me]
    end

    # optimal_order = ["castle", "city", "temple", "castle", "city", "castle", "city"]
    until holdings_to_add.empty?
      if holdings.values.count("castle") == 0
        type = "castle"
      elsif holdings.values.count("city") == 0
        type = "city"
      elsif holdings.values.count("temple") == 0
        type = "temple"
      elsif holdings.values.count("castle") > holdings.values.count("city")
        type = "city"
      else
        type = "castle"
      end

      barony = holdings_to_add.shift
      node.add! @db.resolve_date(:forever_ago), PropertyList[barony, type]
      holdings[barony] = type
    end

    return if title == "c_roma"
    first_castle = holdings.keys.find{|c| holdings[c] == "castle"}
    first_city   = holdings.keys.find{|c| holdings[c] == "city"}

    if holdings[capital] == "temple" or ["c_pskov", "c_novgorod"].include?(title)
      if first_castle
        node.add! @db.resolve_date(:forever_ago), PropertyList["capital", first_castle]
      else
        # warn "No castle in #{title}"
      end
    elsif %W[c_firenze c_siena c_theodosia c_bologna c_schwyz c_methone].include?(title)
      if first_castle
        node.add! @db.resolve_date(:forever_ago), PropertyList["capital", first_castle]
      else
        warn "No castle in #{title}"
      end
    elsif %W[c_provence c_hamburg c_danzig c_pisa c_gloucester c_coruna].include?(title)
      if first_city
        node.add! @db.resolve_date(:forever_ago), PropertyList["capital", first_city]
      else
        warn "No city in #{title}"
      end
    # Check and it's good
    # elsif holdings[capital] == "city"
    #   warn "#{@map.landed_titles_lookup[title].reverse.join(" / ")} is city, should it be?"
    end
  end

  def setup_provinces_holdings!
    patch_mod_files!("history/provinces/*.txt") do |node|
      setup_province_holdings!(node)
    end
  end

  # 14th century map is mostly reasonable, but there's a bit of crazy we need to fix
  # https://en.wikipedia.org/wiki/Karluk_languages
  # https://en.wikipedia.org/wiki/Kipchak_languages
  # uzbeks -> karluk
  # kazakhs -> cuman
  # tatars -> bolghar
  def setup_provinces_population!
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
      ["BM_FATE_OF_ENGLAND", "EARLY_MED"],
      ["BM_THE_MONGOLS", "HIGH_MED"],
      ["BM_100_YEARS_WAR", "LATE_MED"],
    ]

    # Bookmark tags are unfortunately magical
    patch_mod_file!("common/bookmarks/00_bookmarks.txt") do |node|
      node.delete_if{true}
      @db.bookmarks.each do |date, bookmark|
        next unless date >= @db.min_date
        name = bookmark[:name]
        desc = bookmark[:desc] || ""
        if bookmark[:key]
          raise "Too many key bookmarks" if key_bookmarks.empty?
          bm_code, splash_code = key_bookmarks.shift
        else
          bm_code, splash_code = date.strftime("BM_%Y_%m_%d"), nil
        end
        bm_desc = "#{bm_code}_DESC"
        bookmark_node = PropertyList[
          "name", bm_code,
          "desc", bm_desc,
          "date", date,
        ]
        if bookmark[:characters]
          bookmark[:characters].each do |title|
            _, ruler_id = @holders[title].select{|d,id| d<=date}[-1]
            unless ruler_id
              warn "No ruler of #{title} at #{date} but marked as key character"
              require 'pry'; binding.pry
            end
            bookmark_node.add! "character", ruler_id
          end
        end
        node.add! "bookmard", bookmark_node

        localization!("ZZ vanilla overrides",
          bm_code => name,
          bm_desc => desc,
        )
        if splash_code
          localization!("ZZ vanilla overrides",
            splash_code => name,
            "#{splash_code}_INFO" => desc,
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

  def move_de_jure_capitals!
    patch_mod_file!("common/landed_titles/landed_titles.txt") do |node|
      @db.titles.each do |title, title_data|
        actual_capital  = title_data[:capital]
        de_jure_capital = map.title_capitals[title]
        next if actual_capital == de_jure_capital
        next unless de_jure_capital
        title_node = @map.landed_titles_lookup[title].reverse.inject(node){|n,t| n[t]}
        title_node["capital"] = @map.title_to_province_id[actual_capital]
      end
    end
  end

  def mexican_invasion!
    patch_mod_file!("events/sunset_invasion.txt") do |node|
      province_events = node.find_all("province_event")
      # Minimum date
      province_events.each do |ev|
        ev["trigger"]["year"] = 1890
      end
      # Increase chance at date
      province_events[0]["mean_time_to_happen"]["modifier"]["year"] = 1940
      # Max date
      province_events[0]["trigger"]["NOT"]["year"] = 1990
    end
  end

  def canada_invasion!
    # TODO: kingdom/empire level country, not rebel? [?]

    leader = CanadaInvasionEvents.find_all("province_event")[0]["immediate"]["k_papal_state"]["holder_scope"]["create_random_soldier"]
    leader["dynasty"] = new_dynasty("Harper", "canadian")

    create_mod_file!("events/modern_times_canada_invasion.txt", CanadaInvasionEvents)
    localization!("canada_invasion",
      "EVTDESC_CANADA_001" => "Canadian envoys arrive on important diplomatic mission",
      "EVTOPTA_CANADA_001" => "Such nice and polite people",

      "EVTNAME_CANADA_002" => "Strangers from Beyond the Sea",
      "EVTDESC_CANADA_002" => "Canadian embassy declares whole Arctic as Canadian, threatens severe consequences to any European country wishing to challenge this claim.",
      "EVTOPTA_CANADA_002" => "I'm sure this will get resolved peacefully somehow",

      "EVTDESC_CANADA_003" => "With no agreement on Arctic ownership, Canadians decided to launch surprise attack on Europe",
      "EVTOPTA_CANADA_003" => "We'll push them back into the cold ocean!",

      "EVTNAME_CANADA_004" => "Canadian Invasion",
      "EVTDESC_CANADA_004" => "Thousands of exotic ships have arrived in [From.SeaZone.GetName], spewing out numberless hordes of mounted policemen - some rumored to ride moose and use hockey sticks as lances. These invaders from beyond the sunset will kill everyone standing in their way, but at least they'll do it politely...",
      "EVTOPTA_CANADA_004" => "[This.Religion.GetRandomGodNameCap] have Mercy!",

      "EVTDESC_CANADA_005" => "A forest of sails has appeared on the horizon - the terrible Canadian scourge has reached our shores!",
      "EVTOPTA_CANADA_005" => "Saddle my Horse!",

      "EVTNAME_CANADA_006" => "Canadian Invasion",
      "EVTDESC_CANADA_006" => "Another huge fleet of the bloodthirsty Canadians has been sighted in [From.SeaZone.GetName]. The populace is fleeing in fear.",
      "EVTOPTA_CANADA_006" => "[This.Religion.GetRandomGodNameCap] have Mercy!",

      "EVTNAME_CANADA_105" => "The Canadians Meet With Defeat",
      "EVTDESC_CANADA_105" => "The great Canadian warhost that crossed the ocean in their mad bid to claim all the Artcic riches has been thrown back into the sea. Their colonies have been lost and their armies vanquished. The pitiful remnants of their invasion force has set sail back towards their homeland of Toronto to lick their wounds and inform the Canadian Emperor of their defeat.\\n\\nThere may come a time when their own shores are visited by fleets from the Old World, and when that happens the debt they have incurred with their former victims will no doubt be collected in full... with interest.",
      "EVTOPTA_CANADA_105" => "There shall be a reckoning.",
    )
  end

  def brazil_invasion!
    # TODO: kingdom/empire level country only as target, not rebel? [?]
    #       not France / UK ? (Gibraltar / Goa taken by Brits are both silly to invade early)

    context = BrazilInvasionEvents.find_all("province_event")[0]["immediate"]["k_papal_state"]["holder_scope"]
    context["create_random_soldier"]["dynasty"] = new_dynasty("Braganza", "portuguese")
    context["new_character"].add! "add_claim", "k_portugal"
    context["new_character"].add! "add_claim", "c_goa"

    create_mod_file!("events/modern_times_brazil_invasion.txt", BrazilInvasionEvents)

    localization!("canada_invasion",
      "EVTDESC_BRAZIL_001" => "Envoys from Emperor of Brazil arrive on important diplomatic mission",
      "EVTOPTA_BRAZIL_001" => "They have kings and emperors on the other side of Atlantic as well?",

      "EVTNAME_BRAZIL_002" => "Strangers from Beyond the Sea",
      "EVTDESC_BRAZIL_002" => "Emperor of Brazil presents his dynastic claim to throne of Portugal, and all lands which were ever Portuguese, and demands immediate answer",
      "EVTOPTA_BRAZIL_002" => "Don't we have enough succession crises in Europe?",

      "EVTDESC_BRAZIL_003" => "With the Portuguese showing little interest in accepting Brazilian claims, Empire of Brazil declares war!",
      "EVTOPTA_BRAZIL_003" => "We'll push them back into the cold ocean!",
      "EVTNAME_BRAZIL_004" => "Brazilian Invasion",

      "EVTDESC_BRAZIL_004" => "Thousands of exotic ships have arrived in [From.SeaZone.GetName], spewing out numberless hordes of soldiers fanatically dedicated to Brazilian emperor, who will stop at nothing less than total subjugation of his ancestral lands and who know what else.",
      "EVTOPTA_BRAZIL_004" => "[This.Religion.GetRandomGodNameCap] have Mercy!",

      "EVTDESC_BRAZIL_005" => "A forest of sails has appeared on the horizon - the terrible Brazilian scourge has reached our shores!",
      "EVTOPTA_BRAZIL_005" => "Saddle my Horse!",
      "EVTNAME_BRAZIL_006" => "Brazilian Invasion",
      "EVTDESC_BRAZIL_006" => "Another huge fleet of the bloodthirsty Brazilians has been sighted in [From.SeaZone.GetName]. The populace is fleeing in fear.",
      "EVTOPTA_BRAZIL_006" => "[This.Religion.GetRandomGodNameCap] have Mercy!",

      "EVTNAME_BRAZIL_105" => "The Brazilians Meet With Defeat",
      "EVTDESC_BRAZIL_105" => "The great Brazilian warhost that crossed the ocean in their mad bid to press their illegitimate dynastic claims has been thrown back into the sea. Their colonies have been lost and their armies vanquished. The pitiful remnants of their invasion force has set sail back towards their homeland of Rio de Janeiro to lick their wounds and inform the Brazilian Emperor of their defeat.\\n\\nThere may come a time when their own shores are visited by fleets from the Old World, and when that happens the debt they have incurred with their former victims will no doubt be collected in full... with interest.",
      "EVTOPTA_BRAZIL_105" => "There shall be a reckoning.",
    )
  end

  def usa_invasion!
    # TODO: kingdom/empire level country only as target, not rebel? [?]
    #       is Lebanon OK as duchy? probably not
    #       muslim target only

    leader = UsaInvasionEvents.find_all("province_event")[0]["immediate"]["k_papal_state"]["holder_scope"]["create_random_soldier"]
    leader["name"] = "Richard"
    leader["dynasty"] = new_dynasty("Cheney", "american")

    create_mod_file!("events/modern_times_america_invasion.txt", UsaInvasionEvents)

    localization!("canada_invasion",
      "EVTDESC_USA_001" => "Envoys from United States arrive on important diplomatic mission with message of democracy",
      "EVTOPTA_USA_001" => "What is this democracy thing? I thought it died out in ancient Greece...",

      "EVTNAME_USA_002" => "Strangers from Beyond the Sea",
      "EVTDESC_USA_002" => "American envoys demand installation of democracy and immediate ending of all Weapons of Mass Destruction development",
      "EVTOPTA_USA_002" => "Weapons of Mass what? No such thing exists in Modern Times...",

      "EVTDESC_USA_003" => "Not giving much time for diplomacy, Americans decided to advance case for democracy and WMD-free world by force!",
      "EVTOPTA_USA_003" => "We'll push them back into the cold ocean!",

      "EVTNAME_USA_004" => "American Invasion",
      "EVTDESC_USA_004" => "Thousands of exotic ships have arrived in [From.SeaZone.GetName], spewing out numberless hordes of marines in heavy gear. Whatever those Weapons of Mass Destruction they were looking for might be, it is pretty clear destruction they're going to bring to anyone standing in their way will be mass enough.",
      "EVTOPTA_USA_004" => "[This.Religion.GetRandomGodNameCap] have Mercy!",

      "EVTDESC_USA_005" => "A forest of sails has appeared on the horizon - the terrible American scourge has reached our shores!",
      "EVTOPTA_USA_005" => "Saddle my Horse!",

      "EVTNAME_USA_006" => "American Invasion",
      "EVTDESC_USA_006" => "Another huge fleet of the bloodthirsty Americans has been sighted in [From.SeaZone.GetName]. The populace is fleeing in fear.",
      "EVTOPTA_USA_006" => "[This.Religion.GetRandomGodNameCap] have Mercy!",

      "EVTNAME_USA_105" => "The Americans Meet With Defeat",
      "EVTDESC_USA_105" => "The great Aztec warhost that crossed the ocean in their mad bid to spread so called democracy has been thrown back into the sea. Their colonies have been lost and their armies vanquished. The pitiful remnants of their invasion force has set sail back towards their homeland of Washington to lick their wounds and inform the American Emperor of their defeat.\\n\\nThere may come a time when their own shores are visited by fleets from the Old World, and when that happens the debt they have incurred with their former victims will no doubt be collected in full... with interest.",
      "EVTOPTA_USA_105" => "There shall be a reckoning.",
    )
  end

  def setup_cbs_for_new_invasions!
    patch_mod_file!("common/cb_types/00_cb_types.txt") do |node|
      # Should probably use better CB, but will do for now
      tribal_invasion = node["tribal_invasion"]

      # Culture/religion convert target province on successful invasion
      target_effects = tribal_invasion["on_success_title"]["custom_tooltip"]["hidden_tooltip"]
      target_effects.add! "if", PropertyList[
        "limit", PropertyList["e_canada", PropertyList["holder", "ROOT"]],
        "ROOT", PropertyList["any_realm_province", PropertyList[
          "limit", PropertyList["OR", PropertyList[
            "has_province_flag", "canadian_explorers",
            "has_province_flag", "canadian_second_wave",
          ]],
          "culture", "canadian",
          "religion", "protestant",
          "clr_province_flag", "canadian_explorers",
          "clr_province_flag", "canadian_second_wave",
        ]],
      ]
      target_effects.add! "if", PropertyList[
        "limit", PropertyList["e_united_states", PropertyList["holder", "ROOT"]],
        "ROOT", PropertyList["any_realm_province", PropertyList[
          "limit", PropertyList["OR", PropertyList[
            "has_province_flag", "american_explorers",
            "has_province_flag", "american_second_wave",
          ]],
          "culture", "american",
          "religion", "protestant",
          "clr_province_flag", "american_explorers",
          "clr_province_flag", "american_second_wave",
        ]],
      ]
      target_effects.add! "if", PropertyList[
        "limit", PropertyList["e_brazil", PropertyList["holder", "ROOT"]],
        "ROOT", PropertyList["any_realm_province", PropertyList[
          "limit", PropertyList["OR", PropertyList[
            "has_province_flag", "brazilian_explorers",
            "has_province_flag", "brazilian_second_wave",
          ]],
          "culture", "brazilian",
          "religion", "catholic",
          "clr_province_flag", "brazilian_explorers",
          "clr_province_flag", "brazilian_second_wave",
        ]],
      ]

      # CBs
      vanilla_cb, not_same_realm = tribal_invasion["can_use_title"].find_all("ROOT")
      tribal_invasion["can_use_title"] = PropertyList[
        "OR", PropertyList[
          "ROOT", PropertyList["has_landed_title", "e_brazil"],
          "ROOT", PropertyList["has_landed_title", "e_canada"],
          "ROOT", PropertyList["has_landed_title", "e_united_states"],
          "ROOT", vanilla_cb,
        ],
        "ROOT", not_same_realm,
      ]
    end
  end

  def fix_russia_colors!
    # Empire of Russia has color of Ukraine, make it have color of Muscovy
    patch_mod_file!("common/landed_titles/landed_titles.txt") do |node|
      node["e_russia"]["color"] = node["e_russia"]["k_rus"]["color"]
    end
  end

  def initialize_empty_title_histories!
    @db.land.each do |title, _|
      patch_mod_file!("history/titles/#{title}.txt", autocreate: true) do |node|
      end
    end
  end

  def create_new_titles!
    create_mod_file! "common/landed_titles/modern_times_landed.txt", PropertyList[
      "e_united_states", PropertyList[
        "color", [30, 120, 220],
        "color2", [255, 255, 0],
        "short_name", "yes",
        "landless", true,
        "culture", "american",
        "religion", "protestant",
      ],
      "e_canada", PropertyList[
        "color", [240, 120, 70],
        "color2", [255, 255, 255],
        "landless", true,
        "culture", "canadian",
        "religion", "protestant",
      ],
      "e_brazil", PropertyList[
        "color", [255, 240, 200],
        "color2", [255, 255, 255],
        "landless", true,
        "culture", "brazilian",
        "religion", "catholic",
      ],
      "k_belarus", PropertyList[
        "color", [75, 125, 6], # same as Vitebsk
        "color2", [255, 255, 255],
        "culture", "belarusian",
        "religion", "orthodox",
      ],
    ]
    ["e_united_states", "e_canada", "e_brazil", "k_belarus"].each do |title|
      create_mod_file! "history/titles/#{title}.txt", PropertyList[
        Date.parse("0020.1.1"), PropertyList["active", false, "law", "succ_primogeniture"],
      ]
      create_file! "gfx/flags/#{title}.tga", open("data/flags/#{title}.tga", "rb", &:read)
    end
    localization! "modern_times_new_titles",
      "e_united_states" => "United States",
      "e_united_states_adj" => "American",
      "e_canada" => "Canada",
      "e_canada_adj" => "Canadian",
      "e_brazil" => "Brazil",
      "e_brazil_adj" => "Brazilian",
      "k_belarus" => "Belarus",
      "k_belarus_adj" => "Belarusian"
  end

  def apply!
    @warnings = []

    @map = MapManager.new(self)
    @db = ModernTimesDatabase.new(self)

    create_new_titles!
    setup_provinces_holdings!
    setup_provinces_population!
    setup_nomad_flag!
    setup_de_jure_map!

    @cultures = CultureManager.new(self)
    @character_manager = CharacterManager.new(self)
    @regional_vassals = {}
    @dynasties        = {}
    initialize_empty_title_histories!
    setup_title_history!
    setup_title_names!
    setup_vassal_dukes!
    save_characters!
    move_de_jure_capitals!
    mexican_invasion!
    canada_invasion!
    brazil_invasion!
    usa_invasion!
    setup_cbs_for_new_invasions!
    save_dynasties!
    fix_russia_colors!
    patch_mod_files!("history/titles/*.txt") do |node|
      cleanup_history_node!(node)
    end
    setup_title_laws! # Run after other title history changes, to make sure any new titles get covered

    code_warnings!
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

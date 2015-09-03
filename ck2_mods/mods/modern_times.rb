require_relative "modern_times_data.rb"

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

  def new_throwaway_character
    id = @characters_throwaway.size + 10_000_000
    @characters_throwaway.add! id, PropertyList[
      "name", "Bob",
      "religion", "cathar",
      "culture", "bohemian",
      Date.parse("1700.1.1"), PropertyList["birth", Date.parse("1700.1.1")],
      Date.parse("1701.1.1"), PropertyList["death", Date.parse("1701.1.1")],
    ]
    id
  end

  def add_holders!(node, holders)
    holders.each do |date, id|
      node.add! date, PropertyList["holder", id]
    end
  end

  def setup_county_history!(title, node)
    node.add! Date.parse("1500.1.1"), PropertyList["liege", 0]
    node.add! Date.parse("1500.1.1"), PropertyList["holder", new_throwaway_character]

    land = landed_titles_lookup[title].map{|t| @land[t]}.find(&:itself)

    unless land
      # This is really a bug, warn here once we get nontrivial amount of land covered
      puts "No idea what to do with #{landed_titles_lookup[title].reverse.join(" / ")}"
      return
    end

    land.each do |date, liege|
      if liege == @capitals[title]
        add_holders! node, @holders[@capitals[title]]
      end
      if liege =~ /\Ac_/
        node.add! date, PropertyList["liege", 0]
      else
        node.add! date, PropertyList["liege", liege]
      end
    end
  end

  def setup_major_title_history!(title, node)
    node.add! Date.parse("1500.1.1"), PropertyList["liege", 0]
    node.add! Date.parse("1500.1.1"), PropertyList["holder", 0]
    add_holders! node, @holders[title] if @holders[title]
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
    create_mod_file! "history/characters/modern_times_throwaways.txt", @characters_throwaway
    create_mod_file! "history/characters/modern_times.txt", @characters
  end

  def resolve_date(date)
    return nil unless date
    return date if date.is_a?(Date)
    if date.is_a?(Symbol)
      raise "No date #{date.inspect}" unless ModernTimes::DATES[date]
      date = ModernTimes::DATES[date]
    end
    Date.parse(date)
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
          @culture_names[name] = culture["male_names"].map{|n| n.sub(/_.*/, "")}
        end
      end
    end
    @culture_names
  end

  def culture_specific_name(culture)
    culture_names[culture][0]
  end

  def preprocess_data!
    # ModernTimes module holds data in format convenient for human writing,
    # it needs to be converted to something sensibler
    preprocess_land_mapping!
    preprocess_time_active!

    @capitals = {}
    @holders  = {}
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
      holders  = data[:holders]
      unless holders
        unless @time_active[title]
          raise "Title #{title} is not active in any era. You need to specify its holders manually in such case"
        end
        holders = []
        # We need to break long strethes of time into 20 year fragments
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

      @capitals[capital] = title
      @holders[title] = []
      @seen_title = {}
      holders.each do |date, holder|
        date  = resolve_date(date)
        if holder.nil?
          @holders[title] << [date, 0]
          next
        end
        birth = resolve_date(holder[:birth]) || (date << 12*35)
        death = resolve_date(holder[:death])
        culture = (holder[:culture] || culture).to_s
        religion = (holder[:religion] || religion).to_s
        name = holder[:name] || culture_specific_name(culture)
        character = PropertyList[
          "name", name,
          "religion", religion,
          "culture", culture,
          birth, PropertyList["birth", birth],
        ]
        character.add! death, PropertyList["death", death] if death
        character.add! "female", true if holder[:female]

        id = @characters.size + 11_000_000
        @characters.add! id, character

        @holders[title] << [date, id]
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

  def apply!
    # TODO:
    # - province religions
    # - province cultures
    # - characters leading major empires
    # - etc.
    #
    # Merge back all manual files

    @characters_throwaway = PropertyList[]
    @characters = PropertyList[]
    preprocess_data!
    setup_province_history!
    save_characters!
    setup_defines!
    setup_bookmarks!
    setup_technology!
  end
end

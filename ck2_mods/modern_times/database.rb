class ModernTimesDatabase
  # builder currently used read only to get to MapManager
  def initialize(builder)
    @builder = builder
  end

  def min_date
    if ENV["DEBUG_HISTORY"]
      @min_date ||= Date.parse(ENV["DEBUG_HISTORY"])
    else
      @min_date ||= resolve_date("1818.6.3")
    end
  end

  def title_de_facto_control
    unless @title_de_facto_control
      @title_de_facto_control = {}
      max_date = resolve_date(:title_holders_until)

      control = {}
      map.landed_titles_lookup.each do |county, path|
        next unless county =~ /\Ac_/
        ownership = county_ownership(county)
        ownership.size.times do |i|
          start_date, start_owner = ownership[i]
          end_date, = ownership[i+1]
          path[1..-1].each do |title|
            (control[title] ||= []) << [start_owner, start_date, end_date || max_date]
          end
        end
      end
      control.each do |title, points|
        dates = control[title].map{|t,s,e| [s,e]}.flatten(1).uniq.sort
        county_counts_by_date_range = {}
        (dates.size-1).times do |i|
          start_date = dates[i]
          end_date   = dates[i+1]
          points.each do |liege, s, e|
            if e > start_date and start_date >= s
              county_counts_by_date_range[[start_date, end_date]] ||= Hash.new(0)
              county_counts_by_date_range[[start_date, end_date]][liege] += 1
            end
          end
        end
        title_size = map.counties_in[title].size
        control_ranges = {}
        county_counts_by_date_range.each do |(sd,ed), ctl|
          t,c = ctl.sort_by(&:last)[-1]
          next unless c > title_size/2.0
          control_ranges[t] ||= MultiRange.new
          control_ranges[t] += MultiRange.new(sd..ed)
        end
        @title_de_facto_control[title] = control_ranges
      end
    end
    @title_de_facto_control
  end

  def land
    unless @land
      @land = {}
      ModernTimesDatabase::LAND.merge(holy_orders).each do |title, ownership|
        ownership = ownership.map{|k,v| [[min_date, resolve_date(k)].max, v.to_s] }
        # Strip changes which happened before start of game
        while ownership.size >= 2 and ownership[1][0] == ownership[0][0] and ownership[0][0] == min_date
          ownership.shift
        end
        # Anything else weird is a bug
        unless ownership.map(&:first).each_cons(2).all?{|a,b| a < b}
          raise "Ownership of #{title} is inconsistent"
        end
        @land[title.to_s] = ownership.reverse.uniq(&:first).reverse
      end
    end
    @land
  end

  # It's backwards compared with land, should it be?
  def holy_orders
    unless @holy_orders
      @holy_orders = {}
      ModernTimesDatabase::HOLY_ORDERS.each do |holy_order, counties|
        if holy_order.is_a?(String)
          holy_order = {times_immemorial: holy_order}
        end
        counties.each do |county|
          capital, holdings = map.analyze_province_holdings(county)
          first_minor_castle = holdings.keys.find{|barony| holdings[barony] == "castle" and barony != capital }
          @holy_orders[first_minor_castle] = holy_order
        end
      end
    end
    @holy_orders
  end

  def titles
    unless @titles
      @titles = {}
      ModernTimesDatabase::TITLES.each do |title, data|
        title = title.to_s
        @titles[title] = {}
        extra_keys = data.keys - %i[culture religion capital name liege autoholders demesne male]
        raise "Extra keys: #{extra_keys}" unless extra_keys.empty?
        raise "Culture must be specified for every title: #{title}" unless data[:culture]
        raise "Religion must be specified for every title: #{title}" unless data[:religion]

        capital = if data[:capital]
          data[:capital].to_s
        elsif title =~ /\Ac_/
          title
        else
          map.title_capitals[title] or raise "Can't autodetect capital for #{title}"
        end

        if data[:demesne] and title !~ /\A[ke]_/
          warn "Only king/emperor level titles should have demesne specified: #{title}"
        end

        demesne = [map.duchy_for_county(capital)] + (data[:demesne] || []).map(&:to_s)

        if data[:name]
          names = data[:name]
          names = {forever_ago: names} if names.is_a?(String)
          names = names.map{|d,n| [resolve_date(d), n] }
        else
          names = nil
        end

        autoholders = data[:autoholders]
        if autoholders.is_a?(Array)
          autoholders = MultiRange.new(*autoholders.map{|range| [resolve_date(range.begin), resolve_date(range.end)]})
        else
          autoholders = !!autoholders
        end

        @titles[title] = {
          culture: data[:culture].to_s,
          religion: data[:religion].to_s,
          autoholders: autoholders,
          capital: capital,
          demesne: demesne,
          liege: data[:liege] && data[:liege].map{|d,n| [resolve_date(d), n] },
          name: names,
          male: !!data[:male],
        }
      end
    end
    @titles
  end

  def holders
    unless @holders
      @holders = {}
      ModernTimesDatabase.constants.grep(/\AHOLDERS_/).each do |holder_group_key|
        ModernTimesDatabase.const_get(holder_group_key).each do |title, data|
          title = title.to_s
          @holders[title] = {}
          data = data.to_a
          data.each_with_index do |(date, holder_data), i|
            date = resolve_date(date)
            if holder_data.nil?
              @holders[title][date] = nil
            elsif holder_data.keys == [:use]
              @holders[title][date] = {use: fully_quality_reference(title, holder_data[:use])}
            elsif holder_data.keys == [:use_all]
              next_date = data[i+1] && resolve_date(data[i+1][0])
              @holders[holder_data[:use_all]].each do |copy_date, holder|
                break if next_date and copy_date >= next_date
                @holders[title][copy_date] = {use: holder[:historical_id]}
              end
            else
              @holders[title][date] = parse_holder_data(date, holder_data, title)
            end
          end
        end
      end
      validate_holders!
    end
    @holders
  end

  def de_jure
    unless @de_jure
      @de_jure = {}
      ModernTimesDatabase::DE_JURE.each do |title, lieges|
        title = title.to_s
        lieges = {forever_ago: lieges} if lieges.is_a?(String)
        @de_jure[title] = lieges.map do |date, liege|
          [resolve_date(date), liege]
        end
      end
    end
    @de_jure
  end

  def technology
    unless @technology
      @technology = {}
      ModernTimesDatabase::TECHNOLOGY.each do |title, tech_levels|
        @technology[title.to_s] = tech_levels
      end
    end
    @technology
  end

  def bookmarks
    unless @bookmarks
      @bookmarks = {}
      ModernTimesDatabase::BOOKMARKS.each do |date, bookmark|
        @bookmarks[resolve_date(date)] = bookmark
      end
    end
    @bookmarks
  end

  def title_has_land
    unless @title_has_land
      @title_has_land = {}
      # We don't care what they own, just when they own nonzero amount of land
      # Assume all titles actually resolve, and aren't shadowed by lower level titles or anything like that
      land.each do |area, ownership|
        ownership.size.times do |i|
          start_date, start_owner = ownership[i]
          @title_has_land[start_owner] ||= []
          if i == ownership.size - 1
            @title_has_land[start_owner] << [start_date, nil]
          else
            end_date = ownership[i+1][0]
            raise unless start_date < end_date
            @title_has_land[start_owner] << [start_date, end_date]
          end
        end
      end
      @title_has_land.each do |title, ranges|
        @title_has_land[title] = MultiRange.new(*ranges)
      end
    end
    @title_has_land
  end

  # FIXME: This system is nearly as awful a previous one...
  def fully_quality_reference(title, desc)
    return nil if desc.nil?
    desc = "#{desc} 1" unless desc =~ /\d+\z/
    desc = "#{title} #{desc}" unless desc =~ /\A[bcdke]_/
    cleanup_unicode(desc)
  end

  def liege_has_land_in_active(liege, title)
    ranges = []
    map.counties_in[title].each do |county|
      land = county_ownership(county)
      land.size.times do |i|
        start_date, owner = land[i]
        end_date = land[i+1] && land[i+1][0]
        if owner == liege
          ranges << [start_date, end_date]
        end
      end
    end
    MultiRange.new(*ranges)
  end

  def cultures
    ModernTimesDatabase::CULTURES
  end

  def religions
    ModernTimesDatabase::RELIGIONS
  end

  def county_ownership(county)
    map.landed_titles_lookup[county].map{|t| land[t] }.find(&:itself)
  end

  def province_religion(county)
    map.landed_titles_lookup[county].map{|t| religions[t] }.find(&:itself)
  end

  def province_culture(county)
    map.landed_titles_lookup[county].map{|t| cultures[t] }.find(&:itself)
  end

  def capital_duchy(title)
    map.duchy_for_county(titles[title][:capital])
  end

  def title_technology(title)
    map.landed_titles_lookup[title].map{|t| technology[t] }.find(&:itself)
  end

  # This should sort of be private except magic constants use same system:
  # - start
  # - title_holders_until
  def resolve_date(date)
    ModernTimesDatabase::Dates[date]
  end

  def title_has_holder
    unless @title_has_holder
      @title_has_holder = {}
      holders.keys.each do |title|
        # After writing MultiRange library, I'd have hoped for better API than this...
        holder_times = holders[title].map{|d,h| [d,!!h]}
        @title_has_holder[title] = MultiRange.new(
          *holder_times.size.times.map{|i|
            d0, active0 = holder_times[i]
            d1, _       = holder_times[i+1]
            [d0, d1] if active0
          }.select(&:itself)
        )
      end
    end
    @title_has_holder
  end

  def title_needs_extra_holders
    unless @title_needs_extra_holders
      time_limit = MultiRange.new([min_date, nil])
      @title_needs_extra_holders = Hash.new do |ht,title|
        has_land = (title_has_land[title] || MultiRange.new)
        has_holder = (title_has_holder[title] || MultiRange.new)
        ht[title] = (has_land - has_holder) & time_limit
      end
    end
    @title_needs_extra_holders
  end

  def in_historical_demesne?(liege, county)
    return true unless liege =~ /\A[ke]_/
    !(map.landed_titles_lookup[county] & titles[liege][:demesne]).empty?
  end

private

  def validate_holders!
    # This is obviously error, but we can't fix it due to engine limitations
    known_posthumous = [
      "e_spain Alfonso 2",
    ]

    holders.keys.each do |title|
      time_limit = MultiRange.new([min_date, nil])
      has_land   = title_has_land[title] & time_limit
      has_holder = title_has_holder[title] & time_limit
      # d_sunni is one such title as it is territorial for ISIS, but non-territorial for Ottoman caliphate
      # if has_land != has_holder
      #   warn "Title #{title} has_land: #{has_land} != has_holder #{has_holder}"
      # end
    end
    holders.each do |title, characters|
      characters = characters.map{|d,c| [d,c] }
      characters.size.times do |i|
        d0, c = characters[i]
        d1,   = characters[i+1]
        # If it's no-holder time, it's OK
        next if c.nil? or c[:use]
        # These will be autofilled this way later, TODO: move logic to this class?
        id = c[:historical_id]
        # This validator is problematic as actual numbers are random, used to be 35 and 90
        birth = c[:birth] || (d0 << 12*35) # actual number is random 25-40
        death = c[:death] || (birth >> 12*80) # actual number is random 80-90
        death = Date.parse("2020.1.1") if death == :never
        d1 ||= Date.parse("2020.1.1")

        # Correct
        # birth < d0 < d1 <= death
        unless birth < d0
          # It's only == with posthumous backdated characters like Alfonso of Spain
          unless birth == d0 and known_posthumous.include?(id)
            @builder.warn "Character #{id} born while in charge #{birth} #{d0}"
          end
        end
        unless d0 < d1
          @builder.warn "Character #{id} rulership dates are wrong #{d0} #{d1}"
        end
        unless d1 <= death
          @builder.warn "Character #{id} died while in charge #{death} #{d1}"
        end
        # The reason we'd like to validate age is so that characters won't autodie while in charge
        # but check above detects that condition already
      end
    end
  end

  def resolve_start_date(date)
    date = date.to_s if date.is_a?(Integer)
    return Date.parse("#{date}.1.1") if date =~ /\A\d{4}\z/
    ModernTimesDatabase::Dates[date]
  end

  def resolve_end_date(date)
    date = date.to_s if date.is_a?(Integer)
    return Date.parse("#{date}.12.31") if date =~ /\A\d{4}\z/
    ModernTimesDatabase::Dates[date]
  end

  def map
    @builder.map
  end

  def character_manager
    @builder.character_manager
  end

  def parse_lived(lived)
    case lived
    when /\A(.*?)\s*(?:-|–)\s*\z/
      [resolve_start_date($1), resolve_end_date(:never)]
    when /\A\s*(?:-|–)\s*(.*)\z/
      [nil, resolve_end_date($1)]
    when /\A(.*?)\s*(?:-|–)\s*(.*)\z/
      [resolve_start_date($1), resolve_end_date($2)]
    when nil
      [nil, nil]
    when "?" # This should be used when even Wikipedia doesn't htave any clue
      [nil, nil]
    else
      raise "Parse error for lived: #{lived.inspect}"
    end
  end

  def parse_name(name)
    name = cleanup_unicode(name)
    name, dynasty = name.split(/\s*\|\s*/, 2)
    return [name, dynasty] if dynasty
    words = name.split(/\s+/)
    return words if words.size == 2
    raise "No dynasty for #{name}"
  end

  def parse_holder_data(crowning_date, holder_data, title)
    extra_keys = holder_data.keys - %i[
      name lived female father mother traits events culture religion health
    ]
    raise "Extra keys: #{extra_keys}" unless extra_keys.empty?
    name, dynasty = parse_name(holder_data[:name])
    holder = {
      name:          name,
      dynasty:       dynasty,
      health:        holder_data[:health],
      traits:        holder_data[:traits],
      culture:       (holder_data[:culture]  || titles[title][:culture]).to_s,
      religion:      (holder_data[:religion] || titles[title][:religion]).to_s,
      female:        !!holder_data[:female],
      mother:        fully_quality_reference(title, holder_data[:mother]),
      father:        fully_quality_reference(title, holder_data[:father]),
      historical_id: character_manager.allocate_historical_id(title, name),
    }
    holder[:birth], holder[:death] = parse_lived(holder_data[:lived])
    unless holder[:death] or holder_data[:lived] == "?"
      warn "Historical characters should have lived specified: #{holder[:historical_id]}"
    end
    holder[:events] = holder_data[:events].map do |d,e|
      [(if d == :crowning then crowning_date else resolve_date(d) end), e]
    end if holder_data[:events]
    holder
  end

  def warn(*args)
    @builder.warn(*args)
  end

  def cleanup_unicode(name)
    name.tr("đćűőșăčīķēņ", "dcuosaciken")
  end
end

# This is fairly silly. Load last so we have class loaded already
Pathname(__dir__).glob("*.rb").each{|rb| require_relative rb}

# TODO: Perhaps this class should manage ID allocation?
#       Characters already need to refer to other character at this point
class ModernTimesDatabase
  # builder currently used read only to get to MapManager
  def initialize(builder)
    @builder = builder
  end

  def min_date
    if ENV["DEBUG_HISTORY"]
      @min_date ||= Date.parse(ENV["DEBUG_HISTORY"])
    else
      @min_date ||= resolve_date(:start)
    end
  end

  def land
    unless @land
      @land = {}
      ModernTimesDatabase::LAND.each do |title, ownership|
        ownership = ownership.map{|k,v| [[min_date, resolve_date(k)].max, v.to_s] }
        @land[title.to_s] = ownership.reverse.uniq(&:first).reverse
      end
    end
    @land
  end

  def titles
    unless @titles
      @titles = {}
      ModernTimesDatabase::TITLES.each do |title, data|
        title = title.to_s
        @titles[title] = {}
        extra_keys = data.keys - [:culture, :religion, :capital, :name]
        raise "Extra keys: #{extra_keys}" unless extra_keys.empty?
        raise "Culture must be specified for every title: #{title}" unless data[:culture]
        raise "Religion must be specified for every title: #{title}" unless data[:religion]

        @titles[title][:culture] = data[:culture].to_s
        @titles[title][:religion] = data[:religion].to_s
        if data[:capital]
          @titles[title][:capital] = data[:capital].to_s
        elsif title =~ /\Ac_/
          @titles[title][:capital] = title
        else
          @titles[title][:capital] = map.title_capitals[title] or raise "Can't autodetect capital for #{title}"
        end
        if data[:name]
          if data[:name].is_a?(String)
            names = {:forever_ago => data[:name]}
          else
            names = data[:name]
          end
          @titles[title][:name] = names.map{|d,n| [resolve_date(d), n] }
        end
      end
    end
    @titles
  end

  def holders
    unless @holders
      @holders = {}
      ruler_counts = Hash.new(0)
      ModernTimesDatabase::HOLDERS.each do |title, data|
        title = title.to_s
        @holders[title] = {}
        data.each do |date, holder|
          date = resolve_date(date)
          if holder.nil?
            @holders[title][date] = nil
          elsif holder.keys == [:use]
            @holders[title][date] = {use: fully_quality_reference(title, holder[:use])}
          else
            extra_keys = holder.keys - [:name, :dynasty, :birth, :death, :female, :father, :mother, :traits, :events, :culture, :religion]
            raise "Extra keys: #{extra_keys}" unless extra_keys.empty?
            holder = holder.dup
            holder[:culture]  = (holder[:culture]  || titles[title][:culture]).to_s
            holder[:religion] = (holder[:religion] || titles[title][:religion]).to_s
            holder[:female] = !!holder[:female]
            holder[:birth] = resolve_start_date(holder[:birth]) if holder[:birth]
            holder[:death] = resolve_end_date(holder[:death]) if holder[:death]
            holder[:events] = holder[:events].map{|d,e| [resolve_date(d), e]} if holder[:events]
            holder[:mother] = fully_quality_reference(title, holder[:mother])
            holder[:father] = fully_quality_reference(title, holder[:father])
            i = (ruler_counts[[title, holder[:name]]] += 1)
            holder[:historical_id] = [title, holder[:name], i].join(" ")
            @holders[title][date] = holder
          end
        end
      end
      validate_holders!
    end
    @holders
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
            @title_has_land[start_owner] << [start_date, ownership[i+1][0]]
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
    desc
  end

  def liege_has_land_in_active(liege, duchy)
    ranges = []
    map.counties_in_duchy[duchy].each do |county|
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

  def county_ownership(county)
    map.landed_titles_lookup[county].map{|t| land[t] }.find(&:itself)
  end

  def capital_duchy(title)
    map.duchy_for_county(titles[title][:capital])
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
        birth = c[:birth] || (d0 << 12*35)
        death = c[:death] || (birth >> 12*90)
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
end

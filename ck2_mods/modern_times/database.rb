# TODO: Make this class resolve mother/father from holders
# TODO: Make sure historical characters don't go to female roulette
class ModernTimesDatabase
  attr_reader :land, :titles, :holders, :time_active

  # builder currently used read only to get to MapManager
  def initialize(builder)
    @builder = builder

    @land = {}
    ModernTimesDatabase::LAND.each do |title, ownership|
      @land[title.to_s] = ownership.map{|k,v| [resolve_date(k), v.to_s] }
    end

    @titles = {}
    ModernTimesDatabase::TITLES.each do |title, data|
      title = title.to_s
      @titles[title] = {}
      raise unless (data.keys - [:culture, :religion, :capital, :name]).empty?

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
          names = {:start => data[:name]}
        else
          names = data[:name]
        end
        @titles[title][:name] = names.map{|d,n| [resolve_date(d), n] }
      end
    end

    @holders = {}
    ModernTimesDatabase::HOLDERS.each do |title, data|
      title = title.to_s
      @holders[title] = {}
      data.each do |date, holder|
        date = resolve_date(date)
        raise unless (holder.keys - [:name, :dynasty, :birth, :death, :female, :father, :mother, :traits, :events]).empty?
        holder = holder.dup
        holder[:female] = !!holder[:female]
        holder[:birth] = resolve_date(holder[:birth]) if holder[:birth]
        holder[:death] = resolve_date(holder[:death]) if holder[:death]
        holder[:events] = holder[:events].map{|d,e| [resolve_date(d), e]} if holder[:events]
        @holders[title][date] = holder
      end
    end

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
    merge_time_ranges(ranges)
  end

  def county_ownership(county)
    map.landed_titles_lookup[county].map{|t| @land[t] }.find(&:itself)
  end

  # This should sort of be private except magic constants use same system:
  # - start
  # - title_holders_until
  # - end_of_times  (this one is seriously silly and TODO remove it)
  def resolve_date(date)
    ModernTimesDatabase::Dates[date]
  end

  def capital_duchy(title)
    map.duchy_for_county(@titles[title][:capital])
  end

private

  def map
    @builder.map
  end

  def end_of_times
    @end_of_times ||= resolve_date(:end_of_times)
  end

  def merge_time_ranges(ranges)
    ranges = ranges.map{|s,e| [s, e || end_of_times]}

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

    cut_dates.map{|d| d == @end_of_times ? nil : d}.each_slice(2).map(&:itself)
  end
end

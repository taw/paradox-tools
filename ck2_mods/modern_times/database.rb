# TODO: Make this smart class, not just dumping ground for to_s/to_sym
# TODO: in particular make it resolve mother/father
class ModernTimesDatabase
  attr_reader :land, :titles, :holders

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
        @titles[title][:capital] = @builder.map.title_capitals[title] or raise "Can't autodetect capital for #{title}"
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
        raise unless (holder.keys - [:name, :dynasty, :birth, :death, :female, :father, :mother]).empty?
        holder = holder.dup
        holder[:birth] = resolve_date(holder[:birth]) if holder[:birth]
        holder[:death] = resolve_date(holder[:death]) if holder[:death]
        @holders[title][date] = holder
      end
    end
  end

  def county_ownership(county)
    @builder.map.landed_titles_lookup[county].map{|t| @land[t] }.find(&:itself)
  end

# private

  def resolve_date(date)
    ModernTimesDatabase::Dates[date]
  end
end

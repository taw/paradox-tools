class ModernTimesDatabase
  # Title => list of [date, holder_data] in order of definition
  HOLDERS = {}

  # DSL for holders_*.rb files:
  #
  #   ModernTimesDatabase::Holders.define do
  #     title "k_mauretania" do
  #       ruler "1790.4.9",
  #         name: "Yazid | Alaouite",
  #         lived: "1750 - 1792.2.23",
  #         father: "Mohammed 1"
  #       vacant "1912.3.30"
  #       ruler "1979.9.3", use: "Goukouni 1"
  #       copy_rulers :congress_of_vienna, from: "k_sicily"
  #     end
  #   end
  class Holders
    def self.define(&block)
      new.instance_eval(&block)
    end

    def title(title, &block)
      title = title.to_s
      raise "Duplicate holders for #{title}" if HOLDERS[title]
      @title = title
      @rulers = {}
      instance_eval(&block)
      HOLDERS[title] = @rulers.to_a
    ensure
      @title = @rulers = nil
    end

    def ruler(date, **data)
      add!(date, data)
    end

    def vacant(date)
      add!(date, nil)
    end

    # Copy all rulers of another title from this date on
    def copy_rulers(date, from:)
      add!(date, {use_all: from.to_s})
    end

    private

    def add!(date, data)
      raise "Rulers must be defined inside title block" unless @rulers
      raise "Duplicate date #{date} for #{@title}" if @rulers.key?(date)
      @rulers[date] = data
    end
  end
end

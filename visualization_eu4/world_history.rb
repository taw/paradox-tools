#!/usr/bin/env ruby

require_relative "../lib/paradox"

class ProvinceState
  attr_reader :state
  def initialize
    @state = {
      "cores" => [],
      "claims" => [],
      "discovered_by" => [],
    }
  end

  def command!(key, val)
    case key
    when "add_core"
      @state["cores"] |= [val]
    when "add_claim"
      @state["claims"] |= [val]
    when "remove_core"
      @state["cores"] -= [val]
    when "remove_claim"
      @state["claims"] -= [val]
    when "discovered_by"
      @state["discovered_by"] << val
    when "advisor"
      # We don't care
    when "controller"
      # This is weird
      @state[key] = val["controller"]
    when "revolt"
      # This is not persistent state change, just one off event
    else
      @state[key] = val
    end
  end

  def commands!(cmds)
    cmds.each do |key, val|
      command!(key, val)
    end
  end
end

class WorldHistory
  attr_reader :data, :provinces, :history
  def initialize(path)
    @path = path
    @data = ParadoxModFile.new(path: @path).parse!
    analyze!
  end

  def start_date
    @start_date ||= parse_date(@data["start_date"])
  end

  def current_date
    @current_date ||= parse_date(@data["date"])
  end

  def parse_date(date)
    return date if date.is_a?(Date)
    Date.new(*date.split(".").map(&:to_i), Date::JULIAN)
  end

  def player
    @player ||= @data["player"]
  end

  # Color at the end if date is nil
  # Despite its name, changed_country_mapcolor_from in history is the color set at that date
  # If date is before any recorded change, return nil so caller falls back to game default
  def country_color(tag, date=nil)
    if date and (changes = country_color_changes[tag])
      change = changes.reverse_each.find{|change_date, _| change_date <= date }
      return change && change[1]
    end
    country = @data["countries"][tag] or return
    (country["colors"] && country["colors"]["map_color"]) || country["map_color"]
  end

  # State at the end if date is nil
  def province_state(id, date=nil)
    state = ProvinceState.new
    provinces.fetch(id, {}).each do |key, val|
      if key.is_a?(Date)
        state.commands!(val) if date.nil? or key <= date
      else
        state.command!(key, val)
      end
    end
    state.state
  end

  private

  def country_color_changes
    @country_color_changes ||= begin
      changes = {}
      @countries.each do |tag, history|
        list = []
        history.each do |key, val|
          next unless key.is_a?(Date)
          val.each do |cmd, arg|
            list << [key, arg] if cmd == "changed_country_mapcolor_from"
          end
        end
        changes[tag] = list.each_with_index.sort_by{|(d, _), i| [d, i] }.map(&:first) unless list.empty?
      end
      changes
    end
  end

  def analyze!
    @provinces = {}
    @data["provinces"].each do |id, data|
      # Sea provinces often don't have any history
      @provinces[-id] = data["history"] if data["history"]
    end

    @countries = {}
    @data["countries"].each do |id, data|
      @countries[id] = data["history"] if data["history"]
    end
  end
end

if __FILE__ == $0
  unless ARGV.size == 1
    STDERR.puts "Usage: #{$0} <save.eu4> # non-compressed save only"
    exit 1
  end

  wh = WorldHistory.new(*ARGV)

  wh.provinces.keys.map{|id|
    puts "Province #{id}"
    [1400, 1450, 1500, 1550, 1600].each do |year|
      p({"year" => year}.merge(wh.province_state(id, Date.new(year, 1, 1, Date::JULIAN))))
    end
    puts ""
  }
end

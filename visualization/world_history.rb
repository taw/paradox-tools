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
    @start_date ||= Date.new(*@data["start_date"].split(".").map(&:to_i), Date::JULIAN)
  end

  def current_date
    @current_date ||= Date.new(*@data["date"].split(".").map(&:to_i), Date::JULIAN)
  end

  def player
    @player ||= @data["player"]
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
  wh = WorldHistory.new(*ARGV)

  wh.provinces.keys.map{|id|
    puts "Province #{id}"
    [1400, 1450, 1500, 1550, 1600].each do |year|
      p({"year" => year}.merge(wh.province_state(id, Date.new(year, 1, 1, Date::JULIAN))))
    end
    puts ""
  }
end

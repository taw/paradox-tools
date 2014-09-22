#!/usr/bin/env ruby

require_relative "../lib/paradox"

class WorldHistory
  attr_reader :data, :provinces, :history
  def initialize(path)
    @path = path
    @data = ParadoxModFile.new(path: @path).parse!
    analyze!
  end

  def start_date
    @start_date ||= @data["start_date"]
  end

  def current_date
    @current_date ||= @data["date"]
  end

  def player
    @player ||= @data["player"]
  end

  private

  def analyze!
    @provinces = {}
    @data["provinces"].each do |id, data|
      @provinces[-id] = data["history"]
    end

    @countries = {}
    @data["countries"].each do |id, data|
      @countries[id] = data["history"]
    end
  end
end


if __FILE__ == $0
  wh = WorldHistory.new(*ARGV)

  pp wh.provinces[257] # Warsaw
end

require_relative "../lib/paradox_game"
require "set"
require "pry"

class EU4Analysis < ParadoxGame
  def self.new_from_argv
    unless ARGV.size >= 1
      STDERR.puts "Usage: #{$0} <root> [<mod1> <mod2> ... ] # non-compressed save only"
      exit 1
    end
    new(*ARGV)
  end
end

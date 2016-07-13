require "simplecov"
SimpleCov.start do
  add_filter '/test/'
end

require "pry"
require "minitest/autorun"
require "set"
require_relative "../lib/paradox"

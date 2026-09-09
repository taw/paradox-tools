require "simplecov"
SimpleCov.start do
  skip '/test/'
end

require "minitest/autorun"
require "set"
require_relative "../lib/paradox"

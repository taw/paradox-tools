require_relative "../lib/division_designer"
require "pry"

RSpec.configure do |config|
  config.define_derived_metadata do |meta|
    meta[:aggregate_failures] = true
  end
end

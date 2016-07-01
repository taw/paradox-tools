#!/usr/bin/env ruby

require "minitest/autorun"
require_relative "../lib/paradox"

class ParadoxModFileSerializerTest < MiniTest::Test
  def assert_reserialization(number, expected)
    parsed = ParadoxModFile.new(path: "#{__dir__}/sample_#{number}.txt").parse!
    serialized = ParadoxModFileSerializer.serialize(parsed)
    assert_equal serialized, expected
  end

  def test_sample_7_inequality
    assert_reserialization 7, <<EOF
OR = {
  num_of_factories > 50
  any_country = {
    is_in_faction_with = ROOT
    num_of_factories > 50
  }
}
if = {
  limit = {
    original_research_slots < 3
  }
  add_research_slot = 1
}
EOF
  end
end

require "set"
require "minitest/autorun"
require_relative "../lib/paradox"

class PropeltyTest < MiniTest::Test
  def test_eq
    a1 = Property["foo", "bar"]
    a2 = Property["foo", "bar"]
    b = Property["foo", "fail"]
    assert_equal a1, a2
    refute_equal a1, b
  end

  def test_constructors
    assert_equal Property["NOT", PropertyList["foo", "bar", "hello", "world"]], Property::NOT["foo", "bar", "hello", "world"]
    assert_equal Property["AND", PropertyList["foo", "bar", "hello", "world"]], Property::AND["foo", "bar", "hello", "world"]
    assert_equal Property["OR", PropertyList["foo", "bar", "hello", "world"]], Property::OR["foo", "bar", "hello", "world"]
  end
end

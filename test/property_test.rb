require_relative "test_helper"

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

  def test_hash
    a = Property["foo", 1]
    b = Property["foo", 1]
    c = Property["foo", 2]
    d = Property["bar", 1]
    e = Property["foo", 1.0]
    h = {a => 123, c => 456}
    assert_equal 123, h[a]
    assert_equal 123, h[b]
    assert_equal 456, h[c]
    assert_equal nil, h[d]
    assert_equal nil, h[e]
  end

  def test_special_value_hash
    a = Property["foo", Property::GT[1]]
    b = Property["foo", Property::LT[1]]
    c = Property["foo", 1]
    d = Property["foo", Property::GT[1]]
    h = {a => 123, b => 456, c => 789}
    assert_equal 123, h[a]
    assert_equal 456, h[b]
    assert_equal 789, h[c]
    assert_equal 123, h[d]
  end
end

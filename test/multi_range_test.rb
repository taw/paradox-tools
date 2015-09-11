#!/usr/bin/env ruby

require "minitest/autorun"
require_relative "../lib/multi_range"

class MultiRangeTest < MiniTest::Test
  def test_init
    assert_equal [], MultiRange.new().to_ranges
    assert_equal [], MultiRange.new(2..2).to_ranges
    assert_equal [2..3], MultiRange.new(2..3).to_ranges
    assert_equal [2..4], MultiRange.new(2..3, 3..4).to_ranges
  end

  def test_infinities
    assert_equal [[2,4]], MultiRange.new(2..3, 3..4).to_list
    assert_equal [[2,4]], MultiRange.new([2,3], [3,4] ).to_list
    assert_equal [[2,nil]], MultiRange.new([2,3], [3,nil] ).to_list
    assert_equal [[2,nil]], MultiRange.new([2,nil], [3,4] ).to_list
    assert_equal [[nil,4]], MultiRange.new([nil,3], [3,4] ).to_list
    assert_equal [[nil,4]], MultiRange.new([2,4], [nil,4] ).to_list
    assert_equal [[nil,2], [4,nil]], MultiRange.new([nil,2], [4,nil]).to_list
    assert_equal [[nil,nil]], MultiRange.new([nil,4], [2,nil]).to_list
  end

  def test_errors
    # Not sure if this is sensible or just make it empty
    assert_raises(ArgumentError) do
      MultiRange.new(3..2)
    end
  end

  def test_or
    a = MultiRange.new(1..3, 5..6)
    b = MultiRange.new(2..5, 7..9)
    assert_equal MultiRange.new(1..6, 7..9), (a|b)
    assert_equal MultiRange.new(1..6, 7..9), (a+b)
  end

  def test_and
    a = MultiRange.new(1..3, 5..6)
    b = MultiRange.new(2..5, 7..9)
    assert_equal MultiRange.new(2..3), (a&b)
  end

  def test_sub
    a = MultiRange.new(1..3, 5..6)
    b = MultiRange.new(2..5, 7..9)
    assert_equal MultiRange.new(1..2, 5..6), (a-b)
    assert_equal MultiRange.new(3..5, 7..9), (b-a)
  end
end

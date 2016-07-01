#!/usr/bin/env ruby

require "set"
require "minitest/autorun"
require_relative "../lib/paradox"

class PropeltyListTest < MiniTest::Test
  def test_to_h
    str = ParadoxModFile.new(string: "
      government = merchant_republic
      mercantilism = 0.25
      primary_culture = lombard
      religion = catholic
      add_accepted_culture = greek
      add_accepted_culture = croatian
      technology_group = western
      capital = 112 # Venezia
      historical_friend = KNI
      historical_friend = HAB
    ").parse!
    assert_equal({
      "government"           => "merchant_republic",
      "mercantilism"         => 0.25,
      "primary_culture"      => "lombard",
      "religion"             => "catholic",
      "add_accepted_culture" => ["greek", "croatian"],
      "technology_group"     => "western",
      "capital"              => 112,
      "historical_friend"    => ["KNI", "HAB"],
    }, str.to_h)
  end

  def test_normalize
    str1 = ParadoxModFile.new(string: "
      government = merchant_republic
      mercantilism = 0.25
      primary_culture = lombard
      religion = catholic
      add_accepted_culture = greek
      add_accepted_culture = croatian
      technology_group = western
      capital = 112 # Venezia
      historical_friend = KNI
      historical_friend = HAB
    ").parse!
    str2 = ParadoxModFile.new(string: "
      government = merchant_republic
      add_accepted_culture = croatian
      mercantilism = 0.25
      technology_group = western
      primary_culture = lombard
      religion = catholic
      add_accepted_culture = greek
      capital = 112 # Venezia
      historical_friend = HAB
      historical_friend = KNI
    ").parse!
    assert(str1 != str2)
    assert_equal(str1.normalize, str2.normalize)
  end

  def test_work_as_part_of_set
    set = Set[]
    set << PropertyList["test", 2.0]
    set << PropertyList["test", 2]
    set << PropertyList["test", 2.0]
    set << PropertyList[]
    set << PropertyList["what", 10, "is", "this"]
    set << PropertyList["what", true, "is", PropertyList["this", 15]]
    set << PropertyList["what", true, "is", PropertyList["this", 15]]
    set << PropertyList["what", true, "is", PropertyList["that", 15]]
    assert_equal([
      PropertyList["test", 2.0],
      PropertyList["test", 2],
      PropertyList[],
      PropertyList["what", 10, "is", "this"],
      PropertyList["what", true, "is", PropertyList["this", 15]],
      PropertyList["what", true, "is", PropertyList["that", 15]],
    ], set.to_a)
  end

  def test_property
    cant_by_formed_by = ["MUS", "HLR", "MNG"]
    long = PropertyList[
      "NOT", PropertyList["exists", "BYZ"],
      *cant_by_formed_by.map{|ct| ["NOT", PropertyList["tag", ct]] }.flatten(1),
      "primary_culture", "croatian",
      "is_at_war", false,
    ]
    short = PropertyList[
      Property::NOT["exists", "BYZ"],
      *cant_by_formed_by.map{|ct| Property::NOT["tag", ct] },
      "primary_culture", "croatian",
      Property["is_at_war", false],
    ]
    assert_equal(long, short)
  end

  def test_property_or
    long = PropertyList[
      "OR", PropertyList[
        "technology_group", "south_american",
        "technology_group", "mesoamerican",
        "technology_group", "north_american",
      ],
      "is_subject", false,
    ]
    short = PropertyList[
      Property::OR[
        "technology_group", "south_american",
        "technology_group", "mesoamerican",
        "technology_group", "north_american",
      ],
      "is_subject", false,
    ]
    assert_equal(long, short)
  end

  def test_add!
    a = PropertyList[]
    a.add! "test", "foo"
    a.add! Property::NOT["another", "bar"]
    assert_equal(PropertyList[
      "test", "foo",
      "NOT", PropertyList["another", "bar"],
    ], a)
  end

  def test_delete!
    base = PropertyList["foo", "bar", "hello", "world", "foo", 123]
    [
      ["foo", PropertyList["hello", "world"]],
      [Property["foo", "bar"], PropertyList["hello", "world", "foo", 123]],
      [Property["foo", 123], PropertyList["foo", "bar", "hello", "world"]],
      ["hello", PropertyList["foo", "bar", "foo", 123]],
      [Property["hello", "world"], PropertyList["foo", "bar", "foo", 123]],
      # Various nonexistent properties
      [Property["foo", "lol"], base],
      [Property["hello", "omg"], base],
      ["xxx", base],
    ].each do |arg, expected|
      v = base.dup
      v.delete!(arg)
      assert_equal v, expected
    end
  end

  def test_delete_with_block
    base = PropertyList["foo", "bar", "hello", "world", "foo", 123]
    v = base.dup
    v.delete!{|prop| prop.val == 123 }
    assert_equal v, PropertyList["foo", "bar", "hello", "world"]
  end

  def test_get
    a = PropertyList["foo", "bar", "hello", "world", "foo", 123]
    assert_equal a["foo"], "bar"
    assert_equal a["hello"], "world"
    assert_equal a["omg"], nil
  end

  def test_set
    a = PropertyList["foo", "bar", "hello", "world", "foo", 123]
    a["hello"] = "WORLD"
    a["omg"] = "WTF"
    assert_equal a, PropertyList["foo", "bar", "hello", "WORLD", "foo", 123, "omg", "WTF"]
    assert_raises("Expected 0 or 1 property with value foo") do
      a["foo"] = "BAR"
    end
  end

  def test_find_all
    a = PropertyList["foo", "bar", "hello", "world", "foo", 123]
    assert_equal a.find_all("foo"), ["bar", 123]
    assert_equal a.find_all("hello"), ["world"]
    assert_equal a.find_all("omg"), []
  end

  def test_hash_to_plist
    a = {"foo" => "bar", "hello" => "world"}
    assert_equal a.to_plist.to_h, a
    assert_equal a.to_plist, PropertyList["foo", "bar", "hello", "world"]
  end

  def test_to_a
    a = PropertyList["foo", "bar", "hello", "world", "foo", 123]
    assert_equal a.to_a, [Property["foo", "bar"], Property["hello", "world"], Property["foo", 123]]
  end
end

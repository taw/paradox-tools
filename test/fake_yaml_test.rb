#!/usr/bin/env ruby

require "minitest/autorun"
require_relative "../lib/fake_yaml"

class MultiRangeTest < MiniTest::Test
  def sample(name)
    "#{__dir__}/sample_yaml/#{name}.yml"
  end

  # EU4 up to 1.16.x
  def test_old
    assert_equal({
      "shiva"=>"Shiva",
      "ganesha"=>"Ganesha",
      "surya"=>"Surya",
      "ganga"=>"Ganga",
      "shakti"=>"Shakti",
      "vishnu"=>"Vishnu",
      "shiva_desc"=>"Shiva is the god of transformation through destruction and the Lord of Dance.",
      "ganesha_desc"=>"Ganesha is the god of knowledge and beginnings, the Lord of Obstacles.",
      "surya_desc"=>"Surya is the god of the sun, courage and will.",
      "ganga_desc"=>"Ganga is the goddess of the sacred river, Ganges, who purifies and redeems.",
      "shakti_desc"=>"Shakti is the goddess of power and dynamic energy.",
      "vishnu_desc"=>"Vishnu is the all-pervading god who sustains the world.",
      "RV_NO_DEITY_TITLE"=>"No Current Deity.",
      "RV_NO_DEITY_DESC"=>"Hinduism allows you to select which god to follow as your main deity. Each deity will come with its own effects and last until your monarch changes.",
      "RV_PICK_DEITY_THIS"=>"Follow $NAME|Y$",
      "RV_PICK_DEITY"=>"Select Deity",
    }, FakeYaml.load(sample("religion_l_english")))
  end

  # HOI4 and EU4 1.17.x+
  def test_new
    assert_equal({
      "drylands"=>"Drylands",
      "savannah"=>"Savanna",
    }, FakeYaml.load(sample("terrain_stuff_l_english")))
  end
end

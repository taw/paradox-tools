require "minitest/autorun"
require_relative "../lib/paradox"

class Test < MiniTest::Test
  def test_sample_1
    parsed = ParadoxModFile.new("#{__dir__}/sample_1.txt").parse_obj
  end

  def test_sample_2
    parsed = ParadoxModFile.new("#{__dir__}/sample_2.txt").parse_obj
  end

  def test_sample_3
    parsed = ParadoxModFile.new("#{__dir__}/sample_3.txt").parse_obj
  end
end

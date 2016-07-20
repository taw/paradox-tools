require_relative "test_helper"

class DateTest < MiniTest::Test
  def test_to_s
    assert_equal "1939.9.1", Date.parse("1 Sep 1939").to_s
  end

  def test_inspect
    assert_equal "Date.new(1939, 9, 1)", Date.parse("1 Sep 1939").inspect
  end
end

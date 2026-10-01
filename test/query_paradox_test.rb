require_relative "test_helper"
load "#{__dir__}/../bin/query_paradox"

class QueryParadoxTest < Minitest::Test
  SAMPLE = <<~EOF
    countries={
      ARA={
        history={
          1356.1.1={ monarch={ name="Pedro" id=5 } capital=213 }
          1363.1.1={ capital=214 add_core=213 }
          1363.1.1={ add_core=214 }
        }
        flags={ 151=yes }
        cores={ 213 214 }
        government=monarchy
      }
      CAS={ history={ 1400.1.1={ monarch={ name="Juan" } } } }
    }
    1.000={ x=1 }
    -151={ owner=ARA }
    "quoted key"=2
    trigger={ prestige > 50 }
  EOF

  def root
    @root ||= ParadoxModFile.new(string: SAMPLE).parse!
  end

  def assert_query(query, expected)
    out, _ = capture_io do
      QueryParadoxPrinter.new.print(QueryParadox.new(query).call(root))
    end
    assert_equal expected, out
  end

  def test_simple_path
    assert_query ".countries.ARA.government", "government = monarchy\n"
  end

  def test_missing_key_is_empty
    assert_query ".countries.XXX.history", ""
    assert_query ".countries.ARA.government.foo", ""
  end

  def test_duplicate_keys_are_all_returned
    assert_query ".countries.ARA.history.1363.1.1", <<~EOF
      1363.1.1 = {
        capital = 214
        add_core = 213
      }
      1363.1.1 = {
        add_core = 214
      }
    EOF
  end

  def test_bracket_and_quote_syntax
    expected = "1356.1.1 = {\n  monarch = {\n    name = Pedro\n    id = 5\n  }\n  capital = 213\n}\n"
    assert_query '.countries.ARA.history["1356.1.1"]', expected
    assert_query '.countries.ARA.history."1356.1.1"', expected
    assert_query '.countries.ARA.history.["1356.1.1"]', expected
  end

  def test_keys
    assert_query '.countries.ARA.history["1363.1.1"] | keys', "capital\nadd_core\nadd_core\n"
    assert_query ".countries | keys", "ARA\nCAS\n"
  end

  def test_integer_key
    assert_query ".countries.ARA.flags.151", "151 = yes\n"
  end

  def test_negative_integer_key
    assert_query ".-151.owner", "owner = ARA\n"
  end

  def test_float_key_matches_regardless_of_formatting
    assert_query ".1.000.x", "x = 1\n"
    assert_query ".1.0.x", "x = 1\n"
  end

  def test_quoted_key
    assert_query '."quoted key"', %Q["quoted key" = 2\n]
    assert_query '.["quoted key"]', %Q["quoted key" = 2\n]
  end

  def test_iterate_children
    assert_query ".countries[] | .history[] | .monarch.name", "name = Pedro\nname = Juan\n"
  end

  def test_array
    assert_query ".countries.ARA.cores", "cores = {\n  213\n  214\n}\n"
    assert_query ".countries.ARA.cores[1]", "214\n"
    assert_query ".countries.ARA.cores[-1]", "214\n"
    assert_query ".countries.ARA.cores[5]", ""
    assert_query ".countries.ARA.cores[]", "213\n214\n"
  end

  def test_recursive_descent
    assert_query ".. | .monarch.name", "name = Pedro\nname = Juan\n"
    assert_query "..|.name", "name = Pedro\nname = Juan\n"
  end

  def test_length
    assert_query ".countries.ARA | length", "4\n"
    assert_query ".countries.ARA.cores | length", "2\n"
    assert_query ".countries.ARA.history[] | length", "2\n2\n1\n"
  end

  def test_count
    assert_query ".. | .add_core | count", "2\n"
    assert_query ".countries.XXX | count", "0\n"
  end

  def test_uniq
    assert_query ".countries.ARA.history[] | .capital", "capital = 213\ncapital = 214\n"
    assert_query ".countries.ARA.history.1363.1.1 | keys | uniq", "capital\nadd_core\n"
  end

  def test_values
    assert_query ".countries.ARA.history.1363.1.1 | values", "capital = 214\nadd_core = 213\nadd_core = 214\n"
  end

  def test_identity
    assert_query ".countries.CAS.history | .", "history = {\n  1400.1.1 = {\n    monarch = {\n      name = Juan\n    }\n  }\n}\n"
  end

  def test_keyless_property_list_output
    assert_query ".countries.CAS.history[] | values", "monarch = {\n  name = Juan\n}\n"
    assert_query ".countries.CAS.history.1400.1.1 | keys", "monarch\n"
  end

  def test_special_values
    assert_query ".trigger.prestige", "prestige > 50\n"
  end

  def test_parse_error
    assert_raises(RuntimeError) { QueryParadox.new(".foo bar") }
  end

  def test_command_line
    out = IO.popen(["#{__dir__}/../bin/query_paradox", "#{__dir__}/sample_3.txt", ".title"], &:read)
    assert_equal "title = c_cagliari\n", out
  end
end

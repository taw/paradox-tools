require_relative "test_helper"

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

  def test_sample_3
    assert_reserialization 3, <<EOF
title = c_cagliari
max_settlements = 4
b_cagliari = castle
b_ogliastra = city
b_assemini = temple
culture = italian
religion = norse_pagan
terrain = hills
867.1.1 = {
  b_cagliari = ca_shipyard_1
}
1066.1.1 = {
  trade_post = b_caetani
}
1285.1.1 = {
  trade_post = b_grimaldi
}
EOF
  end

  def test_sample_4
    assert_reserialization 4, <<EOF
christian = {
  defender_of_faith = yes
  catholic = {
    color = {
      0.8
      0.8
      0
    }
    icon = 1
    allowed_conversion = {
      reformed
      protestant
    }
    country = {
      tolerance_own = 1
      tolerance_heretic = -1
    }
    on_convert = {
      change_religion = catholic
      add_prestige = -100
      remove_country_modifier = the_test_act
      remove_country_modifier = superintendent_office
      remove_country_modifier = the_popery_act
      add_country_modifier = {
        name = conversion_zeal
        duration = 3650
      }
    }
    heretic = {
      BOGOMILIST
      WALDENSIAN
      FRATICELLI
      HUSSITE
      LOLLARD
      SOCINIAN
    }
    papacy = yes
  }
}
EOF
  end
end

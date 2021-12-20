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

  def test_sample_9
    assert_reserialization 9, <<EOF
has_completed_idea_group_of_category = {
  [[adm_ideas]
    custom_trigger_tooltip = {
      tooltip = has_completed_one_adm_idea_group
      OR = {
        full_idea_group = innovativeness_ideas
        full_idea_group = religious_ideas
        full_idea_group = economic_ideas
        full_idea_group = expansion_ideas
        full_idea_group = administrative_ideas
        full_idea_group = humanist_ideas
      }
    }
  ]
  [[dip_ideas]
    custom_trigger_tooltip = {
      tooltip = has_completed_one_dip_idea_group
      OR = {
        full_idea_group = spy_ideas
        full_idea_group = diplomatic_ideas
        full_idea_group = trade_ideas
        full_idea_group = exploration_ideas
        full_idea_group = maritime_ideas
        full_idea_group = influence_ideas
      }
    }
  ]
  [[mil_ideas]
    custom_trigger_tooltip = {
      tooltip = has_completed_one_mil_idea_group
      OR = {
        full_idea_group = aristocracy_ideas
        full_idea_group = offensive_ideas
        full_idea_group = defensive_ideas
        full_idea_group = quality_ideas
        full_idea_group = quantity_ideas
        full_idea_group = naval_ideas
        full_idea_group = theocracy_gov_ideas
        full_idea_group = indigenous_ideas
        full_idea_group = horde_gov_ideas
        full_idea_group = plutocracy_ideas
      }
    }
  ]
}
EOF
  end
end

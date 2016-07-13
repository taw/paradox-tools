require_relative "test_helper"

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

  def test_error_correction
    assert_equal({
    "corruption_event.17.d"=>
     "Matters of governmental organization have never been [Root.Monarch.GetName]'s strong suit. What a good leader does to compensate for such a known weakness is to delegate and this is exactly what our [Root.Monarch.GetTitle] has done, but the people who have handled administration in [Root.Monarch.GetHerHis] stead have proven to be more competent than honest. The government runs well enough, but tends to slowly shift its priorities towards matters which the benefactors of these irreplaceable officials find to be of importance.\n\nWith [Root.Monarch.GetName] [Root.Monarch.GetHerselfHimself] unable to fully grasp the intricacies of the matters in question, the guilty parties cannot easily be seen or removed from office. For now, we'll simply have to suffer the consequences.",
    "corruption_event.17.a"=>"Unfortunate that skill and honor do not always go hand in hand.",
    "corruption_event.18.t"=>"Overextension Exploited",
    "corruption_event.18.d"=>
     "The rapid expansion of the [Root.GetAdjective] borders is most fortunate, but brings with it new administrative challenges. As every person familiar with the optimistic language knows, \"challenges\" is the sweeter-tasting word for \"problems\". Our country has not fully adjusted to its new extent yet, and people who have noticed the confusion and poorly enforced law in these new acquisitions are reaping the benefits.\n\nThis lawlessness may eventually pass, but the temporary administrations appear to have built an unstable foundation for the future. It will take time and money to rid our society from the distrust forming in the present situation."
   }, FakeYaml.load(sample("mare_nostrum_l_english")))
  end
end

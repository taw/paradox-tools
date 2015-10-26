class ProtestantismGameModification < CK2GameModification
  def add_holy_sites!(sites)
    found = Set[]
    add_sites = proc do |node|
      node.each do |k,v|
        if sites[k]
          found << k
          # This is nasty but produces better looking output that add!
          v.instance_eval do
            idx = @list.index{|a,| a == "color2" } or raise
            @list[idx+1,0] = sites[k].map{|rel| ["holy_site", rel] }
          end
        elsif v.is_a?(PropertyList) and k =~ /\A[dke]/
          add_sites[v]
        end
      end
    end
    patch_mod_file!("common/landed_titles/landed_titles.txt") do |node|
      add_sites[node]
    end
    raise unless found == Set[*sites.keys]
  end

  def setup_protestantism!
    %W[religion_icon_strip.dds religion_icon_strip_small.dds religion_icon_strip_big.dds].each do |name|
      create_file! "gfx/interface/#{name}", open("data/modern_times/#{name}", "rb", &:read)
    end
    generalstuff = ParadoxModFile.new(path: "data/vanilla/generalstuff.gfx").parse!
    generalstuff["spriteTypes"].find_all("spriteType").each do |data|
      next unless data["name"] =~ /\AGFX_religion_icon_strip/
      raise unless data["noOfFrames"] = 52
      data["noOfFrames"] = 54
    end
    create_mod_file! "interface/generalstuff.gfx", generalstuff

    create_mod_file! "history/titles/d_protestant.txt", PropertyList[
      Date.parse("0020.1.1"), PropertyList["active", false],
    ]
    create_file! "common/landed_titles/modern_times.txt",
    'd_protestant = {
      color={ 180 137 97 }
      color2={ 220 220 0 }
      capital = 333 # Rome
      title = "PROTESTANT_PRIMATE"
      foa = "POPE_FOA"
      short_name = yes
      # Always exists
      landless = yes
      # Controls a religion
      controls_religion = protestant
      religion = protestant
      # Cannot be held as a secondary title
      primary = yes
      dynasty_title_names = no # Will not be named "Seljuk", etc.
    }'
    create_mod_file! "common/religions/01_modern_times.txt", PropertyList[
      "christian", PropertyList[
        "protestant", PropertyList[
          "graphical_culture", "westerngfx",
          "icon", 53,
          "heresy_icon", 54,
          "color", [0.7, 0.7, 0.8],
          "crusade_name", "CRUSADE",
          "scripture_name", "THE_BIBLE",
          "priest_title", "PRIEST",
          "high_god_name", "GOD_GOD",
          "god_names", ["GOD_GOD", "GOD_THE_LORD", "GOD_JESUS", "GOD_THE_BLESSED_VIRGIN"],
          "evil_god_names", ["SATAN", "LUCIFER", "THE_DEVIL"],
          "autocephaly", true,
          "can_call_crusade", false,
          "can_grant_divorce", true,
          "priests_can_inherit", false,
          "priests_can_marry", true,
          "religious_clothing_head", 0,
          "religious_clothing_priest", 1,
        ],
        "reformed", PropertyList[
          "graphical_culture", "westerngfx",
          "icon", 53,
          "heresy_icon", 54,
          "color", [0.4, 0.4, 0.6],
          "crusade_name", "CRUSADE",
          "scripture_name", "THE_BIBLE",
          "priest_title", "PRIEST",
          "high_god_name", "GOD_GOD",
          "god_names", ["GOD_GOD", "GOD_THE_LORD", "GOD_JESUS", "GOD_THE_BLESSED_VIRGIN"],
          "evil_god_names", ["SATAN", "LUCIFER", "THE_DEVIL"],
          # Protestant Work Ethic
          "character_modifier", PropertyList["stewardship", 4],
          "priests_can_inherit", false,
          "priests_can_marry", true,
          "religious_clothing_head", 0,
          "religious_clothing_priest", 1,
          "parent", "protestant",
        ],
      ],
    ]
    localization! "modern_times_religions",
      "protestant" => "Protestant",
      "protestant_DESC" => "Lutheran/Anglican branch of Protestantism",
      "d_protestant" => "Ecumenical Primacy",
      "d_protestant_adj" => "Primatial",
      "PROTESTANT_PRIMATE" => "Ecumenical Primate",
      "reformed" => "Reformed",
      "reformed_DESC" => "Reformed/Calvinist branch of Protestantism"

    add_holy_sites!(
      "c_kent"      => ["protestant", "reformed"],
      "c_roma"      => ["protestant", "reformed"],
      "c_koln"      => ["protestant", "reformed"],
      "c_jerusalem" => ["protestant", "reformed"],
      "c_santiago"  => ["protestant", "reformed"],
    )
  end

  def apply!
    setup_protestantism!
  end
end

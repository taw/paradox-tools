require_relative "base"

class AdjustProvinceReligionGameModification < CK2GameModification
  # This method seems to be totally confused by one level, and yet it works...
  def deep_search(node, path=[], &blk)
    node.each do |key, val|
      if val.is_a?(PropertyList)
        deep_search(val, [*path, key], &blk)
      end
      yield(node, [*path, key])
    end
  end

  def landed_titles_lookup
    unless @landed_titles_lookup
      @landed_titles_lookup = {}
      landed_titles = parse("common/landed_titles/landed_titles.txt")
      deep_search(landed_titles) do |node, path|
        next unless path[-1] =~ /\A[cb]_/
        @landed_titles_lookup[path[-1]] = path.reverse
      end
    end
    @landed_titles_lookup
  end

  def setup_fun_province_religions!
    religion_map = {
      # Western Europe
      "e_spain"          => "catholic",
      "k_ireland"        => "catholic",
      "k_scotland"       => "catholic",
      "k_england"        => "lollard",
      "k_wales"          => "lollard",
      "k_portugal"       => "fraticelli",
      "k_andalusia"      => "fraticelli",
      "k_aquitaine"      => "cathar",
      "k_italy"          => "catholic",
      "e_france"         => "catholic",
      "k_frisia"         => "catholic",
      "k_venice"         => "catholic",

      # Scandinavia
      "e_scandinavia"    => "catholic",
      "d_iceland"        => "restore",
      "k_finland"        => "restore",
      "d_norrland"       => "restore",
      "d_trondelag"      => "restore",

      # Byzantine region
      "d_sicily"         => "orthodox",
      "k_byzantium"      => "orthodox",
      "k_anatolia"       => "orthodox",
      "k_georgia"        => "orthodox",
      "k_bulgaria"       => "bogomilist",
      "k_armenia"        => "miaphysite",
      "k_sicily"         => "restore",
      "d_armenia_minor"  => "miaphysite",
      "d_achaia"         => "hellenic_pagan",
      "k_dacia"          => "paulician",
      "k_serbia"         => "bogomilist",

      # Central Europe
      "k_bohemia"        => "waldensian",
      "d_bavaria"        => "waldensian",
      "d_osterreich"     => "waldensian",
      "k_lithuania"      => "baltic_pagan",
      "k_hungary"        => "tengri_pagan",
      "k_croatia"        => "catholic",
      "k_poland"         => "slavic_pagan",
      "d_pomeralia"      => "slavic_pagan",
      "d_pommerania"     => "slavic_pagan",
      "d_brandenburg"    => "slavic_pagan",
      "d_mecklemburg"    => "slavic_pagan",
      "k_germany"        => "catholic",
      "k_bavaria"        => "catholic",
      "k_lotharingia"    => "catholic",
      "d_saxony"         => "catholic",
      "d_meissen"        => "catholic",

      # Eastern Europe
      "k_perm"           => "restore",
      "k_volga_bulgaria" => "restore",
      "k_rus"            => "restore",
      "k_ruthenia"       => "restore",

      # Africa
      "k_egypt"          => "miaphysite",
      "k_africa"         => "sunni",
      "d_tlemcen"        => "kharijite",
      "d_alger"          => "kharijite",
      "d_kabylia"        => "kharijite",
      "e_mali"           => "west_african_pagan",
      "d_semien"         => "jewish",
      "d_harer"          => "hurufi",
      "d_afar"           => "hurufi",
      "e_abyssinia"      => "miaphysite",
      "c_canarias"       => "west_african_pagan",
      "d_fes"            => "yazidi",
      "d_marrakech"      => "zikri",
      "d_tangiers"       => "sunni",
      "d_cyrenaica"      => "monothelite",

      # Middle East
      "k_jerusalem"      => "jewish",
      "d_baghdad"        => "karaite",
      "d_oultrejourdain" => "samaritan",
      "d_tripoli"        => "monothelite",
      "d_damascus"       => "sunni",
      "d_syria"          => "druze",
      "d_jazira"         => "monophysite",

      # Arabia / Mesopotamia
      "d_basra"          => "shiite",
      "d_amman"          => "shiite",
      "d_tigris"         => "shiite",
      "d_sanaa"          => "shiite",
      "d_oman"           => "ibadi",
      "d_mosul"          => "nestorian",
      "c_socotra"        => "nestorian",
      "c_suwaida"        => "nestorian",
      "k_arabia"         => "sunni",
      "d_antioch"        => "orthodox",
      "d_aleppo"         => "orthodox",

      # Persia
      "k_persia"         => "zoroastrian",
      "k_baluchistan"    => "restore",
      "k_afghanistan"    => "zun_pagan",
      "k_khiva"          => "restore",
      "d_kermanshah"     => "shiite",
      "d_fars"           => "shiite",

      # Steppe
      # manichean goes here by restore
      "k_cumania"        => "tengri_pagan",
      "d_itil"           => "jewish",
      "k_khotan"         => "buddhist",
      "e_tartaria"       => "restore",

      # India
      # its mix of hindu/buddhist/jain is fairly sensible
      "e_rajastan"       => "restore",
      "e_deccan"         => "restore",
      "e_bengal"         => "restore",
      "d_sauvira"        => "hindu",
    }

    # These should maybe go somewhere:
    # * iconoclast (orthodox)
    # * messalian (nestorian)
    # * mazdaki (zoroastrian)
    # On the other hand they could just spawn via theology focus eventually

    patch_mod_files!("history/provinces/*.txt") do |node|
      titles = landed_titles_lookup[node["title"]]

      religion = titles.map{|t| religion_map[t] }.find(&:itself)
      unless religion
        actual = [node["religion"], *node.keys.grep(Date).map{|k| node[k]["religion"]}.compact]
        warn "No religion for #{titles.join(", ")} - #{actual.join(", ")}"
        next
      end

      # restore means just rollback to 769 whatever it was originally
      node["religion"] = religion unless religion == "restore"

      node.each do |key, val|
        next unless key.is_a?(Date) and val.is_a?(PropertyList)
        val.delete! "religion"
      end
    end
  end

  def apply!
    setup_fun_province_religions!
  end
end

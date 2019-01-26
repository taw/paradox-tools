ModernTimesDatabase::TITLES = {
  d_ferghana: {
    culture: :kirghiz,
    religion: :sunni,
    name: "Kyrgyzstan / Kyrgyz",
    liege: {end_ww1: "e_russia", fall_soviet_union: nil},
  },
  d_khuttal: {
    culture: :persian,
    religion: :sunni,
    name: "Tajikistan / Tajik",
    liege: {end_ww1: "e_russia", fall_soviet_union: nil},
  },
  d_gloucester: { # "Hwicce"
    culture: :english,
    religion: :protestant,
    name: "Gloucester / Gloucesterian",
    liege: {times_immemorial: "e_britannia"},
    autoholders: true,
  },
  d_hereford: { # "Mercia"
    culture: :english,
    religion: :protestant,
    name: "Midlands / Midland",
    liege: {times_immemorial: "e_britannia"},
    autoholders: true,
  },
  # TODO: china policy / status / flags
  e_offmap_china: {
    culture: :han,
    religion: :taoist,
    name: {times_immemorial: "Qing / Qing", end_of_qing: "China / Chinese"},
  },
  e_china_west_governor: {
    culture: :han,
    religion: :taoist,
    name: {times_immemorial: "Qing / Qing", end_of_qing: "China / Chinese"},
  },
  d_bhutan: {
    culture: :nepali,
    religion: :buddhist,
  },
  k_nepal: {
    culture: :nepali,
    religion: :hindu,
  },
  e_tibet: {
    culture: :bodpa,
    religion: :buddhist,
  },
  e_britannia: {
    culture: :english,
    religion: :protestant,
    capital: :c_middlesex,
    name: "United Kingdom / British",
    demesne: ["d_somerset"],
  },
  k_wales: {
    culture: :welsh,
    religion: :protestant,
    liege: {wales_devolution: "e_britannia"},
  },
  k_ireland: {
    culture: :irish,
    religion: :catholic,
    capital: :c_dublin,
    name: "Ireland / Irish",
    demesne: ["d_leinster"],
  },
  d_iceland: {
    culture: :norwegian,
    religion: :protestant,
    capital: :c_vestisland,
    name: "Iceland / Icelandic",
    liege: {times_immemorial: "k_denmark", iceland_independence: nil},
    autoholders: [:times_immemorial..:iceland_independence],
  },
  k_portugal: {
    culture: :portuguese,
    religion: :catholic,
    capital: :c_lisboa,
    demesne: [], # 4 counties should be fine
  },
  e_spain: {
    culture: :castillan,
    religion: :catholic,
    capital: :c_toledo,
    name: "Spain / Spanish",
    demesne: ["d_cordoba"],
  },
  e_france: {
    culture: :frankish,
    religion: :catholic,
    capital: :c_ile_de_france,
    name: "France / French",
    demesne: ["d_champagne"],
  },
  k_papal_state: {
    culture: :italian,
    religion: :catholic,
    capital: :c_roma,
    demesne: [], # Latium is OK
  },
  k_italy: {
    culture: :italian,
    religion: :catholic,
    capital: :c_piemonte,
    name: {times_immemorial: "Piedmont-Sardinia / Piedmontese-Sardinian", italy_unification: "North Italy / North Italian"},
    demesne: ["d_sardinia"],
  },
  e_italy: {
    culture: :italian,
    religion: :catholic,
    capital: :c_orvieto,
    name: "Italy / Italian",
    demesne: ["d_susa"],
  },
  d_cyprus: {
    culture: :greek,
    religion: :orthodox,
    capital: :c_limisol,
  },
  c_malta: {
    culture: :italian, # not really
    religion: :catholic,
    capital: :c_malta,
  },
  k_denmark: {
    culture: :danish,
    religion: :protestant,
    capital: :c_sjaelland,
    name: "Denmark / Danish",
    demesne: ["d_slesvig"],
  },
  k_sweden: {
    culture: :swedish,
    religion: :protestant,
    capital: :c_uppland,
    demesne: ["d_ostergotland"],
  },
  k_norway: {
    culture: :norwegian,
    religion: :protestant,
    capital: :c_akershus,
    name: "Norway / Norwegian",
    demesne: [], # 4 counties is enough
  },
  c_maldives: {
    culture: :tamil,
    religion: :sunni,
    capital: :c_maldives,
  },
  k_lanka: {
    culture: :sinhala,
    religion: :buddhist,
    capital: :c_dakhina_desa,
    name: "Sri Lanka / Sri Lankan",
    demesne: ["d_sinhala"],
  },
  e_india: {
    culture: :hindustani,
    religion: :hindu,
    capital: :c_delhi,
    demesne: ["d_haritanaka"],
  },
  e_rajastan: { # FIXME: name is hax
    culture: :hindustani, # persian ?
    religion: :sunni,
    name: "Mughals / Mughal",
    capital: :c_delhi,
    demesne: ["d_vodamayutja"],
  },
  e_deccan: { # FIXME: name is hax
    culture: :marathi,
    religion: :hindu,
    name: "Marathas / Maratha",
    capital: :c_kondana,
    demesne: ["d_devagiri"],
  },
  d_chera_nadu: { # Travancore
    culture: :tamil,
    religion: :hindu,
  },
  # TODO: make British India Company e_bengal ?
  d_luxembourg: {
    culture: :dutch,
    religion: :catholic,
    capital: :c_luxembourg,
  },
  e_russia: {
    culture: :russian,
    religion: :orthodox,
    capital: :c_moskva,
    name: {end_ww1: "Soviet Union / Soviet", fall_soviet_union: nil},
    demesne: ["d_tver", "c_ingria"],
  },
  d_flanders: {
    culture: :dutch,
    religion: :catholic,
    capital: :c_brabant,
    name: "Belgium / Belgian",
  },
  k_frisia: {
    culture: :dutch,
    religion: :reformed,
    capital: :c_holland,
    name: "Netherlands / Dutch",
    demesne: [], # Should be fine
  },
  e_carpathia: {
    culture: :german,
    religion: :catholic,
    capital: :c_osterreich,
    name: "Austria-Hungary / Austro-Hungarian",
    demesne: ["d_tyrol"],
  },
  k_bavaria: {
    culture: :german,
    religion: :catholic,
    capital: :c_osterreich,
    name: "Austria / Austrian",
    demesne: ["d_tyrol"],
  },
  k_pomerania: {
    culture: :german,
    religion: :protestant,
    capital: :c_brandenburg,
    name: {times_immemorial: "Prussia / Prussian", end_ww2: "East Germany / East German"},
    demesne: ["d_prussia"],
  },
  k_germany: {
    culture: :german,
    religion: :catholic,
    name: {end_ww2: "West Germany / West Germany"},
  },
  e_germany: {
    culture: :german,
    religion: :catholic,
    # It was outside country (as Berlin was 1945-1990)
    # b_bonn is non-existent barony in d_koln/c_koln
    capital: :c_brandenburg,
    name: {times_immemorial: "Germany / German", end_ww2: "West Germany / West German", german_reunification: "Germany / German"},
    demesne: ["d_koln"],
  },
  c_danzig: {
    culture: :german,
    religion: :catholic,
  },
  c_lubeck: {
    culture: :german,
    religion: :protestant,
  },
  c_nassau: {
    culture: :german,
    religion: :reformed,
  },
  # It's actually a composite of various minors
  c_thuringen: {
    culture: :german,
    religion: :protestant,
  },
  d_franconia: {
    culture: :german,
    religion: :protestant,
    name: "Hesse / Hessian",
  },
  c_oldenburg: {
    culture: :german,
    religion: :protestant,
  },
  d_bremen: {
    culture: :german,
    religion: :protestant,
  },
  c_hamburg: {
    culture: :german,
    religion: :protestant,
  },
  d_mecklemburg: {
    culture: :german,
    religion: :protestant,
    liege: {german_unification: "e_germany", end_ww1: nil},
  },
  d_baden: {
    culture: :german,
    religion: :catholic,
    liege: {german_unification: "e_germany", end_ww1: nil},
  },
  c_breisgau: { # Fürstenberg
    culture: :german,
    religion: :catholic, # seemingly
  },
  d_swabia: {
    culture: :german,
    religion: :protestant,
    name: "Württemberg / Württembergian",
    liege: {german_unification: "e_germany", end_ww1: nil},
  },
  c_ulm: {
    culture: :german,
    religion: "protestant",
  },
  c_schwaben: { # Duchy of Waldburg
    culture: :german,
    religion: "catholic", # no reliable information, it seems they were Catholic probably, unlike Wurttemberg
  },
  d_brunswick: {
    culture: :german,
    religion: :protestant,
    name: "Hannover / Hannoverian",
  },
  c_weimar: { # Duchy of Saxe-Weimar-Eisenach
    culture: :german,
    religion: :protestant,
  },
  c_anhalt: {
    culture: :german,
    religion: :protestant,
  },
  k_bohemia: {
    culture: :bohemian,
    religion: :catholic,
    capital: :c_praha,
    name: {czechoslovakia_independence: "Czechoslovakia / Czechoslovak", czechoslovakia_dissolution: nil},
    demesne: [], # 5 counties is enough
  },
  d_nyitra: {
    culture: :bohemian,
    religion: :catholic,
    capital: :c_pressburg,
    name: "Slovakia / Slovak",
  },
  k_switzerland: {
    culture: :german,
    religion: :reformed,
    capital: :c_bern,
  },
  e_arabia: {
    culture: :turkish,
    religion: :sunni,
    capital: :c_byzantion,
    name: {times_immemorial: "Ottoman Empire / Ottoman", end_of_ottoman_empire: nil},
    demesne: ["d_paphlagonia"],
  },
  k_anatolia: {
    culture: :turkish,
    religion: :sunni,
    capital: :c_ankyra,
    demesne: ["d_thrace"],
    name: "Turkey / Turkish",
  },
  d_sunni: {
    culture: :levantine_arabic,
    religion: :sunni,
  },
  d_tunis: {
    culture: :maghreb_arabic,
    religion: :sunni,
    capital: :c_tunis,
    name: "Tunisia / Tunisian",
  },
  d_tripolitania: {
    culture: :maghreb_arabic,
    religion: :sunni,
    capital: :c_tripolitana,
    name: "Libya / Libyan",
  },
  d_alger: {
    culture: :maghreb_arabic,
    religion: :sunni,
    capital: :c_al_djazair,
    name: "Algeria / Algerian",
  },
  k_mauretania: {
    culture: :maghreb_arabic,
    religion: :sunni,
    name: "Morocco / Moroccan",
  },
  d_krete: {
    culture: :greek,
    religion: :orthodox,
  },
  k_byzantium: {
    culture: :greek,
    religion: :orthodox,
    # This must remain traditional capital, even if it's never actually held
    capital: :c_byzantion,
    demesne: ["d_athens", "d_aegean_islands"],
  },
  k_bulgaria: {
    culture: :bulgarian,
    religion: :orthodox,
    capital: :c_serdica,
  },
  k_baluchistan: {
    culture: :sindhi,
    religion: :sunni,
    capital: :c_makran,
    name: {india_independence: "Pakistan / Pakistani"},
  },
  k_afghanistan: {
    culture: :afghan,
    religion: :sunni,
    capital: :c_kabul,
    name: "Afghanistan / Afghani",
  },
  c_kuwait: {
    culture: :bedouin_arabic,
    religion: :sunni,
  },
  c_bahrein: {
    culture: :bedouin_arabic,
    religion: :sunni,
    name: "Qatar / Qatari",
  },
  c_uwal: {
    culture: :bedouin_arabic,
    religion: :sunni,
    name: "Bahrain / Bahraini",
  },
  k_persia: {
    culture: :persian,
    religion: :shiite,
    capital: :c_rayy,
    name: {"1925.12.15" => "Iran / Iranian"},
    demesne: ["d_jibal"],
  },
  k_bengal: {
    culture: :bengali,
    religion: :sunni,
    capital: :c_bikrampur,
    name: {india_independence: "Bangladesh / Bangladeshi"},
  },
  d_dihistan: {
    culture: :turkish,
    religion: :sunni,
    name: "Turkmenistan / Turkmenistani",
    liege: {end_ww1: "e_russia", fall_soviet_union: nil},
  },
  k_cuman: {
    culture: :cuman, # localized as Kazakh
    religion: :sunni,
    name: "Kazakhstan / Kazakh",
    capital: "c_kimak",
    liege: {end_ww1: "e_russia", fall_soviet_union: nil},
    demesne: ["d_zhetysu"],
  },
  k_khiva: {
    culture: :karluk, # localized as Uzbek
    religion: :sunni,
    name: "Uzbekisan / Uzkekistani",
    liege: {end_ww1: "e_russia", fall_soviet_union: nil},
  },
  k_khotan: {
    culture: :uyghur, # China, but autonomous region is mostly Uyghur
    religion: :buddhist,
    # Qing conquest
    name: {times_immemorial: "Dzungar / Dzungarian", fall_dzungar: "Xinjiang / Xinjiang"},
  },
  d_esthonia: {
    culture: :ugricbaltic,
    religion: :protestant,
    liege: {annexation_estonia: "e_russia", fall_soviet_union: nil},
  },
  d_lithuanians: {
    culture: :lithuanian,
    religion: :catholic,
    liege: {annexation_lithuania: "e_russia", fall_soviet_union: nil},
  },
  k_finland: {
    culture: :finnish,
    religion: :protestant,
    capital: :c_finland,
    name: "Finland / Finnish",
    liege: {end_of_swedish_finland: "e_russia", end_ww1: nil},
  },
  d_livonia: {
    culture: :lettigallish,
    religion: :protestant,
    capital: :c_riga,
    name: "Latvia / Latvian",
    liege: {annexation_latvia: "e_russia", fall_soviet_union: nil},
  },
  d_azerbaijan: {
    culture: :turkish, # close enough
    religion: :shiite,
    liege: {annexation_azerbaijan: "e_russia", fall_soviet_union: nil},
  },
  d_armenia: {
    culture: :armenian,
    religion: :orthodox,
    liege: {annexation_armenia: "e_russia", fall_soviet_union: nil},
  },
  d_nefoud: {
    culture: :bedouin_arabic,
    religion: :sunni,
  },
  d_medina: {
    culture: :bedouin_arabic,
    religion: :sunni,
  },
  k_iraq: {
    culture: :levantine_arabic,
    religion: :shiite,
    capital: :c_baghdad,
    name: "Iraq / Iraqi",
    liege: {british_iraq: "e_britannia", iraq_independence: nil},
  },
  k_arabia: {
    culture: :bedouin_arabic,
    religion: :sunni,
  },
  k_hungary: {
    culture: :hungarian,
    religion: :catholic,
    capital: :c_pest,
    demesne: ["d_esztergom"],
  },
  k_georgia: {
    culture: :georgian,
    religion: :orthodox,
    liege: {annexation_georgia: "e_russia", fall_soviet_union: nil},
  },
  k_ruthenia: {
    culture: :ukrainian, # Unique Ukrainian culture
    religion: :orthodox,
    name: "Ukraine / Ukrainian",
    liege: {end_ww1: "e_russia", fall_soviet_union: nil},
    demesne: ["d_pereyaslavl"],
  },
  k_belarus: {
    culture: :belarusian, # Unique Belarusian culture
    religion: :orthodox,
    capital: :c_minsk,
    name: "Belarus / Belarussian",
    liege: {end_ww1: "e_russia", fall_soviet_union: nil},
  },
  k_mongolia: {
    culture: :mongol,
    religion: :buddhist,
    liege: nil,
  },
  d_carinthia: {
    culture: :carantanian,
    religion: :catholic,
    name: "Slovenia / Slovenian",
    capital: :c_steiermark,
  },
  k_croatia: {
    culture: :croatian,
    religion: :catholic,
    capital: :c_zagreb,
  },
  d_bosnia: {
    culture: :croatian,
    religion: :sunni,
  },
  k_serbia: {
    culture: :serbian,
    religion: :orthodox,
    capital: :c_belgrade,
    name: {end_ww1: "Yugoslavia / Yugoslavian", montenegro_independence: nil},
  },
  d_strymon: {
    culture: :serbian,
    religion: :orthodox,
    capital: :c_ochrid,
    name: "Macedonia / Macedonian",
  },
  k_egypt: {
    culture: :egyptian_arabic,
    religion: :sunni,
    liege: {times_immemorial: "e_arabia", british_egypt: "e_britannia", egypt_independence: nil},
    demesne: ["d_alexandria"],
  },
  k_syria: {
    culture: :levantine_arabic,
    religion: :shiite,
    demesne: ["d_tripoli"], # traditional Alawite lands
  },
  d_galilee: {
    culture: :levantine_arabic,
    religion: :monothelite,
    name: "Lebanon / Lebanese",
  },
  d_oultrejourdain: {
    culture: :levantine_arabic,
    religion: :sunni,
    name: "Jordan / Jordanian",
    liege: {end_ww1: "e_britannia", jordan_independence: nil},
  },
  k_israel: {
    culture: :ashkenazi,
    religion: :jewish,
    capital: :c_jerusalem,
  },
  d_arabia_felix: {
    culture: :bedouin_arabic,
    religion: :sunni,
    capital: :c_sanaa,
    name: "North Yemen / North Yemeni",
  },
  d_sanaa: {
    culture: :bedouin_arabic,
    religion: :sunni,
    capital: :c_aden,
    name: {times_immemorial: "Yemen / Yemeni", south_yemen_independence: "South Yemen / South Yemeni", yemen_unification: "Yemen / Yemeni"},
  },
  d_afar: {
    culture: :somali,
    religion: :sunni,
    capital: :c_tadjoura,
    name: "Djibouti / Djiboutian",
  },
  d_hayya: {
    culture: :nubian,
    religion: :miaphysite,
    capital: :c_massawa,
    name: "Eritrea / Eritrean",
  },
  d_harer: {
    culture: :somali,
    religion: :sunni,
    name: "Somalia / Somali",
  },
  k_abyssinia: {
    culture: :ethiopian,
    religion: :miaphysite,
    name: "Ethiopia / Ethiopian",
    demesne: ["d_gojjam"],
  },
  k_ghana: {
    culture: :manden,
    religion: :sunni,
    name: "Mauritania / Mauritanian",
  },
  d_ghana: {
    culture: :manden,
    religion: :sunni,
    autoholders: true, # 1818.6.3..1884.12.26
  },
  d_songhay: {
    culture: :songhay,
    religion: :sunni,
  },
  d_gurma: {
    culture: :songhay,
    religion: :sunni,
    autoholders: true,
  },
  d_mali: { # Fake pre-colonization state
    culture: :manden,
    religion: :sunni,
    autoholders: true, # 1818.6.3..1892.1.1
  },
  d_tagant: {
    culture: :soninke,
    religion: :sunni,
    autoholders: true,
  },
  d_timbuktu: {
    culture: :soninke,
    religion: :sunni,
    autoholders: true,
  },
  d_yatenga: {
    culture: :manden,
    religion: :sunni,
    autoholders: true,
  },
  d_bambuk: {
    culture: :manden,
    religion: :sunni,
    autoholders: true,
  },
  k_mali: {
    culture: :manden,
    religion: :sunni,
    capital: :c_mali,
  },
  d_kanem: {
    culture: :kanuri,
    religion: :sunni,
    autoholders: true,
  },
  d_bornu: {
    culture: :zaghawa,
    religion: :sunni,
    autoholders: true,
  },
  d_wadai: {
    culture: :daju,
    religion: :sunni,
    autoholders: true,
  },
  d_kebbi: {
    culture: :hausa,
    religion: :sunni,
    autoholders: true,
  },
  d_air: {
    culture: :maghreb_arabic,
    religion: :sunni,
    autoholders: true,
  },
  d_hausaland: {
    culture: :hausa,
    religion: :sunni,
    autoholders: true,
  },
  k_nubia: {
    culture: :nubian,
    religion: :sunni,
    name: "Sudan / Sudanese",
    liege: {sudan_turkish: "e_arabia", british_egypt: "e_britannia", sudan_independence: nil},
    autoholders: [:times_immemorial..:sudan_independence],
  },
  k_dacia: {
    culture: :romanian,
    religion: :orthodox,
    capital: :c_turnu,
    name: "Romania / Romanian",
  },
  d_moldau: {
    culture: :romanian,
    religion: :orthodox,
    capital: :c_torki,
    name: "Moldova / Moldovan",
    liege: {soviet_partition_of_romania: "e_russia", fall_soviet_union: nil},
  },
  d_dyrrachion: {
    culture: :arberian,
    religion: :sunni,
    capital: :c_zeta,
    name: "Albania / Albanian",
  },
  d_dioclea: {
    culture: :serbian,
    religion: :orthodox,
    capital: :c_travunia,
    name: "Montenegro / Montenegrin",
  },
  d_oman: {
    culture: :bedouin_arabic,
    religion: :ibadi,
  },
  c_dhu_zabi: {
    culture: :bedouin_arabic,
    religion: :sunni,
    name: "Abu Dhabi / Abu Dhabian",
  },
  # Yes, this is Catholic ruler and Protestant population
  # This was Saxony before 3.0 :-/
  d_lausitz: {
    culture: :german,
    religion: :catholic,
    name: "Saxony / Saxon",
    liege: {german_unification: "e_germany", end_ww1: nil},
  },
  d_saxony: {
    culture: :german,
    religion: :protestant,
    name: "Brunswick / Brunswickian",
  },
  k_poland: {
    culture: :polish,
    religion: :catholic,
    capital: :c_plock, # Not Krakow
    demesne: ["d_lesser_poland"],
    liege: {congress_of_vienna: "e_russia", end_ww1: nil},
  },
  d_bavaria: {
    culture: :german,
    religion: :catholic,
    liege: {german_unification: "e_germany", end_ww1: nil},
  },
  d_salzburg: {
    culture: :german,
    religion: :catholic,
  },
  e_wendish_empire: {
    culture: :polish,
    religion: :catholic,
    name: "Commonwealth / Commonwealth",
  },
  k_genoa: {
    culture: :italian,
    religion: :catholic,
  },
  k_venice: {
    culture: :italian,
    religion: :catholic,
  },
  c_lucca: {
    culture: :italian,
    religion: :catholic,
  },
  c_parma: {
    culture: :italian,
    religion: :catholic,
  },
  c_modena: {
    culture: :italian,
    religion: :catholic,
  },
  c_urbino: {
    culture: :italian,
    religion: :catholic,
  },
  c_mantua: {
    culture: :italian,
    religion: :catholic,
  },
  d_toscana: {
    culture: :italian,
    religion: :catholic,
  },
  k_sicily: { # Kingdom of Sicily (Naples), then as Kingdom of Two Sicilies
    culture: :italian,
    religion: :catholic,
  },
  d_sicily: { # Kingdom of Sicily (island of Sicily)
    culture: :italian,
    religion: :catholic,
  },
  c_krakowskie: {
    culture: :polish,
    religion: :catholic,
  },
  c_alania: {
    culture: :alan,
    religion: :sunni,
    name: "Chechnya / Chechen",
  },
  d_samarkand: {
    culture: :karluk, # localized as Uzbek
    religion: :sunni,
    name: "Bukhara / Bukharan",
  },
  d_khiva: {
    culture: :karluk, # localized as Uzbek
    religion: :sunni,
  },
  k_scotland: {
    culture: :scottish,
    religion: :reformed,
    liege: {scotland_devolution: "e_britannia"},
  },
  d_abkhazia: {
    culture: :georgian,
    religion: :sunni,
    name: {forever_ago: "Circassia / Circassian", russia_circassia_war: nil},
  },
  k_punjab: {
    culture: :panjabi,
    religion: :hindu, # actually Sikh
  },
  k_sindh: {
    culture: :sindhi,
    religion: :sunni,
  },
  d_baluchistan: {
    culture: :baloch,
    religion: :sunni,
  },
  ### Just to deal with UK vassal limit issue
  k_bihar: {
    culture: :bengali,
    religion: :buddhist,
    liege: {battle_of_buxar: "e_britannia", india_independence: nil},
    autoholders: true,
  },
  k_gondwana: {
    culture: :hindustani,
    religion: :hindu,
    liege: {third_maratha_war: "e_britannia", india_independence: nil},
    autoholders: true,
  },
  k_kamarupa: {
    culture: :assamese,
    religion: :buddhist,
    liege: {british_assam: "e_britannia", india_independence: nil},
    name: "Assam / Assamese",
    autoholders: true,
  },
  k_andhra: {
    culture: :telugu,
    religion: :hindu,
    liege: {andhra_british: "e_britannia", india_independence: nil},
    autoholders: true,
  },
  k_karnata: {
    culture: :kannada,
    religion: :jain,
    liege: {fourth_mysore_war: "e_britannia", india_independence: nil},
    autoholders: true,
  },
  k_telingana: {
    culture: :telugu,
    religion: :hindu,
    liege: {hyderabad_british: "e_britannia", india_independence: nil},
    autoholders: true,
  },
  k_tamilakam: {
    culture: :tamil,
    religion: :hindu,
    liege: {fourth_mysore_war: "e_britannia", india_independence: nil},
    autoholders: true,
  },
  k_orissa: {
    culture: :oriya,
    religion: :hindu,
    liege: {orissa_british: "e_britannia", india_independence: nil},
    autoholders: true,
  },
  k_malwa: {
    culture: :english,
    religion: :hindu,
    liege: {third_maratha_war: "e_britannia", india_independence: nil},
    autoholders: true,
  },
  k_gujarat: {
    culture: :gujurati,
    religion: :jain,
    liege: {third_maratha_war: "e_britannia", india_independence: nil},
    autoholders: true,
  },
  k_delhi: {
    culture: :hindustani,
    religion: :buddhist,
    liege: {third_maratha_war: "e_britannia", india_independence: nil},
    autoholders: true,
  },
  k_kosala: {
    culture: :hindustani,
    religion: :buddhist,
    liege: {third_maratha_war: "e_britannia", india_independence: nil},
    autoholders: true,
  },
  k_maharastra: {
    culture: :marathi,
    religion: :jain,
    liege: {third_maratha_war: "e_britannia", india_independence: nil},
    autoholders: true,
  },
  k_rajputana: {
    culture: :rajput,
    religion: :jain,
    liege: {third_maratha_war: "e_britannia", india_independence: nil},
    autoholders: true,
  },
  d_jerusalem: {
    culture: :english,
    religion: :protestant,
    liege: {end_ww1: "e_britannia", israel_independence: nil},
    autoholders: true,
  },

  ### Holy orders
  # d_huitzilopochtli: { culture: :nahuatl, religion: :aztec_reformed, autoholders: true, male: true},
  # d_chosen_perkunas: { culture: :lettigallish, religion: :baltic_pagan_reformed, autoholders: true, male: true},
  d_ashokas_chosen: {culture: :marathi, religion: :buddhist, autoholders: true, male: true},
  d_knights_santiago: {culture: :castillan, religion: :catholic, autoholders: true, male: true},
  d_knights_hospitaler: {culture: :occitan, religion: :catholic, autoholders: true, male: true},
  d_teutonic_order: {culture: :german, religion: :catholic, autoholders: true, male: true},
  d_knights_templar: {culture: :frankish, religion: :catholic, autoholders: true, male: true},
  d_knights_calatrava: {culture: :castillan, religion: :catholic, autoholders: true, male: true},
  # d_sons_kaleva: { culture: :finnish, religion: :finnish_pagan_reformed, autoholders: true, male: true},
  d_followers_arjuna: {culture: :hindustani, religion: :hindu, autoholders: true, male: true},
  d_haruriyyah: {culture: :bedouin_arabic, religion: :ibadi, autoholders: true, male: true},
  d_bulls_rishabha: {culture: :kannada, religion: :jain, autoholders: true, male: true},
  d_zealots: {culture: :ashkenazi, religion: :jewish, autoholders: true, male: true},
  d_saint_anthony: {culture: :ethiopian, religion: :miaphysite, autoholders: true, male: true},
  d_saint_addai: {culture: :persian, religion: :nestorian, autoholders: true, male: true},
  # d_jomsvikings: { culture: :norse, religion: :norse_pagan, autoholders: true, male: true},
  d_holy_sepulchre: {culture: :greek, religion: :orthodox, autoholders: true, male: true},
  d_hashshashin: {culture: :persian, religion: :shiite, autoholders: true, male: true},
  # d_warriors_perun: { culture: :russian, religion: :slavic_pagan_reformed, autoholders: true, male: true},
  d_bektashi: {culture: :persian, religion: :sunni, autoholders: true, male: true},
  # d_sky_lords: { culture: :cuman, religion: :tengri_pagan_reformed, autoholders: true, male: true},
  # d_spirit_guardians: { culture: :manden, religion: :west_african_pagan_reformed, autoholders: true, male: true},
  # d_immortals: { culture: :persian, religion: :zoroastrian, autoholders: true, male: true},
  # d_zun_warriors: { culture: :afghan, religion: :zun_pagan_reformed, autoholders: true, male: true},

  ### Just renames or capital moves, not actual countries
  k_crimea: {
    culture: :bolghar,
    religion: :sunni,
    name: "Crimea / Crimean",
  },
  k_vladimir: {
    culture: :russian,
    religion: :orthodox,
    name: "Muscovy / Muscovite",
  },
  d_holstein: {
    culture: :german,
    religion: :protestant,
    capital: :c_hamburg,
  },
  k_volga_bulgaria: {
    culture: :bolghar,
    religion: :finnish_pagan,
    name: "Volga / Volgan",
  },
  k_kanem: {
    name: "Chad / Chadian",
    culture: :kanuri, # ???
    religion: :sunni,
  },
  k_hausaland: {
    name: "Niger / Nigerien",
    culture: :hausa, # ???
    religion: :sunni,
  },
  c_saargau: {
    culture: :german,
    religion: :catholic,
  },
}

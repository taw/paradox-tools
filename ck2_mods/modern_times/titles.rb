ModernTimesDatabase::TITLES = {
  e_britannia: {
    culture: :english,
    religion: :protestant,
    capital: :c_middlesex,
    name: "United Kingdom / British",
    demesne: ["d_somerset"],
  },
  k_ireland: {
    culture: :irish,
    religion: :catholic,
    capital: :c_dublin,
    name: "Ireland / Irish",
    demesne: ["d_leinster"]
  },
  d_iceland: {
    culture: :norwegian,
    religion: :protestant,
    capital: :c_vestisland,
    name: "Iceland / Icelandic",
    liege: { times_immemorial: "k_denmark", iceland_independence: nil },
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
    name: "Piedmont-Sardinia / Piedmontese-Sardinian",
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
  d_luxembourg: {
    culture: :dutch,
    religion: :catholic,
    capital: :c_luxembourg,
  },
  e_russia: {
    culture: :russian,
    religion: :orthodox,
    capital: :c_moskva,
    name: { end_ww1: "Soviet Union / Soviet", fall_soviet_union: nil},
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
    name: "Prussia / Prussian",
    demesne: ["d_prussia"],
  },
  e_germany: {
    culture: :german,
    religion: :catholic,
    # It was outside country (as Berlin was 1945-1990)
    # b_bonn is non-existent barony in d_koln/c_koln
    capital: :c_brandenburg,
    name: {times_immemorial: "Germany / German", end_ww2: "West Germany / West German", german_reunification: "Germany / German" },
    demesne: ["d_koln"],
  },
  c_danzig: {
    culture: :german,
    religion: :catholic,
  },
  k_saxony: {
    culture: :german,
    religion: :protestant,
    capital: :c_brandenburg,
    name: "East Germany / East German",
    demesne: ["d_saxony"],
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
  c_bremen: {
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
  },
  d_baden: {
    culture: :german,
    religion: :catholic,
  },
  d_swabia: {
    culture: :german,
    religion: :protestant,
    name: "Württemberg / Württembergian",
  },
  d_brunswick: {
    culture: :german,
    religion: :protestant,
    name: "Hannover / Hannoverian",
  },
  c_weimar: {
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
    name: { czechoslovakia_independence: "Czechoslovakia / Czechoslovak",  czechoslovakia_dissolution: nil},
    demesne: [], # 5 counties is enough
  },
  d_nyitra: {
    culture: :bohemian,
    religion: :catholic,
    capital: :c_pressburg,
    name: "Slovakia / Slovak",
  },
  k_burgundy: {
    culture: :german,
    religion: :reformed,
    capital: :c_bern,
    name: "Switzerland / Swiss",
    demesne: [],
  },
  e_arabia: {
    culture: :turkish,
    religion: :sunni,
    capital: :c_byzantion,
    name: "Ottoman Empire / Ottoman",
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
  # Avoids silliness of ISIS making this primary and two Syrias on the map
  d_syria: {
    culture: :levantine_arabic,
    religion: :sunni,
    name: "East Syria / East Syrian",
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
    capital: :c_atheniai,
    demesne: ["d_thessalonika"],
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
    name: "Pakistan / Pakistani",
  },
  k_afghanistan: {
    culture: :afghan,
    religion: :sunni,
    capital: :c_kabul,
  },
  k_mesopotamia: {
    culture: :levantine_arabic,
    religion: :shiite,
    capital: :c_baghdad,
    name: "Iraq / Iraqi",
    liege: {british_iraq: "e_britannia", iraq_independence: nil},
  },
  c_kuwait: {
    culture: :bedouin_arabic,
    religion: :sunni,
  },
  c_bahrein: {
    culture: :bedouin_arabic,
    religion: :sunni,
  },
  k_persia: {
    culture: :persian,
    religion: :shiite,
    capital: :c_rayy,
    name: {"1925.12.15" => "Iran / Iranian"},
    demesne: ["d_esfahan"],
  },
  k_bengal: {
    culture: :bengali,
    religion: :sunni,
    capital: :c_bikrampur,
    name: "Bangladesh / Bangladeshi",
  },
  d_dihistan: {
    culture: :turkish,
    religion: :sunni,
    name: "Turkmenistan / Turkmenistani",
    liege: { end_ww1: "e_russia", fall_soviet_union: nil },
  },
  k_cuman: {
    culture: :cuman,
    religion: :sunni,
    name: "Kazakhstan / Kazakh",
    capital: "c_kimak",
    liege: { end_ww1: "e_russia", fall_soviet_union: nil },
    demesne: ["d_zhetysu"],
  },
  k_khiva: {
    culture: :karluk,
    religion: :sunni,
    name: "Uzbekisan / Uzkekistani",
    liege: { end_ww1: "e_russia", fall_soviet_union: nil },
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
  },
  d_courland: {
    culture: :lettigallish,
    religion: :protestant,
    capital: :c_zemigalians,
    name: "Latvia / Latvian",
    liege: {annexation_latvia: "e_russia", fall_soviet_union: nil},
  },
  k_poland: {
    culture: :polish,
    religion: :catholic,
    capital: :c_plock, # Not Krakow
    demesne: ["d_lesser_poland"],
  },
  d_azerbaijan: {
    culture: :persian, # close enough
    religion: :shiite,
    liege: { annexation_azerbaijan: "e_russia", fall_soviet_union: nil },
  },
  d_armenia: {
    culture: :armenian,
    religion: :orthodox,
    liege: { annexation_armenia: "e_russia", fall_soviet_union: nil },
  },
  k_egypt: {
    culture: :egyptian_arabic,
    religion: :sunni,
    liege: { times_immemorial: "e_arabia", british_egypt: "e_britannia", egypt_independence: nil },
    demesne: ["d_alexandria"],
  },
  d_nefoud: {
    culture: :bedouin_arabic,
    religion: :sunni,
  },
  d_medina: {
    culture: :bedouin_arabic,
    religion: :sunni,
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
    liege: { annexation_georgia: "e_russia", fall_soviet_union: nil },
  },
  k_ruthenia: {
    culture: :russian, # :volhynian but it would autoconvert anyway
    religion: :orthodox,
    name: "Ukraine / Ukrainian",
    liege: { end_ww1: "e_russia", fall_soviet_union: nil },
    demesne: ["d_pereyaslavl"],
  },
  d_vitebsk: {
    culture: :russian, # :severian but it would autoconvert anyway
    religion: :orthodox,
    capital: :c_minsk,
    name: "Belarus / Belarussian",
    liege: { end_ww1: "e_russia", fall_soviet_union: nil },
  },
  k_mongolia: {
    culture: :mongol,
    religion: :sunni,
  },
  d_carinthia: {
    culture: :croatian,
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
    name: { end_ww1: "Yugoslavia / Yugoslavian", montenegro_independence: nil}
  },
  d_dyrrachion: {
    culture: :serbian,
    religion: :orthodox,
    capital: :c_ochrid,
    name: "Macedonia / Macedonian",
  },
  k_syria: {
    culture: :levantine_arabic,
    religion: :shiite,
    demesne: ["d_tripoli"], # traditional Alawite lands
  },
  d_galilee: {
    culture: :levantine_arabic,
    religion: :sunni,
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
    capital: :c_acre,
  },
  d_sanaa: {
    culture: :bedouin_arabic,
    religion: :sunni,
    capital: :c_aden,
    name: { times_immemorial: "Yemen / Yemeni", south_yemen_independence: "South Yemen / South Yemeni", yemen_unification: "Yemen / Yemeni" },
  },
  d_arabia_felix: {
    culture: :bedouin_arabic,
    religion: :sunni,
    capital: :c_sanaa,
    name: "North Yemen / North Yemeni",
  },
  d_afar: {
    culture: :somali,
    religion: :sunni,
    capital: :c_tadjoura,
    name: "Djibouti / Djiboutian"
  },
  d_hayya: {
    culture: :nubian,
    religion: :sunni,
    capital: :c_massawa,
    name: "Eritrea / Eritrean",
  },
  d_harer: {
    culture: :somali,
    religion: :sunni,
    name: "Somalia / Somali",
  },
  k_abyssinia:  {
    culture: :ethiopian,
    religion: :miaphysite,
    name: "Ethiopia / Ethiopian",
    demesne: ["d_gojjam"],
  },
  d_timbuktu: {
    culture: :manden,
    religion: :sunni,
    name: "Mauritania / Mauritanian",
  },
  d_ghana: {
    culture: :manden,
    religion: :sunni,
  },
  d_songhay: {
    culture: :manden,
    religion: :sunni,
  },
  d_mali: {
    culture: :manden,
    religion: :sunni,
  },
  k_mali: {
    culture: :manden,
    religion: :sunni,
    capital: :c_mali,
  },
  k_nubia: {
    culture: :nubian,
    religion: :sunni,
    name: "Sudan / Sudanese",
    liege: { sudan_turkish: "e_arabia", british_egypt: "e_britannia", sudan_independence: nil},
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
    liege: { soviet_partition_of_romania: "e_russia", fall_soviet_union: nil },
  },
  d_dioclea: {
    culture: :serbian,
    religion: :sunni,
    capital: :c_zeta,
    name: "Albania / Albanian",
  },
  c_ragusa: {
    culture: :serbian,
    religion: :orthodox,
    name: "Montenegro / Montenegrin",
  },
  d_oman: {
    culture: :bedouin_arabic,
    religion: :ibadi,
  },
  c_dhu_zabi: {
    culture: :bedouin_arabic,
    religion: :sunni,
  },
  # special Holy Order
  d_hashshashin: {
    culture: :persian,
    religion: :shiite,
    autoholders: true,
  },
  # Yes, this is Catholic ruler and Protestant population
  d_saxony: {
    culture: :german,
    religion: :catholic,
  },
  d_bavaria: {
    culture: :german,
    religion: :catholic,
  },
  c_salzburg: {
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
  k_sicily: {
    culture: :italian,
    religion: :catholic,
  },
  c_lucca: {
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
    culture: :karluk,
    religion: :sunni,
    name: "Bukhara / Bukharan",
  },
  d_khiva: {
    culture: :karluk,
    religion: :sunni,
  },
  k_scotland: {
    culture: :scottish,
    religion: :reformed,
    liege: { scotland_devolution: "e_britannia" },
  },
  d_abkhazia: {
    culture: :georgian,
    religion: :sunni,
    name: { forever_ago: "Circassia / Circassian", russia_circassia_war: nil },
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
    liege: { third_maratha_war: "e_britannia", india_independence: nil },
    autoholders: true,
  },
  k_gondwana: {
    culture: :hindustani,
    religion: :hindu,
    liege: { third_maratha_war: "e_britannia", india_independence: nil },
    autoholders: true,
  },
  k_kamarupa: {
    culture: :assamese,
    religion: :buddhist,
    liege: { third_maratha_war: "e_britannia", india_independence: nil },
    autoholders: true,
  },
  k_andhra: {
    culture: :telugu,
    religion: :hindu,
    liege: { third_maratha_war: "e_britannia", india_independence: nil },
    autoholders: true,
  },
  k_karnata: {
    culture: :kannada,
    religion: :jain,
    liege: { third_maratha_war: "e_britannia", india_independence: nil },
    autoholders: true,
  },
  k_telingana: {
    culture: :telugu,
    religion: :hindu,
    liege: { third_maratha_war: "e_britannia", india_independence: nil },
    autoholders: true,
  },
  k_tamilakam: {
    culture: :tamil,
    religion: :hindu,
    liege: { third_maratha_war: "e_britannia", india_independence: nil },
    autoholders: true,
  },
  k_orissa: {
    culture: :oriya,
    religion: :hindu,
    liege: { third_maratha_war: "e_britannia", india_independence: nil },
    autoholders: true,
  },
  k_malwa: {
    culture: :english,
    religion: :hindu,
    liege: { third_maratha_war: "e_britannia", india_independence: nil },
    autoholders: true,
  },
  k_gujarat: {
    culture: :gujurati,
    religion: :jain,
    liege: { third_maratha_war: "e_britannia", india_independence: nil },
    autoholders: true,
  },
  k_delhi: {
    culture: :hindustani,
    religion: :buddhist,
    liege: { third_maratha_war: "e_britannia", india_independence: nil },
    autoholders: true,
  },
  k_kosala: {
    culture: :hindustani,
    religion: :buddhist,
    liege: { third_maratha_war: "e_britannia", india_independence: nil },
    autoholders: true,
  },
  k_maharastra: {
    culture: :marathi,
    religion: :jain,
    liege: { third_maratha_war: "e_britannia", india_independence: nil },
    autoholders: true,
  },
  k_rajputana: {
    culture: :rajput,
    religion: :jain,
    liege: { third_maratha_war: "e_britannia", india_independence: nil },
    autoholders: true,
  },
  d_jerusalem: {
    culture: :english,
    religion: :protestant,
    liege: {end_ww1: "e_britannia", israel_independence: nil},
    autoholders: true,
  },

  ### Just renames or capital moves, not actual countries
  k_taurica: {
    culture: :bolghar,
    religion: :sunni,
    name: "Crimea / Crimean",
  },
  k_rus: {
    culture: :russian,
    religion: :orthodox,
    name: "Muscovy / Muscovite",
  },
  d_holstein: {
    culture: :german,
    religion: :protestant,
    capital: :c_hamburg,
  },
}

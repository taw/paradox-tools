ModernTimesDatabase::TITLES = {
  e_britannia: {
    culture: :english,
    religion: :fraticelli,
    capital: :c_middlesex,
    name: "United Kingdom / British",
  },
  k_ireland: {
    culture: :irish,
    religion: :catholic,
    capital: :c_dublin,
    name: "Ireland / Irish",
  },
  d_iceland: {
    culture: :norwegian,
    religion: :waldensian,
    capital: :c_vestisland,
    name: "Iceland / Icelandic",
  },
  k_portugal: {
    culture: :portuguese,
    religion: :catholic,
    capital: :c_lisboa,
  },
  e_spain: {
    culture: :castillan,
    religion: :catholic,
    capital: :c_toledo,
    name: "Spain / Spanish",
  },
  e_france: {
    culture: :frankish,
    religion: :catholic,
    capital: :c_ile_de_france,
    name: "France / French",
  },
  k_papal_state: {
    culture: :italian,
    religion: :catholic,
    capital: :c_roma,
  },
  e_italy: {
    culture: :italian,
    religion: :catholic,
    capital: :c_orvieto,
    name: "Italy / Italian",
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
    religion: :waldensian,
    capital: :c_sjaelland,
    name: "Denmark / Danish",
  },
  k_sweden: {
    culture: :swedish,
    religion: :waldensian,
    capital: :c_uppland,
  },
  k_norway: {
    culture: :norwegian,
    religion: :waldensian,
    capital: :c_bergenshus,
    name: "Norway / Norwegian",
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
  },
  e_india: {
    culture: :hindustani,
    religion: :hindu,
    capital: :c_delhi,
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
  },
  d_flanders: {
    culture: :dutch,
    religion: :catholic,
    capital: :c_brabant,
    name: "Belgium / Belgian",
  },
  k_frisia: {
    culture: :dutch,
    religion: :waldensian,
    capital: :c_breda,
    name: "Netherlands / Dutch",
  },
  e_carpathia: {
    culture: :german,
    religion: :catholic,
    capital: :c_osterreich,
    name: "Austria / Austrian",
  },
  e_germany: {
    culture: :german,
    religion: :catholic,
    # This is silly, but we want to have:
    # * no capitals outside country (as Berlin was 1945-1990)
    # * no bishoprics in capital duchy (Koln/Munich)
    # * no cities in capital duchy (Hamburg)
    capital: :c_nassau,
    name: {start: "Germany / German", end_ww2: "West Germany / West German", german_reunification: "Germany / German" }
  },
  d_pomeralia: {
    culture: :german,
    religion: :catholic,
    capital: :c_danzig,
    name: "Danzig / Danziger",
  },
  k_saxony: {
    culture: :german,
    religion: :catholic,
    capital: :c_brandenburg,
    name: "East Germany / East German",
  },
  k_bohemia: {
    culture: :bohemian,
    religion: :catholic,
    capital: :c_praha,
    name: { czechoslovakia_independence: "Czechoslovakia / Czechoslovak",  czechoslovakia_dissolution: nil}
  },
  d_nyitra: {
    culture: :bohemian,
    religion: :catholic,
    capital: :c_pressburg,
    name: "Slovakia / Slovak",
  },
  k_burgundy: {
    culture: :german,
    religion: :waldensian,
    capital: :c_bern,
    name: "Switzerland / Swiss",
  },
  e_seljuk_turks: {
    culture: :turkish,
    religion: :sunni,
    capital: :c_byzantion,
    name: { start: "Ottoman Empire / Ottomans", end_ww1: "Turkey / Turkish" },
  },
  # TODO: Ottoman caliphate (or maybe ISIS caliphate even)
  d_sunni: {
    culture: :levantine_arabic,
    religion: :sunni,
    capital: :c_mosul, # not true
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
  },
  k_bulgaria: {
    culture: :bulgarian,
    religion: :orthodox,
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
  },
  c_kuwait: {
    culture: :bedouin_arabic,
    religion: :sunni,
  },
  c_bahrein: {
    culture: :bedouin_arabic,
    religion: :sunni,
  },
  e_persia: {
    culture: :persian,
    religion: :shiite,
    capital: :c_esfahan,
    name: "Iran / Iranian",
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
  },
  k_cuman: {
    culture: :cuman,
    religion: :sunni,
    name: "Kazakhstan / Kazakh"
  },
  k_khiva: {
    culture: :karluk,
    religion: :sunni,
    name: "Uzbekisan / Uzkekistani",
  },
  k_khotan: {
    culture: :uyghur, # China, but autonomous region is mostly Uyghur
    religion: :buddhist,
    name: "Xinjiang / Xinjiang",
  },
  d_esthonia: {
    culture: :ugricbaltic,
    religion: :waldensian,
  },
  d_lithuanians: {
    culture: :lithuanian,
    religion: :catholic,
  },
  k_finland: {
    culture: :finnish,
    religion: :waldensian,
    capital: :c_finland,
    name: "Finland / Finnish",
  },
  d_courland: {
    culture: :lettigallish,
    religion: :waldensian,
    capital: :c_zemigalians,
    name: "Latvia / Latvian",
  },
  k_poland: {
    culture: :polish,
    religion: :catholic,
    capital: :c_plock, # Not Krakow
  },
  d_azerbaijan: {
    culture: :persian, # close enough
    religion: :shiite,
  },
  d_armenia: {
    culture: :armenian,
    religion: :orthodox,
  },
  k_egypt: {
    culture: :egyptian_arabic,
    religion: :sunni,
  },
  k_arabia: {
    culture: :bedouin_arabic,
    religion: :sunni,
  },
  k_hungary: {
    culture: :hungarian,
    religion: :catholic,
  },
  k_georgia: {
    culture: :georgian,
    religion: :orthodox,
  },
  k_ruthenia: {
    culture: :russian, # :volhynian but it would autoconvert anyway
    religion: :orthodox,
    name: "Ukraine / Ukrainian",
  },
  d_vitebsk: {
    culture: :russian, # :severian but it would autoconvert anyway
    religion: :orthodox,
    capital: :c_minsk,
    name: "Belarus / Belarussian",
  },
  k_mongolia: {
    culture: :mongol,
    religion: :sunni,
  },
  d_carinthia: {
    culture: :croatian,
    religion: :catholic,
    name: "Slovenia / Slovenian",
    capital: :c_steimark,
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
    name: { start: nil, end_ww1: "Yugoslavia / Yugoslavian", montenegro_independence: nil}
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
    name: { start: "Yemen / Yemeni", south_yemen_independence: "South Yemen / South Yemeni", yemen_unification: "Yemen / Yemeni" },
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
  },
  d_songhay: {
    culture: :manden,
    religion: :sunni,
    name: "Mali / Malian",
  },
  k_mali: {
    culture: :manden,
    religion: :sunni,
    name: "Mauritania / Mauritanian",
  },
  k_nubia: {
    culture: :nubian,
    religion: :sunni,
    name: "Sudan / Sudanese",
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
    religion: :sunni,
  },
  c_dhu_zabi: {
    culture: :bedouin_arabic,
    religion: :sunni,
  },
}

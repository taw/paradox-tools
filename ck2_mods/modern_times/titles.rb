module ModernTimes
  TITLES = {
    e_britannia: {
      culture: :english,
      religion: :waldensian,
      capital: :c_middlesex,
    },
    k_ireland: {
      culture: :irish,
      religion: :catholic,
      capital: :c_dublin,
    },
    d_iceland: {
      culture: :norwegian,
      religion: :waldensian,
      capital: :c_vestisland,
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
    },
    e_france: {
      culture: :frankish,
      religion: :catholic,
      capital: :c_ile_de_france,
    },
    k_papacy: {
      culture: :italian,
      religion: :catholic,
      capital: :c_roma,
    },
    e_italy: {
      culture: :italian,
      religion: :catholic,
      capital: :c_orvieto,
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
    },
    d_flanders: {
      culture: :dutch,
      religion: :catholic,
      capital: :c_brabant,
    },
    k_frisia: {
      culture: :dutch,
      religion: :waldensian,
      capital: :c_breda,
    },
    e_carpathia: {
      culture: :german,
      religion: :catholic,
      capital: :c_osterreich,
    },
    e_germany: {
      culture: :german,
      religion: :catholic,
      capital: :c_oberbayern, # temporary
    },
    d_pomeralia: {
      culture: :german,
      religion: :catholic,
      capital: :c_danzig,
    },
    k_saxony: {
      culture: :german,
      religion: :catholic,
      capital: :c_brandenburg,

    },
    k_bohemia: {
      culture: :bohemian,
      religion: :catholic,
      capital: :c_praha,
    },
    d_slovakia: {
      culture: :bohemian,
      religion: :catholic,
      capital: :c_pressburg,
    },
    k_burgundy: {
      culture: :german,
      religion: :catholic,
      capital: :c_bern,
    },
    e_seljuk_turks: {
      culture: :turkish,
      religion: :sunni,
      capital: :c_byzantion,
    },
    # TODO: Ottoman caliphate (or maybe ISIS caliphate even)
    # d_sunni: {
    #   culture: :turkish,
    #   religion: :sunni,
    #   capital: :c_byzantion,
    # },
    d_tunis: {
      culture: :maghreb_arabic,
      religion: :sunni,
      capital: :c_tunis,
    },
    d_tripolitania: {
      culture: :maghreb_arabic,
      religion: :sunni,
      capital: :c_tripolitana,
    },
    d_alger: {
      culture: :maghreb_arabic,
      religion: :sunni,
      capital: :c_al_djazair,
    },
    k_mauretania: {
      culture: :maghreb_arabic,
      religion: :sunni,
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
    },
    k_afghanistan: {
      culture: :afghan,
      religion: :sunni,
      capital: :c_kabul,
    },
    k_mesopotamia: {
      culture: :bedouin_arabic,
      religion: :shiite,
      capital: :c_baghdad,
    },
    d_basra: {
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
    },
    k_bengal: {
      culture: :bengali,
      religion: :sunni,
      capital: :c_bikrampur,
    },
    d_dihistan: {
      culture: :turkish, # ???
      religion: :sunni,
    },
    k_cuman: {
      culture: :turkish, # ???
      religion: :sunni,
    },
    k_khiva: {
      culture: :cuman, # ???
      religion: :sunni,
    },
    k_khotan: {
      culture: :tocharian, # Chinese
      religion: :buddhist,
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
    },
    d_courland: {
      culture: :lettigallish,
      religion: :waldensian,
      capital: :c_zemigalians,
    },
    k_poland: {
      culture: :polish,
      religion: :catholic,
      capital: :c_plock, # Not Krakow
    },
    d_azerbaijan: {
      culture: :persian, # close enough
      religion: :sunni,
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
      culture: :volhynian,
      religion: :orthodox,
    },
    d_minsk: {
      culture: :severian,
      religion: :orthodox,
      capital: :c_minsk,
    },
    k_mongolia: {
      culture: :mongol,
      religion: :sunni,
    },
    d_carinthia: {
      culture: :croatian,
      religion: :catholic,
    },
    k_croatia: {
      culture: :croatian,
      religion: :catholic,
    },
    d_bosnia: {
      culture: :croatian,
      religion: :sunni,
    },
    k_serbia: {
      culture: :serbian,
      religion: :orthodox,
      capital: :c_belgrade,
    },
    d_dyrrachion: {
      culture: :serbian,
      religion: :orthodox,
      capital: :c_ochrid,
    },
    k_syria: {
      culture: :levantine_arabic,
      religion: :shiite,
    },
    d_galilee: {
      culture: :levantine_arabic,
      religion: :sunni,
    },
    d_oultrejourdain: {
      culture: :levantine_arabic,
      religion: :sunni,
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
    },
    d_arabia_felix: {
      culture: :bedouin_arabic,
      religion: :sunni,
      capital: :c_sanaa,
    },
    d_afar: {
      culture: :somali,
      religion: :sunni,
      capital: :c_tadjoura,
    },
    d_hayya: {
      culture: :nubian,
      religion: :sunni,
      capital: :c_massawa,
    },
    d_harer: {
      culture: :somali,
      religion: :sunni,
    },
    k_abyssinia:  {
      culture: :ethiopian,
      religion: :miaphytise,
    },
    d_songhay: {
      culture: :manden,
      religion: :sunni,
    },
    k_mali: {
      culture: :manden,
      religion: :sunni,
    },
    k_nubia: {
      culture: :nubian,
      religion: :sunni,
    },
    k_dacia: {
      culture: :romanian,
      religion: :orthodox,
      capital: :c_turnu,
    },
    d_moldau: {
      culture: :romanian,
      religion: :orthodox,
      capital: :c_torki,
    },
    # Albania, seriously...
    d_dioclea: {
      culture: :serbian,
      religion: :sunni,
      capital: :c_zeta,
    },
    c_ragusa: {
      culture: :serbian,
      religion: :orthodox,
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
end

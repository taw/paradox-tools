###########################################################################
# TODO: k_england -> e_britannia / k_rus -> e_russia

ModernTimesDatabase::LAND = {
  #########################################
  # READY FOR 1600 BOOKMARK

  # Level of actualy Ottoman control was fairly minor
  d_sanaa: {times_immemorial: "e_arabia", aden_protectorate: "e_britannia", south_yemen_independence: "d_sanaa"},
  d_taizz: {times_immemorial: "e_arabia", aden_protectorate: "e_britannia", south_yemen_independence: "d_sanaa"},
  d_socotra: {times_immemorial: "e_arabia", aden_protectorate: "e_britannia", south_yemen_independence: "d_sanaa"},
  c_kathiri: {times_immemorial: "e_arabia", aden_protectorate: "e_britannia", south_yemen_independence: "d_sanaa"},
  c_mahra: {times_immemorial: "e_arabia", aden_protectorate: "e_britannia", south_yemen_independence: "d_sanaa"},
  c_aden: {times_immemorial: "e_arabia", aden_city_british: "e_britannia", south_yemen_independence: "d_sanaa"},

  c_egrisi: {times_immemorial: "e_arabia", treaty_of_adrianople: "d_abkhazia", russia_circassia_war: "e_russia", end_ww1: "k_georgia", abkhazia_war: "e_russia"},
  c_abkhazia: {times_immemorial: "e_arabia", treaty_of_adrianople: "d_abkhazia", russia_circassia_war: "e_russia", end_ww1: "k_georgia", abkhazia_war: "e_russia"},
  c_guria: {times_immemorial: "e_arabia", treaty_of_adrianople: "d_abkhazia", russia_circassia_war: "e_russia", end_ww1: "k_georgia"},
  c_imeretia: {times_immemorial: "e_arabia", treaty_of_adrianople: "d_abkhazia", russia_circassia_war: "e_russia", end_ww1: "k_georgia"},

  d_nikaea: {times_immemorial: "e_arabia", end_of_ottoman_empire: "k_anatolia"},
  d_cappadocia: {times_immemorial: "e_arabia", end_of_ottoman_empire: "k_anatolia"},
  d_optimatoi: {times_immemorial: "e_arabia", end_of_ottoman_empire: "k_anatolia"},
  c_kyzikos: {times_immemorial: "e_arabia", end_of_ottoman_empire: "k_anatolia"},
  c_byzantion: {times_immemorial: "e_arabia", end_of_ottoman_empire: "k_anatolia"},
  d_armeniacon: {times_immemorial: "e_arabia", end_of_ottoman_empire: "k_anatolia"},
  d_thracesia: {times_immemorial: "e_arabia", end_of_ottoman_empire: "k_anatolia"},
  d_anatolia: {times_immemorial: "e_arabia", end_of_ottoman_empire: "k_anatolia"},
  d_charsianon: {times_immemorial: "e_arabia", end_of_ottoman_empire: "k_anatolia"},
  d_trebizond: {times_immemorial: "e_arabia", end_of_ottoman_empire: "k_anatolia"},
  d_paphlagonia: {times_immemorial: "e_arabia", end_of_ottoman_empire: "k_anatolia"},
  d_bucellarian: {times_immemorial: "e_arabia", end_of_ottoman_empire: "k_anatolia"},
  c_abydos: {times_immemorial: "e_arabia", end_of_ottoman_empire: "k_anatolia"},
  d_cibyrrhaeot: {times_immemorial: "e_arabia", end_of_ottoman_empire: "k_anatolia"},
  d_mesopotamia: {times_immemorial: "e_arabia", end_of_ottoman_empire: "k_anatolia"},
  d_coloneia: {times_immemorial: "e_arabia", end_of_ottoman_empire: "k_anatolia"},
  d_armenia_minor: {times_immemorial: "e_arabia", end_of_ottoman_empire: "k_anatolia"},
  c_ani: {times_immemorial: "e_arabia", end_of_ottoman_empire: "k_anatolia"},
  c_vaspurakan: {times_immemorial: "e_arabia", end_of_ottoman_empire: "k_anatolia"},
  d_tao: {times_immemorial: "e_arabia", end_of_ottoman_empire: "k_anatolia"},
  d_samos: {times_immemorial: "e_arabia", end_of_ottoman_empire: "k_anatolia"},
  d_edessa: {times_immemorial: "e_arabia", end_of_ottoman_empire: "k_anatolia"},
  c_amida: {times_immemorial: "e_arabia", end_of_ottoman_empire: "k_anatolia"},
  d_thrace: {times_immemorial: "e_arabia", treaty_of_sevres: "k_byzantium", treaty_of_lausanne: "k_anatolia"},

  d_alexandria: {times_immemorial: "k_egypt"},
  d_cairo: {times_immemorial: "k_egypt"},
  d_aswan: {times_immemorial: "k_egypt"},
  d_damietta: {times_immemorial: "k_egypt"},

  c_sinai: {times_immemorial: "k_egypt", six_day_war: "k_israel", egypt_israel_peace: "k_egypt"},
  c_farama: {times_immemorial: "k_egypt", six_day_war: "k_israel", egypt_israel_peace: "k_egypt"},
  "c_el-arish": {times_immemorial: "k_egypt", six_day_war: "k_israel", egypt_israel_peace: "k_egypt"},

  c_beirut: {times_immemorial: "e_arabia", end_ww1: "e_france", lebanon_independence: "d_galilee"},
  c_tyrus: {times_immemorial: "e_arabia", end_ww1: "e_france", lebanon_independence: "d_galilee"},

  c_eilat: {times_immemorial: "e_arabia", end_ww1: "d_jerusalem", israel_independence: "k_israel"},
  c_negev: {times_immemorial: "e_arabia", end_ww1: "d_jerusalem", israel_independence: "k_israel"},
  d_ascalon: {times_immemorial: "e_arabia", end_ww1: "d_jerusalem", israel_independence: "k_israel"},
  c_acre: {times_immemorial: "e_arabia", end_ww1: "d_jerusalem", israel_independence: "k_israel"},

  c_hebron: {times_immemorial: "e_arabia", end_ww1: "d_jerusalem", israel_independence: "d_oultrejourdain", six_day_war: "k_israel"},
  c_jerusalem: {times_immemorial: "e_arabia", end_ww1: "d_jerusalem", israel_independence: "d_oultrejourdain", six_day_war: "k_israel"},

  c_oromieh: {times_immemorial: "e_arabia", british_iraq: "k_iraq"},
  d_baghdad: {times_immemorial: "e_arabia", british_iraq: "k_iraq"},
  d_samarra: {times_immemorial: "e_arabia", british_iraq: "k_iraq"},
  d_tigris: {times_immemorial: "e_arabia", british_iraq: "k_iraq"},
  d_basra: {times_immemorial: "e_arabia", british_iraq: "k_iraq"},
  d_kurdistan: {times_immemorial: "e_arabia", british_iraq: "k_iraq"},
  c_bira: {times_immemorial: "e_arabia", british_iraq: "k_iraq"},

  c_mosul: {times_immemorial: "e_arabia", british_iraq: "k_iraq", caliphate_reborn: "d_sunni", fall_of_mosul: "k_iraq"},
  c_druz: {times_immemorial: "e_arabia", british_iraq: "k_iraq", caliphate_reborn: "d_sunni", fall_of_mosul: "k_iraq"},
  c_sinjar: {times_immemorial: "e_arabia", british_iraq: "k_iraq", caliphate_reborn: "d_sunni", fall_of_mosul: "k_iraq"},
  c_rahbah: {times_immemorial: "e_arabia", british_iraq: "k_iraq", caliphate_reborn: "d_sunni", fall_of_mosul: "k_iraq"},

  c_tiberias: {times_immemorial: "e_arabia", end_ww1: "e_france", syria_independence: "k_syria", six_day_war: "k_israel"},
  c_safed: {times_immemorial: "e_arabia", end_ww1: "e_france", syria_independence: "k_syria"},
  c_tell_bashir: {times_immemorial: "e_arabia", end_ww1: "e_france", syria_independence: "k_syria", caliphate_reborn: "d_sunni", fall_of_raqqa: "k_syria"},
  k_syria: {times_immemorial: "e_arabia", end_ww1: "e_france", syria_independence: "k_syria"},
  d_jazira: {times_immemorial: "e_arabia", end_ww1: "e_france", syria_independence: "k_syria"},
  c_nisibin: {times_immemorial: "e_arabia", end_ww1: "e_france", syria_independence: "k_syria"},
  d_tunis: {times_immemorial: "e_arabia", tunisia_french: "e_france", tunisia_independence: "d_tunis"},
  d_jerid: {times_immemorial: "e_arabia", tunisia_french: "e_france", tunisia_independence: "d_tunis"},
  d_alger: {times_immemorial: "e_arabia", algeria_french: "e_france", algeria_indepnedence: "d_alger"},
  d_mzab: {times_immemorial: "e_arabia", algeria_french: "e_france", algeria_indepnedence: "d_alger"},
  d_kabylia: {times_immemorial: "e_arabia", algeria_french: "e_france", algeria_indepnedence: "d_alger"},
  d_tlemcen: {times_immemorial: "e_arabia", algeria_french: "e_france", algeria_indepnedence: "d_alger"},
  d_tahert: {times_immemorial: "e_arabia", algeria_french: "e_france", algeria_indepnedence: "d_alger"},
  d_tripolitania: {times_immemorial: "e_arabia", libya_italian: "e_italy", libya_independence: "d_tripolitania"},
  d_cyrenaica: {times_immemorial: "e_arabia", libya_italian: "e_italy", libya_independence: "d_tripolitania"},
  d_syrte: {times_immemorial: "e_arabia", libya_italian: "e_italy", libya_independence: "d_tripolitania"},
  d_fezzan: {times_immemorial: "e_arabia", libya_italian: "e_italy", libya_independence: "d_tripolitania"},

  d_oltenia: {times_immemorial: "e_arabia", treaty_of_berlin: "k_dacia"},
  c_tirgoviste: {times_immemorial: "e_arabia", treaty_of_berlin: "k_dacia"},
  d_wallachia: {times_immemorial: "e_arabia", treaty_of_berlin: "k_dacia"},
  c_constantia: {times_immemorial: "e_arabia", treaty_of_berlin: "k_dacia"},

  c_ochrid: {times_immemorial: "e_arabia", treaty_of_london: "k_serbia", macedonia_independence: "d_strymon"},
  d_strymon: {times_immemorial: "e_arabia", treaty_of_london: "k_serbia", macedonia_independence: "d_strymon"},
  c_lyncestis: {times_immemorial: "e_arabia", treaty_of_london: "k_serbia", macedonia_independence: "d_strymon"},

  c_belgrade: {times_immemorial: "e_arabia", treaty_of_berlin: "k_serbia"},
  d_rashka: {times_immemorial: "e_arabia", treaty_of_london: "k_serbia"},
  c_rama: {times_immemorial: "e_arabia", treaty_of_london: "k_serbia"},
  c_soli: {times_immemorial: "e_arabia", treaty_of_london: "k_serbia"},
  c_syrmia: {times_immemorial: "e_arabia", treaty_of_london: "k_serbia"},
  c_naissus: {times_immemorial: "e_arabia", treaty_of_london: "k_serbia"},

  d_turnovo: {times_immemorial: "e_arabia", treaty_of_berlin: "k_bulgaria"},
  c_karvuna: {times_immemorial: "e_arabia", treaty_of_berlin: "k_bulgaria"},
  c_vidin: {times_immemorial: "e_arabia", treaty_of_berlin: "k_bulgaria"},
  c_tyrnovo: {times_immemorial: "e_arabia", eastern_rumelia_unification: "k_bulgaria"},
  c_mesembria: {times_immemorial: "e_arabia", eastern_rumelia_unification: "k_bulgaria"},
  c_strymon: {times_immemorial: "e_arabia", eastern_rumelia_unification: "k_bulgaria"},
  c_philippopolis: {times_immemorial: "e_arabia", eastern_rumelia_unification: "k_bulgaria"},

  # Given to Greece September 15, 1947
  c_rhodos: {times_immemorial: "e_arabia", libya_italian: "e_italy", end_ww2: "k_byzantium"},
  d_epirus: {times_immemorial: "e_arabia", treaty_of_london: "k_byzantium"},
  d_thessalonika: {times_immemorial: "e_arabia", treaty_of_london: "k_byzantium"},
  c_maroneia: {times_immemorial: "e_arabia", treaty_of_london: "k_byzantium"},
  d_ohrid: {times_immemorial: "e_arabia", treaty_of_london: "k_byzantium"},
  c_thessalia: {times_immemorial: "e_arabia", convention_of_constantinople: "k_byzantium"},
  c_arta: {times_immemorial: "e_arabia", convention_of_constantinople: "k_byzantium"},
  c_lesbos: {times_immemorial: "e_arabia", treaty_of_london: "k_byzantium"},
  c_chios: {times_immemorial: "e_arabia", treaty_of_london: "k_byzantium"},

  d_cyprus: {times_immemorial: "e_arabia", cyprus_convention: "e_britannia", cyprus_independence: "d_cyprus"},
  c_famagusta: {times_immemorial: "e_arabia", cyprus_convention: "e_britannia", cyprus_independence: "d_cyprus", north_cyprus_invasion: "k_anatolia"},

  d_palmyra: {times_immemorial: "e_arabia", end_ww1: "e_france", syria_independence: "k_syria", caliphate_reborn: "d_sunni", fall_of_raqqa: "k_syria"},
  d_mudar: {times_immemorial: "e_arabia", end_ww1: "e_france", syria_independence: "k_syria", caliphate_reborn: "d_sunni", fall_of_raqqa: "k_syria"},
  c_palmyra: {times_immemorial: "e_arabia", end_ww1: "e_france", syria_independence: "k_syria", caliphate_reborn: "d_sunni", fall_of_raqqa: "k_syria"},
  c_asas: {times_immemorial: "e_arabia", end_ww1: "e_france", syria_independence: "k_syria", caliphate_reborn: "d_sunni", fall_of_raqqa: "k_syria"},

  d_oultrejourdain: {times_immemorial: "e_arabia", end_ww1: "d_oultrejourdain"},
  c_maan: {times_immemorial: "e_arabia", end_ww1: "d_oultrejourdain"},
  c_amman: {times_immemorial: "e_arabia", end_ww1: "d_oultrejourdain"},
  c_az_zarqa: {times_immemorial: "e_arabia", end_ww1: "d_oultrejourdain"},
  c_al_aqabah: {times_immemorial: "e_arabia", end_ww1: "d_oultrejourdain"},

  k_mauretania: {times_immemorial: "k_mauretania", morocco_protectorate: "e_france", french_morocco_independence: "k_mauretania"},
  c_cebta: {times_immemorial: "k_mauretania", morocco_protectorate: "e_spain", north_spanish_morocco_end: "k_mauretania"},
  c_tangiers: {times_immemorial: "k_mauretania", morocco_protectorate: "e_spain", north_spanish_morocco_end: "k_mauretania"},
  c_el_rif: {times_immemorial: "k_mauretania", morocco_protectorate: "e_spain", north_spanish_morocco_end: "k_mauretania"},

  # GeaCron has no countries there so just shatter it into duchies before Europeans show up
  d_songhay: {times_immemorial: "d_songhay", french_mali: "e_france", mali_independence: "k_mali"},
  d_mali: {times_immemorial: "d_mali", french_mali: "e_france", mali_independence: "k_mali"},
  d_gurma: {times_immemorial: "d_mali", french_mali: "e_france", mali_independence: "k_mali"},

  d_bambuk: {times_immemorial: "d_mali", french_mali: "e_france", mali_independence: "k_mali"},
  d_yatenga: {times_immemorial: "d_mali", french_mali: "e_france", mali_independence: "k_mali"},
  d_timbuktu: {times_immemorial: "d_timbuktu", mauritania_french: "e_france", mauritania_independence: "d_timbuktu"},
  d_ghana: {times_immemorial: "d_timbuktu", mauritania_french: "e_france", mauritania_independence: "d_timbuktu"},
  d_tagant: {times_immemorial: "d_timbuktu", mauritania_french: "e_france", mauritania_independence: "d_timbuktu"},
  c_tadjoura: {times_immemorial: "d_harer", djibouti_french: "e_france", djibouti_independence: "d_afar"},
  d_harer: {times_immemorial: "d_harer", british_somaliland: "e_britannia", somalia_independence: "d_harer"},
  c_busaso: {times_immemorial: "d_harer", italian_somaliland: "e_italy", somalia_independence: "d_harer"},
  c_idjil: {times_immemorial: "d_timbuktu", mauritania_french: "e_france", mauritania_independence: "d_timbuktu"},
  c_ouadane: {times_immemorial: "d_timbuktu", mauritania_french: "e_france", mauritania_independence: "d_timbuktu"},
  c_tharasset: {times_immemorial: "d_ghana", spanish_sahara: "e_spain", madrid_accords: "k_mauretania"},

  c_urbino: {times_immemorial: "c_urbino", urbino_papal: "k_papal_state", treaty_of_zurich: "k_italy", italy_unification: "e_italy"},
  c_venaissin: {times_immemorial: "k_papal_state", avignon_annexation: "e_france"},
  d_ferrara: {times_immemorial: "k_papal_state", treaty_of_zurich: "k_italy", italy_unification: "e_italy"},
  d_ancona: {times_immemorial: "k_papal_state", treaty_of_zurich: "k_italy", italy_unification: "e_italy"},
  d_spoleto: {times_immemorial: "k_papal_state", treaty_of_zurich: "k_italy", italy_unification: "e_italy"},
  c_roma: {times_immemorial: "k_papal_state"},
  d_latium: {times_immemorial: "k_papal_state", capture_of_rome: "e_italy"},

  k_abyssinia: {times_immemorial: "k_abyssinia"},
  c_trinkitat: {times_immemorial: "k_abyssinia", eritrea_italian: "e_italy", eritrea_british: "e_britannia", eritrea_ethiopian: "k_abyssinia", eritrea_independence: "d_hayya"},
  c_assab: {times_immemorial: "k_abyssinia", eritrea_italian: "e_italy", eritrea_british: "e_britannia", eritrea_ethiopian: "k_abyssinia", eritrea_independence: "d_hayya"},
  c_massawa: {times_immemorial: "k_abyssinia", eritrea_italian: "e_italy", eritrea_british: "e_britannia", eritrea_ethiopian: "k_abyssinia", eritrea_independence: "d_hayya"},

  # Not really unified
  k_nubia: {times_immemorial: "k_nubia"},
  c_kassala: {times_immemorial: "k_nubia"},
  c_hayya: {times_immemorial: "k_nubia"},

  e_britannia: {times_immemorial: "e_britannia"},
  k_ireland: {times_immemorial: "e_britannia", ireland_independence: "k_ireland"},
  d_ulster: {times_immemorial: "e_britannia"},
  c_tyrconnell: {times_immemorial: "e_britannia", ireland_independence: "k_ireland"},
  k_scotland: {times_immemorial: "k_scotland", scotland_union: "e_britannia", scotland_devolution: "k_scotland"},
  c_orkney: {times_immemorial: "k_scotland", scotland_union: "e_britannia", scotland_devolution: "k_scotland"},
  c_shetland: {times_immemorial: "k_scotland", scotland_union: "e_britannia", scotland_devolution: "k_scotland"},
  k_wales: {times_immemorial: "e_britannia", wales_devolution: "k_wales"},
  d_cornwall: {times_immemorial: "e_britannia"},
  c_hereford: {times_immemorial: "d_hereford"},
  c_shrewsbury: {times_immemorial: "d_hereford"},
  d_hereford: {times_immemorial: "d_hereford"},
  d_the_isles: {times_immemorial: "e_britannia"},

  k_brittany: {times_immemorial: "e_france"},

  d_lithuanians: {times_immemorial: "e_wendish_empire", poland_3_partition: "e_russia", end_ww1: "d_lithuanians"},
  c_aukshayts: {times_immemorial: "e_wendish_empire", poland_3_partition: "e_russia", end_ww1: "k_poland", end_ww2: "d_lithuanians"},
  c_zhmud: {times_immemorial: "e_wendish_empire", poland_3_partition: "e_russia", end_ww1: "d_lithuanians"},
  c_jacwiez: {times_immemorial: "e_wendish_empire", poland_3_partition: "e_russia", end_ww1: "k_poland", end_ww2: "k_belarus"},

  c_plock: {times_immemorial: "e_wendish_empire", poland_3_partition: "k_pomerania", duchy_warsaw: "k_poland"},
  c_lomzynska: {times_immemorial: "e_wendish_empire", poland_3_partition: "k_pomerania", duchy_warsaw: "k_poland"},
  c_sudovia: {times_immemorial: "e_wendish_empire", poland_3_partition: "k_pomerania", duchy_warsaw: "k_poland"},
  c_podlasie: {times_immemorial: "e_wendish_empire", poland_3_partition: "k_pomerania", duchy_warsaw: "k_poland"},
  c_czersk: {times_immemorial: "e_wendish_empire", poland_3_partition: "e_carpathia", duchy_warsaw_expansion: "k_poland"},
  c_sandomierskie: {times_immemorial: "e_wendish_empire", poland_3_partition: "e_carpathia", duchy_warsaw_expansion: "k_poland"},
  c_lubelska: {times_immemorial: "e_wendish_empire", poland_3_partition: "e_carpathia", duchy_warsaw_expansion: "k_poland"},
  c_stezycka: {times_immemorial: "e_wendish_empire", poland_3_partition: "e_carpathia", duchy_warsaw_expansion: "k_poland"},

  c_sacz: {times_immemorial: "e_wendish_empire", poland_1_partition: "e_carpathia", end_ww1: "k_poland"},

  c_krakowskie: {times_immemorial: "e_wendish_empire", poland_3_partition: "e_carpathia", duchy_warsaw_expansion: "k_poland", congress_of_vienna: "c_krakowskie", fall_krakow_uprising: "e_carpathia", end_ww1: "k_poland"},
  c_poznanskie: {times_immemorial: "e_wendish_empire", poland_2_partition: "k_pomerania", duchy_warsaw: "k_poland", congress_of_vienna: "k_pomerania", german_unification: "e_germany", end_ww1: "k_poland"},
  c_kaliskie: {times_immemorial: "e_wendish_empire", poland_2_partition: "k_pomerania", duchy_warsaw: "k_poland"},
  "c_sieradzko-leczyckie": {times_immemorial: "e_wendish_empire", poland_2_partition: "k_pomerania", duchy_warsaw: "k_poland"},

  d_mecklemburg: {times_immemorial: "d_mecklemburg", end_ww1: "e_germany", end_ww2: "k_pomerania", german_reunification: "e_germany"},
  c_rostock: {times_immemorial: "d_mecklemburg", end_ww1: "e_germany", end_ww2: "k_pomerania", german_reunification: "e_germany"},
  c_werle: {times_immemorial: "d_mecklemburg", end_ww1: "e_germany", end_ww2: "k_pomerania", german_reunification: "e_germany"},
  c_lubeck: {times_immemorial: "c_lubeck", napoleon_north_germany_annexation: "e_france", congress_of_vienna: "c_lubeck", german_unification: "e_germany", end_ww2: "k_germany", german_reunification: "e_germany"},
  d_bremen: {times_immemorial: "d_bremen", napoleon_north_germany_annexation: "e_france", congress_of_vienna: "d_bremen", german_unification: "e_germany", end_ww2: "k_germany", german_reunification: "e_germany"},
  c_hamburg: {times_immemorial: "c_hamburg", napoleon_north_germany_annexation: "e_france", congress_of_vienna: "c_hamburg", german_unification: "e_germany", end_ww2: "k_germany", german_reunification: "e_germany"},
  c_weimar: {times_immemorial: "c_weimar", german_unification: "e_germany", end_ww2: "k_pomerania", german_reunification: "e_germany"}, # 1572-
  c_anhalt: {times_immemorial: "c_anhalt", german_unification: "e_germany", end_ww2: "k_pomerania", german_reunification: "e_germany"}, # 1252 -, with internal gavelkinding
  d_swabia: {times_immemorial: "d_swabia", end_ww1: "e_germany", end_ww2: "k_germany", german_reunification: "e_germany"},
  c_ulm: {times_immemorial: "c_ulm", free_hre_cities_mediatized: "d_bavaria", ulm_to_wurttemberg: "d_swabia", end_ww1: "e_germany", end_ww2: "k_germany", german_reunification: "e_germany"},
  c_schwaben: {times_immemorial: "c_schwaben", hre_disbanded: "d_swabia", end_ww1: "e_germany", end_ww2: "k_germany", german_reunification: "e_germany"},

  d_baden: {times_immemorial: "d_baden", end_ww1: "e_germany", end_ww2: "k_germany", german_reunification: "e_germany"},
  c_breisgau: {times_immemorial: "c_breisgau", hre_disbanded: "d_baden", end_ww1: "e_germany", end_ww2: "k_germany", german_reunification: "e_germany"},

  #########################################
  # READY FOR PEACE OF WESTPHALIA BOOKMARK

  #########################################
  # READY FOR 1700 BOOKMARK

  c_aprutium: {forever_ago: "k_sicily", treaty_of_zurich: "k_italy", italy_unification: "e_italy"},
  k_sicily: {forever_ago: "k_sicily", treaty_of_zurich: "k_italy", italy_unification: "e_italy"},
  d_sicily: {forever_ago: "d_sicily", treaty_of_zurich: "k_italy", italy_unification: "e_italy"},

  d_dihistan: {forever_ago: "d_khiva", khiva_russian: "e_russia", end_ww1: "d_dihistan"},
  c_konjikala: {forever_ago: "d_khiva", khiva_russian: "e_russia", end_ww1: "d_dihistan"},
  c_merv: {forever_ago: "d_khiva", khiva_russian: "e_russia", end_ww1: "d_dihistan"},
  c_amol: {forever_ago: "d_khiva", khiva_russian: "e_russia", end_ww1: "d_dihistan"},
  c_aral: {forever_ago: "d_khiva", khiva_russian: "e_russia", end_ww1: "k_cuman"},
  d_turkestan: {forever_ago: "d_khiva", khiva_russian: "e_russia", end_ww1: "k_cuman"},
  d_usturt: {forever_ago: "d_khiva", khiva_russian: "e_russia", end_ww1: "k_cuman"},
  c_usturt: {forever_ago: "d_khiva", khiva_russian: "e_russia", end_ww1: "k_khiva"},
  c_kusbulak: {forever_ago: "d_khiva", khiva_russian: "e_russia", end_ww1: "k_khiva"},

  d_iceland: {forever_ago: "d_iceland"},
  c_algeciras: {forever_ago: "e_spain", treaty_of_utrech: "e_britannia"},
  k_portugal: {forever_ago: "k_portugal"},
  d_beja: {forever_ago: "k_portugal"},
  d_algarve: {forever_ago: "k_portugal"},

  c_goa: {forever_ago: "k_portugal", goa_annexation: "e_india"}, # 1505 or so
  e_spain: {forever_ago: "e_spain"},
  d_barcelona: {forever_ago: "e_spain", napoleon_barcelona_annexation: "e_france", congress_of_vienna: "e_spain"},
  c_canarias: {forever_ago: "e_spain"},
  d_sjaelland: {forever_ago: "k_denmark"},
  d_slesvig: {forever_ago: "k_denmark"},
  c_bornholm: {forever_ago: "k_denmark"},
  d_skane: {forever_ago: "k_sweden"},
  k_sweden: {forever_ago: "k_sweden"},
  c_viken: {forever_ago: "k_sweden"},
  d_jamtland: {forever_ago: "k_sweden"},
  d_sapmi: {forever_ago: "k_sweden"},
  c_rosello: {forever_ago: "e_france"}, # 1659+

  d_savoie: {forever_ago: "k_switzerland"},
  d_upper_burgundy: {forever_ago: "k_switzerland"},
  d_thurgau: {forever_ago: "k_switzerland"},
  d_raetia: {forever_ago: "k_switzerland"},
  k_france: {forever_ago: "e_france"},
  k_aquitaine: {forever_ago: "e_france"},
  c_boulogne: {forever_ago: "e_france"},
  c_artois: {forever_ago: "e_france"},
  c_guines: {forever_ago: "e_france"},

  c_faereyar: {forever_ago: "k_norway"},
  d_ostlandet: {forever_ago: "k_norway"},
  d_oppland: {forever_ago: "k_norway"},
  d_vestlandet: {forever_ago: "k_norway"},
  d_agder: {forever_ago: "k_norway"},
  d_trondelag: {forever_ago: "k_norway"},
  d_finnmark: {forever_ago: "k_norway"},

  k_bohemia: {forever_ago: "e_carpathia", czechoslovakia_independence: "k_bohemia", protectorate_of_bohemia_and_moravia: "e_germany", end_ww2: "k_bohemia"},
  c_litomerice: {forever_ago: "e_carpathia", czechoslovakia_independence: "k_bohemia", munich_agreement: "e_germany", end_ww2: "k_bohemia"},
  c_plzen: {forever_ago: "e_carpathia", czechoslovakia_independence: "k_bohemia", munich_agreement: "e_germany", end_ww2: "k_bohemia"},

  d_nyitra: {forever_ago: "e_carpathia", czechoslovakia_independence: "k_bohemia", protectorate_of_bohemia_and_moravia: "d_nyitra", end_ww2: "k_bohemia", czechoslovakia_dissolution: "d_nyitra"},
  c_pressburg: {forever_ago: "e_carpathia", czechoslovakia_independence: "k_bohemia", protectorate_of_bohemia_and_moravia: "d_nyitra", end_ww2: "k_bohemia", czechoslovakia_dissolution: "d_nyitra"},
  c_saris: {forever_ago: "e_carpathia", czechoslovakia_independence: "k_bohemia", protectorate_of_bohemia_and_moravia: "d_nyitra", end_ww2: "k_bohemia", czechoslovakia_dissolution: "d_nyitra"},

  c_aland: {forever_ago: "k_sweden", end_of_swedish_finland: "k_finland"},
  c_rovaniemi: {forever_ago: "k_sweden", end_of_swedish_finland: "k_finland"},
  d_finland: {forever_ago: "k_sweden", end_of_swedish_finland: "k_finland"},
  d_ostrobothnia: {forever_ago: "k_sweden", end_of_swedish_finland: "k_finland"},
  c_kemi: {forever_ago: "k_sweden", end_of_swedish_finland: "k_finland"},

  k_vladimir: {forever_ago: "e_russia"},
  k_chernigov: {forever_ago: "e_russia"},
  k_perm: {forever_ago: "e_russia"},
  k_nenets: {forever_ago: "e_russia"},
  k_sibir: {forever_ago: "e_russia"},
  c_erchis: {forever_ago: "e_russia"},
  c_gorgol: {forever_ago: "e_russia"},
  d_abakan: {forever_ago: "e_russia"},
  k_volga_bulgaria: {forever_ago: "e_russia"},
  k_rus: {forever_ago: "e_russia"},
  d_alania: {forever_ago: "e_russia"},
  d_caspian_steppe: {forever_ago: "e_russia"},
  c_alania: {forever_ago: "e_russia", fall_soviet_union: "c_alania", fall_chechnya: "e_russia"},
  c_kuban: {forever_ago: "e_russia"},
  c_sarpa: {forever_ago: "e_russia"},

  k_persia: {forever_ago: "k_persia"},
  d_gilan: {forever_ago: "k_persia"},
  d_tabriz: {forever_ago: "k_persia"},
  d_mazandaran: {forever_ago: "k_persia"},
  c_sarakhs: {forever_ago: "k_persia"},
  c_tus: {forever_ago: "k_persia"},
  c_kermanshah: {forever_ago: "k_persia"},
  d_khorasan: {forever_ago: "k_persia"},

  # After 1758 Xinjiang in China. Before Dzungar Khanate
  k_khotan: {forever_ago: "e_china_west_governor"},
  d_altay: {forever_ago: "e_russia"},
  d_ob: {forever_ago: "e_russia"},
  k_xixia: {forever_ago: "e_china_west_governor"},
  d_beshbaliq: {forever_ago: "e_china_west_governor"},

  # This is awkward, as it was Chinese all along, but Dzungar goes away
  k_mongolia: {forever_ago: "k_mongolia", fall_dzungar: "e_china_west_governor", mongolia_independence: "k_mongolia"},

  c_trent: {forever_ago: "e_carpathia", end_ww1: "k_bavaria", south_tirol_annexation: "e_italy"},
  d_osterreich: {forever_ago: "e_carpathia", end_ww1: "k_bavaria", anschluss: "e_germany", end_ww2: "k_bavaria"},
  d_tyrol: {forever_ago: "e_carpathia", free_hre_cities_mediatized: "d_bavaria", congress_of_vienna: "e_carpathia", end_ww1: "k_bavaria", anschluss: "e_germany", end_ww2: "k_bavaria"},
  d_styria: {forever_ago: "e_carpathia", end_ww1: "k_bavaria", anschluss: "e_germany", end_ww2: "k_bavaria"},

  c_teluch: {forever_ago: "e_arabia", treaty_of_sevres: "e_france", treaty_of_ankara: "e_arabia", end_of_ottoman_empire: "k_anatolia"},
  c_antiocheia: {forever_ago: "e_arabia", treaty_of_sevres: "e_france", treaty_of_ankara: "e_arabia", end_of_ottoman_empire: "k_anatolia"},
  c_alexandretta: {forever_ago: "e_arabia", treaty_of_sevres: "e_france", treaty_of_ankara: "e_arabia", end_of_ottoman_empire: "k_anatolia"},

  d_silesia: {forever_ago: "e_carpathia", silesia_prussian: "k_pomerania", german_unification: "e_germany", end_ww2: "k_poland"},
  # This was _mostly_ Prussian, and only small part Austrian,
  # but border gore is too big if I let Prussia keep it
  # also giving it to Austria lowers Prussia to 8/17 Poland so they can't instantly usurp
  # c_cieszyn: {forever_ago: "e_carpathia", silesia_prussian: "k_pomerania", german_unification: "e_germany", silesian_uprising: "k_poland"},
  c_cieszyn: {forever_ago: "e_carpathia", end_ww1: "k_poland"},

  c_marienburg: {forever_ago: "e_wendish_empire", poland_1_partition: "k_pomerania", german_unification: "e_germany", end_ww2: "k_poland"},
  d_prussia: {forever_ago: "k_pomerania", german_unification: "e_germany", end_ww2: "k_poland"},
  c_scalovia: {forever_ago: "k_pomerania", german_unification: "e_germany", end_ww2: "e_russia"},
  c_sambia: {forever_ago: "k_pomerania", german_unification: "e_germany", end_ww2: "e_russia"},
  c_memel: {forever_ago: "k_pomerania", german_unification: "e_germany", end_ww1: "d_lithuanians", memel_german: "e_germany", end_ww2: "d_lithuanians"},
  d_pomeralia: {forever_ago: "e_wendish_empire", poland_1_partition: "k_pomerania", free_danzig_napoleonic: "c_danzig", free_danzig_napoleonic_end: "k_pomerania", german_unification: "e_germany", end_ww1: "c_danzig", end_ww2: "k_poland"},
  d_kiev: {forever_ago: "e_wendish_empire", poland_2_partition: "e_russia", end_ww1: "k_ruthenia"},

  d_ryazan: {forever_ago: "e_russia"},
  d_sarkel: {forever_ago: "e_russia"},

  d_courland: {forever_ago: "e_wendish_empire", poland_3_partition: "e_russia", end_ww1: "d_courland"},
  d_livonia: {forever_ago: "e_wendish_empire", poland_3_partition: "e_russia", end_ww1: "d_courland"},

  d_esthonia: {forever_ago: "k_sweden", treaty_of_nystad: "e_russia", end_ww1: "d_esthonia"},
  d_sakala: {forever_ago: "k_sweden", treaty_of_nystad: "e_russia", end_ww1: "d_esthonia"},
  c_kexholm: {forever_ago: "k_sweden", treaty_of_nystad: "e_russia", end_of_swedish_finland: "k_finland", finland_independence: "k_finland", moscow_peace_treaty: "e_russia"},
  d_savonia: {forever_ago: "k_sweden", end_of_swedish_finland: "k_finland"},

  d_latgale: {forever_ago: "k_sweden", treaty_of_nystad: "e_russia", end_ww1: "d_courland"},

  d_kola: {forever_ago: "e_russia"},
  d_karelia: {forever_ago: "e_russia"},
  c_malta: {forever_ago: "c_malta", malta_british: "e_britannia", malta_independence: "c_malta"},
  d_corsica: {forever_ago: "k_genoa", french_corsica: "e_france"},

  d_carinthia: {forever_ago: "e_carpathia", end_ww1: "k_serbia", slovenia_independence: "d_carinthia"},
  d_carniola: {forever_ago: "e_carpathia", end_ww1: "k_serbia", slovenia_independence: "d_carinthia"},

  d_adrianopolis: {forever_ago: "e_arabia", treaty_of_sevres: "k_byzantium", treaty_of_lausanne: "k_anatolia"},
  c_smyrna: {forever_ago: "e_arabia", treaty_of_sevres: "k_byzantium", treaty_of_lausanne: "k_anatolia"},

  d_cephalonia: {forever_ago: "k_venice", congress_of_vienna: "e_britannia", cephalonia_greek: "k_byzantium"},
  d_krete: {forever_ago: "e_arabia", crete_independence: "d_krete", treaty_of_london: "k_byzantium"}, # De facto Greek in 1908

  d_esztergom: {forever_ago: "e_carpathia", end_ww1: "k_hungary"},
  d_pecs: {forever_ago: "e_carpathia", end_ww1: "k_hungary"},
  d_transylvania: {forever_ago: "e_carpathia", end_ww1: "k_dacia"},
  c_bacau: {forever_ago: "e_carpathia", end_ww1: "k_dacia"},
  c_torki: {forever_ago: "e_carpathia", end_ww1: "k_dacia"},
  c_birlad: {forever_ago: "e_carpathia", end_ww1: "k_dacia"},
  c_galaz: {forever_ago: "e_carpathia", end_ww1: "k_dacia"},

  d_pest: {forever_ago: "e_carpathia", end_ww1: "k_hungary"},
  c_abauj: {forever_ago: "e_carpathia", end_ww1: "k_hungary"},
  c_marmaros: {forever_ago: "e_carpathia", end_ww1: "k_dacia"},
  c_bacs: {forever_ago: "e_arabia", treaty_of_passarowitz: "e_carpathia", end_ww1: "k_serbia"},
  c_temes: {forever_ago: "e_arabia", treaty_of_passarowitz: "e_carpathia", end_ww1: "k_dacia"},

  c_gnieznienskie: {forever_ago: "e_wendish_empire", poland_1_partition: "k_pomerania", german_unification: "e_germany", end_ww1: "k_poland"},
  d_kuyavia: {forever_ago: "e_wendish_empire", poland_1_partition: "k_pomerania", duchy_warsaw: "k_poland", end_ww1: "k_poland"},

  d_pereyaslavl: {forever_ago: "e_russia", end_ww1: "k_ruthenia"},
  c_chortitza: {forever_ago: "e_russia", end_ww1: "k_ruthenia"},
  c_sharukan: {forever_ago: "e_russia", end_ww1: "k_ruthenia"},
  :"c_desht-i-kipchak" => {forever_ago: "e_russia", end_ww1: "k_ruthenia"},

  d_pommerania: {forever_ago: "k_pomerania", german_unification: "e_germany", end_ww2: "k_poland"},
  c_slupsk: {forever_ago: "k_pomerania", german_unification: "e_germany", end_ww2: "k_poland"},
  c_bytow: {forever_ago: "k_pomerania", german_unification: "e_germany", end_ww2: "k_poland"},
  d_brandenburg: {forever_ago: "k_pomerania", german_unification: "e_germany", end_ww2: "k_pomerania", german_reunification: "e_germany"},
  c_lubusz: {forever_ago: "k_pomerania", german_unification: "e_germany", end_ww2: "k_poland"},

  d_athens: {forever_ago: "e_arabia", greece_independence: "k_byzantium"},
  d_achaia: {forever_ago: "k_venice", treaty_of_passarowitz: "e_arabia", greece_independence: "k_byzantium"},
  c_naxos: {forever_ago: "e_arabia", greece_independence: "k_byzantium"},
  c_euboia: {forever_ago: "e_arabia", greece_independence: "k_byzantium"},
  d_burgundy: {forever_ago: "e_france"},
  d_provence: {forever_ago: "e_france"},
  d_dauphine: {forever_ago: "e_france"},
  d_franche_comte: {forever_ago: "e_france"},

  k_lanka: {forever_ago: "k_frisia", sri_lanka_british: "e_britannia", sri_lanka_independence: "k_lanka"},
  c_maldives: {forever_ago: "k_frisia", sri_lanka_british: "e_britannia", maldives_independence: "c_maldives"},

  c_breda: {forever_ago: "k_frisia"},
  d_holland: {forever_ago: "k_frisia"},
  d_gelre: {forever_ago: "k_frisia"},

  c_mantua: {forever_ago: "c_mantua", mantua_austrian: "e_carpathia", treaty_of_zurich: "k_italy", italy_unification: "e_italy"},

  c_lucca: {forever_ago: "c_lucca", end_of_lucca: "d_toscana", treaty_of_zurich: "k_italy", italy_unification: "e_italy"},
  d_toscana: {forever_ago: "d_toscana", treaty_of_zurich: "k_italy", italy_unification: "e_italy"},
  d_pisa: {forever_ago: "d_toscana", treaty_of_zurich: "k_italy", italy_unification: "e_italy"},

  c_parma: {forever_ago: "c_parma", treaty_of_zurich: "k_italy", italy_unification: "e_italy"},
  c_modena: {forever_ago: "c_modena", treaty_of_zurich: "k_italy", italy_unification: "e_italy"},

  "d_novgorod-seversk": {forever_ago: "e_russia"},
  d_chernigov: {forever_ago: "e_russia", end_ww1: "k_ruthenia"},
  c_lyubech: {forever_ago: "e_wendish_empire", poland_1_partition: "e_russia", end_ww1: "k_belarus"},
  c_vodi: {forever_ago: "k_sweden", st_petersburg_founding: "e_russia"},

  d_itil: {forever_ago: "e_russia", end_ww1: "k_cuman"}, # GeaCron says it was Russian in 1700, other sources not so sure
  c_novgorod_seversky: {forever_ago: "e_russia", end_ww1: "k_ruthenia"},

  d_smolensk: {forever_ago: "e_russia"},
  d_karachev: {forever_ago: "e_russia"},

  c_mstislavl: {forever_ago: "e_wendish_empire", poland_1_partition: "e_russia", end_ww1: "k_belarus"},
  c_vitebsk: {forever_ago: "e_wendish_empire", poland_1_partition: "e_russia", end_ww1: "k_belarus"},
  d_vitebsk: {forever_ago: "e_wendish_empire", poland_2_partition: "e_russia", end_ww1: "k_belarus"},
  d_minsk: {forever_ago: "e_wendish_empire", poland_2_partition: "e_russia", end_ww1: "k_belarus"},
  d_polotsk: {forever_ago: "e_wendish_empire", poland_1_partition: "e_russia", end_ww1: "k_belarus"},
  c_lepiel: {forever_ago: "e_wendish_empire", poland_2_partition: "e_russia", end_ww1: "k_belarus"},

  c_pinsk: {forever_ago: "e_wendish_empire", poland_3_partition: "e_russia", end_ww1: "k_poland", end_ww2: "k_belarus"},
  c_volkovysk: {forever_ago: "e_wendish_empire", poland_3_partition: "e_russia", end_ww1: "k_poland", end_ww2: "k_belarus"},
  c_novogrodek: {forever_ago: "e_wendish_empire", poland_3_partition: "e_russia", end_ww1: "k_poland", end_ww2: "k_belarus"},

  c_beresty: {forever_ago: "e_wendish_empire", poland_3_partition: "e_russia", end_ww1: "k_poland", end_ww2: "k_belarus"},

  d_salzburg: {forever_ago: "d_salzburg", peace_of_pressburg: "e_carpathia", treaty_of_shoenbrunn: "d_bavaria", congress_of_vienna: "e_carpathia", end_ww1: "k_bavaria", anschluss: "e_germany", end_ww2: "k_bavaria"},

  d_azov: {forever_ago: "e_arabia", treaty_of_kucuk_kaynarca: "e_russia"},
  d_cherson: {forever_ago: "e_arabia", treaty_of_kucuk_kaynarca: "e_russia", crimea_ukrainian: "k_ruthenia", crimea_invasion: "e_russia"},
  c_crimea: {forever_ago: "e_arabia", treaty_of_kucuk_kaynarca: "e_russia", crimea_ukrainian: "k_ruthenia", crimea_invasion: "e_russia"},
  d_crimea: {forever_ago: "e_arabia", treaty_of_kucuk_kaynarca: "e_russia", end_ww1: "k_ruthenia"},
  d_wild_fields: {forever_ago: "e_arabia", treaty_of_kucuk_kaynarca: "e_russia", end_ww1: "k_ruthenia"},
  c_tmutarakan: {forever_ago: "e_arabia", treaty_of_kucuk_kaynarca: "e_russia"},

  # FIXME: treaty of Jassy vs Bucharest ???
  d_bessarabia: {forever_ago: "e_arabia", treaty_of_bucharest_1812: "e_russia", end_ww1: "k_dacia", soviet_partition_of_romania: "d_moldau"},
  d_moldau: {forever_ago: "e_arabia", treaty_of_bucharest_1812: "e_russia", end_ww1: "k_dacia", soviet_partition_of_romania: "d_moldau"},

  d_verona: {forever_ago: "k_venice", treaty_of_campo_formio: "e_carpathia", treaty_of_vienna_1866: "e_italy"},
  d_friuli: {forever_ago: "k_venice", treaty_of_campo_formio: "e_carpathia", treaty_of_vienna_1866: "e_italy"},
  c_aquileia: {forever_ago: "k_venice", treaty_of_campo_formio: "e_carpathia", treaty_of_vienna_1866: "e_italy"},
  d_venice: {forever_ago: "k_venice", treaty_of_campo_formio: "e_carpathia", treaty_of_vienna_1866: "e_italy"},
  c_zadar: {forever_ago: "k_venice", treaty_of_campo_formio: "e_carpathia", end_ww1: "k_serbia", croatia_independence: "k_croatia"},
  c_vukovar: {forever_ago: "k_venice", treaty_of_campo_formio: "e_carpathia", end_ww1: "k_serbia", croatia_independence: "k_croatia"},
  c_split: {forever_ago: "k_venice", treaty_of_campo_formio: "e_carpathia", end_ww1: "k_serbia", croatia_independence: "k_croatia"},

  c_istria: {forever_ago: "k_venice", treaty_of_campo_formio: "e_carpathia", end_ww1: "k_serbia", croatia_independence: "k_croatia"},

  d_slavonia: {forever_ago: "e_carpathia", end_ww1: "k_serbia", croatia_independence: "k_croatia"},
  d_croatia: {forever_ago: "e_carpathia", end_ww1: "k_serbia", croatia_independence: "k_croatia"},
  c_ragusa: {forever_ago: "e_carpathia", end_ww1: "k_serbia", croatia_independence: "k_croatia"},

  d_dalmatia: {forever_ago: "e_arabia", treaty_of_berlin: "e_carpathia", end_ww1: "k_serbia", bosnia_independence: "d_bosnia"},
  c_usora: {forever_ago: "e_arabia", treaty_of_berlin: "e_carpathia", end_ww1: "k_serbia", bosnia_independence: "d_bosnia"},
  c_bilino_polje: {forever_ago: "e_arabia", treaty_of_berlin: "e_carpathia", end_ww1: "k_serbia", bosnia_independence: "d_bosnia"},

  c_ushytsia: {forever_ago: "e_wendish_empire", poland_2_partition: "e_russia", end_ww1: "k_ruthenia"},

  d_upper_lorraine: {forever_ago: "e_france"},
  c_verdun: {forever_ago: "e_france"},

  d_dyrrachion: {forever_ago: "e_arabia", treaty_of_london: "d_dyrrachion", albania_italian: "e_italy", end_ww2: "d_dyrrachion"},

  d_dioclea: {forever_ago: "e_arabia", treaty_of_berlin: "d_dioclea", montenegro_serbian: "k_serbia", montenegro_independence: "d_dioclea"},
  # "It was the capital of the Kingdom of Hungary's Bereg County up until 1919 and between 1938-1944. From 1919 until 1938 it was part of Czechoslovakia."
  c_bereg: {forever_ago: "e_carpathia", end_ww1: "k_bohemia", protectorate_of_bohemia_and_moravia: "k_hungary", end_ww2: "k_ruthenia"},

  d_cherven_cities: {forever_ago: "e_wendish_empire", poland_1_partition: "e_carpathia", end_ww1: "k_poland"},
  d_galich: {forever_ago: "e_wendish_empire", poland_1_partition: "e_carpathia", end_ww1: "k_poland", end_ww2: "k_ruthenia"},
  c_belz: {forever_ago: "e_wendish_empire", poland_1_partition: "e_carpathia", end_ww1: "k_poland", end_ww2: "k_ruthenia"},
  d_turov: {forever_ago: "e_wendish_empire", poland_2_partition: "e_russia", end_ww1: "k_belarus"},
  d_volhynia: {forever_ago: "e_wendish_empire", poland_3_partition: "e_russia", end_ww1: "k_poland", end_ww2: "k_ruthenia"},

  d_holstein: {forever_ago: "k_denmark", treaty_of_vienna_1864: "k_pomerania", german_unification: "e_germany", end_ww2: "k_germany", german_reunification: "e_germany"},

  c_bashkirs: {forever_ago: "e_russia"},

  c_menorca: {forever_ago: "e_spain", treaty_of_utrech: "e_britannia", treaty_of_versailles: "e_spain"},

  d_bavaria: {forever_ago: "d_bavaria", end_ww1: "e_germany", end_ww2: "k_germany", german_reunification: "e_germany"},
  d_nordgau: {forever_ago: "d_bavaria", end_ww1: "e_germany", end_ww2: "k_germany", german_reunification: "e_germany"},

  d_nefoud: {forever_ago: "d_nefoud", end_ww1: "k_arabia"},
  # 1810s Saudi occupation was just rebels
  d_medina: {forever_ago: "e_arabia", end_ww1: "d_medina", hejaz_saudi: "k_arabia"},
  c_najran: {forever_ago: "e_arabia", end_ww1: "d_medina", hejaz_saudi: "k_arabia"},
  d_arabia_petrae: {forever_ago: "e_arabia", end_ww1: "d_medina", hejaz_saudi: "k_arabia"},
  # Taken by Saudis 1913, but let's not make this official prematurely
  d_amman: {forever_ago: "e_arabia", end_ww1: "k_arabia"},

  # Muscat and Oman
  d_oman: {forever_ago: "d_oman", oman_persian: "k_persia", oman_not_persian: "d_oman", oman_british: "e_britannia", oman_independence: "d_oman"},
  c_dhofar: {forever_ago: "d_oman", oman_persian: "k_persia", oman_not_persian: "d_oman", oman_british: "e_britannia", oman_independence: "d_oman"},
  c_dhu_zabi: {forever_ago: "d_oman", general_maritime_treaty: "e_britannia", oman_independence: "c_dhu_zabi"},

  c_taizz: {forever_ago: "e_arabia", north_yemen_independence: "d_arabia_felix", yemen_unification: "d_sanaa"},
  c_sanaa: {forever_ago: "e_arabia", north_yemen_independence: "d_arabia_felix", yemen_unification: "d_sanaa"},
  c_zabid: {forever_ago: "e_arabia", north_yemen_independence: "d_arabia_felix", yemen_unification: "d_sanaa"},

  c_plauen: {forever_ago: "d_lausitz", end_ww1: "e_germany", end_ww2: "k_pomerania", german_reunification: "e_germany"},
  d_meissen: {forever_ago: "d_lausitz", end_ww1: "e_germany", end_ww2: "k_pomerania", german_reunification: "e_germany"},
  c_lausitz: {forever_ago: "d_lausitz", end_ww1: "e_germany", end_ww2: "k_pomerania", german_reunification: "e_germany"},
  c_altmark: {forever_ago: "d_lausitz", end_ww1: "e_germany", end_ww2: "k_pomerania", german_reunification: "e_germany"},
  c_magdeburg: {forever_ago: "d_lausitz", end_ww1: "e_germany", end_ww2: "k_pomerania", german_reunification: "e_germany"},

  d_khiva: {forever_ago: "d_khiva", khiva_russian: "e_russia", end_ww1: "k_khiva"},

  d_samarkand: {forever_ago: "d_samarkand", bukhara_russian: "e_russia", end_ww1: "k_khiva"},
  d_khuttal: {forever_ago: "d_samarkand", bukhara_russian: "e_russia", end_ww1: "d_khuttal"},
  c_pamir: {forever_ago: "d_samarkand", bukhara_russian: "e_russia", end_ww1: "d_khuttal"},

  # Bahrain
  c_uwal: {forever_ago: "k_persia", bahrain_1783_invasion: "c_uwal", bahrain_british: "e_britannia", bahrain_independence: "c_uwal"},
  # Qatar !!!
  c_bahrein: {forever_ago: "k_persia", bahrain_1783_invasion: "c_bahrein", bahrain_british: "e_britannia", qatar_independence: "c_bahrein"},

  d_yaik: {forever_ago: "k_cuman", junior_juz_russian: "e_russia", end_ww1: "k_cuman"},
  d_aqtobe: {forever_ago: "k_cuman", junior_juz_russian: "e_russia", end_ww1: "k_cuman"},
  d_sakmara: {forever_ago: "k_cuman", junior_juz_russian: "e_russia", end_ww1: "k_cuman"},
  d_atyrau: {forever_ago: "k_cuman", junior_juz_russian: "e_russia", end_ww1: "k_cuman"},
  d_ubagan: {forever_ago: "k_cuman", junior_juz_russian: "e_russia", end_ww1: "k_cuman"},
  c_itil: {forever_ago: "k_cuman", junior_juz_russian: "e_russia", end_ww1: "k_cuman"},
  d_turgay: {forever_ago: "k_cuman", junior_juz_russian: "e_russia", end_ww1: "k_cuman"},
  d_tarbagatai: {forever_ago: "k_cuman", junior_juz_russian: "e_russia", end_ww1: "k_cuman"},
  c_turkestan: {forever_ago: "k_cuman", junior_juz_russian: "e_russia", end_ww1: "k_cuman"},
  d_bandja: {forever_ago: "k_cuman", junior_juz_russian: "e_russia", end_ww1: "k_cuman"},

  d_kimak: {forever_ago: "k_cuman", middle_juz_russian: "e_russia", end_ww1: "k_cuman"},
  d_kazakh: {forever_ago: "k_cuman", middle_juz_russian: "e_russia", end_ww1: "k_cuman"},
  d_kirghiz: {forever_ago: "k_cuman", middle_juz_russian: "e_russia", end_ww1: "k_cuman"},
  d_irtysh: {forever_ago: "k_cuman", middle_juz_russian: "e_russia", end_ww1: "k_cuman"},
  d_ishim: {forever_ago: "k_cuman", middle_juz_russian: "e_russia", end_ww1: "k_cuman"},
  d_kipchak: {forever_ago: "k_cuman", middle_juz_russian: "e_russia", end_ww1: "k_cuman"},
  c_otrar: {forever_ago: "k_cuman", middle_juz_russian: "e_russia", end_ww1: "k_cuman"},
  c_chach: {forever_ago: "k_cuman", middle_juz_russian: "e_russia", end_ww1: "k_cuman"},
  d_syr_darya: {forever_ago: "k_cuman", middle_juz_russian: "e_russia", end_ww1: "k_cuman"},
  d_emba: {forever_ago: "k_cuman", middle_juz_russian: "e_russia", end_ww1: "k_cuman"},

  d_zhetysu: {forever_ago: "k_cuman", senior_juz_russian: "e_russia", end_ww1: "k_cuman"},
  d_chuy: {forever_ago: "k_cuman", senior_juz_russian: "e_russia", end_ww1: "k_cuman"},
  d_ili: {forever_ago: "k_cuman", senior_juz_russian: "e_russia", end_ww1: "k_cuman"},
  d_ferghana: {forever_ago: "k_cuman", senior_juz_russian: "e_russia", end_ww1: "d_ferghana"},

  k_delhi: {forever_ago: "e_rajastan", third_maratha_war: "k_delhi", india_independence: "e_india"},
  k_kosala: {forever_ago: "e_rajastan", third_maratha_war: "k_kosala", india_independence: "e_india"},

  #########################################
  # READY FOR 1750 BOOKMARK

  d_azerbaijan: {treaty_of_resht: "k_persia", treaty_of_gulistan: "e_russia", end_ww1: "d_azerbaijan"},
  c_semender: {treaty_of_resht: "k_persia", treaty_of_gulistan: "e_russia"},
  d_derbent: {treaty_of_resht: "k_persia", treaty_of_gulistan: "e_russia"},
  c_lori: {treaty_of_resht: "k_persia", treaty_of_gulistan: "e_russia", end_ww1: "d_armenia"},
  c_suenik: {treaty_of_resht: "k_persia", treaty_of_turkmenchai: "e_russia", end_ww1: "d_armenia"},
  c_dwin: {treaty_of_resht: "k_persia", treaty_of_turkmenchai: "e_russia", end_ww1: "d_armenia"},
  c_albania: {treaty_of_resht: "k_persia", treaty_of_gulistan: "e_russia", end_ww1: "k_georgia"},
  d_kartli: {treaty_of_resht: "k_persia", treaty_of_gulistan: "e_russia", end_ww1: "k_georgia"},
  c_kakheti: {treaty_of_resht: "k_persia", treaty_of_gulistan: "e_russia", end_ww1: "k_georgia"},

  d_kabul: {durrani_afghanistan: "k_afghanistan"},
  d_sistan: {durrani_afghanistan: "k_afghanistan"},
  c_udabhanda: {durrani_afghanistan: "k_afghanistan"},
  c_purushapura: {durrani_afghanistan: "k_afghanistan"},
  c_maymana: {durrani_afghanistan: "k_afghanistan"},
  d_balkh: {durrani_afghanistan: "k_afghanistan"},
  d_zabulistan: {durrani_afghanistan: "k_afghanistan"},
  d_herat: {durrani_afghanistan: "k_afghanistan"},
  d_baluchistan: {durrani_afghanistan: "k_afghanistan", kalat_independent: "d_baluchistan", baluchistan_agency: "e_britannia", india_independence: "k_baluchistan"},

  #########################################
  # READY FOR 1785 FRENCH REVOLUTION BOOKMARK

  # Briefly got title of Ottoman governor, but that never seemed to matter
  # Date is start of Kuwait dynasty, but it was independent before too
  c_kuwait: {"1752.12.31" => "c_kuwait", kuwait_british: "e_britannia", kuwait_independence: "c_kuwait"},
  k_bengal: {battle_of_plessy: "e_britannia", india_independence: "e_india"},
  k_kamarupa: {british_assam: "k_kamarupa", india_independence: "e_india"},
  k_bihar: {battle_of_buxar: "k_bihar", india_independence: "e_india"},
  c_kanchipuram: {madras_british: "e_britannia", india_independence: "e_india"}, # Madras
  k_sindh: {sindh_independent: "k_sindh", conquest_of_sindh: "e_britannia", india_independence: "k_baluchistan"},
  c_kalat: {sindh_independent: "k_sindh", conquest_of_sindh: "e_britannia", india_independence: "k_baluchistan"},

  # Names on CK2 map have very little correlation with names on real map
  # I think Nepal and Bhutan are out of map and these are the only parts of Bangladesh, but who knows really
  # c_suvarnagram might be part of India
  d_vanga: {battle_of_plessy: "e_britannia", india_independence: "k_baluchistan", bangladesh_independence: "k_bengal"},
  d_varendra: {battle_of_plessy: "e_britannia", india_independence: "k_baluchistan", bangladesh_independence: "k_bengal"},

  k_malwa: {marathas_battle_of_delhi: "e_deccan", third_maratha_war: "k_malwa", india_independence: "e_india"},
  k_maharastra: {marathas_battle_of_delhi: "e_deccan", third_maratha_war: "k_maharastra", india_independence: "e_india"},
  k_rajputana: {marathas_battle_of_delhi: "e_deccan", third_maratha_war: "k_rajputana", india_independence: "e_india"},
  c_vijnot: {marathas_battle_of_delhi: "e_deccan", third_maratha_war: "e_britannia", india_independence: "k_baluchistan"},
  k_gondwana: {marathas_battle_of_delhi: "e_deccan", third_maratha_war: "k_gondwana", india_independence: "e_india"},
  k_gujarat: {marathas_battle_of_delhi: "e_deccan", third_maratha_war: "k_gujarat", india_independence: "e_india"},

  #########################################
  # READY FOR 1800 NAPOLEON BOOKMARK

  k_punjab: {sikh_empire_founded: "k_punjab", second_sikh_war: "e_britannia", india_independence: "k_baluchistan"},
  k_kashmir: {sikh_empire_founded: "k_punjab", second_sikh_war: "e_britannia", india_independence: "k_baluchistan"},
  d_uttaranchal: {sikh_empire_founded: "k_punjab", second_sikh_war: "e_britannia", india_independence: "e_india"},
  c_trigarta: {sikh_empire_founded: "k_punjab", second_sikh_war: "e_britannia", india_independence: "e_india"},

  #########################################
  # READY FOR CONGRESS OF VIENNA BOOKMARK

  c_luxembourg: {congress_of_vienna: "k_frisia", luxembourg_independence: "d_luxembourg"},
  c_liege: {congress_of_vienna: "k_frisia", belgium_independence: "d_flanders"},
  d_flanders: {congress_of_vienna: "k_frisia", belgium_independence: "d_flanders"},
  d_brabant: {congress_of_vienna: "k_frisia", belgium_independence: "d_flanders"},

  c_savoie: {congress_of_vienna: "k_italy", treaty_of_zurich: "e_france"},
  c_nice: {congress_of_vienna: "k_italy", treaty_of_zurich: "e_france"},
  d_sardinia: {congress_of_vienna: "k_italy", italy_unification: "e_italy"},
  d_susa: {congress_of_vienna: "k_italy", italy_unification: "e_italy"},
  d_genoa: {congress_of_vienna: "k_italy", italy_unification: "e_italy"},
  d_lombardia: {congress_of_vienna: "e_carpathia", treaty_of_zurich: "k_italy", italy_unification: "e_italy"},

  # More or less Alsace-Lorraine
  d_alsace: {congress_of_vienna: "e_france", german_unification: "e_germany", end_ww1: "e_france"},
  c_lorraine: {congress_of_vienna: "e_france", german_unification: "e_germany", end_ww1: "e_france"},
  c_metz: {congress_of_vienna: "e_france", german_unification: "e_germany", end_ww1: "e_france"},

  c_loon: {congress_of_vienna: "k_frisia"},

  c_julich: {congress_of_vienna: "k_pomerania", german_unification: "e_germany", end_ww2: "k_germany", german_reunification: "e_germany"},
  d_koln: {congress_of_vienna: "k_pomerania", german_unification: "e_germany", end_ww2: "k_germany", german_reunification: "e_germany"},
  d_munster_germany: {congress_of_vienna: "k_pomerania", german_unification: "e_germany", end_ww2: "k_germany", german_reunification: "e_germany"},

  c_oldenburg: {congress_of_vienna: "c_oldenburg", german_unification: "e_germany", end_ww2: "k_germany", german_reunification: "e_germany"},
  c_rugen: {congress_of_vienna: "k_pomerania", german_unification: "e_germany", end_ww2: "k_pomerania", german_reunification: "e_germany"},
  c_ostfriesland: {congress_of_vienna: "d_brunswick", prussia_annexes_hannover: "k_pomerania", german_unification: "e_germany", end_ww2: "k_germany", german_reunification: "e_germany"},
  d_saxony: {congress_of_vienna: "d_brunswick", prussia_annexes_hannover: "k_pomerania", german_unification: "e_germany", end_ww2: "k_germany", german_reunification: "e_germany"},
  c_gottingen: {congress_of_vienna: "d_brunswick", prussia_annexes_hannover: "k_pomerania", german_unification: "e_germany", end_ww2: "k_germany", german_reunification: "e_germany"},
  d_angria: {congress_of_vienna: "d_brunswick", prussia_annexes_hannover: "k_pomerania", german_unification: "e_germany", end_ww2: "k_germany", german_reunification: "e_germany"},
  c_verden: {congress_of_vienna: "d_brunswick", prussia_annexes_hannover: "k_pomerania", german_unification: "e_germany", end_ww2: "k_germany", german_reunification: "e_germany"},
  c_pfalz: {congress_of_vienna: "d_bavaria", end_ww1: "e_germany", end_ww2: "k_germany", german_reunification: "e_germany"},
  d_trier: {congress_of_vienna: "k_pomerania", german_unification: "e_germany", end_ww2: "k_germany", german_reunification: "e_germany"},
  c_bamberg: {congress_of_vienna: "d_bavaria", end_ww1: "e_germany", end_ww2: "k_germany", german_reunification: "e_germany"},
  c_wurzburg: {congress_of_vienna: "d_bavaria", end_ww1: "e_germany", end_ww2: "k_germany", german_reunification: "e_germany"},
  c_wolgast: {congress_of_vienna: "k_pomerania", german_unification: "e_germany", end_ww2: "k_pomerania", german_reunification: "e_germany"},
  c_thuringen: {congress_of_vienna: "c_thuringen", german_unification: "e_germany", end_ww2: "k_pomerania", german_reunification: "e_germany"},
  c_nassau: {congress_of_vienna: "c_nassau", prussia_annexes_hannover: "k_pomerania", german_unification: "e_germany", end_ww2: "k_germany", german_reunification: "e_germany"},
  d_franconia: {congress_of_vienna: "d_franconia", prussia_annexes_hannover: "k_pomerania", german_unification: "e_germany", end_ww2: "k_germany", german_reunification: "e_germany"},
  d_hesse: {congress_of_vienna: "d_franconia", prussia_annexes_hannover: "k_pomerania", german_unification: "e_germany", end_ww2: "k_germany", german_reunification: "e_germany"},
  d_rhine: {congress_of_vienna: "d_franconia", prussia_annexes_hannover: "k_pomerania", german_unification: "e_germany", end_ww2: "k_germany", german_reunification: "e_germany"},

  d_chera_nadu: {travancore_british: "k_tamilakam", india_independence: "e_india"},
  k_andhra: {andhra_british: "k_andhra", india_independence: "e_india"},
  k_karnata: {fourth_mysore_war: "k_karnata", india_independence: "e_india"},
  k_tamilakam: {fourth_mysore_war: "k_tamilakam", india_independence: "e_india"},
  k_telingana: {hyderabad_british: "k_telingana", india_independence: "e_india"},
  k_orissa: {orissa_british: "k_orissa", india_independence: "e_india"},

  # FIXME: c_saargau: was independent for a while

  e_tibet: {forever_ago: "e_tibet", tibet_chinese: "e_china_west_governor"},
  d_bhutan: {forever_ago: "d_bhutan"},
  k_nepal: {forever_ago: "k_nepal"},

  # ALL FIXME, it's OK for 2017 but history is not correct:
  k_hausaland: {forever_ago: "e_france", niger_independence: "k_hausaland"},
  k_kanem: {forever_ago: "e_france", chad_independence: "k_kanem"},
}

###########################################################################
# FIXME: Everything that uses temporary_start: needs fixing
# TODO: k_england -> e_britannia / k_rus -> e_russia
# FIXME: Hungary / Romania / Serbia border might need fixing

ModernTimesDatabase::LAND = {
  #########################################
  # READY FOR 1600 BOOKMARK

  # Level of actualy Ottoman control was fairly minor
  d_sanaa:        { times_immemorial: "e_seljuk_turks", aden_protectorate: "e_britannia", south_yemen_independence: "d_sanaa" },
  c_aden:         { times_immemorial: "e_seljuk_turks",aden_city_british: "e_britannia", south_yemen_independence: "d_sanaa" },

  c_abkhazia:     { times_immemorial: "e_seljuk_turks", treaty_of_adrianople: "d_abkhazia", russia_circassia_war: "e_russia", end_ww1: "k_georgia", abkhazia_war: "e_russia" },
  c_guria:        { times_immemorial: "e_seljuk_turks", treaty_of_adrianople: "d_abkhazia", russia_circassia_war: "e_russia", end_ww1: "k_georgia" },
  c_imeretia:     { times_immemorial: "e_seljuk_turks", treaty_of_adrianople: "d_abkhazia", russia_circassia_war: "e_russia", end_ww1: "k_georgia" },

  d_nikaea:       { times_immemorial: "e_seljuk_turks" },
  c_byzantion:    { times_immemorial: "e_seljuk_turks" },
  d_armeniacon:   { times_immemorial: "e_seljuk_turks" },
  d_thracesia:    { times_immemorial: "e_seljuk_turks" },
  d_anatolia:     { times_immemorial: "e_seljuk_turks" },
  d_charsianon:   { times_immemorial: "e_seljuk_turks" },
  d_trebizond:    { times_immemorial: "e_seljuk_turks" },
  d_paphlagonia:  { times_immemorial: "e_seljuk_turks" },
  c_abydos:       { times_immemorial: "e_seljuk_turks" },
  d_cibyrrhaeot:  { times_immemorial: "e_seljuk_turks" },
  d_mesopotamia:  { times_immemorial: "e_seljuk_turks" },
  d_coloneia:     { times_immemorial: "e_seljuk_turks" },
  d_armenia_minor:{ times_immemorial: "e_seljuk_turks" },
  c_ani:          { times_immemorial: "e_seljuk_turks" },
  c_vaspurakan:   { times_immemorial: "e_seljuk_turks" },
  c_tao:          { times_immemorial: "e_seljuk_turks" },
  d_samos:        { times_immemorial: "e_seljuk_turks" },
  d_edessa:       { times_immemorial: "e_seljuk_turks"},
  c_amida:        { times_immemorial: "e_seljuk_turks"},
  c_kurdistan:    { times_immemorial: "e_seljuk_turks"}, # Maybe Iraq, but then Turkey wouldn't border Iran any more
  d_thrace:       { times_immemorial: "e_seljuk_turks", treaty_of_sevres: "k_byzantium", treaty_of_lausanne: "e_seljuk_turks" },

  d_alexandria: { times_immemorial: "k_egypt" },
  d_cairo: { times_immemorial: "k_egypt" },
  d_aswan: { times_immemorial: "k_egypt" },
  d_damietta: { times_immemorial: "k_egypt" },

  c_sinai: { times_immemorial: "k_egypt", six_day_war: "k_israel", egypt_israel_peace: "k_egypt" },
  c_farama: { times_immemorial: "k_egypt", six_day_war: "k_israel", egypt_israel_peace: "k_egypt" },
  "c_el-arish": { times_immemorial: "k_egypt", six_day_war: "k_israel", egypt_israel_peace: "k_egypt" },

  c_beirut: { times_immemorial: "e_seljuk_turks", end_ww1: "e_france", lebanon_independence: "d_galilee" },
  c_tyrus:  { times_immemorial: "e_seljuk_turks", end_ww1: "e_france", lebanon_independence: "d_galilee" },

  c_eilat:   { times_immemorial: "e_seljuk_turks", end_ww1: "e_britannia", israel_independence: "k_israel" },
  c_negev:   { times_immemorial: "e_seljuk_turks", end_ww1: "e_britannia", israel_independence: "k_israel" },
  d_ascalon: { times_immemorial: "e_seljuk_turks", end_ww1: "e_britannia", israel_independence: "k_israel" },
  c_acre:    { times_immemorial: "e_seljuk_turks", end_ww1: "e_britannia", israel_independence: "k_israel" },

  c_hebron:    { times_immemorial: "e_seljuk_turks", end_ww1: "e_britannia", israel_independence: "d_oultrejourdain", six_day_war: "k_israel" },
  c_jerusalem: { times_immemorial: "e_seljuk_turks", end_ww1: "e_britannia", israel_independence: "d_oultrejourdain", six_day_war: "k_israel" },

  c_oromieh: { times_immemorial: "e_seljuk_turks", british_iraq: "e_britannia", iraq_independence: "k_mesopotamia"},
  d_baghdad: { times_immemorial: "e_seljuk_turks", british_iraq: "e_britannia", iraq_independence: "k_mesopotamia"},
  d_tigris:  { times_immemorial: "e_seljuk_turks", british_iraq: "e_britannia", iraq_independence: "k_mesopotamia"},
  d_basra:   { times_immemorial: "e_seljuk_turks", british_iraq: "e_britannia", iraq_independence: "k_mesopotamia"},

  c_mosul:   { times_immemorial: "e_seljuk_turks", british_iraq: "e_britannia", iraq_independence: "k_mesopotamia", caliphate_reborn: "d_sunni"},
  c_suwaida: { times_immemorial: "e_seljuk_turks", british_iraq: "e_britannia", iraq_independence: "k_mesopotamia", caliphate_reborn: "d_sunni"},
  c_druz:    { times_immemorial: "e_seljuk_turks", british_iraq: "e_britannia", iraq_independence: "k_mesopotamia", caliphate_reborn: "d_sunni"},
  c_sinjar:  { times_immemorial: "e_seljuk_turks", british_iraq: "e_britannia", iraq_independence: "k_mesopotamia", caliphate_reborn: "d_sunni"},
  c_tiberias:    { times_immemorial: "e_seljuk_turks", end_ww1: "e_france", syria_independence: "k_syria", six_day_war: "k_israel" },
  c_safed:       { times_immemorial: "e_seljuk_turks", end_ww1: "e_france", syria_independence: "k_syria" },
  c_tell_bashir: { times_immemorial: "e_seljuk_turks", end_ww1: "e_france", syria_independence: "k_syria", caliphate_reborn: "d_sunni"  },
  k_syria:       { times_immemorial: "e_seljuk_turks", end_ww1: "e_france", syria_independence: "k_syria" },
  d_jazira:      { times_immemorial: "e_seljuk_turks", end_ww1: "e_france", syria_independence: "k_syria" },
  d_tunis:        { times_immemorial: "e_seljuk_turks", tunisia_french: "e_france", tunisia_independence: "d_tunis" },
  d_alger:        { times_immemorial: "e_seljuk_turks", algeria_french: "e_france", algeria_indepnedence: "d_alger" },
  d_kabylia:      { times_immemorial: "e_seljuk_turks", algeria_french: "e_france", algeria_indepnedence: "d_alger" },
  d_tlemcen:      { times_immemorial: "e_seljuk_turks", algeria_french: "e_france", algeria_indepnedence: "d_alger" },
  d_tripolitania: { times_immemorial: "e_seljuk_turks", libya_italian: "e_italy", libya_independence: "d_tripolitania"},
  d_cyrenaica:    { times_immemorial: "e_seljuk_turks", libya_italian: "e_italy", libya_independence: "d_tripolitania"},

  c_severin:    { times_immemorial: "e_seljuk_turks", treaty_of_berlin: "k_dacia" },
  c_tirgoviste: { times_immemorial: "e_seljuk_turks", treaty_of_berlin: "k_dacia" },
  c_turnu:      { times_immemorial: "e_seljuk_turks", treaty_of_berlin: "k_dacia" },
  c_constantia: { times_immemorial: "e_seljuk_turks", treaty_of_berlin: "k_dacia" },

  c_strymon:  { times_immemorial: "e_seljuk_turks", treaty_of_london: "k_serbia", macedonia_independence: "d_dyrrachion" },
  c_ochrid:   { times_immemorial: "e_seljuk_turks", treaty_of_london: "k_serbia", macedonia_independence: "d_dyrrachion" },
  c_belgrade: { times_immemorial: "e_seljuk_turks", treaty_of_berlin: "k_serbia" },
  d_rashka:   { times_immemorial: "e_seljuk_turks", treaty_of_london: "k_serbia" },
  c_rama:     { times_immemorial: "e_seljuk_turks", treaty_of_london: "k_serbia" },
  c_naissus:  { times_immemorial: "e_seljuk_turks", treaty_of_london: "k_serbia" },

  d_turnovo:      { times_immemorial: "e_seljuk_turks", treaty_of_berlin: "k_bulgaria" },
  c_karvuna:      { times_immemorial: "e_seljuk_turks", treaty_of_berlin: "k_bulgaria" },
  c_vidin:        { times_immemorial: "e_seljuk_turks", treaty_of_berlin: "k_bulgaria" },
  c_tyrnovo:      { times_immemorial: "e_seljuk_turks", eastern_rumelia_unification: "k_bulgaria" },
  c_mesembria:    { times_immemorial: "e_seljuk_turks", eastern_rumelia_unification: "k_bulgaria" },

  # Given to Greece September 15, 1947
  c_rhodos:       { times_immemorial: "e_seljuk_turks", libya_italian: "e_italy", end_ww2: "k_byzantium"},
  c_epeiros:      { times_immemorial: "e_seljuk_turks", treaty_of_london: "k_byzantium" },
  d_thessalonika: { times_immemorial: "e_seljuk_turks", treaty_of_london: "k_byzantium" },
  c_philippopolis:{ times_immemorial: "e_seljuk_turks", treaty_of_london: "k_byzantium" },
  c_thessalia:    { times_immemorial: "e_seljuk_turks", convention_of_constantinople: "k_byzantium" },
  c_arta:         { times_immemorial: "e_seljuk_turks", convention_of_constantinople: "k_byzantium" },
  c_lesbos:       { times_immemorial: "e_seljuk_turks", treaty_of_london: "k_byzantium" },
  c_chios:        { times_immemorial: "e_seljuk_turks", treaty_of_london: "k_byzantium" },

  d_cyprus:     { times_immemorial: "e_seljuk_turks", cyprus_convention: "e_britannia", cyprus_independence: "d_cyprus" },
  c_famagusta:  { times_immemorial: "e_seljuk_turks", cyprus_convention: "e_britannia", cyprus_independence: "d_cyprus", north_cyprus_invasion: "e_seljuk_turks" },

  d_syria:       { times_immemorial: "e_seljuk_turks", end_ww1: "e_france", syria_independence: "k_syria", caliphate_reborn: "d_sunni" },
  c_palmyra:     { times_immemorial: "e_seljuk_turks", end_ww1: "e_france", syria_independence: "k_syria", caliphate_reborn: "d_sunni" },
  c_asas:        { times_immemorial: "e_seljuk_turks", end_ww1: "e_france", syria_independence: "k_syria", caliphate_reborn: "d_sunni" },
  d_oultrejourdain: { times_immemorial: "e_seljuk_turks", end_ww1: "e_britannia", jordan_independence: "d_oultrejourdain" },

  k_mauretania:{ times_immemorial: "k_mauretania", morocco_protectorate: "e_france", french_morocco_independence: "k_mauretania" },
  c_cebta:     { times_immemorial: "k_mauretania", morocco_protectorate: "e_spain",  north_spanish_morocco_end: "k_mauretania" },
  c_tangiers:  { times_immemorial: "k_mauretania", morocco_protectorate: "e_spain",  north_spanish_morocco_end: "k_mauretania" },
  c_el_rif:    { times_immemorial: "k_mauretania", morocco_protectorate: "e_spain",  north_spanish_morocco_end: "k_mauretania" },

  c_petra:   { times_immemorial: "e_seljuk_turks", end_ww1: "e_britannia", jordan_independence: "d_oultrejourdain" },
  c_maan:    { times_immemorial: "e_seljuk_turks", end_ww1: "e_britannia", jordan_independence: "d_oultrejourdain" },
  c_amman:   { times_immemorial: "e_seljuk_turks", end_ww1: "e_britannia", jordan_independence: "d_oultrejourdain" },
  c_az_zarqa:{ times_immemorial: "e_seljuk_turks", end_ww1: "e_britannia", jordan_independence: "d_oultrejourdain" },


  # GeaCron has no countries there so just shatter it into duchies before Europeans show up
  d_songhay:    { times_immemorial: "d_songhay", french_mali: "e_france", mali_independence: "k_mali" },
  d_mali:       { times_immemorial: "d_mali", french_mali: "e_france", mali_independence: "k_mali" },
  d_timbuktu:   { times_immemorial: "d_timbuktu", mauritania_french: "e_france", mauritania_independence: "d_timbuktu" },
  c_ghana:      { times_immemorial: "d_timbuktu", mauritania_french: "e_france", mauritania_independence: "d_timbuktu" },
  c_aoudaghost: { times_immemorial: "d_timbuktu", mauritania_french: "e_france", mauritania_independence: "d_timbuktu" },
  c_tadjoura:   { times_immemorial: "d_harer", djibouti_french: "e_france", djibouti_independence: "d_afar" },
  d_harer:      { times_immemorial: "d_harer", british_somaliland: "e_britannia", somalia_independence: "d_harer" },
  c_busaso:     { times_immemorial: "d_harer", italian_somaliland: "e_italy", somalia_independence: "d_harer"  },
  c_idjil:      { times_immemorial: "d_ghana", spanish_sahara: "e_spain", madrid_accords: "k_mauretania" },
  c_ouadane:    { times_immemorial: "d_ghana", spanish_sahara: "e_spain", madrid_accords: "k_mauretania" },
  c_tharasset:  { times_immemorial: "d_ghana", spanish_sahara: "e_spain", madrid_accords: "k_mauretania" },

  c_urbino:     { times_immemorial: "c_urbino", urbino_papal: "k_papal_state", treaty_of_zurich: "k_italy", italy_unification: "e_italy" },
  c_venaissin:  { times_immemorial: "k_papal_state", avignon_annexation: "e_france" },
  d_ferrara:    { times_immemorial: "k_papal_state", treaty_of_zurich: "k_italy", italy_unification: "e_italy" },
  d_ancona:     { times_immemorial: "k_papal_state", treaty_of_zurich: "k_italy", italy_unification: "e_italy" },
  c_spoleto:    { times_immemorial: "k_papal_state", treaty_of_zurich: "k_italy", italy_unification: "e_italy" },
  c_roma:       { times_immemorial: "k_papal_state" },
  d_latium:     { times_immemorial: "k_papal_state", capture_of_rome: "e_italy" },

  k_abyssinia: { times_immemorial: "k_abyssinia" },
  c_kassala:   { times_immemorial: "k_abyssinia" },
  c_trinkitat:{ times_immemorial: "k_abyssinia", eritrea_italian: "e_italy", eritrea_british: "e_britannia", eritrea_ethiopian: "k_abyssinia", eritrea_independence: "d_hayya"},
  c_hayya:    { times_immemorial: "k_abyssinia", eritrea_italian: "e_italy", eritrea_british: "e_britannia", eritrea_ethiopian: "k_abyssinia", eritrea_independence: "d_hayya"},
  c_assab:    { times_immemorial: "k_abyssinia", eritrea_italian: "e_italy", eritrea_british: "e_britannia", eritrea_ethiopian: "k_abyssinia", eritrea_independence: "d_hayya"},
  c_massawa:  { times_immemorial: "k_abyssinia", eritrea_italian: "e_italy", eritrea_british: "e_britannia", eritrea_ethiopian: "k_abyssinia", eritrea_independence: "d_hayya"},

  # Not really unified
  k_nubia:      { times_immemorial: "k_nubia", sudan_turkish: "e_seljuk_turks", british_egypt: "e_britannia", sudan_independence: "k_nubia" },

  e_britannia:  { times_immemorial: "e_britannia" },
  k_ireland:    { times_immemorial: "e_britannia", ireland_independence: "k_ireland" },
  d_ulster:     { times_immemorial: "e_britannia" },
  c_tyrconnell: { times_immemorial: "e_britannia", ireland_independence: "k_ireland" },
  k_scotland:   { times_immemorial: "k_scotland", scotland_union: "e_britannia", scotland_devolution: "k_scotland" },
  c_orkney:     { times_immemorial: "k_scotland", scotland_union: "e_britannia" },
  c_shetland:   { times_immemorial: "k_scotland", scotland_union: "e_britannia" },

  k_brittany:   { times_immemorial: "e_france" },

  #########################################
  # READY FOR PEACE OF WESTPHALIA BOOKMARK

  #########################################
  # READY FOR 1700 BOOKMARK

  d_dihistan:  { forever_ago: "d_khiva", khiva_russian: "e_russia", end_ww1: "d_dihistan" },
  c_merv:      { forever_ago: "d_khiva", khiva_russian: "e_russia", end_ww1: "d_dihistan" },
  c_aral:      { forever_ago: "d_khiva", khiva_russian: "e_russia", end_ww1: "k_khiva" },
  d_turkestan: { forever_ago: "d_khiva", khiva_russian: "e_russia", end_ww1: "k_cuman" },

  d_iceland:    { forever_ago: "k_denmark", iceland_independence: "d_iceland" },
  c_algeciras:  { forever_ago: "e_spain", treaty_of_utrech: "e_britannia" },
  k_portugal:   { forever_ago: "k_portugal" },
  c_goa:        { forever_ago: "k_portugal", goa_annexation: "e_india" }, # 1505 or so
  e_spain:      { forever_ago: "e_spain" },
  c_canarias:   { forever_ago: "e_spain" },
  d_sjaelland:  { forever_ago: "k_denmark" },
  d_slesvig:    { forever_ago: "k_denmark" },
  c_bornholm:   { forever_ago: "k_denmark" },
  d_skane:      { forever_ago: "k_sweden" },
  k_sweden:     { forever_ago: "k_sweden" },
  d_jamtland:   { forever_ago: "k_sweden" },
  c_rosello:    { forever_ago: "e_france" }, # 1659+

  d_savoie:         { forever_ago: "k_burgundy" },
  d_upper_burgundy: { forever_ago: "k_burgundy" },
  k_france:         { forever_ago: "e_france" },
  k_aquitaine:      { forever_ago: "e_france" },
  c_boulogne:       { forever_ago: "e_france" },
  c_artois:         { forever_ago: "e_france" },
  c_guines:         { forever_ago: "e_france" },

  c_faereyar:   { forever_ago: "k_norway" },
  d_ostlandet:  { forever_ago: "k_norway" },
  d_vestlandet: { forever_ago: "k_norway" },
  d_trondelag:  { forever_ago: "k_norway" },

  k_bohemia:    { forever_ago: "e_carpathia", czechoslovakia_independence: "k_bohemia", protectorate_of_bohemia_and_moravia: "e_germany", end_ww2: "k_bohemia" },
  c_litomerice: { forever_ago: "e_carpathia", czechoslovakia_independence: "k_bohemia", munich_agreement: "e_germany", end_ww2: "k_bohemia" },
  c_plzen:      { forever_ago: "e_carpathia", czechoslovakia_independence: "k_bohemia", munich_agreement: "e_germany", end_ww2: "k_bohemia" },

  d_nyitra:       { forever_ago: "e_carpathia", czechoslovakia_independence: "k_bohemia", protectorate_of_bohemia_and_moravia: "e_germany", end_ww2: "k_bohemia", czechoslovakia_dissolution: "d_nyitra" },
  c_pressburg:    { forever_ago: "e_carpathia", czechoslovakia_independence: "k_bohemia", protectorate_of_bohemia_and_moravia: "e_germany", end_ww2: "k_bohemia", czechoslovakia_dissolution: "d_nyitra" },
  c_saris:        { forever_ago: "e_carpathia", czechoslovakia_independence: "k_bohemia", protectorate_of_bohemia_and_moravia: "e_germany", end_ww2: "k_bohemia", czechoslovakia_dissolution: "d_nyitra" },

  c_aland:      { forever_ago: "k_sweden", end_of_swedish_finland: "e_russia", finland_independence: "k_finland" },
  d_finland:    { forever_ago: "k_sweden", end_of_swedish_finland: "e_russia", finland_independence: "k_finland" },
  c_kemi:       { forever_ago: "k_sweden", end_of_swedish_finland: "e_russia", finland_independence: "k_finland" },

  k_perm:           { forever_ago: "e_russia" },
  k_volga_bulgaria: { forever_ago: "e_russia" },
  k_rus:            { forever_ago: "e_russia" },
  d_alania:         { forever_ago: "e_russia" },
  c_alania:         { forever_ago: "e_russia", fall_soviet_union: "c_alania", fall_chechnya: "e_russia"},
  c_kuban:          { forever_ago: "e_russia" },
  c_sarpa:          { forever_ago: "e_russia" },

  k_persia:       { forever_ago: "e_persia" },
  d_sistan:       { forever_ago: "e_persia" },
  d_kermanshah:   { forever_ago: "e_persia" },
  c_dailam:       { forever_ago: "e_persia", iranian_revolution: "d_hashshashin" },

  # After 1758 Xinjiang in China. Before Dzungar Khanate
  k_khotan:     { forever_ago: "k_khotan" },
  c_dunkheger:  { forever_ago: "k_khotan" },
  c_altay:      { forever_ago: "k_khotan" },

  # This is awkward, as it was Chinese all along, but Dzungar goes away
  k_mongolia:   { forever_ago: "k_mongolia", fall_dzungar: "k_khotan", mongolia_independence: "k_mongolia" },

  c_trent:        { forever_ago: "e_carpathia", end_ww1: "k_bavaria", south_tirol_annexation: "e_italy" },
  d_osterreich:   { forever_ago: "e_carpathia", end_ww1: "k_bavaria", anschluss: "e_germany", end_ww2: "k_bavaria" },
  d_tyrol:        { forever_ago: "e_carpathia", end_ww1: "k_bavaria", anschluss: "e_germany", end_ww2: "k_bavaria" },

  c_teluch:      { forever_ago: "e_seljuk_turks", treaty_of_sevres: "e_france", treaty_of_ankara: "e_seljuk_turks" },
  c_antiocheia:  { forever_ago: "e_seljuk_turks", treaty_of_sevres: "e_france", treaty_of_ankara: "e_seljuk_turks" },
  c_alexandretta:{ forever_ago: "e_seljuk_turks", treaty_of_sevres: "e_france", treaty_of_ankara: "e_seljuk_turks" },

  d_silesia: {forever_ago: "e_carpathia", silesia_prussian: "k_pomerania", german_unification: "e_germany", end_ww2: "k_poland"},
  c_cieszyn: {forever_ago: "e_carpathia", silesia_prussian: "k_pomerania", german_unification: "e_germany", silesian_uprising: "k_poland"},

  c_marienburg:   { forever_ago: "e_wendish_empire", poland_1_partition: "k_pomerania", german_unification: "e_germany", end_ww2: "k_poland"},
  d_prussia:      { forever_ago: "k_pomerania", german_unification: "e_germany", end_ww2: "k_poland"},
  c_scalovia:     { forever_ago: "k_pomerania", german_unification: "e_germany", end_ww2: "e_russia"},
  c_sambia:       { forever_ago: "k_pomerania", german_unification: "e_germany", end_ww2: "e_russia"},
  c_memel:        { forever_ago: "k_pomerania", german_unification: "e_germany", end_ww1: "d_lithuanians", memel_german: "e_germany", end_ww2: "d_lithuanians" },
  c_danzig:       { forever_ago: "e_wendish_empire", poland_1_partition: "k_pomerania", free_danzig_napoleonic: "d_pomeralia", free_danzig_napoleonic_end: "k_pomerania", german_unification: "e_germany", end_ww1: "d_pomeralia", end_ww2: "k_poland"},
  d_kiev:        {  forever_ago: "e_wendish_empire", poland_2_partition: "e_russia", end_ww1: "k_ruthenia"},

  d_ryazan:     { forever_ago: "e_russia" },
  d_sarkel:     { forever_ago: "e_russia" },

  d_courland:    { forever_ago: "e_wendish_empire", poland_3_partition: "e_russia", end_ww1: "d_courland" },

  d_esthonia:    { forever_ago: "k_sweden", treaty_of_nystad: "e_russia", end_ww1: "d_esthonia" },
  d_livonia:     { forever_ago: "k_sweden", treaty_of_nystad: "e_russia", end_ww1: "d_esthonia" },
  c_kexholm:    { forever_ago: "k_sweden", treaty_of_nystad: "e_russia", finland_independence: "k_finland" },
  c_savolaks:   { forever_ago: "k_sweden", end_of_swedish_finland: "e_russia", finland_independence: "k_finland" },

  c_lettigalians:{ forever_ago: "k_sweden", treaty_of_nystad: "e_russia", end_ww1: "d_courland" },
  c_west_dvina:  { forever_ago: "k_sweden", treaty_of_nystad: "e_russia", end_ww1: "d_courland" },

  d_kola:       { forever_ago: "e_russia" },
  d_karelia:    { forever_ago: "e_russia" },
  c_malta:      { forever_ago: "c_malta", malta_british: "e_britannia", malta_independence: "c_malta" },
  c_corsica:    { forever_ago: "d_genoa", french_corsica: "e_france" },

  c_steiermark:   { forever_ago: "e_carpathia", end_ww1: "k_serbia", slovenia_independence: "d_carinthia" },
  c_aquileia:     { forever_ago: "e_carpathia", end_ww1: "k_serbia", slovenia_independence: "d_carinthia" },

  c_adrianopolis:{ forever_ago: "e_seljuk_turks", treaty_of_sevres: "k_byzantium", treaty_of_lausanne: "e_seljuk_turks" },
  c_smyrna:      { forever_ago: "e_seljuk_turks", treaty_of_sevres: "k_byzantium", treaty_of_lausanne: "e_seljuk_turks" },

  c_cephalonia:   { forever_ago: "d_venice", congress_of_vienna: "e_britannia", cephalonia_greek: "k_byzantium" },
  d_krete:       { forever_ago: "e_seljuk_turks", crete_independence: "d_krete", treaty_of_london: "k_byzantium" }, # De facto Greek in 1908

  d_esztergom:    { forever_ago: "e_carpathia", end_ww1: "k_hungary" },
  d_pecs:         { forever_ago: "e_carpathia", end_ww1: "k_hungary" },
  d_transylvania: { forever_ago: "e_carpathia", end_ww1: "k_dacia" },
  d_pest:         { forever_ago: "e_carpathia", end_ww1: "k_hungary" },
  c_abauj:        { forever_ago: "e_carpathia", end_ww1: "k_hungary" },
  c_marmaros:     { forever_ago: "e_carpathia", end_ww1: "k_dacia" },
  d_temes:        { forever_ago: "e_seljuk_turks", treaty_of_passarowitz: "e_carpathia", end_ww1: "k_hungary" },
  c_temes:        { forever_ago: "e_seljuk_turks", treaty_of_passarowitz: "e_carpathia", end_ww1: "k_dacia" },

  c_gnieznienskie: { forever_ago: "e_wendish_empire", poland_1_partition: "k_pomerania", german_unification: "e_germany", end_ww1: "k_poland" },
  c_kujawy:       { forever_ago: "e_wendish_empire", poland_1_partition: "k_pomerania", duchy_warsaw: "k_poland", congress_of_vienna: "e_russia", end_ww1: "k_poland" },

  d_pereyaslavl: { forever_ago: "e_russia", end_ww1: "k_ruthenia"},
  c_sharukan: { forever_ago: "e_russia", end_ww1: "k_ruthenia"},
  :"c_desht-i-kipchak" => { forever_ago: "e_russia", end_ww1: "k_ruthenia"},

  c_stettin:      { forever_ago: "k_pomerania", german_unification: "e_germany", end_ww2: "k_poland"},
  c_slupsk:       { forever_ago: "k_pomerania", german_unification: "e_germany", end_ww2: "k_poland"},
  d_brandenburg:  { forever_ago: "k_pomerania", german_unification: "e_germany", end_ww2: "k_saxony", german_reunification: "e_germany"},
  c_lubusz:       { forever_ago: "k_pomerania", german_unification: "e_germany", end_ww2: "k_poland"},

  d_athens:      { forever_ago: "e_seljuk_turks", greece_independence: "k_byzantium" },
  d_achaia:      { forever_ago: "d_venice", treaty_of_passarowitz: "e_seljuk_turks", greece_independence: "k_byzantium" },
  c_naxos:       { forever_ago: "e_seljuk_turks", greece_independence: "k_byzantium" },
  c_euboia:      { forever_ago: "e_seljuk_turks", greece_independence: "k_byzantium" },
  d_burgundy:    { forever_ago: "e_france" },
  d_provence:    { forever_ago: "e_france" },
  d_dauphine:    { forever_ago: "e_france" },
  c_besancon:    { forever_ago: "e_france" },

  k_lanka:       { forever_ago: "k_frisia", sri_lanka_british: "e_britannia", sri_lanka_independence: "k_lanka" },
  c_maldives:    { forever_ago: "k_frisia", sri_lanka_british: "e_britannia", maldives_independence: "c_maldives" },

  c_breda:      { forever_ago: "k_frisia" },
  d_holland:    { forever_ago: "k_frisia" },
  d_gelre:      { forever_ago: "k_frisia" },

  c_mantua:     { forever_ago: "c_mantua", mantua_austrian: "e_carpathia", treaty_of_zurich: "k_italy", italy_unification: "e_italy"},

  c_lucca:      { forever_ago: "c_lucca", end_of_lucca: "d_toscana", treaty_of_zurich: "k_italy", italy_unification: "e_italy" },
  d_toscana:    { forever_ago: "d_toscana", treaty_of_zurich: "k_italy", italy_unification: "e_italy" },
  d_pisa:       { forever_ago: "d_toscana", treaty_of_zurich: "k_italy", italy_unification: "e_italy" },

  c_parma:      { forever_ago: "c_parma", treaty_of_zurich: "k_italy", italy_unification: "e_italy" },
  c_modena:     { forever_ago: "c_modena", treaty_of_zurich: "k_italy", italy_unification: "e_italy" },

  d_lithuanians: { forever_ago: "e_wendish_empire", poland_3_partition: "e_russia", end_ww1: "d_lithuanians" },
  c_aukshayts:   { forever_ago: "e_wendish_empire", poland_3_partition: "e_russia", end_ww1: "k_poland", end_ww2: "d_lithuanians" },
  c_zhmud:      { forever_ago: "e_wendish_empire", poland_3_partition: "e_russia", end_ww1: "d_lithuanians" },
  c_jacwiez:  { forever_ago: "e_wendish_empire", poland_3_partition: "e_russia", end_ww1: "k_poland", end_ww2: "d_vitebsk"},
  c_podlasie: { forever_ago: "e_wendish_empire", poland_3_partition: "e_russia", end_ww1: "k_poland", end_ww2: "d_vitebsk"},
  c_bryansk:    { forever_ago: "e_russia" },
  c_chernigov:   { forever_ago: "e_russia", end_ww1: "k_ruthenia"},
  c_lyubech:     { forever_ago: "e_wendish_empire", poland_1_partition: "e_russia", end_ww1: "k_ruthenia"},
  c_vodi:       { forever_ago: "k_sweden", st_petersburg_founding: "e_russia" },

  d_itil:      { forever_ago: "e_russia", end_ww1: "k_cuman" }, # GeaCron says it was Russian in 1700, other sources not so sure
  c_novgorod_seversky: { forever_ago: "e_russia", end_ww1: "k_ruthenia"},

  d_smolensk:   { forever_ago: "e_russia" },

  c_mstislavl:{ forever_ago: "e_wendish_empire", poland_1_partition: "e_russia", end_ww1: "d_vitebsk"},
  c_vitebsk:    { forever_ago: "e_wendish_empire", poland_1_partition: "e_russia", end_ww1: "d_vitebsk"},
  d_vitebsk:    { forever_ago: "e_wendish_empire", poland_2_partition: "e_russia", end_ww1: "d_vitebsk"},
  c_polotsk:   { forever_ago: "e_wendish_empire", poland_1_partition: "e_russia", end_ww1: "d_vitebsk"},
  c_lepiel:    { forever_ago: "e_wendish_empire", poland_2_partition: "e_russia", end_ww1: "d_vitebsk"},
  c_pinsk:    { forever_ago: "e_wendish_empire", poland_3_partition: "e_russia", end_ww1: "k_poland", end_ww2: "d_vitebsk"},

  c_salzburg:     { forever_ago: "c_salzburg", peace_of_pressburg: "e_carpathia", treaty_of_shoenbrunn: "d_bavaria", congress_of_vienna: "e_carpathia", end_ww1: "k_bavaria", anschluss: "e_germany", end_ww2: "k_bavaria" },

  d_azov:    { forever_ago: "e_seljuk_turks", treaty_of_kucuk_kaynarca: "e_russia"},
  d_cherson: { forever_ago: "e_seljuk_turks", treaty_of_kucuk_kaynarca: "e_russia", crimea_ukrainian: "k_ruthenia", crimea_invasion: "e_russia" },
  c_crimea:  { forever_ago: "e_seljuk_turks", treaty_of_kucuk_kaynarca: "e_russia", crimea_ukrainian: "k_ruthenia", crimea_invasion: "e_russia" },
  d_crimea:   { forever_ago: "e_seljuk_turks", treaty_of_kucuk_kaynarca: "e_russia", end_ww1: "k_ruthenia"},
  c_tmutarakan: { forever_ago: "e_seljuk_turks", treaty_of_kucuk_kaynarca: "e_russia" },

  # Maybe I sohuld just not have Moldova in the game.
  c_torki:        { forever_ago: "e_seljuk_turks", treaty_of_bucharest_1812: "e_russia", end_ww1: "k_dacia", soviet_partition_of_romania: "d_moldau"},
  c_birlad:       { forever_ago: "e_seljuk_turks", treaty_of_bucharest_1812: "e_russia", end_ww1: "k_dacia", soviet_partition_of_romania: "d_moldau"},
  c_galaz:        { forever_ago: "e_seljuk_turks", treaty_of_bucharest_1812: "e_russia", end_ww1: "k_dacia", soviet_partition_of_romania: "k_ruthenia"},
  d_moldau:       { forever_ago: "e_seljuk_turks", treaty_of_jassy: "e_russia", end_ww1: "k_ruthenia"},

  d_verona:     { forever_ago: "d_venice", treaty_of_campo_formio: "e_carpathia", treaty_of_vienna_1866: "e_italy" },
  d_venice:     { forever_ago: "d_venice", treaty_of_campo_formio: "e_carpathia", treaty_of_vienna_1866: "e_italy" },
  c_zadar:        { forever_ago: "d_venice", treaty_of_campo_formio: "e_carpathia", end_ww1: "k_serbia", croatia_independence: "k_croatia" },
  c_split:        { forever_ago: "d_venice", treaty_of_campo_formio: "e_carpathia", end_ww1: "k_serbia", bosnia_independence: "d_bosnia" },
  d_carinthia:    { forever_ago: "e_carpathia", end_ww1: "k_serbia", croatia_independence: "k_croatia" },
  c_istria:       { forever_ago: "d_venice", treaty_of_campo_formio: "e_carpathia", end_ww1: "k_serbia", croatia_independence: "k_croatia" },

  d_slavonia:     { forever_ago: "e_carpathia", end_ww1: "k_serbia", croatia_independence: "k_croatia" },
  d_croatia:      { forever_ago: "e_carpathia", end_ww1: "k_serbia", croatia_independence: "k_croatia" },
  c_zachlumia:    { forever_ago: "e_seljuk_turks", treaty_of_berlin: "e_carpathia", end_ww1: "k_serbia", bosnia_independence: "d_bosnia" },
  c_usora:        { forever_ago: "e_seljuk_turks", treaty_of_berlin: "e_carpathia", end_ww1: "k_serbia", bosnia_independence: "d_bosnia" },
  c_terebovl:          { forever_ago: "e_wendish_empire", poland_2_partition: "e_russia", end_ww1: "k_ruthenia"},

  d_upper_lorraine: { forever_ago: "e_france" },
  c_verdun:         { forever_ago: "e_france" },

  c_zeta:       { forever_ago: "e_seljuk_turks", treaty_of_london: "d_dioclea", albania_italian: "e_italy", end_ww2: "d_dioclea" },
  c_dyrrachion: { forever_ago: "e_seljuk_turks", treaty_of_london: "d_dioclea", albania_italian: "e_italy", end_ww2: "d_dioclea" },

  c_ragusa:   { forever_ago: "e_seljuk_turks", treaty_of_berlin: "c_ragusa", montenegro_serbian: "k_serbia", montenegro_independence: "c_ragusa" },
  # "It was the capital of the Kingdom of Hungary's Bereg County up until 1919 and between 1938-1944. From 1919 until 1938 it was part of Czechoslovakia."
  c_bereg:  { forever_ago: "e_carpathia", end_ww1: "k_bohemia", protectorate_of_bohemia_and_moravia: "k_hungary", end_ww2: "k_ruthenia" },

  c_peremyshl:         { forever_ago: "e_wendish_empire", poland_1_partition: "e_carpathia", end_ww1: "k_poland" },
  c_galich:            { forever_ago: "e_wendish_empire", poland_1_partition: "e_carpathia", end_ww1: "k_poland", end_ww2: "k_ruthenia" },
  c_turov:             { forever_ago: "e_wendish_empire", poland_2_partition: "e_russia", end_ww1: "k_ruthenia"},
  d_volhynia:          { forever_ago: "e_wendish_empire", poland_3_partition: "e_russia", end_ww1: "k_poland", end_ww2: "k_ruthenia" },

  c_holstein:     { forever_ago: "k_denmark", treaty_of_vienna_1864: "k_pomerania", german_unification: "e_germany" },

  c_bashkirs:  { forever_ago: "e_russia" },
  c_sibir:     { forever_ago: "e_russia" },

  c_menorca: { forever_ago: "e_spain", treaty_of_utrech: "e_britannia", treaty_of_versailles: "e_spain" },

  d_bavaria: { forever_ago: "d_bavaria", german_unification: "e_germany" },

  c_ar_ar:  { forever_ago: "d_nefoud", end_ww1: "k_arabia" },
  d_nefoud: { forever_ago: "d_nefoud", end_ww1: "k_arabia" },
  # 1810s Saudi occupation was just rebels
  d_medina: { forever_ago: "e_seljuk_turks", end_ww1: "d_medina", hejaz_saudi: "k_arabia" },
  d_arabia_petrae: { forever_ago: "e_seljuk_turks", end_ww1: "d_medina", hejaz_saudi: "k_arabia" },
  # Taken by Saudis 1913, but let's not make this official prematurely
  d_amman:   { forever_ago: "e_seljuk_turks", end_ww1: "k_arabia" },

  # Muscat and Oman
  d_oman:     { forever_ago: "d_oman", oman_persian: "e_persia", oman_not_persian: "d_oman", oman_british: "e_britannia", oman_independence: "d_oman" },
  c_dhu_zabi:  { forever_ago: "d_oman", general_maritime_treaty: "e_britannia", oman_independence: "c_dhu_zabi" },

  c_taizz:   { forever_ago: "e_seljuk_turks", north_yemen_independence: "d_arabia_felix", yemen_unification: "d_sanaa" },
  c_sanaa:   { forever_ago: "e_seljuk_turks", north_yemen_independence: "d_arabia_felix", yemen_unification: "d_sanaa" },

  c_plauen:     { forever_ago: "d_saxony", german_unification: "e_germany", end_ww2: "k_saxony", german_reunification: "e_germany"},
  d_meissen:    { forever_ago: "d_saxony", german_unification: "e_germany", end_ww2: "k_saxony", german_reunification: "e_germany"},

  d_khiva:      { forever_ago: "d_khiva", khiva_russian: "e_russia", end_ww1: "k_khiva" },
  c_kyzylkum:   { forever_ago: "d_khiva", khiva_russian: "e_russia", end_ww1: "k_khiva" },

  d_samarkand:  { forever_ago: "d_samarkand", bukhara_russian: "e_russia", end_ww1: "k_khiva" },

  c_bahrein:    { forever_ago: "e_persia", bahrain_1783_invasion: "c_bahrein", bahrain_british: "e_britannia", bahrain_independence: "c_bahrein" },

  d_yaik:       { forever_ago: "k_cuman", junior_juz_russian: "e_russia", end_ww1: "k_cuman" },
  c_guryev:     { forever_ago: "k_cuman", junior_juz_russian: "e_russia", end_ww1: "k_cuman" },
  c_tyumen:     { forever_ago: "k_cuman", junior_juz_russian: "e_russia", end_ww1: "k_cuman" },
  c_itil:       { forever_ago: "k_cuman", junior_juz_russian: "e_russia", end_ww1: "k_cuman" },
  c_turgay:     { forever_ago: "k_cuman", junior_juz_russian: "e_russia", end_ww1: "k_cuman" },
  c_turkestan:  { forever_ago: "k_cuman", junior_juz_russian: "e_russia", end_ww1: "k_cuman" },
  c_pecheneg:   { forever_ago: "k_cuman", junior_juz_russian: "e_russia", end_ww1: "k_cuman" },

  d_kimak:      { forever_ago: "k_cuman", middle_juz_russian: "e_russia", end_ww1: "k_cuman" },
  d_kirghiz:    { forever_ago: "k_cuman", middle_juz_russian: "e_russia", end_ww1: "k_cuman" },
  d_sibir:      { forever_ago: "k_cuman", middle_juz_russian: "e_russia", end_ww1: "k_cuman" },
  d_kipchak:    { forever_ago: "k_cuman", middle_juz_russian: "e_russia", end_ww1: "k_cuman" },
  c_otrar:      { forever_ago: "k_cuman", middle_juz_russian: "e_russia", end_ww1: "k_cuman" },
  c_chach:      { forever_ago: "k_cuman", middle_juz_russian: "e_russia", end_ww1: "k_cuman" },
  c_syr_darya:  { forever_ago: "k_cuman", middle_juz_russian: "e_russia", end_ww1: "k_cuman" },

  d_zhetysu:    { forever_ago: "k_cuman", senior_juz_russian: "e_russia", end_ww1: "k_cuman" },

  #########################################
  # READY FOR 1750 BOOKMARK

  d_azerbaijan:   { treaty_of_resht: "e_persia", treaty_of_gulistan: "e_russia", end_ww1: "d_azerbaijan" },
  c_semender:     { treaty_of_resht: "e_persia", treaty_of_gulistan: "e_russia" },
  c_derbent:      { treaty_of_resht: "e_persia", treaty_of_gulistan: "e_russia" },
  c_lori:         { treaty_of_resht: "e_persia", treaty_of_gulistan: "e_russia", end_ww1: "d_armenia" },
  c_suenik:       { treaty_of_resht: "e_persia", treaty_of_turkmenchai: "e_russia", end_ww1: "d_armenia" },
  c_dwin:         { treaty_of_resht: "e_persia", treaty_of_turkmenchai: "e_russia", end_ww1: "d_armenia" },
  c_albania:      { treaty_of_resht: "e_persia", treaty_of_gulistan: "e_russia", end_ww1: "k_georgia" },
  c_kartli:       { treaty_of_resht: "e_persia", treaty_of_gulistan: "e_russia", end_ww1: "k_georgia" },
  c_kakheti:      { treaty_of_resht: "e_persia", treaty_of_gulistan: "e_russia", end_ww1: "k_georgia" },

  d_kabul:       { durrani_afghanistan: "k_afghanistan" },
  c_udabhanda:   { durrani_afghanistan: "k_afghanistan" },
  c_purushapura: { durrani_afghanistan: "k_afghanistan" },
  c_maymana:     { durrani_afghanistan: "k_afghanistan" },
  c_balkh:       { durrani_afghanistan: "k_afghanistan" },
  d_zabulistan:  { durrani_afghanistan: "k_afghanistan" },
  c_herat:       { durrani_afghanistan: "k_afghanistan" },
  d_baluchistan: { durrani_afghanistan: "k_afghanistan", kalat_independent: "d_baluchistan", baluchistan_agency: "e_britannia", india_independence: "k_baluchistan" },

  #########################################
  # READY FOR CONGRESS OF VIENNA BOOKMARK

  k_sindh:       { sindh_independent: "k_sindh", conquest_of_sindh: "e_britannia", india_independence: "k_baluchistan" },

  k_punjab:      { sikh_empire_founded: "k_punjab", second_sikh_war: "e_britannia", india_independence: "k_baluchistan" },
  c_trigarta:    { sikh_empire_founded: "k_punjab", second_sikh_war: "e_britannia", india_independence: "e_india" },
  c_sakala:      { sikh_empire_founded: "k_punjab", second_sikh_war: "e_britannia", india_independence: "e_india" },

  c_luxembourg: { congress_of_vienna: "k_frisia", luxembourg_independence: "d_luxembourg"},
  c_liege:      { congress_of_vienna: "k_frisia", belgium_independence: "d_flanders" },
  d_flanders:   { congress_of_vienna: "k_frisia", belgium_independence: "d_flanders" },
  d_brabant:    { congress_of_vienna: "k_frisia", belgium_independence: "d_flanders" },

  c_aprutium:   { congress_of_vienna: "k_sicily", treaty_of_zurich: "k_italy", italy_unification: "e_italy" },
  k_sicily:     { congress_of_vienna: "k_sicily", treaty_of_zurich: "k_italy", italy_unification: "e_italy" },
  d_sicily:     { congress_of_vienna: "k_sicily", treaty_of_zurich: "k_italy", italy_unification: "e_italy" },
  c_savoie:     { congress_of_vienna: "k_italy", treaty_of_zurich: "e_france" },
  c_nice:       { congress_of_vienna: "k_italy", treaty_of_zurich: "e_france" },
  d_sardinia:   { congress_of_vienna: "k_italy", italy_unification: "e_italy" },
  d_susa:       { congress_of_vienna: "k_italy", italy_unification: "e_italy" },
  d_genoa:      { congress_of_vienna: "k_italy", italy_unification: "e_italy" },
  d_lombardia:  { congress_of_vienna: "e_carpathia", treaty_of_zurich: "k_italy", italy_unification: "e_italy" },

  d_lesser_poland: { congress_of_vienna: "e_carpathia", end_ww1: "k_poland" },
  c_krakowskie:    { congress_of_vienna: "c_krakowskie", fall_krakow_uprising: "e_carpathia", end_ww1: "k_poland" },
  d_mazovia:       { congress_of_vienna: "e_russia", end_ww1: "k_poland" },
  "c_sieradzko-leczyckie": { congress_of_vienna: "e_russia", end_ww1: "k_poland" },
  c_sandomierskie: { congress_of_vienna: "e_russia", end_ww1: "k_poland" },
  c_kalisz:        { congress_of_vienna: "e_russia", end_ww1: "k_poland" },
  c_poznanskie:    { congress_of_vienna: "k_pomerania", german_unification: "e_germany", end_ww1: "k_poland"},
  c_kaliskie:      { congress_of_vienna: "k_pomerania", german_unification: "e_germany", end_ww1: "k_poland"},

  # More or less Alsace-Lorraine
  d_alsace:         { congress_of_vienna: "e_france", german_unification: "e_germany", end_ww1: "e_france"},
  c_lorraine:       { congress_of_vienna: "e_france", german_unification: "e_germany", end_ww1: "e_france"},
  c_metz:           { congress_of_vienna: "e_france", german_unification: "e_germany", end_ww1: "e_france"},

  c_loon: { congress_of_vienna: "k_frisia" },

  c_julich:     { congress_of_vienna: "k_pomerania", german_unification: "e_germany" },
  d_koln:       { congress_of_vienna: "k_pomerania", german_unification: "e_germany" },

  # FIXME: This ignores all changes 1815-1871, and it definitely shouldn't
  # Peace of Prague Prussia annexes Hanover, Schleswig-Holstein, Electorate of Hesse, Frankfurt, Nassau, and parts of Hesse-Darmstadt
  c_lubeck:       { congress_of_vienna: "c_lubeck", german_unification: "e_germany" },
  c_oldenburg:    { congress_of_vienna: "c_oldenburg", german_unification: "e_germany" },
  c_bremen:       { congress_of_vienna: "c_bremen", german_unification: "e_germany" },
  c_hamburg:      { congress_of_vienna: "c_hamburg", german_unification: "e_germany" },
  c_rugen:        { congress_of_vienna: "k_pomerania", german_unification: "e_germany", end_ww2: "k_saxony", german_reunification: "e_germany" },
  d_mecklemburg:  { congress_of_vienna: "d_mecklemburg", german_unification: "e_germany", end_ww2: "k_saxony", german_reunification: "e_germany"},
  d_baden:        { congress_of_vienna: "d_baden", german_unification: "e_germany" },
  d_swabia:       { congress_of_vienna: "d_swabia", german_unification: "e_germany" },
  c_ostfriesland: { congress_of_vienna: "d_brunswick", prussia_annexes_hannover: "k_pomerania", german_unification: "e_germany" },
  d_brunswick:    { congress_of_vienna: "d_brunswick", prussia_annexes_hannover: "k_pomerania", german_unification: "e_germany" },
  c_gottingen:    { congress_of_vienna: "d_brunswick", prussia_annexes_hannover: "k_pomerania", german_unification: "e_germany" },
  c_pfalz:        { congress_of_vienna: "d_bavaria", german_unification: "e_germany"},
  c_trier:        { congress_of_vienna: "k_pomerania", german_unification: "e_germany"},
  c_bamberg:      { congress_of_vienna: "d_bavaria", german_unification: "e_germany" },
  c_wurzburg:     { congress_of_vienna: "d_bavaria", german_unification: "e_germany" },
  c_wolgast:      { congress_of_vienna: "k_pomerania", german_unification: "e_germany", end_ww2: "k_saxony", german_reunification: "e_germany"},
  c_weimar: { congress_of_vienna: "c_weimar", german_unification: "e_germany", end_ww2: "k_saxony", german_reunification: "e_germany"},
  c_anhalt: { congress_of_vienna: "c_anhalt", german_unification: "e_germany", end_ww2: "k_saxony", german_reunification: "e_germany"},
  c_thuringen:    { congress_of_vienna: "c_thuringen", german_unification: "e_germany", end_ww2: "k_saxony", german_reunification: "e_germany"},
  c_nassau:       { congress_of_vienna: "c_nassau", prussia_annexes_hannover: "k_pomerania", german_unification: "e_germany" },
  c_mainz:        { congress_of_vienna: "d_franconia", prussia_annexes_hannover: "k_pomerania", german_unification: "e_germany" },
  c_leiningen:    { congress_of_vienna: "d_franconia", prussia_annexes_hannover: "k_pomerania", german_unification: "e_germany" },

  # Briefly got title of Ottoman governor, but that never seemed to matter
  # Date is start of Kuwait dynasty, but it was independent before too
  c_kuwait:     { "1752.12.31" => "c_kuwait", kuwait_british: "e_britannia", kuwait_independence: "c_kuwait" },

  #########################################
  # READY FOR VICTORIAN ERA BOOKMARK

  e_deccan:      { third_maratha_war: "e_britannia", india_independence: "e_india" },
  k_orissa:      { third_maratha_war: "e_britannia", india_independence: "e_india" },
  k_malwa:       { third_maratha_war: "e_britannia", india_independence: "e_india" },
  k_gujarat:     { third_maratha_war: "e_britannia", india_independence: "e_india" },
  k_delhi:       { third_maratha_war: "e_britannia", india_independence: "e_india" },
  k_rajputana:   { third_maratha_war: "e_britannia", india_independence: "e_india" },
  k_kosala:      { third_maratha_war: "e_britannia", india_independence: "e_india" },
  e_bengal:      { third_maratha_war: "e_britannia", india_independence: "e_india" },
  c_vijnot:      { third_maratha_war: "e_britannia", india_independence: "k_baluchistan" },

  # Names on CK2 map have very little correlation with names on real map
  # I think Nepal and Bhutan are out of map and these are the only parts of Bangladesh, but who knows really
  # c_suvarnagram might be part of India
  d_vanga:       { third_maratha_war: "e_britannia", india_independence: "k_baluchistan", bangladesh_independence: "k_bengal" },
  d_varendra:    { third_maratha_war: "e_britannia", india_independence: "k_baluchistan", bangladesh_independence: "k_bengal" },
}

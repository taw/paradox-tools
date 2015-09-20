###########################################################################
# FIXME: Everything that uses temporary_start: needs fixing
# FIXME: Silliness during Napoleonic wars / WW1 / WW2 is generally not modelled
# TODO: Serious modelling of 1938-1945 and Napoleonic Wars era
# TODO: Protectorate of Bohemia and Moravia
# FIXME: Hungary / Romania / Serbia border is crap
# FIXME: Romania / Moldova border is crap
# FIXME: Central Asian and Caucasus history are a bit bullshit
# FIXME: Pakistan area history is totally wrong, it was Afghan/Iranian/British mix, not just all UK

ModernTimesDatabase::LAND = {
  e_britannia:  { forever_ago: "e_britannia" },
  k_ireland:    { forever_ago: "e_britannia", ireland_independence: "k_ireland" },
  d_ulster:     { forever_ago: "e_britannia" },
  c_tyrconnell: { forever_ago: "e_britannia", ireland_independence: "k_ireland" },
  c_orkney:     { forever_ago: "e_britannia" },
  c_shetland:   { forever_ago: "e_britannia" },
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
  k_brittany:   { forever_ago: "e_france" },

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

  k_bohemia:    { forever_ago: "e_carpathia", czechoslovakia_independence: "k_bohemia" },
  c_litomerice: { forever_ago: "e_carpathia", czechoslovakia_independence: "k_bohemia", munich_agreement: "e_germany", end_ww2: "k_bohemia" },
  c_plzen:      { forever_ago: "e_carpathia", czechoslovakia_independence: "k_bohemia", munich_agreement: "e_germany", end_ww2: "k_bohemia" },

  d_nikaea:       { forever_ago: "e_seljuk_turks" },
  c_byzantion:    { forever_ago: "e_seljuk_turks" },
  d_armeniacon:   { forever_ago: "e_seljuk_turks" },
  d_thracesia:    { forever_ago: "e_seljuk_turks" },
  d_anatolia:     { forever_ago: "e_seljuk_turks" },
  d_charsianon:   { forever_ago: "e_seljuk_turks" },
  d_trebizond:    { forever_ago: "e_seljuk_turks" },
  d_paphlagonia:  { forever_ago: "e_seljuk_turks" },
  c_abydos:       { forever_ago: "e_seljuk_turks" },
  d_cibyrrhaeot:  { forever_ago: "e_seljuk_turks" },
  d_mesopotamia:  { forever_ago: "e_seljuk_turks" },
  d_coloneia:     { forever_ago: "e_seljuk_turks" },
  d_armenia_minor:{ forever_ago: "e_seljuk_turks" },
  c_ani:          { forever_ago: "e_seljuk_turks" },
  c_vaspurakan:   { forever_ago: "e_seljuk_turks" },
  c_tao:          { forever_ago: "e_seljuk_turks" },
  d_samos:        { forever_ago: "e_seljuk_turks" },
  d_edessa:       { forever_ago: "e_seljuk_turks"},
  c_amida:        { forever_ago: "e_seljuk_turks"},
  c_kurdistan:    { forever_ago: "e_seljuk_turks"}, # Maybe Iraq, but then Turkey wouldn't border Iran any more
  d_thrace:       { forever_ago: "e_seljuk_turks", treaty_of_sevres: "k_byzantium", treaty_of_lausanne: "e_seljuk_turks" },

  c_aland:      { forever_ago: "k_sweden", end_of_swedish_finland: "e_russia", finland_independence: "k_finland" },
  d_finland:    { forever_ago: "k_sweden", end_of_swedish_finland: "e_russia", finland_independence: "k_finland" },
  c_kemi:       { forever_ago: "k_sweden", end_of_swedish_finland: "e_russia", finland_independence: "k_finland" },

  k_mauretania:{ forever_ago: "k_mauretania", morocco_protectorate: "e_france", french_morocco_independence: "k_mauretania" },
  c_cebta:     { forever_ago: "k_mauretania", morocco_protectorate: "e_spain",  north_spanish_morocco_end: "k_mauretania" },
  c_tangiers:  { forever_ago: "k_mauretania", morocco_protectorate: "e_spain",  north_spanish_morocco_end: "k_mauretania" },
  c_el_rif:    { forever_ago: "k_mauretania", morocco_protectorate: "e_spain",  north_spanish_morocco_end: "k_mauretania" },

  k_perm:           { forever_ago: "e_russia" },
  k_volga_bulgaria: { forever_ago: "e_russia" },
  k_rus:            { forever_ago: "e_russia" },
  d_alania:         { forever_ago: "e_russia" },
  c_alania:         { forever_ago: "e_russia",  fall_soviet_union: "c_alania", fall_chechnya: "e_russia"},
  c_kuban:          { forever_ago: "e_russia" },
  c_sarpa:          { forever_ago: "e_russia" },

  c_severin:    { forever_ago: "e_seljuk_turks", treaty_of_berlin: "k_dacia" },
  c_tirgoviste: { forever_ago: "e_seljuk_turks", treaty_of_berlin: "k_dacia" },
  c_turnu:      { forever_ago: "e_seljuk_turks", treaty_of_berlin: "k_dacia" },
  c_constantia: { forever_ago: "e_seljuk_turks", treaty_of_berlin: "k_dacia" },

  c_strymon:  { forever_ago: "e_seljuk_turks", treaty_of_london: "k_serbia", macedonia_independence: "d_dyrrachion" },
  c_ochrid:   { forever_ago: "e_seljuk_turks", treaty_of_london: "k_serbia", macedonia_independence: "d_dyrrachion" },
  c_belgrade: { forever_ago: "e_seljuk_turks", treaty_of_berlin: "k_serbia" },
  d_rashka:   { forever_ago: "e_seljuk_turks", treaty_of_london: "k_serbia" },
  c_rama:     { forever_ago: "e_seljuk_turks", treaty_of_london: "k_serbia" },
  c_naissus:  { forever_ago: "e_seljuk_turks", treaty_of_london: "k_serbia" },

  d_turnovo:      { forever_ago: "e_seljuk_turks", treaty_of_berlin: "k_bulgaria" },
  c_karvuna:      { forever_ago: "e_seljuk_turks", treaty_of_berlin: "k_bulgaria" },
  c_vidin:        { forever_ago: "e_seljuk_turks", treaty_of_berlin: "k_bulgaria" },
  c_tyrnovo:      { forever_ago: "e_seljuk_turks", eastern_rumelia_unification: "k_bulgaria" },
  c_mesembria:    { forever_ago: "e_seljuk_turks", eastern_rumelia_unification: "k_bulgaria" },

  d_cyprus:     { forever_ago: "e_seljuk_turks", cyprus_convention: "e_britannia", cyprus_independence: "d_cyprus" },
  c_famagusta:  { forever_ago: "e_seljuk_turks", cyprus_convention: "e_britannia", cyprus_independence: "d_cyprus", north_cyprus_invasion: "e_seljuk_turks" },

  d_alexandria: { forever_ago: "e_seljuk_turks", british_egypt: "e_britannia", egypt_independence: "k_egypt" },
  d_cairo: { forever_ago: "e_seljuk_turks", british_egypt: "e_britannia", egypt_independence: "k_egypt" },
  d_aswan: { forever_ago: "e_seljuk_turks", british_egypt: "e_britannia", egypt_independence: "k_egypt" },
  d_damietta: { forever_ago: "e_seljuk_turks", british_egypt: "e_britannia", egypt_independence: "k_egypt" },

  c_sinai: { forever_ago: "e_seljuk_turks", british_egypt: "e_britannia", egypt_independence: "k_egypt", six_day_war: "k_israel", egypt_israel_peace: "k_egypt" },
  c_farama: { forever_ago: "e_seljuk_turks", british_egypt: "e_britannia", egypt_independence: "k_egypt", six_day_war: "k_israel", egypt_israel_peace: "k_egypt" },
  :"c_el-arish"=> { forever_ago: "e_seljuk_turks", british_egypt: "e_britannia", egypt_independence: "k_egypt", six_day_war: "k_israel", egypt_israel_peace: "k_egypt" },

  c_beirut: { forever_ago: "e_seljuk_turks", end_ww1: "e_france", lebanon_independence: "d_galilee" },
  c_tyrus:  { forever_ago: "e_seljuk_turks", end_ww1: "e_france", lebanon_independence: "d_galilee" },

  c_eilat:   { forever_ago: "e_seljuk_turks", end_ww1: "e_britannia", israel_independence: "k_israel" },
  c_negev:   { forever_ago: "e_seljuk_turks", end_ww1: "e_britannia", israel_independence: "k_israel" },
  d_ascalon: { forever_ago: "e_seljuk_turks", end_ww1: "e_britannia", israel_independence: "k_israel" },
  c_acre:    { forever_ago: "e_seljuk_turks", end_ww1: "e_britannia", israel_independence: "k_israel" },

  c_hebron:    { forever_ago: "e_seljuk_turks", end_ww1: "e_britannia", israel_independence: "d_oultrejourdain", six_day_war: "k_israel" },
  c_jerusalem: { forever_ago: "e_seljuk_turks", end_ww1: "e_britannia", israel_independence: "d_oultrejourdain", six_day_war: "k_israel" },

  c_oromieh: { forever_ago: "e_seljuk_turks", british_iraq: "e_britannia", iraq_independence: "k_mesopotamia"},
  d_baghdad: { forever_ago: "e_seljuk_turks", british_iraq: "e_britannia", iraq_independence: "k_mesopotamia"},
  d_tigris:  { forever_ago: "e_seljuk_turks", british_iraq: "e_britannia", iraq_independence: "k_mesopotamia"},
  d_basra:   { forever_ago: "e_seljuk_turks", british_iraq: "e_britannia", iraq_independence: "k_mesopotamia"},

  c_mosul:   { forever_ago: "e_seljuk_turks", british_iraq: "e_britannia", iraq_independence: "k_mesopotamia", caliphate_reborn: "d_sunni"},
  c_suwaida: { forever_ago: "e_seljuk_turks", british_iraq: "e_britannia", iraq_independence: "k_mesopotamia", caliphate_reborn: "d_sunni"},
  c_druz:    { forever_ago: "e_seljuk_turks", british_iraq: "e_britannia", iraq_independence: "k_mesopotamia", caliphate_reborn: "d_sunni"},
  c_sinjar:  { forever_ago: "e_seljuk_turks", british_iraq: "e_britannia", iraq_independence: "k_mesopotamia", caliphate_reborn: "d_sunni"},
  c_tiberias:    { forever_ago: "e_seljuk_turks", end_ww1: "e_france", syria_independence: "k_syria", six_day_war: "k_israel" },
  c_safed:       { forever_ago: "e_seljuk_turks", end_ww1: "e_france", syria_independence: "k_syria" },
  c_tell_bashir: { forever_ago: "e_seljuk_turks", end_ww1: "e_france", syria_independence: "k_syria", caliphate_reborn: "d_sunni"  },
  k_syria:       { forever_ago: "e_seljuk_turks", end_ww1: "e_france", syria_independence: "k_syria" },
  d_jazira:      { forever_ago: "e_seljuk_turks", end_ww1: "e_france", syria_independence: "k_syria" },
  d_tunis:        { forever_ago: "e_seljuk_turks", tunisia_french: "e_france", tunisia_independence: "d_tunis" },
  d_alger:        { forever_ago: "e_seljuk_turks", algeria_french: "e_france", algeria_indepnedence: "d_alger" },
  d_kabylia:      { forever_ago: "e_seljuk_turks", algeria_french: "e_france", algeria_indepnedence: "d_alger" },
  d_tlemcen:      { forever_ago: "e_seljuk_turks", algeria_french: "e_france", algeria_indepnedence: "d_alger" },
  d_tripolitania: { forever_ago: "e_seljuk_turks", libya_italian: "e_italy", libya_independence: "d_tripolitania"},
  d_cyrenaica:    { forever_ago: "e_seljuk_turks", libya_italian: "e_italy", libya_independence: "d_tripolitania"},

  k_persia:       { forever_ago: "e_persia" },
  d_sistan:       { forever_ago: "e_persia" },
  d_kermanshah:   { forever_ago: "e_persia" },
  c_herat:        { forever_ago: "e_persia" },
  c_zaranj:       { forever_ago: "e_persia" },
  c_farrah:       { forever_ago: "e_persia" },
  c_dailam:       { forever_ago: "e_persia", iranian_revolution: "d_hashshashin" },

  # After 1758 Xinjiang in China. Before Dzungar Khanate
  k_khotan:     { forever_ago: "k_khotan" },
  c_dunkheger:  { forever_ago: "k_khotan" },
  c_altay:      { forever_ago: "k_khotan" },

  # This is awkward, as it was Chinese all along, but Dzungar goes away
  k_mongolia:   { forever_ago: "k_mongolia", fall_dzungar: "k_khotan", mongolia_independence: "k_mongolia" },

  d_syria:       { forever_ago: "e_seljuk_turks", end_ww1: "e_france", syria_independence: "k_syria", caliphate_reborn: "d_sunni" },
  c_palmyra:     { forever_ago: "e_seljuk_turks", end_ww1: "e_france", syria_independence: "k_syria", caliphate_reborn: "d_sunni" },
  c_asas:        { forever_ago: "e_seljuk_turks", end_ww1: "e_france", syria_independence: "k_syria", caliphate_reborn: "d_sunni" },

  d_oultrejourdain: { forever_ago: "e_seljuk_turks", end_ww1: "e_britannia", jordan_independence: "d_oultrejourdain" },

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
  c_memel:        { forever_ago: "k_pomerania", german_unification: "e_germany", end_ww1: "d_lithuanians", memel_german: "e_germany", end_ww2: "e_russia", fall_soviet_union: "d_lithuanians" },
  c_danzig:       { forever_ago: "e_wendish_empire", poland_1_partition: "k_pomerania", free_danzig_napoleonic: "d_pomeralia", free_danzig_napoleonic_end: "k_pomerania", german_unification: "e_germany", end_ww1: "d_pomeralia", end_ww2: "k_poland"},
  d_kiev:        {  forever_ago: "e_wendish_empire", poland_2_partition: "e_russia", fall_soviet_union: "k_ruthenia"},

  d_ryazan:     { forever_ago: "e_russia" },
  d_sarkel:     { forever_ago: "e_russia" },

  d_courland:    { forever_ago: "e_wendish_empire", poland_3_partition: "e_russia", end_ww1: "d_courland", annexation_latvia: "e_russia", fall_soviet_union: "d_courland" },

  d_esthonia:    { forever_ago: "k_sweden", treaty_of_nystad: "e_russia", end_ww1: "d_esthonia", annexation_estonia: "e_russia", fall_soviet_union: "d_esthonia" },
  d_livonia:     { forever_ago: "k_sweden", treaty_of_nystad: "e_russia", end_ww1: "d_esthonia", annexation_estonia: "e_russia", fall_soviet_union: "d_esthonia" },
  c_kexholm:    { forever_ago: "k_sweden", treaty_of_nystad: "e_russia", finland_independence: "k_finland" },
  c_savolaks:   { forever_ago: "k_sweden", end_of_swedish_finland: "e_russia", finland_independence: "k_finland" },

  c_lettigalians:{ forever_ago: "k_sweden", treaty_of_nystad: "e_russia", end_ww1: "d_courland", annexation_latvia: "e_russia", fall_soviet_union: "d_courland" },
  c_west_dvina:  { forever_ago: "k_sweden", treaty_of_nystad: "e_russia", end_ww1: "d_courland", annexation_latvia: "e_russia", fall_soviet_union: "d_courland" },

  d_kola:       { forever_ago: "e_russia" },
  d_karelia:    { forever_ago: "e_russia" },
  c_malta:      { forever_ago: "c_malta", malta_british: "e_britannia", malta_independence: "c_malta" },
  c_corsica:    { forever_ago: "d_genoa", french_corsica: "e_france" },

  c_steiermark:   { forever_ago: "e_carpathia", end_ww1: "k_serbia", slovenia_independence: "d_carinthia" },
  c_aquileia:     { forever_ago: "e_carpathia", end_ww1: "k_serbia", slovenia_independence: "d_carinthia" },

  c_adrianopolis:{ forever_ago: "e_seljuk_turks", treaty_of_sevres: "k_byzantium", treaty_of_lausanne: "e_seljuk_turks" },
  c_smyrna:      { forever_ago: "e_seljuk_turks", treaty_of_sevres: "k_byzantium", treaty_of_lausanne: "e_seljuk_turks" },

  # Given to Greece September 15, 1947
  c_rhodos:      { forever_ago: "e_seljuk_turks", libya_italian: "e_italy", end_ww2: "k_byzantium"},
  d_krete:       { forever_ago: "e_seljuk_turks", crete_independence: "d_krete", treaty_of_london: "k_byzantium" }, # De facto Greek in 1908
  c_cephalonia:   { forever_ago: "e_seljuk_turks", treaty_of_london: "k_byzantium" },
  c_epeiros:      { forever_ago: "e_seljuk_turks", treaty_of_london: "k_byzantium" },
  d_thessalonika: { forever_ago: "e_seljuk_turks", treaty_of_london: "k_byzantium" },
  c_philippopolis:{ forever_ago: "e_seljuk_turks", treaty_of_london: "k_byzantium" },
  c_thessalia:    { forever_ago: "e_seljuk_turks", convention_of_constantinople: "k_byzantium" },
  c_arta:         { forever_ago: "e_seljuk_turks", convention_of_constantinople: "k_byzantium" },
  c_lesbos:       { forever_ago: "e_seljuk_turks", treaty_of_london: "k_byzantium" },
  c_chios:        { forever_ago: "e_seljuk_turks", treaty_of_london: "k_byzantium" },

  d_nyitra:       { forever_ago: "e_carpathia", czechoslovakia_independence: "k_bohemia", czechoslovakia_dissolution: "d_nyitra" },
  d_esztergom:    { forever_ago: "e_carpathia", end_ww1: "k_hungary" },
  d_pecs:         { forever_ago: "e_carpathia", end_ww1: "k_hungary" },
  d_transylvania: { forever_ago: "e_carpathia", end_ww1: "k_dacia" },
  d_pest:         { forever_ago: "e_carpathia", end_ww1: "k_hungary" },
  c_abauj:        { forever_ago: "e_carpathia", end_ww1: "k_hungary" },
  c_marmaros:     { forever_ago: "e_carpathia", end_ww1: "k_dacia" },
  d_temes:        { forever_ago: "e_seljuk_turks", treaty_of_passarowitz: "e_carpathia", end_ww1: "k_hungary" },
  c_temes:        { forever_ago: "e_seljuk_turks", treaty_of_passarowitz: "e_carpathia", end_ww1: "k_dacia" },
  c_pressburg:    { forever_ago: "e_carpathia", czechoslovakia_independence: "k_bohemia", czechoslovakia_dissolution: "d_nyitra" },

  c_gnieznienskie: { forever_ago: "e_wendish_empire", poland_1_partition: "k_pomerania", german_unification: "e_germany", end_ww1: "k_poland" },
  c_kujawy:       { forever_ago: "e_wendish_empire", poland_1_partition: "k_pomerania", duchy_warsaw: "k_poland", congress_of_vienna: "e_russia", end_ww1: "k_poland" },

  d_pereyaslavl: { forever_ago: "e_russia", fall_soviet_union: "k_ruthenia"},
  c_sharukan: { forever_ago: "e_russia", fall_soviet_union: "k_ruthenia"},
  :"c_desht-i-kipchak" => { forever_ago: "e_russia", fall_soviet_union: "k_ruthenia"},

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
  c_venaissin:   { forever_ago: "k_papal_state", avignon_annexation: "e_france" },

  k_lanka:       { forever_ago: "k_frisia", sri_lanka_british: "e_britannia", sri_lanka_independence: "k_lanka" },
  c_maldives:    { forever_ago: "k_frisia", sri_lanka_british: "e_britannia", maldives_independence: "c_maldives" },

  c_breda:      { forever_ago: "k_frisia" },
  d_holland:    { forever_ago: "k_frisia" },
  d_gelre:      { forever_ago: "k_frisia" },

  d_ferrara:    { forever_ago: "k_papal_state", treaty_of_zurich: "k_italy", italy_unification: "e_italy" },
  d_ancona:     { forever_ago: "k_papal_state", treaty_of_zurich: "k_italy", italy_unification: "e_italy" },
  c_spoleto:    { forever_ago: "k_papal_state", treaty_of_zurich: "k_italy", italy_unification: "e_italy" },
  c_mantua:     { forever_ago: "c_mantua", mantua_austrian: "e_carpathia", treaty_of_zurich: "k_italy", italy_unification: "e_italy"},

  c_lucca:      { forever_ago: "c_lucca", end_of_lucca: "d_toscana", treaty_of_zurich: "k_italy", italy_unification: "e_italy" },
  d_toscana:    { forever_ago: "d_toscana", treaty_of_zurich: "k_italy", italy_unification: "e_italy" },
  d_pisa:       { forever_ago: "d_toscana", treaty_of_zurich: "k_italy", italy_unification: "e_italy" },

  c_parma:      { forever_ago: "c_parma", treaty_of_zurich: "k_italy", italy_unification: "e_italy" },
  c_modena:     { forever_ago: "c_modena", treaty_of_zurich: "k_italy", italy_unification: "e_italy" },

  c_roma:       { forever_ago: "k_papal_state" },
  d_latium:     { forever_ago: "k_papal_state", capture_of_rome: "e_italy" },

  d_lithuanians: { forever_ago: "e_wendish_empire", poland_3_partition: "e_russia", end_ww1: "d_lithuanians", annexation_lithuania: "e_russia", fall_soviet_union: "d_lithuanians" },
  c_aukshayts:   { forever_ago: "e_wendish_empire", poland_3_partition: "e_russia", end_ww1: "k_poland", end_ww2: "e_russia", fall_soviet_union: "d_lithuanians" },
  c_zhmud:      { forever_ago: "e_wendish_empire", poland_3_partition: "e_russia", end_ww1: "d_lithuanians", annexation_lithuania: "e_russia", fall_soviet_union: "d_lithuanians" },
  c_jacwiez:  { forever_ago: "e_wendish_empire", poland_3_partition: "e_russia", end_ww1: "k_poland", end_ww2: "e_russia", fall_soviet_union: "d_vitebsk"},
  c_podlasie: { forever_ago: "e_wendish_empire", poland_3_partition: "e_russia", end_ww1: "k_poland", end_ww2: "e_russia",  fall_soviet_union: "d_vitebsk"},
  c_bryansk:    { forever_ago: "e_russia" },
  c_chernigov:   { forever_ago: "e_russia", fall_soviet_union: "k_ruthenia"},
  c_lyubech:     { forever_ago: "e_wendish_empire", poland_1_partition: "e_russia", fall_soviet_union: "k_ruthenia"},
  c_vodi:       { forever_ago: "k_sweden", st_petersburg_founding: "e_russia" },

  d_itil:      { forever_ago: "e_russia", fall_soviet_union: "k_cuman" }, # GeaCron says it was Russian in 1700, other sources not so sure
  c_novgorod_seversky: { forever_ago: "e_russia", fall_soviet_union: "k_ruthenia"},

  d_smolensk:   { forever_ago: "e_russia" },

  c_mstislavl:{ forever_ago: "e_wendish_empire", poland_1_partition: "e_russia", fall_soviet_union: "d_vitebsk"},
  c_vitebsk:    { forever_ago: "e_wendish_empire", poland_1_partition: "e_russia", fall_soviet_union: "d_vitebsk"},
  d_vitebsk:    { forever_ago: "e_wendish_empire", poland_2_partition: "e_russia", fall_soviet_union: "d_vitebsk"},
  c_polotsk:   { forever_ago: "e_wendish_empire", poland_1_partition: "e_russia", fall_soviet_union: "d_vitebsk"},
  c_lepiel:    { forever_ago: "e_wendish_empire", poland_2_partition: "e_russia", fall_soviet_union: "d_vitebsk"},
  c_pinsk:    { forever_ago: "e_wendish_empire", poland_3_partition: "e_russia", end_ww1: "k_poland", end_ww2: "e_russia", fall_soviet_union: "d_vitebsk"},

  k_abyssinia: { forever_ago: "k_abyssinia" },
  c_kassala:   { forever_ago: "k_abyssinia" },

  c_salzburg:     { forever_ago: "c_salzburg", peace_of_pressburg: "e_carpathia", treaty_of_shoenbrunn: "d_bavaria", congress_of_vienna: "e_carpathia", end_ww1: "k_bavaria", anschluss: "e_germany", end_ww2: "k_bavaria" },

  d_azov:    { forever_ago: "e_seljuk_turks", treaty_of_kucuk_kaynarca: "e_russia"},
  d_cherson: { forever_ago: "e_seljuk_turks", treaty_of_kucuk_kaynarca: "e_russia", fall_soviet_union: "k_ruthenia", crimea_invasion: "e_russia" },
  c_crimea:  { forever_ago: "e_seljuk_turks", treaty_of_kucuk_kaynarca: "e_russia", fall_soviet_union: "k_ruthenia", crimea_invasion: "e_russia" },
  d_crimea:   { forever_ago: "e_seljuk_turks", treaty_of_kucuk_kaynarca: "e_russia", fall_soviet_union: "k_ruthenia"},
  c_tmutarakan: { forever_ago: "e_seljuk_turks", treaty_of_kucuk_kaynarca: "e_russia" },

  # Maybe I sohuld just not have Moldova in the game.
  c_torki:        { forever_ago: "e_seljuk_turks", treaty_of_bucharest_1812: "e_russia", end_ww1: "k_dacia", soviet_partition_of_romania: "e_russia", fall_soviet_union: "d_moldau"},
  c_birlad:       { forever_ago: "e_seljuk_turks", treaty_of_bucharest_1812: "e_russia", end_ww1: "k_dacia", soviet_partition_of_romania: "e_russia", fall_soviet_union: "d_moldau"},
  c_galaz:        { forever_ago: "e_seljuk_turks", treaty_of_bucharest_1812: "e_russia", end_ww1: "k_dacia", soviet_partition_of_romania: "e_russia", fall_soviet_union: "k_ruthenia"},
  d_moldau:       { forever_ago: "e_seljuk_turks", treaty_of_jassy: "e_russia", fall_soviet_union: "k_ruthenia"},

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
  c_terebovl:          { forever_ago: "e_wendish_empire", poland_2_partition: "e_russia", fall_soviet_union: "k_ruthenia"},

  d_upper_lorraine: { forever_ago: "e_france" },
  c_verdun:         { forever_ago: "e_france" },

  c_zeta:       { forever_ago: "e_seljuk_turks", treaty_of_london: "d_dioclea", albania_italian: "e_italy", end_ww2: "d_dioclea" },
  c_dyrrachion: { forever_ago: "e_seljuk_turks", treaty_of_london: "d_dioclea", albania_italian: "e_italy", end_ww2: "d_dioclea" },

  c_ragusa:   { forever_ago: "e_seljuk_turks", treaty_of_berlin: "c_ragusa", montenegro_serbian: "k_serbia", montenegro_independence: "c_ragusa" },
  # "It was the capital of the Kingdom of Hungary's Bereg County up until 1919 and between 1938-1944. From 1919 until 1938 it was part of Czechoslovakia."
  c_bereg:  { forever_ago: "e_carpathia", end_ww1: "k_bohemia", end_ww2: "e_russia", fall_soviet_union: "k_ruthenia" },

  # Not really unified
  k_nubia:      { forever_ago: "k_nubia", sudan_turkish: "e_seljuk_turks", british_egypt: "e_britannia", sudan_independence: "k_nubia" },

  c_peremyshl:         { forever_ago: "e_wendish_empire", poland_1_partition: "e_carpathia", end_ww1: "k_poland" },
  c_galich:            { forever_ago: "e_wendish_empire", poland_1_partition: "e_carpathia", end_ww1: "k_poland", end_ww2: "e_russia", fall_soviet_union: "k_ruthenia" },
  c_turov:             { forever_ago: "e_wendish_empire", poland_2_partition: "e_russia", fall_soviet_union: "k_ruthenia"},
  d_volhynia:          { forever_ago: "e_wendish_empire", poland_3_partition: "e_russia", end_ww1: "k_poland", end_ww2: "e_russia", fall_soviet_union: "k_ruthenia" },
  c_saris:        { forever_ago: "e_carpathia", czechoslovakia_independence: "k_bohemia", czechoslovakia_dissolution: "d_nyitra" },

  c_holstein:     { forever_ago: "k_denmark", treaty_of_vienna_1864: "k_pomerania", german_unification: "e_germany" },

  c_trinkitat:{ forever_ago: "k_abyssinia", eritrea_italian: "e_italy", eritrea_british: "e_britannia", eritrea_ethiopian: "k_abyssinia", eritrea_independence: "d_hayya"},
  c_hayya:    { forever_ago: "k_abyssinia", eritrea_italian: "e_italy", eritrea_british: "e_britannia", eritrea_ethiopian: "k_abyssinia", eritrea_independence: "d_hayya"},
  c_assab:    { forever_ago: "k_abyssinia", eritrea_italian: "e_italy", eritrea_british: "e_britannia", eritrea_ethiopian: "k_abyssinia", eritrea_independence: "d_hayya"},
  c_massawa:  { forever_ago: "k_abyssinia", eritrea_italian: "e_italy", eritrea_british: "e_britannia", eritrea_ethiopian: "k_abyssinia", eritrea_independence: "d_hayya"},

  c_petra:   { forever_ago: "e_seljuk_turks", end_ww1: "e_britannia", jordan_independence: "d_oultrejourdain" },
  c_maan:    { forever_ago: "e_seljuk_turks", end_ww1: "e_britannia", jordan_independence: "d_oultrejourdain" },
  c_amman:   { forever_ago: "e_seljuk_turks", end_ww1: "e_britannia", jordan_independence: "d_oultrejourdain" },
  c_az_zarqa:{ forever_ago: "e_seljuk_turks", end_ww1: "e_britannia", jordan_independence: "d_oultrejourdain" },

  c_bashkirs:  { forever_ago: "e_russia" },
  c_sibir:     { forever_ago: "e_russia" },

  d_kabul:       { forever_ago: "k_afghanistan" },
  c_udabhanda:   { forever_ago: "k_afghanistan" },
  c_purushapura: { forever_ago: "k_afghanistan" },
  c_maymana:     { forever_ago: "k_afghanistan" },
  c_balkh:       { forever_ago: "k_afghanistan" },
  c_bost:        { forever_ago: "k_afghanistan" },
  c_mandesh:     { forever_ago: "k_afghanistan" },

  c_menorca: { forever_ago: "e_spain", treaty_of_utrech: "e_britannia", treaty_of_versailles: "e_spain" },

  d_bavaria:      { forever_ago: "d_bavaria", german_unification: "e_germany" },

  c_ar_ar:  { forever_ago: "d_nefoud", end_ww1: "k_arabia" },
  d_nefoud: { forever_ago: "d_nefoud", end_ww1: "k_arabia" },
  # 1810s Saudi occupation was just rebels
  d_medina: { forever_ago: "e_seljuk_turks", end_ww1: "d_medina", hejaz_saudi: "k_arabia" },
  d_arabia_petrae: { forever_ago: "e_seljuk_turks", end_ww1: "d_medina", hejaz_saudi: "k_arabia" },
  # Taken by Saudis 1913, but let's not make this official prematurely
  d_amman:   { forever_ago: "e_seljuk_turks", end_ww1: "k_arabia" },

  # Muscat and Oman
  d_oman:     { forever_ago: "d_oman", oman_persian: "e_persia", oman_not_persian: "d_oman", oman_british: "e_britannia", oman_independence: "d_oman" },

  c_taizz:   { forever_ago: "e_seljuk_turks", north_yemen_independence: "d_arabia_felix", yemen_unification: "d_sanaa" },
  c_sanaa:   { forever_ago: "e_seljuk_turks", north_yemen_independence: "d_arabia_felix", yemen_unification: "d_sanaa" },

  # GeaCron has no countries there so just shatter it into duchies before Europeans show up
  d_songhay:    { forever_ago: "d_songhay", french_mali: "e_france", mali_independence: "k_mali" },
  d_mali:       { forever_ago: "d_mali", french_mali: "e_france", mali_independence: "k_mali" },
  d_timbuktu:   { forever_ago: "d_timbuktu", mauritania_french: "e_france", mauritania_independence: "d_timbuktu" },
  c_ghana:      { forever_ago: "d_timbuktu", mauritania_french: "e_france", mauritania_independence: "d_timbuktu" },
  c_aoudaghost: { forever_ago: "d_timbuktu", mauritania_french: "e_france", mauritania_independence: "d_timbuktu" },
  c_tadjoura:   { forever_ago: "d_harer", djibouti_french: "e_france", djibouti_independence: "d_afar" },
  d_harer:      { forever_ago: "d_harer", british_somaliland: "e_britannia", somalia_independence: "d_harer" },
  c_busaso:     { forever_ago: "d_harer", italian_somaliland: "e_italy", somalia_independence: "d_harer"  },


  c_idjil:      { forever_ago: "d_ghana", spanish_sahara: "e_spain", madrid_accords: "k_mauretania" },
  c_ouadane:    { forever_ago: "d_ghana", spanish_sahara: "e_spain", madrid_accords: "k_mauretania" },
  c_tharasset:  { forever_ago: "d_ghana", spanish_sahara: "e_spain", madrid_accords: "k_mauretania" },

  c_plauen:     { forever_ago: "d_saxony", german_unification: "e_germany", end_ww2: "k_saxony", german_reunification: "e_germany"},
  d_meissen:    { forever_ago: "d_saxony", german_unification: "e_germany", end_ww2: "k_saxony", german_reunification: "e_germany"},

  #########################################
  # READY FOR CONGRESS OF VIENNA BOOKMARK

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
  c_rugen:        { congress_of_vienna: "k_pomerania", german_unification: "e_germany" },
  d_mecklemburg:  { congress_of_vienna: "d_mecklemburg", german_unification: "e_germany", end_ww2: "k_saxony", german_reunification: "e_germany"},
  d_baden:        { congress_of_vienna: "d_baden", german_unification: "e_germany" },
  d_swabia:       { congress_of_vienna: "d_swabia", german_unification: "e_germany" },
  c_ostfriesland: { congress_of_vienna: "d_brunswick", prussia_annexes_hannover: "k_pomerania", german_unification: "e_germany" },
  d_brunswick:    { congress_of_vienna: "d_brunswick", prussia_annexes_hannover: "k_pomerania", german_unification: "e_germany" },
  c_pfalz:        { congress_of_vienna: "d_bavaria", german_unification: "e_germany", end_ww1: "e_france"},
  c_trier:        { congress_of_vienna: "k_pomerania", german_unification: "e_germany", end_ww1: "e_france"},
  c_bamberg:      { congress_of_vienna: "d_bavaria", german_unification: "e_germany" },
  c_wurzburg:     { congress_of_vienna: "d_bavaria", german_unification: "e_germany" },
  c_wolgast:      { congress_of_vienna: "k_pomerania", german_unification: "e_germany", end_ww2: "k_saxony", german_reunification: "e_germany"},
  c_weimar: { congress_of_vienna: "c_weimar", german_unification: "e_germany", end_ww2: "k_saxony", german_reunification: "e_germany"},
  c_anhalt: { congress_of_vienna: "c_anhalt", german_unification: "e_germany", end_ww2: "k_saxony", german_reunification: "e_germany"},

  # Briefly got title of Ottoman governor, but that never seemed to matter
  # Date is start of Kuwait dynasty, but it was independent before too
  c_kuwait:     { "1752.12.31" => "c_kuwait", kuwait_british: "e_britannia", kuwait_independence: "c_kuwait" },

  #########################################
  # READY FOR ITALIAN UNIFICATION BOOKMARK

  e_deccan:      { third_maratha_war: "e_britannia", india_independence: "e_india" },
  k_orissa:      { third_maratha_war: "e_britannia", india_independence: "e_india" },
  k_malwa:       { third_maratha_war: "e_britannia", india_independence: "e_india" },
  k_gujarat:     { third_maratha_war: "e_britannia", india_independence: "e_india" },
  k_delhi:       { third_maratha_war: "e_britannia", india_independence: "e_india" },
  k_rajputana:   { third_maratha_war: "e_britannia", india_independence: "e_india" },
  k_kosala:      { third_maratha_war: "e_britannia", india_independence: "e_india" },
  c_trigarta:    { third_maratha_war: "e_britannia", india_independence: "e_india" },
  c_sakala:      { third_maratha_war: "e_britannia", india_independence: "e_india" },
  e_bengal:      { third_maratha_war: "e_britannia", india_independence: "e_india" },

  # Names on CK2 map have very little correlation with names on real map
  # I think Nepal and Bhutan are out of map and these are the only parts of Bangladesh, but who knows really
  # c_suvarnagram might be part of India
  d_vanga:       { third_maratha_war: "e_britannia", india_independence: "k_baluchistan", bangladesh_independence: "k_bengal" },
  d_varendra:    { third_maratha_war: "e_britannia", india_independence: "k_baluchistan", bangladesh_independence: "k_bengal" },

  k_punjab:      { second_sikh_war: "e_britannia", india_independence: "k_baluchistan" },

  #########################################
  # READY FOR GERMAN UNIFICATION BOOKMARK

  # Details needed, loads of wars with Persia and locals
  c_suenik:       { "1864.6.2"=> "e_russia", end_ww1: "d_armenia", annexation_armenia: "e_russia", fall_soviet_union: "d_armenia" },
  d_armenia:      { "1864.6.2"=> "e_russia", end_ww1: "d_armenia", annexation_armenia: "e_russia", fall_soviet_union: "d_armenia" },
  d_azerbaijan:   { "1864.6.2"=> "e_russia", end_ww1: "d_azerbaijan", annexation_azerbaijan: "e_russia", fall_soviet_union: "d_azerbaijan" },
  k_georgia:      { "1864.6.2"=> "e_russia", end_ww1: "k_georgia", annexation_georgia: "e_russia", fall_soviet_union: "k_georgia" },
  c_abkhazia:     { "1864.6.2"=> "e_russia", end_ww1: "k_georgia", annexation_georgia: "e_russia", fall_soviet_union: "k_georgia", abkhazia_war: "e_russia" },
  c_semender:     { "1864.6.2" => "e_russia" },
  c_derbent:      { "1864.6.2" => "e_russia" },

  d_dihistan:  { "1867.7.11" => "e_russia", fall_soviet_union: "d_dihistan" },
  c_merv:      { "1867.7.11" => "e_russia", fall_soviet_union: "d_dihistan" },
  d_samarkand: { "1867.7.11" => "e_russia", fall_soviet_union: "k_khiva" },
  d_khiva:     { "1867.7.11" => "e_russia", fall_soviet_union: "k_khiva" },
  c_aral:      { "1867.7.11" => "e_russia", fall_soviet_union: "k_khiva" },
  d_turkestan: { "1867.7.11" => "e_russia", fall_soviet_union: "k_cuman" },
  d_kipchak:   { "1867.7.11" => "e_russia", fall_soviet_union: "k_cuman" },
  d_kimak:     { "1867.7.11" => "e_russia", fall_soviet_union: "k_cuman" },
  d_zhetysu:   { "1867.7.11" => "e_russia", fall_soviet_union: "k_cuman" },
  d_kirghiz:   { "1867.7.11" => "e_russia", fall_soviet_union: "k_cuman" },
  d_yaik:      { "1867.7.11" => "e_russia", fall_soviet_union: "k_cuman" },
  d_sibir:     { "1867.7.11" => "e_russia", fall_soviet_union: "k_cuman" },
  d_syr_darya: { "1867.7.11" => "e_russia", fall_soviet_union: "k_cuman" },

  d_thuringia:    { german_unification: "e_germany" },
  c_mainz:        { german_unification: "e_germany" },
  c_leiningen:    { german_unification: "e_germany" },
  c_thuringen:    { german_unification: "e_germany", end_ww2: "k_saxony", german_reunification: "e_germany"},

  d_sanaa:    { aden_protectorate: "e_britannia", south_yemen_independence: "d_sanaa" },
  c_aden:     { aden_city_british: "e_britannia", south_yemen_independence: "d_sanaa" },
  c_dhu_zabi: { general_maritime_treaty: "e_britannia", oman_independence: "c_dhu_zabi" },

  #########################################
  # READY FOR 1900 BOOKMARK

  c_bahrein:    { bahrain_british: "e_britannia", bahrain_independence: "c_bahrein" },

  d_baluchistan: { temporary_start: "e_britannia", india_independence: "k_baluchistan" },
  d_sauvira:     { temporary_start: "e_britannia", india_independence: "k_baluchistan" },
  d_bhakkar:     { temporary_start: "e_britannia", india_independence: "k_baluchistan" },
  c_vijnot:      { temporary_start: "e_britannia", india_independence: "k_baluchistan" },
}

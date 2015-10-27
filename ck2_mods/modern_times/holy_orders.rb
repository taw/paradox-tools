##########################################
# HOLY ORDER BARONY HOLDINGS
# (totally imaginary and bookmark independent)
#
# Names here are counties, but what they mean is first minor barony
# Not sure if this order is better or reversing it to match Land DB
# ()
#
# It doesn't actually increase number of troops they can raise, but it won't hurt
ModernTimesDatabase::HOLY_ORDERS = {
  "d_knights_calatrava" => ["c_calatrava", "c_almeria", "c_albarracin", "c_urgell"],
  "d_knights_santiago"  => ["c_santiago", "c_evora"],
  "d_teutonic_order"    => ["c_marienburg", "c_litomerice", "c_ulm", "c_pecs", "c_gemer", "c_memel", "c_st_gallen"],
  "d_knights_hospitaler" => ["c_malta", "c_rosello", "c_perigord"],
  "d_knights_templar" => ["c_blois", "c_gent", "c_ormond", "c_istria"],
  "d_bektashi" => ["c_mecca", "c_aswan", "c_annaba", "c_massat", "c_gao", "c_zachlumia", "c_chaldea", "c_farrah", "c_madhupur", "c_bukhara", "c_bhakkar"],
  "d_haruriyyah" => ["c_hajar"],
  "d_ashokas_chosen" => ["c_alampur", "c_chanderi"],
  "d_bulls_rishabha" => ["c_somnath", "c_gwalior"],
  "d_followers_arjuna" => ["c_gauda", "c_kucha"],
  { israel_independence: "d_zealots" } => ["c_ascalon", "c_tiberias"],
  { iranian_revolution: "d_hashshashin" } => ["c_gilan", "c_shiraz", "c_bam", "c_kufa", "c_taizz", "c_baalbek"],
}

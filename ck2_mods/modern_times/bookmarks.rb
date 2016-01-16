ModernTimesDatabase::BOOKMARKS = {
  ### History files testing:
  "1600.1.1" => {
    name: "Test 1600",
  },
  "1648.10.24" => {
    name: "Peace of Westphalia",
  },
  "1700.1.1" => {
    name: "Test 1700",
  },
  "1750.1.1" => {
    name: "Test 1750",
  },
  "1780.1.1" => {
    name: "Test 1780",
  },
  ### Actual bookmarks, must have 5 key bookmarks
  "1815.6.9" => {
    name: "Congress of Vienna",
    desc: "Order in Europe is being restored after chaos of Napoleonic Wars. Meanwhile Britain, Mughals, and Marathas fight for control over India, but many local Indian rulers would much rather be independent.",
    characters: ["e_deccan", "e_rajastan", "e_britannia"],
  },
  "1818.6.3" => {
    name: "Fall of Marathas",
    desc: "With India conquered, Britain is the world's greatest empire, at least for now. Will anyone challenge their supremacy?",
    characters: ["c_krakowskie", "k_pomerania", "k_italy", "e_arabia"],
  },
  "1837.6.20" => {
    name: "Victorian Era",
    desc: "Victoria, Empress of United Kingdom and India, leads the greatest empire the world has ever seen, but will her empire survive where all states as vast and diverse failed in the past?",
    key: true,
    characters: ["e_britannia", "k_punjab", "k_frisia", "k_byzantium"],
  },
  "1861.3.17" => {
    name:  "Kingdom of Italy",
    desc: "With Italy united, Prussia clearly has similar ambitions to unify Germany. Will its neighbours allow new great power to emerge, or will they try to stop it?",
    characters: ["e_france", "k_pomerania", "e_italy", "e_carpathia"],
  },
  "1878.7.13" => {
    name: "Treaty of Berlin",
    desc: "Emergent Balkan powers are challenging much weakened but still dangerous Ottoman caliphate.",
    key: true,
    characters: ["k_serbia", "k_bulgaria", "k_byzantium", "k_dacia"],
  },
  "1914.6.28" => {
    name: "The Great War",
    desc: "After century of relative calm, the greatest war yet to come is on the horizon.",
    characters: ["e_germany", "e_france", "e_britannia", "e_russia", "e_italy", "e_carpathia"],
  },
  "1922.11.1" => {
    name: "Fall of Ottomans",
    desc: "Collapse of Ottoman Empire, Austria-Hungary, and Tsarist Russia created power vacuum in Central Europe. Who's going to become the new dominant power?",
    key: true,
    characters: ["k_anatolia", "k_serbia", "k_bavaria", "k_poland", "e_russia"],
  },
  "1939.8.31" => {
    name: "The Greater War",
    desc: "Hitler and Stalin are just like leaders of indaving hordes of old times. Can you survive their wrath?",
    characters: ["e_germany", "e_russia", "k_poland"],
  },
  "1948.5.14" => {
    name: "Cold War",
    desc: "With fall of Hitler and beginning of decolonization new world order emerged.",
    key: true,
    characters: ["e_russia", "e_germany", "k_pomerania", "e_india", "k_israel"],
  },
  # Delay it a bit to get Saddam in charge of Iraq
  "1979.7.16" => {
    name: "Iranian Revolution",
    desc: "Shiite Islamic Revolution in Iran and Saddam Hussein's ambition to become leader of Arab world are on a colision course.",
    characters: ["k_mesopotamia", "k_persia"],
  },
  "1991.12.26" => {
    name: "Fall of Soviet Union",
    desc: "Collapse of the Soviet Union freed nations of Soviet periphery, but also woke up dormant national conflicts. Will Russia continue its descent into chaos, or is it just a temporary setback?",
    characters: ["k_poland", "c_alania", "k_cuman"],
  },
  "2016.1.16" => {
    name: "Modern Times",
    desc: "After a brief period of calm following breakup of Soviet Union, new trouble is stirring. Putin challenges borders in former Soviet sphere, radical Islamists rally around a new caliph.",
    key: true,
    characters: ["e_russia", "k_ruthenia", "d_sunni", "k_scotland"],
  },
}

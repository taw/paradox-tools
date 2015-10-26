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
  "1815.6.9" => {
    name: "Congress of Vienna",
  },
  ### Actual bookmarks, must have 5 key bookmarks
  "1818.6.3" => {
    name: "Fall of Marathas",
    characters: ["e_britannia", "k_pomerania", "k_italy", "e_france", "e_carpathia", "e_arabia"],
  },
  "1837.6.20" => {
    name: "Victorian Era",
    key: true,
    characters: ["e_britannia", "k_pomerania", "k_italy", "e_france", "e_carpathia", "e_arabia"],
  },
  "1861.3.17" => {
    name:  "Kingdom of Italy",
    characters: ["e_britannia", "k_pomerania", "e_italy", "e_france", "e_carpathia", "e_arabia"],
  },
  "1871.1.18" => {
    name:  "German Empire",
    key: true,
    characters: ["e_britannia", "e_germany", "e_italy"],
  },
  "1900.1.1" => {
    name: "New Century",
  },
  "1914.6.28" => {
    name: "The Great War",
    characters: ["e_germany", "e_france", "e_britannia", "e_russia", "e_italy", "e_carpathia"],
  },
  "1920.8.10" => {
    name: "Treaty of Sevres",
  },
  "1922.11.1" => {
    name: "Fall of Ottomans",
    key: true,
    characters: ["k_anatolia", "k_poland", "e_russia"],
  },
  "1939.8.31" => {
    name: "The Greater War",
    characters: ["e_germany", "e_russia", "e_britannia", "e_italy", "e_france"],
  },
  "1945.5.8" => {
    name: "Cold War",
    key: true,
    characters: ["e_britannia", "e_russia", "e_germany", "k_saxony"],
  },
  # Delay it a bit to get Saddam in charge of Iraq
  "1979.7.16" => {
    name: "Iranian Revolution",
    characters: ["k_mesopotamia", "k_persia"], # India?
  },
  "1991.12.26" => {
    name: "Fall of Soviet Union",
    characters: ["k_poland", "e_russia", "c_alania"], # Serbia should be here, Israel maybe?
  },
  "2015.9.1" => {
    name: "Modern Times",
    key: true,
    # I'm quite happy about those
    characters: ["e_russia", "k_ruthenia", "d_sunni", "k_mesopotamia", "k_syria", "k_scotland"],
  },
}

ModernTimesDatabase::HOLDERS_SCANDINAVIA = {
  k_denmark: {
    "1699.8.25" => {
      name: "Frederick | Oldenburg",
      lived: "1671.10.11 - 1730.10.12",
    },
    "1730.10.12" => {
      name: "Christian | Oldenburg",
      lived: "1699.11.30 - 1746.8.6",
    },
    "1746.8.6" => {
      name: "Frederick | Oldenburg",
      lived: "1723.3.31 - 1766.1.14",
    },
    "1766.1.14" => {
      name: "Christian | Oldenburg",
      lived: "1749.1.29 - 1808.3.13",
    },
    "1808.3.13" => {
      name: "Frederick | Oldenburg",
      lived: "1768.1.28 - 1839.12.3",
    },
    "1839.12.3" => {
      name: "Christian | Oldenburg",
      lived: "1786.9.18 - 1848.1.20",
    },
    "1848.1.20" => {
      name: "Frederick | Oldenburg",
      lived: "1808.10.6 - 1863.11.15",
    },
    "1863.11.15" => {
      name: "Christian | Schleswig-Holstein-Sonderburg-Glücksburg",
      lived: "1818.4.8 - 1906.1.29",
    },
    "1906.1.29" => {
      name: "Frederick | Schleswig-Holstein-Sonderburg-Glücksburg",
      lived: "1843.6.3 - 1912.5.14",
      father: "Christian 1",
    },
    "1912.5.14" => {
      name: "Christian | Schleswig-Holstein-Sonderburg-Glücksburg",
      lived: "1870.9.26 - 1947.4.20",
      father: "Frederick 1",
    },
    "1947.4.20" => {
      name: "Frederick | Schleswig-Holstein-Sonderburg-Glücksburg",
      lived: "1899.3.11 - 1972.1.14",
      father: "Christian 2",
    },
    "1972.1.14" => {
      name: "Margrethe | Schleswig-Holstein-Sonderburg-Glücksburg",
      female: true,
      lived: "1940.4.16 -",
      father: "Frederick 2",
    }
  },
  # Wikipedia uses these spellings, however inconsistent they are
  k_sweden: {
    "1720.3.24" => {
      name: "Frederick | Hesse",
      lived: "1676.4.23 - 1751.3.25",
    },
    "1751.3.25" => {
      name: "Adolph Frederick | Holstein-Gottorp",
      lived: "1710.5.14 - 1771.2.12",
    },
    "1771.2.12" => {
      name: "Gustav | Holstein-Gottorp",
      lived: "1746.1.24 - 1792.3.29",
      father: "Adolph Frederick 1",
    },
    "1792.3.29" => {
      name: "Gustav Adolf | Holstein-Gottorp",
      lived: "1778.11.1 - 1837.2.7",
      father: "Gustav 1",
    },
    "1809.6.6" => {
      name: "Charles | Holstein-Gottorp",
      lived: "1748.10.7 - 1818.2.5",
      father: "Adolph Frederick 1",
    },
    "1818.2.5" => {
      name: "Charles John | Bernadotte",
      lived: "1763.1.26 - 1844.3.8",
      # culture: :frankish,
      # Went Church-of-Sweden from Catholic
    },
    "1844.3.8" => {
      name: "Oscar | Bernadotte",
      lived: "1763.1.26 - 1859.7.8",
      father: "Charles John",
    },
    "1859.7.8" => {
      name: "Charles | Bernadotte",
      lived: "May 1826 - 1872.9.18",
      father: "Oscar 1"
    },
    "1872.9.18" => {
      name: "Oscar | Bernadotte",
      lived: "1829.1.21 - 1907.12.8",
      father: "Oscar 1"
    },
    "1907.12.8" => {
      name: "Gustaf | Bernadotte",
      lived: "1858.6.16 - 1950.10.29",
      father: "Oscar 2",
    },
    "1950.10.29" => {
      name: "Gustaf Adolf | Bernadotte",
      lived: "1882.11.11 - 1973.9.15",
      father: "Gustaf",
    },
    "1973.9.15" => {
      name: "Carl Gustaf | Bernadotte",
      lived: "1946.4.30 -",
      father: "Gustaf Adolf",
    },
  },
  k_norway: {
    "1699.8.25"  => {use: "k_denmark Frederick 1"},
    "1730.10.12" => {use: "k_denmark Christian 1"},
    "1746.8.6"   => {use: "k_denmark Frederick 2"},
    "1766.1.14"  => {use: "k_denmark Christian 2"},
    "1808.3.13"  => {use: "k_denmark Frederick 3"},
    "1814.5.17"  => {use: "k_sweden Charles 1"},
    "1818.2.5"   => {use: "k_sweden Charles John 1"},
    "1844.3.8"   => {use: "k_sweden Oscar 1"},
    "1859.7.8"   => {use: "k_sweden Charles 2"},
    "1872.9.18"  => {use: "k_sweden Oscar 2"},
    "1905.6.7"   => {name: "Haakon | Schleswig-Holstein-Sonderburg-Glücksburg", lived: "1872.8.3 - 1957.9.21"},
    "1957.9.21"  => {name: "Olav | Schleswig-Holstein-Sonderburg-Glücksburg", father: "Haakon 1", lived: "1903.7.2 - 1991.1.17"},
    "1991.1.17"  => {name: "Harald | Schleswig-Holstein-Sonderburg-Glücksburg", father: "Olav 1", lived: "1937.2.21 -"},
  },
}

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
  d_iceland: {
    "1944.6.17" => {
      name: "Sveinn Björnsson",
      lived: "1881–1952",
    },
    "1952.8.1" => {
      name: "Ásgeir Ásgeirsson",
      lived: "1894–1972",
    },
    "1968.8.1" => {
      name: "Kristján Eldjárn",
      lived: "1916–1982",
      female: true,
    },
    "1980.8.1" => {
      name: "Vigdís Finnbogadóttir",
      lived: "1930–",
    },
    "1996.8.1" => {
      name: "Ólafur Ragnar | Grímsson",
      lived: "1943–",
    },
    "2016.8.1" => {
      name: "Guðni Thorlacius | Jóhannesson",
      lived: "1968.6.26 -",
    },
  },
  k_finland: {
    # Backdating from "1919.7.26"
    "1917.12.6" => {
      name: "Kaarlo Juho | Ståhlberg",
      lived: "1865.1.28 - 1952.9.22",
    },
    "1925.3.2" => {
      name: "Lauri Kristian | Relander",
      lived: "1883.5.31 - 1942.2.9",
    },
    "1931.3.2" => {
      name: "Pehr Evind | Svinhufvud",
      lived: "1861.12.15 - 1944.2.29",
    },
    "1937.3.1" => {
      name: "Kyösti Kallio",
      lived: "1873.4.10 - 1940.12.19",
    },
    "1940.12.19" => {
      name: "Risto Ryti",
      lived: "1889.2.3 - 1956.10.25",
    },
    "1944.8.4" => {
      name: "Carl Gustaf Emil | Mannerheim",
      lived: "1867.6.4 - 1951.1.27",
    },
    "1946.3.11" => {
      name: "Juho Kusti | Paasikivi",
      lived: " 27 November 1870 - 1956.12.14",
    },
    "1956.3.1" => {
      name: "Urho Kekkonen",
      lived: "1900.9.3 - 1986.8.31",
    },
    "1982.1.27" => {
      name: "Mauno Koivisto",
      lived: "1923.11.25-"
    },
    "1994.3.1" => {
      name: "Martti Ahtisaari",
      lived: "1937.6.23-",
    },
    "2000.3.1" => {
      name: "Tarja Halonen",
      lived: "1943.12.24-",
      female: true,
    },
    "2012.3.1" => {
      name: "Sauli Niinistö",
      lived: "1948.8.24-",
    },
  },
}

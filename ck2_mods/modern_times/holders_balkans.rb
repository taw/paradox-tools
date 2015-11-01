ModernTimesDatabase::HOLDERS_BALKANS = {
  d_krete: {
    # 21 December 1898, backdating to foundation
    "1898.12.13" => {
      # He's a royal but it was High Commissioner post
      name: "George | Schleswig-Holstein-Sonderburg-Glücksburg",
      lived: "1869.6.24 - 1957.11.25",
    },
    "1906.10.1" => {
      name: "Alexandros | Zaimis",
      lived: "1855.11.9 - 1936.9.15",
    },
    "1913.5.30" => nil,
  },
  d_carinthia: {
    # Backdating, actually 23 December 1991
    "1991.7.7" => {
      name: "Milan | Kucan",
      lived: "1941.1.14 -",
    },
    "2002.12.22" => {
      name: "Janez | Drnovsek",
      lived: "1950.5.17 – 2008.2.23",
    },
    "2007.12.23" => {
      name: "Danilo | Türk",
      lived: "1952.2.19 -",
    },
    "2012.12.22" => {
      name: "Borut | Pahor",
      lived: "1963.11.2 -",
    },
  },
  k_croatia: {
    croatia_independence: {name: "Franjo | Tudman", lived: "1922 - 1999"},
    # Backdated from 18 February 2000, skipping two active presidents
    "1999.12.10" => {name: "Stjepan | Mesic", lived: "1934-" },
    "2010.2.19" => {name: "Ivo | Josipovic", lived: "1957-" },
    "2015.2.19" => {name: "Kolinda | Grabar-Kitarovic", female: true, lived: "1968-"},
  },
  # Serbia/Yugoslavia. There was a lot of silliness about rulers of Serbia vs "Yugoslavia" or "Serbia and Montenegro"
  # Just a simplified view here
  #
  # Pretty much all data here is crap quality
  k_serbia: {
    "1878.7.13" => {
      name: "Milan | Obrenović",
      lived: "1854.8.22 – 1901.2.11",
    },
    "1889.3.6" => {
      name: "Alexander | Obrenović",
      lived: "1876.8.14 – 1903.6.11",
      father: "Milan 1",
    },
    "1903.6.11" => {
      name: "Peter | Karađorđević",
      lived: "1844.6.29 – 1921.8.16",
    },
    "1921.8.16" => {
      name: "Alexander | Karađorđević",
      lived: "1888.12.16 – 1934.10.9",
      father: "Peter 1",
    },
    "1934.10.9" => {
      name: "Peter | Karađorđević",
      lived: "1923.9.6 – 1970.11.3",
      father: "Alexander 2",
    },
    end_ww2: {
      name: "Josip Broz | Tito",
      lived: "1892.5.7 – 1980.5.4",
    },
    # Who the hell ruled between Tito and Milosevic?
    # No matter which post I pick here, half of them were too insignificant to have wikipedia article
    # So I'll just drop them and backdate Milošević hard
    "1980.5.4" => {
    # Reasonably true from "1989.5.8" onwards
      name: "Slobodan Milošević",
      lived: "1941.8.20 – 2006.3.11",
    },
    "2000.10.7" => {
      name: "Vojislav Koštunica",
      lived: "1944.3.24-",
    },
    "2003.3.7" => {
      name: "Svetozar Marović",
      lived: "1955.3.31 -",
    },
    "2006.6.3" => {
      name: "Boris Tadić",
      lived: "1958–",
    },
    "2012.5.31" => {
      name: "Tomislav Nikolić",
      lived: "1952–",
    }
  },
  d_cyprus: {
    # Actually "1960.8.16"
    # skipping coup attempt etc.
    # Makarios was archbishop, but can't play as such until theocracy DLC
    cyprus_independence: {
      name: "Makarios | Mouskos",
      lived: "1913.8.13 – 1977.8.3",
    },
    "1977.8.3" => {
      name: "Spyros Kyprianou",
      lived: "1932–2002",
    },
    "1988.2.28" => {
      name: "George Vasiliou",
      lived: "1931–",
    },
    "1993.2.28" => {
      name: "Glafcos Clerides",
      lived: "1919–2013",
    },
    "2003.2.28" => {
      name: "Tassos Papadopoulos",
      lived: "1934–2008",
    },
    "2008.2.28" => {
      name: "Demetris Christofias",
      lived: "1946–",
    },
    "2013.2.28" => {
      name: "Nicos Anastasiades",
      lived: "1946–",
    },
  },
  k_bulgaria: {
    # backdating
    "1878.7.13" => {
      name: "Alexander | Battenberg",
      lived: "1857.4.5 – 1893.10.23",
    },
    # backdating
    "1886.9.7" => {
      name: "Ferdinand | Saxe-Coburg and Gotha",
      lived: "1861.2.26 – 1948.9.10"
    },
    "1918.10.3" => {
      name: "Boris | Saxe-Coburg and Gotha",
      lived: "1894.1.30 – 1943.8.28",
      father: "Ferdinand 1",
    },
    "1943.8.28" => {
      name: "Simeon | Saxe-Coburg and Gotha",
      lived: "1937.6.16-",
      father: "Boris 1",
    },
    # Communists abolished monarchy, listing general secretaries
    # backdating from december
    "1946.9.15" => {
      name: "Georgi Dimitrov",
      lived: "1882.6.18 – 1949.7.2",
    },
    "1949.7.2" => {
      name: "Vulko Chervenkov",
      lived: "1900–1980",
    },
    "1954.3.4" => {
      name: "Todor Zhivkov",
      lived: "1911–1998",
    },
    "1989.11.10" => {
      name: "Petar Mladenov",
      lived: "1936–2000",
    },
    # Post-Communist, backdating
    "1990.2.2" => {
      name: "Zhelyu Zhelev",
      lived: "1935–2015",
    },
    "1997.1.22" => {
      name: "Petar Stoyanov",
      lived: "1952–",
    },
    "2002.1.22" => {
      name: "Georgi Parvanov",
      lived: "1957–",
    },
    "2012.1.22" => {
      name: "Rosen Plevneliev",
      lived: "1964–",
    },
  },
  k_byzantium: {
    # backdating
    "1832.5.7" => {
      name: "Otto | Wittelsbach",
      lived: "1815.6.1 – 1867.7.26",
    },
    # backdating, actually 30 March 1863
    "1862.10.23" => {
      name: "George | Glücksburg",
      lived: "1845.12.24 – 1913.3.18",
    },
    "1913.3.18" => {
      name: "Constantine | Glücksburg",
      lived: "1868.8.2 – 1923.1.11",
    },
    "1917.6.11" => {
      name: "Alexander | Glücksburg",
      lived: "1893.8.1 – 1920.10.25",
      father: "Constantine 1",
    },
    # Backdating restoration
    "1920.10.25" => {
      use: "Constantine 1",
    },
    "1922.9.27" => {
      name: "George | Glücksburg",
      lived: "1890.7.19 – 1947.4.1",
      father: "Constantine 1",
    },
    # second hellenic republic
    "1924.3.25" => {
      name: "Pavlos Kountouriotis",
      lived: "1855–1935",
    },
    "1926.4.6" => {
      name: "Theodoros Pangalos",
      lived: "1878–1952",
    },
    "1926.8.22" => {
      use: "Pavlos 1",
    },
    "1929.12.10" => {
      name: "Alexandros Zaimis",
      lived: "1855–1936",
    },
    # restored monarchy
    "1935.11.25" => {
      use: "George 1", # king restored
    },
    "1947.4.1" => {
      name: "Paul | Glücksburg",
      lived: "1901.12.14 – 1964.3.6",
      father: "Constantine 1"
    },
    "1964.3.6" => {
      name: "Constantine | Glücksburg",
      lived: "1940–",
      father: "Paul 1",
    },
    # junta
    "1973.6.1" => {
      name: "Georgios Papadopoulos",
      lived: "1919–1999",
    },
    "1973.11.25" => {
      name: "Phaedon Gizikis",
      lived: "1917–1999",
    },
    # post-junta
    # provisional
    "1974.12.18" => {
      name: "Michail Stasinopoulos",
      lived: "1903–2002",
    },
    "1975.7.19" => {
      name: "Konstantinos Tsatsos",
      lived: "1899–1987",
    },
    "1980.5.10" => {
      name: "Konstantinos Karamanlis", # 2
      lived: "1907–1998",
    },
    # backdating from 30 March 1985
    "1985.3.10" => {
      name: "Christos Sartzetakis",
      lived: "1929–",
    },
    "1990.5.5" => {use: "Konstantinos 2"}, # Konstantinos Karamanlis
    "1995.3.10" => {
      name: "Konstantinos Stephanopoulos", # 3
      lived: "1926–",
    },
    "2005.3.12" => {
      name: "Karolos Papoulias",
      lived: "1929–",
    },
    "2015.3.13" => {
      name: "Prokopis Pavlopoulos",
      lived: "1950–",
    },
  },
  d_bosnia: {
    # President
    "1993.3.3"  => { name: "Alija Izetbegović", lived: "1925.8.8 – 2003.10.19" },
    # High Representatives
    "1995.12.14" => { name: "Carl Bildt", lived: "1949.7.15 -", culture: :swedish },
    "1997.6.18" => { name: "Carlos Westendorp", lived: "1937.1.7 -", culture: :castillan },
    "1999.8.18" => { name: "Wolfgang Petritsch", lived: "1947.8.26 -", culture: :german },
    "2002.5.27" => { name: "Paddy Ashdown", lived: "1941.2.27 -", culture: :english },
    "2006.2.1"  => { name: "Christian Schwarz-Schilling", lived: "1930.11.19 -", culture: :german },
    "2007.7.1"  => { name: "Miroslav Lajčák", lived: "1963.3.20 -", culture: :croatian },
    "2009.3.1"  => { name: "Valentin Inzko", lived: "1949.5.22 -", culture: :german },
  },
  # Montenegro
  c_ragusa: {
    "2006.6.3" => { name: "Filip Vujanović", lived: "1954.9.1 -" },
  },
  # Macedonia
  d_dyrrachion:  {
    "1991.9.8"  => { name: "Kiro Gligorov", lived: "1917.5.3 – 2012.1.1" },
    "1995.10.4"  => { name: "Stojan Andov", lived: "1935.11.30 -" },
    "1995.11.17" => { use: "Kiro 1" },
    "1999.11.19" => { name: "Savo Klimovski", lived: "1947-" },
    "1999.12.15" => { name: "Boris Trajkovski", lived: "1956.6.25 – 2004.2.26" },
    "2004.2.26"  => { name: "Ljupčo Jordanovski", lived: "1953.2.13 – 2010.10.7" },
    "2004.5.12"  => { name: "Branko Crvenkovski", lived: "1962.10.2 -" },
    "2009.5.12"  => { name: "Gjorge Ivanov", lived: "1960.5.2 -" },
  },
  # Albania
  d_dioclea: {
    # Chairmen of provisional/central government
    "1913.5.30" => { name: "Ismail Qemali", lived: "1844.1.16 – 1919.1.24" },
    "1914.1.22" => { name: "Fejzi Alizoti", lived: "1874.9.22 - 1945.4.14" },
    # Prince, had pretty much zero power, and was in exile due to war and civil war most of the time,
    # but whatever
    "1914.3.7" => { name: "Vidi | Wied", lived: "1876.3.26 – 1945.4.18" },
    # President, then king
    "1925.2.1" => { name: "Zog | Zogu", lived: "1895.10.8 – 1961.4.9" },
    # PU under Italy
    "1939.4.12" => nil,
    # Communist First Secretaries after WW2
    "1945.5.8" => { name: "Enver Hoxha", lived: "1908.10.16 – 1985.4.11" },
    "1985.4.11" => { name: "Ramiz Alia", lived: "1925.10.18 – 2011.10.7" },
    # Post-Communist
    "1992.4.9" => { name: "Sali Berisha", lived: "1944.10.15 -" },
    "1997.7.24" => { name: "Rexhep Meidani", lived: "1944.8.17 -" },
    "2002.7.24" => { name: "Alfred Moisiu", lived: "1929.12.1 -" },
    "2007.7.24" => { name: "Bamir Topi", lived: "1957.4.24 -" },
    "2012.7.24" => { name: "Bujar Nishani", lived: "1966.9.29 -" },
  },
}

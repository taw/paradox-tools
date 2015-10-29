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
      lived: "17 May 1950 – 23 February 2008",
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
      lived: "August 22, 1854 – February 11, 1901",
    },
    "1889.3.6" => {
      name: "Alexander | Obrenović",
      lived: "August 14, 1876 – June 11, 1903",
      father: "Milan 1",
    },
    "1903.6.11" => {
      name: "Peter | Karađorđević",
      lived: "29 June 1844 – 16 August 1921",
    },
    "1921.8.16" => {
      name: "Alexander | Karađorđević",
      lived: "16 December 1888 – 9 October 1934",
      father: "Peter 1",
    },
    "1934.10.9" => {
      name: "Peter | Karađorđević",
      lived: "6 September 1923 – 3 November 1970",
      father: "Alexander 2",
    },
    end_ww2: {
      name: "Josip Broz | Tito",
      lived: "7 May 1892 – 4 May 1980",
    },
    # Who the hell ruled between Tito and Milosevic?
    # No matter which post I pick here, half of them were too insignificant to have wikipedia article
    # So I'll just drop them and backdate Milošević hard
    "1980.5.4" => {
    # Reasonably true from "1989.5.8" onwards
      name: "Slobodan Milošević",
      lived: "20 August 1941 – 11 March 2006",
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
      lived: "August 13, 1913 – August 3, 1977",
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
      lived: "5 April 1857 – 23 October 1893",
    },
    # backdating
    "1886.9.7" => {
      name: "Ferdinand | Saxe-Coburg and Gotha",
      lived: "26 February 1861 – 10 September 1948"
    },
    "1918.10.3" => {
      name: "Boris | Saxe-Coburg and Gotha",
      lived: "30 January 1894 – 28 August 1943",
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
      lived: "June 18, 1882 – July 2, 1949",
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
      lived: "1 June 1815 – 26 July 1867",
    },
    # backdating, actually 30 March 1863
    "1862.10.23" => {
      name: "George | Glücksburg",
      lived: "24 December 1845 – 18 March 1913",
    },
    "1913.3.18" => {
      name: "Constantine | Glücksburg",
      lived: "2 August 1868 – 11 January 1923",
    },
    "1917.6.11" => {
      name: "Alexander | Glücksburg",
      lived: "1 August 1893 – 25 October 1920",
      father: "Constantine 1",
    },
    # Backdating restoration
    "1920.10.25" => {
      use: "Constantine 1",
    },
    "1922.9.27" => {
      name: "George | Glücksburg",
      lived: "19 July 1890 – 1 April 1947",
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
      lived: "14 December 1901 – 6 March 1964",
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
}

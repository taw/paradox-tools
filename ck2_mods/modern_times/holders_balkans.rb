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
      lived: "14 January 1941 -",
    },
    "2002.12.22" => {
      name: "Janez | Drnovsek",
      lived: "17 May 1950 – 23 February 2008",
    },
    "2007.12.23" => {
      name: "Danilo | Türk",
      lived: "19 February 1952 -",
    },
    "2012.12.22" => {
      name: "Borut | Pahor",
      lived: "2 November 1963 -",
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
    "16 August 1921" => {
      name: "Alexander | Karađorđević",
      lived: "16 December 1888 – 9 October 1934",
      father: "Peter 1",
    },
    "9 October 1934" => {
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
    "4 May 1980" => {
    # Reasonably true from "8 May 1989" onwards
      name: "Slobodan Milošević",
      lived: "20 August 1941 – 11 March 2006",
    },
    "7 October 2000" => {
      name: "Vojislav Koštunica",
      lived: "24 March 1944-",
    },
    "7 March 2003" => {
      name: "Svetozar Marović",
      lived: "31 March 1955 -",
    },
    "3 June 2006" => {
      name: "Boris Tadić",
      lived: "1958–",
    },
    "31 May 2012" => {
      name: "Tomislav Nikolić",
      lived: "1952–",
    }
  },
  d_cyprus: {
    # Actually "16 August 1960"
    # skipping coup attempt etc.
    # Makarios was archbishop, but can't play as such until theocracy DLC
    cyprus_independence: {
      name: "Makarios | Mouskos",
      lived: "August 13, 1913 – August 3, 1977",
    },
    "3 August 1977" => {
      name: "Spyros Kyprianou",
      lived: "1932–2002",
    },
    "28 February 1988" => {
      name: "George Vasiliou",
      lived: "1931–",
    },
    "28 February 1993" => {
      name: "Glafcos Clerides",
      lived: "1919–2013",
    },
    "28 February 2003" => {
      name: "Tassos Papadopoulos",
      lived: "1934–2008",
    },
    "28 February 2008" => {
      name: "Demetris Christofias",
      lived: "1946–",
    },
    "28 February 2013" => {
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
    "7 September 1886" => {
      name: "Ferdinand | Saxe-Coburg and Gotha",
      lived: "26 February 1861 – 10 September 1948"
    },
    "3 October 1918" => {
      name: "Boris | Saxe-Coburg and Gotha",
      lived: "30 January 1894 – 28 August 1943",
      father: "Ferdinand 1",
    },
    "28 August 1943" => {
      name: "Simeon | Saxe-Coburg and Gotha",
      lived: "16 June 1937-",
      father: "Boris 1",
    },
    # Communists abolished monarchy, listing general secretaries
    # backdating from december
    "15 September 1946" => {
      name: "Georgi Dimitrov",
      lived: "June 18, 1882 – July 2, 1949",
    },
    "2 July 1949" => {
      name: "Vulko Chervenkov",
      lived: "1900–1980",
    },
    "4 March 1954" => {
      name: "Todor Zhivkov",
      lived: "1911–1998",
    },
    "10 November 1989" => {
      name: "Petar Mladenov",
      lived: "1936–2000",
    },
    # Post-Communist, backdating
    "2 February 1990" => {
      name: "Zhelyu Zhelev",
      lived: "1935–2015",
    },
    "22 January 1997" => {
      name: "Petar Stoyanov",
      lived: "1952–",
    },
    "22 January 2002" => {
      name: "Georgi Parvanov",
      lived: "1957–",
    },
    "22 January 2012" => {
      name: "Rosen Plevneliev",
      lived: "1964–",
    },
  },
  k_byzantium: {
    # backdating
    "7 May 1832" => {
      name: "Otto | Wittelsbach",
      lived: "1 June 1815 – 26 July 1867",
    },
    # backdating, actually 30 March 1863
    "23 October 1862" => {
      name: "George | Glücksburg",
      lived: "24 December 1845 – 18 March 1913",
    },
    "18 March 1913" => {
      name: "Constantine | Glücksburg",
      lived: "2 August 1868 – 11 January 1923",
    },
    "11 June 1917" => {
      name: "Alexander | Glücksburg",
      lived: "1 August 1893 – 25 October 1920",
      father: "Constantine 1",
    },
    # Backdating restoration
    "25 October 1920" => {
      use: "Constantine 1",
    },
    "27 September 1922" => {
      name: "George | Glücksburg",
      lived: "19 July 1890 – 1 April 1947",
      father: "Constantine 1",
    },
    # second hellenic republic
    "25 March 1924" => {
      name: "Pavlos Kountouriotis",
      lived: "1855–1935",
    },
    "6 April 1926" => {
      name: "Theodoros Pangalos",
      lived: "1878–1952",
    },
    "22 August 1926" => {
      use: "Pavlos 1",
    },
    "10 December 1929" => {
      name: "Alexandros Zaimis",
      lived: "1855–1936",
    },
    # restored monarchy
    "25 November 1935" => {
      use: "George 1", # king restored
    },
    "1 April 1947" => {
      name: "Paul | Glücksburg",
      lived: "14 December 1901 – 6 March 1964",
      father: "Constantine 1"
    },
    "6 March 1964" => {
      name: "Constantine | Glücksburg",
      lived: "1940–",
      father: "Paul 1",
    },
    # junta
    "1 June 1973" => {
      name: "Georgios Papadopoulos",
      lived: "1919–1999",
    },
    "25 November 1973" => {
      name: "Phaedon Gizikis",
      lived: "1917–1999",
    },
    # post-junta
    # provisional
    "18 December 1974" => {
      name: "Michail Stasinopoulos",
      lived: "1903–2002",
    },
    "19 July 1975" => {
      name: "Konstantinos Tsatsos",
      lived: "1899–1987",
    },
    "10 May 1980" => {
      name: "Konstantinos Karamanlis", # 2
      lived: "1907–1998",
    },
    # backdating from 30 March 1985
    "10 March 1985" => {
      name: "Christos Sartzetakis",
      lived: "1929–",
    },
    "5 May 1990" => {use: "Konstantinos 2"}, # Konstantinos Karamanlis
    "10 March 1995" => {
      name: "Konstantinos Stephanopoulos", # 3
      lived: "1926–",
    },
    "12 March 2005" => {
      name: "Karolos Papoulias",
      lived: "1929–",
    },
    "13 March 2015" => {
      name: "Prokopis Pavlopoulos",
      lived: "1950–",
    },
  },
}

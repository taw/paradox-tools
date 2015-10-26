ModernTimesDatabase::HOLDERS_BRITAIN = {
  # Dynasty changed names twice, but whatever
  e_britannia: {
    "1689.2.13" => {
      name: "William | Stuart",
      lived: "1650.11.4 - 1702.3.8",
    },
    # From 1 May 1707 as UK, but let's not pretend Scotland mattered before
    "1702.3.8" => {
      name: "Anne | Stuart",
      lived: "1665.2.6 - 1714.8.1",
      female: true,
    },
    "1714.8.1" => {
      name: "George | Windsor",
      lived: "1660.5.28 - 1727.6.11",
    },
    "1727.6.11" => {
      name: "George | Windsor",
      father: "George 1",
      lived: "1683.10.30 - 1760.10.25",
    },
    "1760.10.25" => {
      name: "George | Windsor",
      # grandfather: "George 2",
      lived: "1738.6.4 - 1820.1.29",
      events: {
        crowning: PropertyList[
          "prestige", 2000,
        ],
      },
    },
    "1820.1.29" => {
      name: "George | Windsor",
      father: "George 3",
      lived: "1762.8.12 - 1830.6.26",
      events: {
        crowning: PropertyList[
          "prestige", 2000,
        ],
      },
    },
    "1830.6.26" => {
      name: "William | Windsor",
      lived: "1765.8.21 - 1837.6.20",
      father: "George 3",
      events: {
        crowning: PropertyList[
          "prestige", 2000,
        ],
      },
    },
    "1837.6.20" => {
      lived: "1819.5.24 - 1901.1.22",
      name: "Victoria | Windsor",
      female: true,
      health: 7,
      events: {
        crowning: PropertyList[
          "prestige", 2000,
        ],
      },
      # granddaughter of George 3
    },
    "1901.1.22" => {
      lived: "1841.11.9 - 1910.5.6",
      name: "Edward | Windsor",
      mother: "Victoria",
      events: {
        crowning: PropertyList[
          "prestige", 2000,
        ],
      },
    },
    "1910.5.6" => {
      lived: "1865.6.3 - 1936.1.20",
      name: "George | Windsor",
      father: "Edward",
      events: {
        crowning: PropertyList[
          "prestige", 2000,
        ],
      },
    },
    "1936.1.20" => {
      lived: "1894.6.23 - 1972.5.28",
      name: "Edward | Windsor",
      father: "George 5",
      events: {
        crowning: PropertyList[
          "prestige", 2000,
        ],
      },
    },
    "1936.12.11" => {
      lived: "1895.12.14 - 1952.2.6",
      name: "George | Windsor",
      father: "George 5",
      events: {
        crowning: PropertyList[
          "prestige", 2000,
        ],
      },
    },
    "1952.2.6" => {
      lived: "1926.4.21 -",
      name: "Elizabeth | Windsor",
      female: true,
      father: "George 6",
    },
  },
  k_scotland: {
    "7 May 1999" => {
      name: "Donald | Dewar",
      lived: "1937–2000",
    },
    "27 October 2000" => {
      name: "Henry | McLeish",
      lived: "1948–",
    },
    "22 November 2001" => {
      name: "Jack | McConnell",
      lived: "1960–",
    },
    "16 May 2007" => {
      name: "Alex | Salmond",
      lived: "1954–",
    },
    "20 November 2014" => {
      name: "Nicola | Sturgeon",
      lived: "1970–",
      female: true,
    },
  },
  k_ireland: {
    ireland_independence: {
      name: "Éamon | de Valera",
      lived: "14 October 1882 – 29 August 1975",
    },
    "9 January 1922" => {
      name: "Michael Collins",
      lived: "16 October 1890 – 22 August 1922",
    },
    # Before that it's a bit messy
    "22 August 1922" => {
      name: "William Thomas | Cosgrave",
      lived: "1880–1965",
    },
    "9 March 1932" => {use: "Éamon 1"},
    "18 February 1948" => {
      name: "John Aloysius | Costello",
      lived: "1891–1976",
    },
    "13 June 1951" => {use: "Éamon 1"},
    "2 June 1954" => {use: "John Aloysius 1"},
    "20 March 1957" => {use: "Éamon 1"},
    "23 June 1959" => {
      name: "Seán Lemass",
      lived: "1899–1971",
    },
    "10 November 1966" => {
      name: "Jack Lynch",
      lived: "1917–1999",
    },
    "14 March 1973" => {
      name: "Liam Cosgrave",
      lived: "1920–",
    },
    "5 July 1977" => {use: "Jack 1"},
    "11 December 1979" => {
      name: "Charles Haughey",
      lived: "1925–2006",
    },
    "30 June 1981" => {
      name: "Garret FitzGerald",
      lived: "1926–2011",
    },
    "9 March 1982" => {use: "Charles 1"},
    "14 December 1982" => {use: "Garret 1"},
    "10 March 1987" => {use: "Charles 1"},
    "11 February 1992" => {
      name: "Albert Reynolds",
      lived: "1932–2014",
    },
    "15 December 1994" => {
      name: "John Bruton",
      lived: "1947–",
    },
    "26 June 1997" => {
      name: "Bertie Ahern",
      lived: "1951–",
    },
    "7 May 2008" => {
      name: "Brian Cowen",
      lived: "1960–",
    },
    "9 March 2011" => {
      name: "Enda Kenny",
      lived: "1951–",
    },
  },
}

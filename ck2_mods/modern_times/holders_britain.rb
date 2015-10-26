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
    "7 May 1999" => {name: "Donald | Dewar"},
    "27 October 2000" => {name: "Henry | McLeish"},
    "22 November 2001" => {name: "Jack | McConnell"},
    "16 May 2007" => { name: "Alex | Salmond" },
    "20 November 2014" => {name: "Nicola | Sturgeon", female: true},
  },
}

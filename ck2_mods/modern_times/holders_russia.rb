ModernTimesDatabase::HOLDERS_RUSSIA = {
  e_russia: {
    "1682.6.2" => {
      name: "Peter | Romanov",
      lived: "1672.6.9 - 1725.2.8",
    },
    "1725.2.8" => {
      name: "Catherine | Romanov",
      lived: "1684.4.15 - 1727.5.17",
      female: true,
    },
    "1727.5.17" => {
      name: "Peter | Romanov",
      lived: "1715.10.23 - 1730.1.30",
    },
    "1730.1.30" => {
      name: "Anna | Romanov",
      lived: "1693.2.7 - 1740.10.28",
      female: true,
    },
    "1740.10.28" => {
      name: "Ivan | Romanov",
      lived: "1740.8.23 - 1764.7.16",
    },
    "1741.12.6" => {
      name: "Elizabeth | Romanov",
      lived: "1709.12.29 - 1762.1.5",
      female: true,
    },
    "1762.1.5" => {
      name: "Peter | Romanov",
      lived: "1728.2.21 - 1762.7.17",
    },
    "1762.7.9" => {
      name: "Catherine | Romanov",
      lived: "1729.5.2 - 1796.11.17",
      female: true,
    },
    "1796.11.17" => {
      name: "Paul | Romanov",
      lived: "1754.10.1 - 1801.3.23",
    },
    "1801.3.23" => {
      name: "Alexander | Romanov",
      lived: "1777.12.23 - 1825.12.1",
    },
    "1825.12.1" => {
      name: "Nicholas | Romanov",
      lived: "1796.7.6 - 1855.3.2",
    },
    "1855.3.2" => {
      name: "Alexander | Romanov",
      lived: "1818.4.29 - 1881.3.13",
    },
    "1881.3.13" => {
      name: "Alexander | Romanov",
      lived: "1845.3.10 - 1894.11.1",
    },
    "1894.11.1" => {
      name: "Nicholas | Romanov",
      lived: "1868.5.6 - 1918.7.17",
    },
    # Not really ruling ever, but alternative is interregnum
    "1917.3.15" => {
      name: "Michael | Romanov",
      lived: "1878.10.22 - 1918.6.12",
    },
    # Backdating
    "1918.6.12" => {
      name: "Vladimir | Lenin", lived: "April 22, 1870 - 1924.1.21",
      traits: ["cynical"],
      health: 6,
    },
    "1924.1.21" => {
      name: "Joseph | Stalin", lived: "December 18, 1878 - 1953.3.5",
      health: 7,
      traits: ["ambitious", "cynical"],
      events: {
        crowning: PropertyList[
          "effect", PropertyList["set_character_flag", "horde_invader"],
          "prestige", 1000, # enough to start 2 wars
        ],
      },
    },
    "1953.3.5" => {
      name: "Georgy | Malenkov",
    },
    "1955.2.8" => {
      name: "Nikita | Khrushchev",
    },
    "1964.10.14" => {
      name: "Leonid | Brezhnev",
    },
    "1982.10.12" => {
      name: "Yuri | Andropov",
    },
    "1984.2.13" => {
      name: "Konstantin | Chernenko"
    },
    # Skipping Gennady Yanayev 3-day plot silliness
    "1985.3.11" => {
      name: "Mikhail | Gorbachev",
    },
    "1991.12.25" => {
      name: "Boris | Yeltsin",
      lived: "1931.2.1 - 2007.4.23",
      traits: ["drunkard"],
      health: 6,
    },
    "1999.12.31" => {
      name: "Vladimir | Putin",
      lived: "7 October 1952 -",
      health: 6,
    },
    "2008.5.7" => {
      name: "Dmitry | Medvedev",
      lived: "14 September 1965 -",
    },
    "2012.5.7" => { use: "Vladimir 2" },
  },
  c_alania: {
    fall_soviet_union: {
      name: "Dzhokhar | Dudayev",
      lived: "1944.2.15 - 1996.4.21",
      traits: ["brilliant_strategist"],
      health: 6,
    },
    "1996.4.21" => {
      name: "Zelimkhan | Yandarbiyev",
      lived: "1952.9.12 - 2004.2.13",
    },
    "1997.2.12" => {
      name: "Aslan | Maskhadov",
      lived: "1951.9.21 - 2005.3.8",
    },
    fall_chechnya: nil,
  },
  k_ruthenia: {
    fall_soviet_union: {
      name: "Leonid | Kravchuk",
      lived: "1934.1.10 -",
    },
    "1994.7.19" => {
      name: "Leonid | Kuchma",
      lived: "1938.8.9 -",
    },
    "2005.1.23" => {
      name: "Viktor | Yushchenko",
      lived: "1954.2.23 -",
    },
    "2010.2.25" => {
      name: "Viktor | Yanukovych",
      lived: "1950.7.9 -",
    },
    # acting, but timing is pretty important
    "2014.2.23" => {
      name: "Oleksandr | Turchynov",
      lived: "31 March 1964 -",
      events: {
        crimea_invasion: PropertyList[
          "add_claim", "c_crimea",
          "add_claim", "d_cherson",
          "add_claim", "c_theodosia",
          "add_claim", "c_cherson",
          "add_claim", "c_korchev",
        ],
        "2014.6.7" => PropertyList[
          "remove_claim", "c_crimea",
          "remove_claim", "d_cherson",
          "remove_claim", "c_theodosia",
          "remove_claim", "c_cherson",
          "remove_claim", "c_korchev",
        ],
      },
    },
    "2014.6.7" => {
      name: "Petro | Poroshenko",
      lived: "1965.9.26 -",
      events: {
        "2014.6.7" => PropertyList[
          "add_claim", "c_crimea",
          "add_claim", "d_cherson",
          "add_claim", "c_theodosia",
          "add_claim", "c_cherson",
          "add_claim", "c_korchev",
        ],
      },
    },
  },
  d_vitebsk: {
    fall_soviet_union: {
      name: "Stanislav | Shushkevich",
      lived: "1934.12.15 -",
    },
    # Skipping two acting chairmen of supreme soviet, not backdating
    "1994.7.20" => {
      name: "Alexander | Lukashenko",
      lived: "1954.8.30 -",
    }
  },
  k_georgia: {
    # A lot of backdating
    fall_soviet_union: {name: "Eduard | Shevardnadze", lived: "1928.1.25 - 2014.7.7"},
    "2003.11.23" => {name: "Mikheil | Saakashvili", lived: "1967.12.21 -"},
    "2013.11.17" => {name: "Giorgi | Margvelashvili", lived: "1969.9.4-"}
  },
  d_azerbaijan: {
    # actually 28 May 1918
    end_ww1: {name: "Mammad Amin | Rasulzade"},
    "1918.12.7" => {name: "Alimardan | Topchubashov"},
    # End date is somewhat dubious
    "1920.5.11" => nil,
    # 3 October 1993, backdating, but Heydar Aliyev was sort of leader of Azerbaijan since 1969
    fall_soviet_union: { name: "Heydar | Aliyev", lived: "1923.5.10 - 2003.12.12" },
    "2003.10.31" => { name: "Ilham | Aliyev", father: "Heydar 1", lived: "1961.12.24-" },
  },
  d_esthonia: {
    # 6 October 1992, backdating
    fall_soviet_union: {name: "Lennart Georg | Meri"},
    "2001.10.8" => {name: "Arnold | Rüütel"},
    "2006.10.9" => {name: "Toomas Hendrik | Ilves"},
  },
  d_lithuanians: {
    # From 11 March 1990, chairman of supreme soviet
    fall_soviet_union: {name: "Vytautas | Landsbergis"},
    "1993.2.25" => {name: "Algirdas | Brazauskas"},
    "1998.2.26" => {name: "Valdas | Adamkus"},
    "2003.2.26" => {name: "Rolandas | Paksas"},
    # backdated to skip acting president
    "2004.4.6" => {use: "Valdas 1"},
    "2009.7.12" => {name: "Dalia | Grybauskaite", female: true},
  },
  k_cuman: {
    fall_soviet_union: {name: "Nursultan | Nazarbayev", lived: "1940.7.6-"},
  },
  k_khiva: {
    fall_soviet_union: {name: "Islam | Karimov", lived: "1938.1.30-"},
  },
  d_dihistan: {
    fall_soviet_union: {name: "Saparmurat | Niyazov", lived: "1940.2.19 - 2006.12.21"},
    "2006.12.21" => {name: "Gurbanguly | Berdimuhamedow", lived: "1957.6.29-"},
  },
}

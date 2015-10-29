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
      name: "Vladimir | Lenin", lived: "1870.4.22 - 1924.1.21",
      traits: ["cynical"],
      health: 6,
    },
    "1924.1.21" => {
      name: "Joseph | Stalin", lived: "1878.12.18 - 1953.3.5",
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
      lived: "8 January 1902 – 14 January 1988",
    },
    "1955.2.8" => {
      name: "Nikita | Khrushchev",
      lived: "April 15 1894 – September 11, 1971",
    },
    "1964.10.14" => {
      name: "Leonid | Brezhnev",
      lived: "19 December 1906 – 10 November 1982",
    },
    "1982.10.12" => {
      name: "Yuri | Andropov",
      lived: "15 June 1914 – 9 February 1984",
    },
    # backdating from 1984.2.13
    "1984.2.9" => {
      name: "Konstantin | Chernenko",
      lived: "24 September 1911 – 10 March 1985",
    },
    # Skipping Gennady Yanayev 3-day plot silliness
    # backdating one day
    "1985.3.10" => {
      name: "Mikhail | Gorbachev",
      lived: "1931.3.2 -",
    },
    "1991.12.25" => {
      name: "Boris | Yeltsin",
      lived: "1931.2.1 - 2007.4.23",
      traits: ["drunkard"],
      health: 6,
    },
    "1999.12.31" => {
      name: "Vladimir | Putin",
      lived: "1952.10.7 -",
      health: 6,
    },
    "2008.5.7" => {
      name: "Dmitry | Medvedev",
      lived: "1965.9.14 -",
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
      lived: "1964.3.31 -",
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
    end_ww1: {name: "Mammad Amin | Rasulzade", lived: "1884.1.31 - 1955.3.6"},
    "1918.12.7" => {name: "Alimardan | Topchubashov", lived: "1863.5.4 - 1934.11.8"},
    # End date is somewhat dubious
    # Communists
    # Grigory Kaminsky started 24 October 1920, backdating a bit
    "1920.5.11"  => { name: "Grigory Kaminsky", lived: "1895.11.1 - 1938.2.10" },
    "1921.7.24"     => { name: "Sergey Kirov", lived: "1886.3.27 - 1934.12.1" },
    "1925.1.5"   => { name: "Ruhulla Akhundov", lived: "1897.1.1 - 1938.4.21" },
    "1926.1.21"  => { name: "Levon Mirzoyan", lived: "December 1887 - 1939.2.26" },
    "1929.7.11"     => { name: "Nikolay Gikalo", lived: "1897.3.8 - 1938.4.25" },
    "1930.8.5"    => { name: "Vladimir Polonsky", lived: "1893.6.17 - 1937.10.30" },
    "1933.2.7"  => { name: "Ruben Rubenov", lived: "1894 - 1937.11.27" },
    "1933.12.10" => { name: "Mir Jafar | Baghirov", lived: "1896.9.17 - 1956.5.7" },
    "1953.4.6"     => { name: "Mir Teymur | Yaqubov", lived: "1904.11.6 - 1970.2.17" },
    "1954.2.17" => { name: "Imam Mustafayev", lived: "1910.2.25 - 1997.3.10" },
    "1959.7.10"     => { name: "Vali Akhundov", lived: "1916.5.14 - 1986.8.22" },

    "1969.7.14" => { name: "Heydar | Aliyev", lived: "1923.5.10 - 2003.12.12" },
    "1982.12.3" => {name: "Kamran Baghirov", lived: "1933.1.24 - 2000.10.25" },
    "1988.5.21"     => {name: "Abdurrahman Vazirov", lived: "1930.5.26 -" },
    "1990.1.25" => {name: "Ayaz Mutallibov", lived: "1938.5.12 -" },
    # After Communism (but still same people mostly)
    "1992.6.16" => { name: "Abulfaz Elchibey", lived: "1938.6.24 - 2000.8.22"},
    "1993.10.3" => {use: "Heydar 1"},
    "2003.10.31" => { name: "Ilham | Aliyev", father: "Heydar 1", lived: "1961.12.24-" },
  },
  d_esthonia: {
    "1933.10.21" => {name: "Konstantin Päts", lived: "23 February 1874 – 18 January 1956"},
    "1940.7.23" => nil,
    # Communists

    # 6 October 1992, backdating
    fall_soviet_union: {name: "Lennart Georg | Meri", lived: "29 March 1929 – 14 March 2006"},
    "2001.10.8" => {name: "Arnold | Rüütel", lived: "1928.5.10 -"},
    "2006.10.9" => {name: "Toomas Hendrik | Ilves", lived: "1953.12.26 -"},
  },
  d_lithuanians: {
    # Presidents
    "1919.4.4" => { name: "Antanas Smetona", lived: "1874.8.10 - 1944.1.9" },
    "1920.6.19" => { name: "Aleksandras Stulginskis", lived: "1885.2.26 - 1969.9.22" },
    "1926.6.7" => { name: "Kazys Grinius", lived: "1866.12.17 - 1950.6.4" },
    # Military
    "1926.12.19" => { use: "Antanas 1" },
    # Communist First Secretaries, backdating
    "1940.6.15" => { name: "Antanas Sniečkus", lived: "1903.1.7 - 1974.1.22" },
    "January 22 1974" => { name: "Petras Griškevičius", lived: "1924.7.19 - 1987.11.14" },
    "November 14 1987" => { name: "Ringaudas Bronislovas | Songaila", lived: "1929.3.20 -" },
    "1988.10.19" => { name: "Algirdas Mykolas | Brazauskas", lived: "1932.9.22 - 2010.6.26" },
    # First as Chairman of supreme soviet, then all post-Communist
    "1990.3.11" => {name: "Vytautas | Landsbergis", lived: "1932.10.8 -"},
    "1993.2.25" => {name: "Algirdas | Brazauskas", lived: "1932.9.22 - 2010.6.26"},
    "1998.2.26" => {name: "Valdas | Adamkus", lived: "1926.11.3 -"},
    "2003.2.26" => {name: "Rolandas | Paksas", lived: "1956.6.10 -"},
    # backdated to skip acting president
    "2004.4.6" => {use: "Valdas 1"},
    "2009.7.12" => {name: "Dalia | Grybauskaite", female: true, lived: "1956.3.1 -"},
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

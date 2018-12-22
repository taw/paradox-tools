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
      lived: "1902.1.8 - 1988.1.14",
    },
    "1955.2.8" => {
      name: "Nikita | Khrushchev",
      lived: "April 15 1894 - 1971.9.11",
    },
    "1964.10.14" => {
      name: "Leonid | Brezhnev",
      lived: "1906.12.19 - 1982.11.10",
    },
    "1982.10.12" => {
      name: "Yuri | Andropov",
      lived: "1914.6.15 - 1984.2.9",
    },
    # backdating from 1984.2.13
    "1984.2.9" => {
      name: "Konstantin | Chernenko",
      lived: "1911.9.24 - 1985.3.10",
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
  k_belarus: {
    # backdating from "1920.8.9"
    "1918.11.11" => { name: "Vilgelm Knorinsh", lived: "1890-1939" },
    # noby has better than year date, even Belarussian wikipedia, just picking some shit up
    "1923.5.1" => { name: "Aleksandr Osatkin-Vladimirsky", lived: "1885-1937" },
    "1924.5.13" => { name: "Aleksandr Krinitsky", lived: "1894-1937" },
    # Spelled Nikolay on English wikipedia, use consistent spelling instead
    "1925.12.22" => { name: "Nikolai Goloded", lived: "1894-1937" },
    "1927.5.7" => { use: "Vilgelm 1" },
    "1928.12.4" => { name: "Yakov Gamarnik", lived: "June 2 1894 - 1937.5.31" },
    "1930.1.3" => { name: "Konstantin Gey", lived: "1896 - 1939.2.25" },
    # FIXME: He was azerbaijan and uzbek SSR too, wtf?
    "1932.1.18" => { name: "Nikolay Gikalo", lived: "1897.3.8 - 1938.4.25" },
    "1937.3.18" => { name: "Vasily Sharangovich", lived: "1897-1938" },
    "1937.7.27" => { name: "Yakov Yakovlev", lived: "1896.6.9 - 1938.7.29" },
    "1937.8.11" => { name: "Aleksei Alekseyevich | Volkov", lived: "1890-1942" },
    "1938.6.18" => { name: "Panteleimon Ponomarenko", lived: "1902.8.9 - 1984.1.18" },
    "1947.3.7" => { name: "Nikolai Gusarov", lived: "1905.8.16 - 1985.3.17" },
    "1950.5.31" => { name: "Nikolai Patolichev", lived: "1908.9.10 - 1989.12.1" },
    "1953.3.8" => { name: "Mikhail Zimyanin", lived: "1914-1995" },
    "1953.6.25" => { use:"Nikolai 3" },
    "1956.7.28" => { name: "Kirill Mazurov", lived: "1914.3.25 - 1989.12.19" },
    "1965.3.30" => { name: "Pyotr Masherov", lived: "February 26 1918 - 1980.10.4" },
    # backdating from 1980.10.15
    "1980.10.4" => { name: "Tikhon Kiselyov", lived: "1917.8.12 - 1983.1.11" },
    # backdating from 1983.1.13
    "1983.1.11" => { name: "Nikolay Slyunkov", lived: "1929-" },
    "1987.2.6" => { name: "Yefrem Sokolov", lived: "1926.4.26-" },
    "1990.11.30" => { name: "Anatoly Malofeyev", lived: "1933.5.14 -" },
    "1991.8.15" => {
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
    "1920.5.11" => { name: "Grigory Kaminsky", lived: "1895.11.1 - 1938.2.10" },
    "1921.7.24" => { name: "Sergey Kirov", lived: "1886.3.27 - 1934.12.1" },
    "1925.1.5"  => { name: "Ruhulla Akhundov", lived: "1897.1.1 - 1938.4.21" },
    "1926.1.21" => { name: "Levon Mirzoyan", lived: "December 1887 - 1939.2.26" },
    "1929.7.11" => { name: "Nikolay Gikalo", lived: "1897.3.8 - 1938.4.25" },
    "1930.8.5" => { name: "Vladimir Polonsky", lived: "1893.6.17 - 1937.10.30" },
    "1933.2.7" => { name: "Ruben Rubenov", lived: "1894 - 1937.11.27" },
    "1933.12.10" => { name: "Mir Jafar | Baghirov", lived: "1896.9.17 - 1956.5.7" },
    "1953.4.6" => { name: "Mir Teymur | Yaqubov", lived: "1904.11.6 - 1970.2.17" },
    "1954.2.17" => { name: "Imam Mustafayev", lived: "1910.2.25 - 1997.3.10" },
    "1959.7.10" => { name: "Vali Akhundov", lived: "1916.5.14 - 1986.8.22" },

    "1969.7.14" => { name: "Heydar | Aliyev", lived: "1923.5.10 - 2003.12.12" },
    "1982.12.3" => {name: "Kamran Baghirov", lived: "1933.1.24 - 2000.10.25" },
    "1988.5.21" => {name: "Abdurrahman Vazirov", lived: "1930.5.26 -" },
    "1990.1.25" => {name: "Ayaz Mutallibov", lived: "1938.5.12 -" },
    # After Communism (but still same people mostly)
    "1992.6.16" => { name: "Abulfaz Elchibey", lived: "1938.6.24 - 2000.8.22"},
    "1993.10.3" => {use: "Heydar 1"},
    "2003.10.31" => { name: "Ilham | Aliyev", father: "Heydar 1", lived: "1961.12.24-" },
  },
  d_esthonia: {
    "1933.10.21" => {name: "Konstantin Päts", lived: "1874.2.23 - 1956.1.18"},
    "1940.7.23" => nil,
    # Communists

    # 6 October 1992, backdating
    fall_soviet_union: {name: "Lennart Georg | Meri", lived: "1929.3.29 - 2006.3.14"},
    "2001.10.8" => {name: "Arnold | Rüütel", lived: "1928.5.10 -"},
    "2006.10.9" => {name: "Toomas Hendrik | Ilves", lived: "1953.12.26 -"},
    "2016.10.10" => {name: "Kersti Kaljulaid", female: true, lived: "1969.12.30 -"},
  },
  d_lithuanians: {
    # Presidents
    # backdating from "1919.4.4"
    end_ww1: { name: "Antanas Smetona", lived: "1874.8.10 - 1944.1.9" },
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
    "1990.2.22" => {name: "Nursultan | Nazarbayev", lived: "1940.7.6-"},
  },
  k_khiva: { # Uzbekistan
    "1989.6.23" => {name: "Islam | Karimov", lived: "1938.1.30-"},
  },
  d_khuttal: { # Tajikistan
    "1990.11.30" => { name: "Qahhor | Mahkamov", lived: "1932.4.16 - 2016.6.8"},
    "1991.9.23" => { name: "Rahmon | Nabiyev", lived: "1930.10.5 - 1993.4.11"},
    "1992.11.20" => { name: "Emomali | Rahmon", lived: "1952.10.5 -"},
  },
  d_ferghana: { # Kyrgyzstan
    "1990.10.27" => {name: "Askar Akayev", lived: "1944.11.10 -"},
    "2005.3.25" => {name: "Kurmanbek Bakiyev", lived: "1949.8.1 -"},
    "2010.4.7"  => {name: "Roza Otunbayeva", lived: "1950.8.23 -", female: true},
    "2011.12.1" => {name: "Almazbek Atambayev", lived: "1956.9.17 -"},
    "2017.11.24" => {name: "Sooronbay Jeenbekov", lived: "1958.11.16 -"},
  },
  d_dihistan: { # Turkmenistan
    "1958.12.14" => { name: "Dzhuma Durdy | Karayev", lived: "1910-1960.5.4" },
    # backdating from "1960.6.13"
    "1960.5.4" => { name: "Balysh Ovezov", lived: "1915-1975" },
    "1969.12.24" => { name: "Muhammetnazar Gapurow", lived: "1922.2.15 - 1999.7.13" },
    "1985.12.21" => { name: "Saparmurat | Niyazov", lived: "1940.2.19 - 2006.12.21"},
    "2006.12.21" => { name: "Gurbanguly | Berdimuhamedow", lived: "1957.6.29-"},
  },
  d_moldau: { # Moldova
    "1990.4.27" => { name: "Mircea Snegur", lived: "1940.1.17 -" },
    "1997.1.15" => { name: "Petru Lucinschi", lived: "1940.1.27 -" },
    "2001.4.7"  => { name: "Vladimir Voronin", lived: "1941.5.25 -" },
    # 3 acting presidents
    "2009.9.11" => { name: "Mihai Ghimpu", lived: "1951.11.19 -" },
    "2010.12.28" => { name: "Vladimir Filat", lived: "1969.5.6 -" },
    "2010.12.30" => { name: "Marian Lupu", lived: "1966.6.20 -" },
    "2012.3.23" => { name: "Nicolae Timofti", lived: "1948.12.22 -" },
    "2016.12.27" => {name: "Igor Dodon", lived: "1975.2.18 -"},
  },
  d_armenia: {
    # From 11 November 1991 presidents
    "1990.8.4" => { name: "Levon Ter-Petrossian", lived: "1945.1.9 -" },
    "1998.2.4" => { name: "Robert Kocharyan", lived: "1954.8.31 -" },
    "2008.4.9" => { name: "Serzh Sargsyan", lived: "1954.6.30 -" },
  },
  d_courland: { # Latvia
    end_ww1: { name: "Jānis Čakste", lived: "1859.9.14 - 1927.3.14" },
    "1927.3.14" => { name: "Gustavs Zemgals", lived: "1871.8.12 - 1939.1.6" },
    "1930.9.4" => { name: "Alberts Kviesis", lived: "1881.12.22 - 1944.8.9" },
    "1936.11.4" => { name:  "Kārlis Ulmanis", lived: "1877.9.4 - 1942.9.20" },
    # Dates of both adjusted a bit so transition and occupation cooccur same day
    annexation_latvia: { name: "Augusts Kirhenšteins", lived: "1872.9.18 - 1963.11.3" },
    "1952.4.11" => { name: "Kārlis Ozoliņš", lived: "1905.8.31 - 1987.8.15" },
    "1959.11.27"=> { name: "Jānis Kalnbērziņš", lived: "1893.9.17 - 1986.2.4" },
    "1970.5.5" => { name: "Vitālijs Rubenis", lived: "1914.2.26 - 1994.1.2" },
    "1974.8.20" => { name: "Pēteris Strautmanis", lived: "1919.4.24 - 2007.6.27" },
    "1985.6.22" => { name: "Jānis Vagris", lived: "1930.10.17 -" },
    "1988.10.6" => { name: "Anatolijs Gorbunovs", lived: "1942.2.10 -" },
    "1993.7.8" => { name: "Guntis Ulmanis", lived: "1939.9.13 -" },
    "1999.7.8" => { name: "Vaira Vīķe-Freiberga", lived: "1937.12.1 -", female: true },
    "2007.7.8" => { name: "Valdis Zatlers", lived: "1955.3.22 -" },
    "2011.7.8" => { name: "Andris Bērziņš", lived: "1944.12.10 -" },
    "2015.7.8" => { name: "Raimonds Vējonis", lived: "1966.6.15 -" },
  },
  d_abkhazia: { # Circassia
    # There weren't any real rulers, so just pick someone up instead of generating fully random one
    # really lived 1777-1840 - https://en.wikipedia.org/wiki/Tuguzhuko_Kyzbech
    "1829.9.14" => { name: "Kazbech Tuguzhoko", lived: "1800-1865" },
    "1864.6.2" => nil,
  },
}

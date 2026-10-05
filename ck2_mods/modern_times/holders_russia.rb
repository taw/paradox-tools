ModernTimesDatabase::Holders.define do
  title "e_russia" do
    ruler "1645.6.12",
      name: "Aleksey | Romanov", #1
      lived: "1629.5.9 - 1676.1.29"
    ruler "1676.1.29",
      name: "Fyodor | Romanov", #1
      lived: "1661.6.9 - 1682.5.7",
      father: "Aleksey"
    ruler "1682.5.7",
      name: "Ivan | Romanov", #1
      lived: "1666.9.6 - 1696.2.8",
      father: "Aleksey"
    ruler "1682.6.2",
      name: "Pyotr | Romanov", #1
      lived: "1672.6.9 - 1725.2.8",
      father: "Aleksey"
    ruler "1725.2.8",
      name: "Yekaterina | Romanov",
      lived: "1684.4.15 - 1727.5.17",
      female: true
      # Wife of Pyotr I, Skowroński not Romanov
    character "Tsarevich Alexei",
      name: "Aleksey | Romanov",
      lived: "1690.2.28 - 1718.7.7",
      father: "Pyotr 1"
    ruler "1727.5.17",
      name: "Pyotr | Romanov", #2
      lived: "1715.10.23 - 1730.1.30",
      # Grandson of Pyotr I via the murdered Tsesarevich Alexei. Last of the direct male Romanov line.
      father: "Tsarevich Alexei"
    ruler "1730.1.30",
      name: "Anna | Romanov",
      lived: "1693.2.7 - 1740.10.28",
      female: true,
      father: "Ivan 1"
      # Daughter of Ivan V
    character "Catherine Ivanovna",
      name: "Yekaterina | Romanov",
      lived: "1691.11.8 - 1733.6.25",
      female: true,
      father: "Ivan 1"
    character "Anna Leopoldovna",
      name: "Anna | Mecklenburg",
      culture: "german",
      lived: "1718.12.18 - 1746.3.19",
      female: true,
      father: "d_mecklemburg Karl Leopold 1",
      mother: "Catherine Ivanovna"
    ruler "1740.10.28",
      name: "Ivan | Romanov", # 6
      lived: "1740.8.23 - 1764.7.16",
      # Great-grandson of Ivan V
      mother: "Anna Leopoldovna"
    ruler "1741.12.6",
      name: "Yelizaveta | Romanov",
      lived: "1709.12.29 - 1762.1.5",
      female: true,
      father: "Pyotr 1",
      mother: "Yekaterina 1"
    character "Anna Petrovna",
      name: "Anna | Romanov",
      # Sources disagree, 1728.3.15 according to some
      lived: "1708.2.7 - 1728.5.15",
      female: true,
      father: "Pyotr 1",
      mother: "Yekaterina 1"
    ruler "1762.1.5",
      name: "Pyotr | Romanov",
      lived: "1728.2.21 - 1762.7.17",
      # grandson of Peter 1
      mother: "Anna Petrovna"
    ruler "1762.7.9",
      name: "Katharina | Romanov",
      lived: "1729.5.2 - 1796.11.17",
      female: true,
      culture: "german"
      # Wife of Peter 3, coup, not real Romanov but keep it for gameplay reasons
    ruler "1796.11.17",
      name: "Pavel | Romanov",
      lived: "1754.10.1 - 1801.3.23",
      father: "Pyotr 3",
      mother: "Katharina"
    ruler "1801.3.23",
      name: "Aleksandr | Romanov",
      lived: "1777.12.23 - 1825.12.1",
      father: "Pavel 1"
    ruler "1825.12.1",
      name: "Nikolay | Romanov",
      lived: "1796.7.6 - 1855.3.2",
      father: "Pavel 1"
    ruler "1855.3.2",
      name: "Aleksandr | Romanov",
      lived: "1818.4.29 - 1881.3.13",
      father: "Nikolay 1"
    ruler "1881.3.13",
      name: "Aleksandr | Romanov",
      lived: "1845.3.10 - 1894.11.1",
      father: "Aleksandr 2"
    ruler "1894.11.1",
      name: "Nikolay | Romanov",
      lived: "1868.5.6 - 1918.7.17",
      father: "Aleksandr 3"
    # Not really ruling ever, but alternative is interregnum
    ruler "1917.3.15",
      name: "Michail | Romanov",
      lived: "1878.10.22 - 1918.6.12",
      father: "Aleksandr 3"
    # Backdating
    ruler "1918.6.12",
      name: "Vladimir | Lenin", lived: "1870.4.22 - 1924.1.21",
      traits: ["cynical"],
      health: 6
    ruler "1924.1.21",
      name: "Joseph | Stalin", lived: "1878.12.18 - 1953.3.5",
      culture: :georgian,
      health: 7,
      traits: ["ambitious", "cynical"],
      events: {
        crowning: PropertyList[
          "effect", PropertyList["set_character_flag", "horde_invader"],
          "prestige", 1000, # enough to start 2 wars
        ],
      }
    ruler "1953.3.5",
      name: "Georgy | Malenkov",
      lived: "1902.1.8 - 1988.1.14"
    ruler "1955.2.8",
      name: "Nikita | Khrushchyov",
      culture: :ukrainian,
      lived: "1894.4.15 - 1971.9.11"
    ruler "1964.10.14",
      name: "Leonid | Brezhnev",
      culture: :ukrainian,
      lived: "1906.12.19 - 1982.11.10"
    ruler "1982.11.12",
      name: "Yuri | Andropov",
      lived: "1914.6.15 - 1984.2.9"
    # backdating from 1984.2.13
    ruler "1984.2.9",
      name: "Konstantin | Chernenko",
      lived: "1911.9.24 - 1985.3.10"
    # Skipping Gennady Yanayev 3-day plot silliness
    # backdating one day
    ruler "1985.3.10",
      name: "Mikhail | Gorbachyov",
      lived: "1931.3.2 - 2022.8.30"
    ruler "1991.12.25",
      name: "Boris | Yeltsin",
      lived: "1931.2.1 - 2007.4.23",
      traits: ["drunkard"],
      health: 6
    ruler "1999.12.31",
      name: "Vladimir | Putin",
      lived: "1952.10.7 -",
      health: 6
    ruler "2008.5.7",
      name: "Dmitry | Medvedev",
      lived: "1965.9.14 -"
    ruler "2012.5.7", use: "Vladimir 2"
  end
  title "c_alania" do
    ruler :fall_soviet_union,
      name: "Dzhokhar | Dudayev",
      lived: "1944.2.15 - 1996.4.21",
      traits: ["brilliant_strategist"],
      health: 6
    ruler "1996.4.21",
      name: "Zelimkhan | Yandarbiyev",
      lived: "1952.9.12 - 2004.2.13"
    ruler "1997.2.12",
      name: "Aslan | Maskhadov",
      lived: "1951.9.21 - 2005.3.8"
    vacant :fall_chechnya
  end
  title "k_ruthenia" do
    ruler :fall_soviet_union,
      name: "Leonid | Kravchuk",
      lived: "1934.1.10 - 2022.5.10"
    ruler "1994.7.19",
      name: "Leonid | Kuchma",
      lived: "1938.8.9 -"
    ruler "2005.1.23",
      name: "Viktor | Yushchenko",
      lived: "1954.2.23 -"
    ruler "2010.2.25",
      name: "Viktor | Yanukovych",
      lived: "1950.7.9 -"
    # acting, but timing is pretty important
    ruler "2014.2.23",
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
      }
    ruler "2014.6.7",
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
      }
    ruler "2019.5.20",
      name: "Volodymyr | Zelensky",
      lived: "1978.1.25 -"
  end
  title "k_belarus" do
    # backdating from "1920.8.9"
    ruler "1918.11.11", name: "Vilgelm Knorinsh", lived: "1890 - 1939"
    # nobody has better than year date, even Belarussian wikipedia, just picking some shit up
    ruler "1923.5.1", name: "Aleksandr Osatkin-Vladimirsky", lived: "1885 - 1937"
    ruler "1924.5.13", name: "Aleksandr Krinitsky", lived: "1894 - 1937"
    # Spelled Nikolay on English wikipedia, use consistent spelling instead
    ruler "1925.12.22", name: "Nikolai Goloded", lived: "1894 - 1937"
    ruler "1927.5.7", use: "Vilgelm 1"
    ruler "1928.12.4", name: "Yakov Gamarnik", lived: "1894.6.2 - 1937.5.31"
    ruler "1930.1.3", name: "Konstantin Gey", lived: "1896 - 1939.2.25"
    # FIXME: He was azerbaijan and uzbek SSR too, wtf?
    ruler "1932.1.18", name: "Nikolay Gikalo", lived: "1897.3.8 - 1938.4.25"
    ruler "1937.3.18", name: "Vasily Sharangovich", lived: "1897 - 1938"
    ruler "1937.7.27", name: "Yakov Yakovlev", lived: "1896.6.9 - 1938.7.29"
    ruler "1937.8.11", name: "Aleksei Alekseyevich | Volkov", lived: "1890 - 1942"
    ruler "1938.6.18", name: "Panteleimon Ponomarenko", lived: "1902.8.9 - 1984.1.18"
    ruler "1947.3.7", name: "Nikolai Gusarov", lived: "1905.8.16 - 1985.3.17"
    ruler "1950.5.31", name: "Nikolai Patolichev", lived: "1908.9.10 - 1989.12.1"
    ruler "1953.3.8", name: "Mikhail Zimyanin", lived: "1914 - 1995"
    ruler "1953.6.25", use:"Nikolai 3"
    ruler "1956.7.28", name: "Kirill Mazurov", lived: "1914.3.25 - 1989.12.19"
    ruler "1965.3.30", name: "Pyotr Masherov", lived: "1918.2.26 - 1980.10.4"
    # backdating from 1980.10.15
    ruler "1980.10.4", name: "Tikhon Kiselyov", lived: "1917.8.12 - 1983.1.11"
    # backdating from 1983.1.13
    ruler "1983.1.11", name: "Nikolay Slyunkov", lived: "1929.4.26 - 2022.8.9"
    ruler "1987.2.6", name: "Yefrem Sokolov", lived: "1926.4.25 - 2022.4.3"
    ruler "1990.11.30", name: "Anatoly Malofeyev", lived: "1933.5.14 - 2022.1.19"
    ruler "1991.8.15",
      name: "Stanislav | Shushkevich",
      lived: "1934.12.15 - 2022.5.3"
    # Skipping two acting chairmen of supreme soviet, not backdating
    ruler "1994.7.20",
      name: "Aleksandr | Lukashenko",
      lived: "1954.8.30 -"
  end
  title "k_georgia" do
    # A lot of backdating
    ruler :fall_soviet_union, name: "Eduard | Shevardnadze", lived: "1928.1.25 - 2014.7.7"
    ruler "2003.11.23", name: "Mikheil | Saakashvili", lived: "1967.12.21 -"
    ruler "2013.11.17", name: "Giorgi | Margvelashvili", lived: "1969.9.4 -"
    ruler "2018.12.16", name: "Salome | Zourabichvili", lived: "1952.3.18 -", female: true
    # Legitimacy disputed by Zourabichvili and the opposition, but he is de facto president
    ruler "2024.12.29", name: "Mikheil | Kavelashvili", lived: "1971.7.22 -"
  end
  title "d_azerbaijan" do
    # actually 28 May 1918
    ruler :end_ww1, name: "Mammad Amin | Rasulzade", lived: "1884.1.31 - 1955.3.6"
    ruler "1918.12.7", name: "Alimardan | Topchubashov", lived: "1863.5.4 - 1934.11.8"
    # End date is somewhat dubious
    # Communists
    # Grigory Kaminsky started 24 October 1920, backdating a bit
    ruler "1920.5.11", name: "Grigory Kaminsky", lived: "1895.11.1 - 1938.2.10"
    ruler "1921.7.24", name: "Sergey Kirov", lived: "1886.3.27 - 1934.12.1"
    ruler "1925.1.5", name: "Ruhulla Akhundov", lived: "1897.1.1 - 1938.4.21"
    ruler "1926.1.21", name: "Levon Mirzoyan", lived: "1887.12.1 - 1939.2.26" # birth day unknown
    ruler "1929.7.11", name: "Nikolay Gikalo", lived: "1897.3.8 - 1938.4.25"
    ruler "1930.8.5", name: "Vladimir Polonsky", lived: "1893.6.17 - 1937.10.30"
    ruler "1933.2.7", name: "Ruben Rubenov", lived: "1894 - 1937.11.27"
    ruler "1933.12.10", name: "Mir Jafar | Baghirov", lived: "1896.9.17 - 1956.5.7"
    ruler "1953.4.6", name: "Mir Teymur | Yaqubov", lived: "1904.11.6 - 1970.2.17"
    ruler "1954.2.17", name: "Imam Mustafayev", lived: "1910.2.25 - 1997.3.10"
    ruler "1959.7.10", name: "Vali Akhundov", lived: "1916.5.14 - 1986.8.22"

    ruler "1969.7.14", name: "Heydar | Aliyev", lived: "1923.5.10 - 2003.12.12"
    ruler "1982.12.3", name: "Kamran Baghirov", lived: "1933.1.24 - 2000.10.25"
    ruler "1988.5.21", name: "Abdurrahman Vazirov", lived: "1930.5.26 - 2022.1.10"
    ruler "1990.1.25", name: "Ayaz Mutallibov", lived: "1938.5.12 - 2022.3.27"
    # After Communism (but still same people mostly)
    ruler "1992.6.16", name: "Abulfaz Elchibey", lived: "1938.6.24 - 2000.8.22"
    ruler "1993.10.3", use: "Heydar 1"
    ruler "2003.10.31", name: "Ilham | Aliyev", father: "Heydar 1", lived: "1961.12.24 -"
  end
  title "d_esthonia" do
    ruler "1933.10.21", name: "Konstantin Päts", lived: "1874.2.23 - 1956.1.18"
    vacant "1940.7.23"
    # Communists

    # 6 October 1992, backdating
    ruler :fall_soviet_union, name: "Lennart Georg | Meri", lived: "1929.3.29 - 2006.3.14"
    ruler "2001.10.8", name: "Arnold | Rüütel", lived: "1928.5.10 - 2024.12.31"
    ruler "2006.10.9", name: "Toomas Hendrik | Ilves", lived: "1953.12.26 -"
    ruler "2016.10.10", name: "Kersti Kaljulaid", female: true, lived: "1969.12.30 -"
    ruler "2021.10.11", name: "Alar Karis", lived: "1958.3.26 -"
  end
  title "d_lithuanians" do
    # Presidents
    # backdating from "1919.4.4"
    ruler :end_ww1, name: "Antanas Smetona", lived: "1874.8.10 - 1944.1.9"
    ruler "1920.6.19", name: "Aleksandras Stulginskis", lived: "1885.2.26 - 1969.9.22"
    ruler "1926.6.7", name: "Kazys Grinius", lived: "1866.12.17 - 1950.6.4"
    # Military
    ruler "1926.12.19", use: "Antanas 1"
    # Communist First Secretaries, backdating
    ruler "1940.6.15", name: "Antanas Sniečkus", lived: "1903.1.7 - 1974.1.22"
    ruler "1974.1.22", name: "Petras Griškevičius", lived: "1924.7.19 - 1987.11.14"
    ruler "1987.11.14", name: "Ringaudas Bronislovas | Songaila", lived: "1929.4.20 - 2019.6.25"
    ruler "1988.10.19", name: "Algirdas Mykolas | Brazauskas", lived: "1932.9.22 - 2010.6.26"
    # First as Chairman of supreme soviet, then all post-Communist
    ruler "1990.3.11", name: "Vytautas | Landsbergis", lived: "1932.10.18 -"
    ruler "1993.2.25", use: "Algirdas Mykolas 1" # Algirdas Brazauskas, returning
    ruler "1998.2.26", name: "Valdas | Adamkus", lived: "1926.11.3 -"
    ruler "2003.2.26", name: "Rolandas | Paksas", lived: "1956.6.10 -"
    # backdated to skip acting president
    ruler "2004.4.6", use: "Valdas 1"
    ruler "2009.7.12", name: "Dalia | Grybauskaite", female: true, lived: "1956.3.1 -"
    ruler "2019.7.12", name: "Gitanas | Nausėda", lived: "1964.5.19 -"
  end
  title "k_cuman" do
    ruler "1990.2.22", name: "Nursultan | Nazarbayev", lived: "1940.7.6 -"
    ruler "2019.3.20", name: "Kassym-Jomart | Tokayev", lived: "1953.5.17 -"
  end
  title "k_khiva" do # Uzbekistan
    ruler "1989.6.23", name: "Islam | Karimov", lived: "1938.1.30 - 2016.9.2"
    # backdating from 2016.9.8 (acting), elected 2016.12.4, inaugurated 2016.12.14
    ruler "2016.9.2", name: "Shavkat | Mirziyoyev", lived: "1957.7.24 -"
  end
  title "d_khuttal" do # Tajikistan
    ruler "1990.11.30", name: "Qahhor | Mahkamov", lived: "1932.4.16 - 2016.6.8"
    ruler "1991.9.23", name: "Rahmon | Nabiyev", lived: "1930.10.5 - 1993.4.11"
    ruler "1992.11.20", name: "Emomali | Rahmon", lived: "1952.10.5 -"
  end
  title "d_ferghana" do # Kyrgyzstan
    ruler "1990.10.27", name: "Askar Akayev", lived: "1944.11.10 -"
    ruler "2005.3.25", name: "Kurmanbek Bakiyev", lived: "1949.8.1 -"
    ruler "2010.4.7", name: "Roza Otunbayeva", lived: "1950.8.23 -", female: true
    ruler "2011.12.1", name: "Almazbek Atambayev", lived: "1956.9.17 -"
    ruler "2017.11.24", name: "Sooronbay Jeenbekov", lived: "1958.11.16 -"
    # Acting from 2020.10.15, skipping acting Talant Mamytov (2020.11.14 - 2021.1.28), elected 2021.1.28
    ruler "2020.10.15", name: "Sadyr Japarov", lived: "1968.12.6 -"
  end
  title "d_dihistan" do # Turkmenistan
    ruler "1958.12.14", name: "Dzhuma Durdy | Karayev", lived: "1910 - 1960.5.4"
    # backdating from "1960.6.13"
    ruler "1960.5.4", name: "Balysh Ovezov", lived: "1915 - 1975"
    ruler "1969.12.24", name: "Muhammetnazar Gapurow", lived: "1922.2.15 - 1999.7.13"
    ruler "1985.12.21", name: "Saparmurat | Niyazov", lived: "1940.2.19 - 2006.12.21"
    ruler "2006.12.21", name: "Gurbanguly | Berdimuhamedow", lived: "1957.6.29 -"
    ruler "2022.3.19", name: "Serdar | Berdimuhamedow", lived: "1981.9.22 -", father: "Gurbanguly 1"
  end
  title "d_moldau" do # Moldova
    ruler "1990.4.27", name: "Mircea Snegur", lived: "1940.1.17 - 2023.9.13"
    ruler "1997.1.15", name: "Petru Lucinschi", lived: "1940.1.27 -"
    ruler "2001.4.7", name: "Vladimir Voronin", lived: "1941.5.25 -"
    # 3 acting presidents
    ruler "2009.9.11", name: "Mihai Ghimpu", lived: "1951.11.19 -"
    ruler "2010.12.28", name: "Vladimir Filat", lived: "1969.5.6 -"
    ruler "2010.12.30", name: "Marian Lupu", lived: "1966.6.20 -"
    ruler "2012.3.23", name: "Nicolae Timofti", lived: "1948.12.22 -"
    ruler "2016.12.27", name: "Igor Dodon", lived: "1975.2.18 -"
    ruler "2020.12.24", name: "Maia Sandu", lived: "1972.5.24 -", female: true
  end
  title "d_armenia" do
    # From 11 November 1991 presidents
    ruler "1990.8.4", name: "Levon Ter-Petrossyan", lived: "1945.1.9 -"
    ruler "1998.2.4", name: "Robert Kocharyan", lived: "1954.8.31 -"
    ruler "2008.4.9", name: "Serzh Sargsyan", lived: "1954.6.30 -"
    # Since 2018 constitutional change presidency is ceremonial, real power is with Prime Minister (Nikol Pashinyan)
    ruler "2018.4.9", name: "Armen Sarkissian", lived: "1953.6.23 -"
    # backdating from 2022.3.13 to skip acting president Alen Simonyan
    ruler "2022.2.1", name: "Vahagn Khachaturyan", lived: "1959.4.22 -"
  end
  title "d_livonia" do # Latvia
    ruler :end_ww1, name: "Jānis Čakste", lived: "1859.9.14 - 1927.3.14"
    ruler "1927.3.14", name: "Gustavs Zemgals", lived: "1871.8.12 - 1939.1.6"
    ruler "1930.4.9", name: "Alberts Kviesis", lived: "1881.12.22 - 1944.8.9"
    ruler "1936.4.11", name:  "Kārlis Ulmanis", lived: "1877.9.4 - 1942.9.20"
    # Dates of both adjusted a bit so transition and occupation cooccur same day
    ruler :annexation_latvia, name: "Augusts Kirhenšteins", lived: "1872.9.18 - 1963.11.3"
    ruler "1952.4.11", name: "Kārlis Ozoliņš", lived: "1905.8.31 - 1987.8.15"
    ruler "1959.11.27", name: "Jānis Kalnbērziņš", lived: "1893.9.17 - 1986.2.4"
    ruler "1970.5.5", name: "Vitālijs Rubenis", lived: "1914.2.26 - 1994.1.2"
    ruler "1974.8.20", name: "Pēteris Strautmanis", lived: "1919.4.24 - 2007.6.27"
    ruler "1985.6.22", name: "Jānis Vagris", lived: "1930.10.17 - 2023.1.6"
    ruler "1988.10.6", name: "Anatolijs Gorbunovs", lived: "1942.2.10 -"
    ruler "1993.7.8", name: "Guntis Ulmanis", lived: "1939.9.13 -"
    ruler "1999.7.8", name: "Vaira Vīķe-Freiberga", lived: "1937.12.1 -", female: true
    ruler "2007.7.8", name: "Valdis Zatlers", lived: "1955.3.22 -"
    ruler "2011.7.8", name: "Andris Bērziņš", lived: "1944.12.10 -"
    ruler "2015.7.8", name: "Raimonds Vējonis", lived: "1966.6.15 -"
    ruler "2019.7.8", name: "Egils Levits", lived: "1955.6.30 -"
    ruler "2023.7.8", name: "Edgars Rinkēvičs", lived: "1973.9.21 -"
  end
  title "d_abkhazia" do # Circassia
    # There weren't any real rulers, so just pick someone up instead of generating fully random one
    # really lived 1777-1840 - https://en.wikipedia.org/wiki/Tuguzhuko_Kyzbech
    ruler "1829.9.14", name: "Kazbech Tuguzhoko", lived: "1800 - 1865"
    vacant "1864.6.2"
  end
end

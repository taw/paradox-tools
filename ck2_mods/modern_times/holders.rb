ModernTimesDatabase::HOLDERS = {
  # Dynasty changed names twice, but whatever
  e_britannia: {
    "1689.2.13" => {
      name: "William",
      dynasty: "Stuart",
      lived: "1650.11.4 - 1702.3.8",
    },
    # From 1 May 1707 as UK, but let's not pretend Scotland mattered before
    "1702.3.8" => {
      name: "Anne",
      dynasty: "Stuart",
      lived: "1665.2.6 - 1714.8.1",
      female: true,
    },
    "1714.8.1" => {
      name: "George",
      dynasty: "Windsor",
      lived: "1660.5.28 - 1727.6.11",
    },
    "1727.6.11" => {
      name: "George",
      dynasty: "Windsor",
      father: "George 1",
      lived: "1683.10.30 - 1760.10.25",
    },
    "1760.10.25" => {
      name: "George",
      dynasty: "Windsor",
      # grandfather: "George 2",
      lived: "1738.6.4 - 1820.1.29",
    },
    "1820.1.29" => {
      name: "George",
      dynasty: "Windsor",
      father: "George 3",
      lived: "1762.8.12 - 1830.6.26",
    },
    "1830.6.26" => {
      name: "William",
      dynasty: "Windsor",
      lived: "1765.8.21 - 1837.6.20",
      father: "George 3",
    },
    "1837.6.20" => {
      lived: "1819.5.24 - 1901.1.22",
      name: "Victoria",
      female: true,
      dynasty: "Windsor",
      # granddaughter of George 3
    },
    "1901.1.22" => {
      lived: "1841.11.9 - 1910.5.6",
      name: "Edward",
      dynasty: "Windsor",
      mother: "Victoria",
    },
    "1910.5.6" => {
      lived: "1865.6.3 - 1936.1.20",
      name: "George",
      dynasty: "Windsor",
      father: "Edward",
    },
    "1936.1.20" => {
      lived: "1894.6.23 - 1972.5.28",
      name: "Edward",
      dynasty: "Windsor",
      father: "George 5",
    },
    "1936.12.11" => {
      lived: "1895.12.14 - 1952.2.6",
      name: "George",
      dynasty: "Windsor",
      father: "George 5",
    },
    "1952.2.6" => {
      lived: "1926.4.21 -",
      name: "Elizabeth",
      dynasty: "Windsor",
      female: true,
      father: "George 6",
    },
  },
  d_brunswick: {
    congress_of_vienna: {use: "e_britannia George 3"},
    "1820.1.29" => {use: "e_britannia George 4"},
    "1830.6.26" => {use: "e_britannia William 2"},
    "1837.6.20" => {name: "Ernest Augustus", dynasty: "Windsor", lived: "1771.6.5 - 1851.11.18", father: "e_britannia George 3"},
    "1851.11.18" => {name: "George", dynasty: "Windsor", lived: "1819.5.27 - 1878.6.12", father: "Ernest Augustus 1"},
    "1866.9.20" => nil,
  },
  k_pomerania: {
    "1786.8.17" => {
      name: "Frederick William",
      dynasty: "Hohenzollern",
      lived: "1744.9.25 - 1797.11.16",
    },
    "1797.11.16" => {
      name: "Frederick William",
      dynasty: "Hohenzollern",
      lived: "1770.7.3 - 1840.6.7",
    },
    "1840.6.7" => {
      name: "Frederick William",
      dynasty: "Hohenzollern",
      lived: "1795.10.15 - 1861.1.2",
    },
    "1861.1.2" => {
      name: "Wilhelm",
      dynasty: "Hohenzollern",
      lived: "1797.3.22 - 1888.3.9",
    },
    "1871.1.18" => nil,
  },
  e_germany: {
    "1871.1.18" => { use: "k_pomerania Wilhelm 1" },
    "1888.3.9" => {
      name: "Friedrich",
      dynasty: "Hohenzollern",
      lived: "1831.10.18 - 1888.6.15",
      father: "k_pomerania Wilhelm 1",
    },
    "1888.6.15" => {
      lived: "1859.1.27 - 1941.6.4",
      name: "Wilhelm",
      dynasty: "Hohenzollern",
      father: "Friedrich 1",
    },
    # Backdate, ignore interregnum
    "1918.11.28" => {
      name: "Friedrich",
      dynasty: "Ebert",
    },
    # Ignore temporary ones
    "1925.5.12" => {
      name: "Paul",
      dynasty: "von Hindenburg", lived: "- 1934.8.2",
    },
    "1934.8.2" => {
      name: "Adolf",
      dynasty: "Hitler", lived: "- 1945.4.30",
    },
    "1945.4.30" => {
      name: "Karl",
      dynasty: "Doenitz", lived: "- 1980.12.24",
    },
    # Now this is bullshit on so many levels...
    # German "presidents" do nothing, so choosing chancellor as much more prominent person
    # Backdating a lot
    end_ww2: {
      name: "Konrad",
      dynasty: "Adenauer",
    },
    "1963.10.17" => {
      name: "Ludwig",
      dynasty: "Erhard",
    },
    "1966.12.1" => {
      name: "Kurt Georg",
      dynasty: "Kiesinger",
    },
    "1969.10.22" => {
      name: "Willy",
      dynasty: "Brandt",
    },
    "1974.5.16" => {
      name: "Helmut",
      dynasty: "Schmidt",
      lived: "1918.12.23 -",
    },
    "1982.10.1" => {
      name: "Helmut",
      dynasty: "Kohl",
      lived: "1930.4.3 -",
    },
    "1998.10.27" => {
      name: "Gerhard",
      dynasty: "Schroeder",
      lived: "1944.4.7 -",
    },
    "2005.11.22" => {
      name: "Angela",
      dynasty: "Merkel",
      female: true,
    }
  },
  e_russia: {
    "1682.6.2" => {
      name: "Peter",
      dynasty: "Romanov",
      lived: "1672.6.9 - 1725.2.8",
    },
    "1725.2.8" => {
      name: "Catherine",
      dynasty: "Romanov",
      lived: "1684.4.15 - 1727.5.17",
      female: true,
    },
    "1727.5.17" => {
      name: "Peter",
      dynasty: "Romanov",
      lived: "1715.10.23 - 1730.1.30",
    },
    "1730.1.30" => {
      name: "Anna",
      dynasty: "Romanov",
      lived: "1693.2.7 - 1740.10.28",
      female: true,
    },
    "1740.10.28" => {
      name: "Ivan",
      dynasty: "Romanov",
      lived: "1740.8.23 - 1764.7.16",
    },
    "1741.12.6" => {
      name: "Elizabeth",
      dynasty: "Romanov",
      lived: "1709.12.29 - 1762.1.5",
      female: true,
    },
    "1762.1.5" => {
      name: "Peter",
      dynasty: "Romanov",
      lived: "1728.2.21 - 1762.7.17",
    },
    "1762.7.9" => {
      name: "Catherine",
      dynasty: "Romanov",
      lived: "1729.5.2 - 1796.11.17",
      female: true,
    },
    "1796.11.17" => {
      name: "Paul",
      dynasty: "Romanov",
      lived: "1754.10.1 - 1801.3.23",
    },
    "1801.3.23" => {
      name: "Alexander",
      dynasty: "Romanov",
      lived: "1777.12.23 - 1825.12.1",
    },
    "1825.12.1" => {
      name: "Nicholas",
      dynasty: "Romanov",
      lived: "1796.7.6 - 1855.3.2",
    },
    "1855.3.2" => {
      name: "Alexander",
      dynasty: "Romanov",
      lived: "1818.4.29 - 1881.3.13",
    },
    "1881.3.13" => {
      name: "Alexander",
      dynasty: "Romanov",
      lived: "1845.3.10 - 1894.11.1",
    },
    "1894.11.1" => {
      name: "Nicholas",
      dynasty: "Romanov",
      lived: "1868.5.6 - 1918.7.17",
    },
    # Not really ruling ever, but alternative is interregnum
    "1917.3.15" => {
      name: "Michael",
      dynasty: "Romanov",
      lived: "1878.10.22 - 1918.6.12",
    },
    # Backdating
    "1918.6.12" => {
      name: "Vladimir",
      dynasty: "Lenin", lived: "- 1924.1.21",
    },
    "1924.1.21" => {
      name: "Joseph",
      dynasty: "Stalin", lived: "- 1953.3.5",
    },
    "1953.3.5" => {
      name: "Georgy",
      dynasty: "Malenkov",
    },
    "1955.2.8" => {
      name: "Nikita",
      dynasty: "Khrushchev",
    },
    "1964.10.14" => {
      name: "Leonid",
      dynasty: "Brezhnev",
    },
    "1982.10.12" => {
      name: "Yuri",
      dynasty: "Andropov",
    },
    "1984.2.13" => {
      name: "Konstantin",
      dynasty: "Chernenko"
    },
    # Skipping Gennady Yanayev 3-day plot silliness
    "1985.3.11" => {
      name: "Mikhail",
      dynasty: "Gorbachev",
    },
    "1991.12.25" => {
      name: "Boris",
      dynasty: "Yeltsin",
      lived: "1931.2.1 - 2007.4.23",
    },
    "1999.12.31" => {
      name: "Vladimir",
      dynasty: "Putin",
      lived: "1952 -",
    },
    "2008.5.7" => {
      name: "Dmitry",
      dynasty: "Medvedev",
      lived: "1965 -",
    },
    "2012.5.7" => { use: "Vladimir 2" },
  },
  k_denmark: {
    "1699.8.25" => {
      name: "Frederick",
      dynasty: "Oldenburg",
      lived: "1671.10.11 - 1730.10.12",
    },
    "1730.10.12" => {
      name: "Christian",
      dynasty: "Oldenburg",
      lived: "1699.11.30 - 1746.8.6",
    },
    "1746.8.6" => {
      name: "Frederick",
      dynasty: "Oldenburg",
      lived: "1723.3.31 - 1766.1.14",
    },
    "1766.1.14" => {
      name: "Christian",
      dynasty: "Oldenburg",
      lived: "1749.1.29 - 1808.3.13",
    },
    "1808.3.13" => {
      name: "Frederick",
      dynasty: "Oldenburg",
      lived: "1768.1.28 - 1839.12.3",
    },
    "1839.12.3" => {
      name: "Christian",
      dynasty: "Oldenburg",
      lived: "1786.9.18 - 1848.1.20",
    },
    "1848.1.20" => {
      name: "Frederick",
      dynasty: "Oldenburg",
      lived: "1808.10.6 - 1863.11.15",
    },
    "1863.11.15" => {
      name: "Christian",
      dynasty: "Schleswig-Holstein-Sonderburg-Glücksburg",
      lived: "1818.4.8 - 1906.1.29",
    },
    "1906.1.29" => {
      name: "Frederick",
      dynasty: "Schleswig-Holstein-Sonderburg-Glücksburg",
      lived: "1843.6.3 - 1912.5.14",
      father: "Christian 1",
    },
    "1912.5.14" => {
      name: "Christian",
      dynasty: "Schleswig-Holstein-Sonderburg-Glücksburg",
      lived: "1870.9.26 - 1947.4.20",
      father: "Frederick 1",
    },
    "1947.4.20" => {
      name: "Frederick",
      dynasty: "Schleswig-Holstein-Sonderburg-Glücksburg",
      lived: "1899.3.11 - 1972.1.14",
      father: "Christian 2",
    },
    "1972.1.14" => {
      name: "Margrethe",
      dynasty: "Schleswig-Holstein-Sonderburg-Glücksburg",
      female: true,
      lived: "1940.4.16 -",
      father: "Frederick 2",
    }
  },
  # Wikipedia uses these spellings, however inconsistent they are
  k_sweden: {
    "1720.3.24" => {
      name: "Frederick",
      dynasty: "Hesse",
      lived: "1676.4.23 - 1751.3.25",
    },
    "1751.3.25" => {
      name: "Adolph Frederick",
      dynasty: "Holstein-Gottorp",
      lived: "1710.5.14 - 1771.2.12",
    },
    "1771.2.12" => {
      name: "Gustav",
      dynasty: "Holstein-Gottorp",
      lived: "1746.1.24 - 1792.3.29",
      father: "Adolph Frederick 1",
    },
    "1792.3.29" => {
      name: "Gustav Adolf",
      dynasty: "Holstein-Gottorp",
      lived: "1778.11.1 - 1837.2.7",
      father: "Gustav 1",
    },
    "1809.6.6" => {
      name: "Charles",
      dynasty: "Holstein-Gottorp",
      lived: "1748.10.7 - 1818.2.5",
      father: "Adolph Frederick 1",
    },
    "1818.2.5" => {
      name: "Charles John",
      dynasty: "Bernadotte",
      lived: "1763.1.26 - 1844.3.8",
      # culture: :frankish,
      # Went Church-of-Sweden from Catholic
    },
    "1844.3.8" => {
      name: "Oscar",
      dynasty: "Bernadotte",
      lived: "1763.1.26 - 1859.7.8",
      father: "Charles John",
    },
    "1859.7.8" => {
      name: "Charles",
      dynasty: "Bernadotte",
      lived: "May 1826 - 1872.9.18",
      father: "Oscar 1"
    },
    "1872.9.18" => {
      name: "Oscar",
      dynasty: "Bernadotte",
      lived: "1829.1.21 - 1907.12.8",
      father: "Oscar 1"
    },
    "1907.12.8" => {
      name: "Gustaf",
      dynasty: "Bernadotte",
      lived: "1858.6.16 - 1950.10.29",
      father: "Oscar 2",
    },
    "1950.10.29" => {
      name: "Gustaf Adolf",
      dynasty: "Bernadotte",
      lived: "1882.11.11 - 1973.9.15",
      father: "Gustaf",
    },
    "1973.9.15" => {
      name: "Carl Gustaf",
      dynasty: "Bernadotte",
      lived: "1946.4.30 -",
      father: "Gustaf Adolf",
    },
  },
  e_persia: {
    "1785.2.18" => {
      name: "Jafar",
      dynasty: "Zand",
    },
    "1789.1.23" => {
      name: "Lotf Ali",
      dynasty: "Zand",
    },
    "1794.3.20" => {
      name: "Mohammad",
      dynasty: "Qajar",
    },
    "1797.6.17" => {
      name: "Fat'h Ali",
      dynasty: "Qajar",
    },
    "1834.10.23" => {
      name: "Mohammad",
      dynasty: "Qajar",
    },
    "1848.9.5" => {
      name: "Naser al-Din",
      dynasty: "Qajar",
    },
    "1896.5.1" => {
      name: "Mozaffar al-Din",
      dynasty: "Qajar",
    },
    "1907.1.3" => {
      name: "Mohammad Ali",
      dynasty: "Qajar",
    },
    "1909.6.16" => {
      name: "Ahmad",
      dynasty: "Qajar",
    },
    "1925.12.15" => {
      name: "Reza",
      dynasty: "Pahlavi",
    },
    "1941.9.16" => {
      name: "Mohammad Reza",
      dynasty: "Pahlavi",
    },
    "1979.2.11" => {
      name: "Ruhollah",
      dynasty: "Khomeini",
      lived: "1902.9.22 - 3 June 1989",
    },
    "1989.6.4" => {
      name: "Ali",
      dynasty: "Khamenei",
      lived: "1939.7.17 -",
    },
  },
  e_seljuk_turks: {
    "1695.2.6" => {
      name: "Mustafa",
      dynasty: "Ottoman",
    },
    "1703.8.22" => {
      name: "Ahmed",
      dynasty: "Ottoman",
    },
    "1730.10.2" => {
      name: "Mahmud",
      dynasty: "Ottoman",
    },
    "1754.12.13" => {
      name: "Osman",
      dynasty: "Ottoman",
    },
    "1757.10.30" => {
      name: "Mustafa",
      dynasty: "Ottoman",
    },
    "1774.1.21" => {
      name: "Abdulhamid",
      dynasty: "Ottoman",
    },
    "1789.4.7" => {
      name: "Selim",
      dynasty: "Ottoman",
    },
    "1807.5.29" => {
      name: "Mustafa",
      dynasty: "Ottoman",
    },
    "1808.7.28" => {
      name: "Mahmud",
      dynasty: "Ottoman",
    },
    "1839.7.1" => {
      name: "Abdulmecid",
      dynasty: "Ottoman",
    },
    "1861.6.25" => {
      name: "Abdulaziz",
      dynasty: "Ottoman",
    },
    "1876.5.30" => {
      name: "Mehmed Murad",
      dynasty: "Ottoman",
    },
    "1876.8.31" => {
      name: "Abdulhamid",
      dynasty: "Ottoman", lived: "- 1918.2.10",
    },
    "1909.4.27" => {
      name: "Mehmed",
      dynasty: "Ottoman",
    },
    "1918.7.4" => {
      name: "Mehmed",
      dynasty: "Ottoman", lived: "- 1926.5.16",
    },
    # There was a caliph Abdulmecid II for 1922-1924, consider maybe?
    # Dates are changed to fill the gaps
    "1922.11.1" => {
      name: "Mustafa Kemal",
      dynasty: "Ataturk",
    },
    "1938.11.11" => {
      name: "Ismet",
      dynasty: "Inonu",
    },
    "1950.5.22" => {
      name: "Celal",
      dynasty: "Bayar",
    },
    # Skipping National Unity Committee
    "1961.10.10" => {
      name: "Cemal",
      dynasty: "Gursel",
    },
    "1966.3.28" => {
      name: "Cevdet",
      dynasty: "Sunay",
    },
    "1973.4.6" => {
      name: "Fahri",
      dynasty: "Koruturk",
    },
    # Skipping National ecurity Council
    "1982.11.9" => {
      name: "Kenan",
      dynasty: "Evren",
      lived: "1917 - 2015",
    },
    "1989.11.9" => {
      name: "Torgut",
      dynasty: "Ozal",
      lived: "1927 - 1993",
    },
    "1993.5.16" => {
      name: "Suleyman",
      dynasty: "Demirel",
      lived: "1924 - 2015",
    },
    "2000.5.16" => {
      name: "Ahmet Necdet",
      dynasty: "Sezer",
      lived: "1941 -",
    },
    "2007.8.28" => {
      name: "Abdullah",
      dynasty: "Gul",
      lived: "1950 -",
    },
    "2014.8.28"  => {
      name: "Recep Tayyip",
      dynasty: "Erdogan",
      lived: "1954 -",
    },
  },
  k_italy: {
    "1802.6.4" => {
      name: "Victor Emmanuel",
      dynasty: "Savoy",
      lived: "1759.7.24 - 1824.1.10",
    },
    "1821.3.12" => {
      name: "Charles Felix",
      dynasty: "Savoy",
      lived: "1765.4.6 - 1831.4.27",
    },
    "1831.4.27" => {
      name: "Charles Albert",
      dynasty: "Savoy",
      lived: "1798.10.2 - 1849.3.23",
    },
    "1849.3.23" => {
      name: "Victor Emmanuel",
      dynasty: "Savoy",
      lived: "1820.3.14 - 1878.1.9",
      father: "Charles Albert 1",
    },
    "1861.3.17" => nil,
  },
  e_italy: {
    # Title created
    "1861.3.17" => { use: "k_italy Victor Emmanuel 2" },
    "1878.1.9" => {
      name: "Umberto",
      dynasty: "Savoy",
      father: "k_italy Victor Emmanuel 2",
      lived: "1844.3.14 - 1900.7.29",
    },
    "1900.7.29" => {
      name: "Victor Emmanuel",
      dynasty: "Savoy",
      father: "Umberto",
      lived: "1869.11.11 - 1947.12.28",
    },
    "1946.5.9" => {
      name: "Umberto",
      dynasty: "Savoy",
      father: "e_italy Victor Emmanuel 1",
      lived: "1904.9.15 - 1983.3.18",
    },
    # Preidents
    "1946.6.12" => {
      name: "Enrico",
      dynasty:  "De Nicola",
    },
    "1948.5.12" => {
      name: "Luigi",
      dynasty: "Einaudi",
    },
    "1955.5.11" => {
      name: "Giovanni",
      dynasty: "Gronchi",
    },
    "1962.5.11" => {
      name: "Antonio",
      dynasty: "Segni",
    },
    "1964.12.29" => {
      name: "Giuseppe",
      dynasty: "Saragat",
    },
    "1971.12.29" => {
      name: "Giovanni",
      dynasty: "Leone",
    },
    "1978.7.9" => {
      name: "Sandro",
      dynasty: "Pertini",
    },
    "1985.7.3" => {
      name: "Francesco",
      dynasty: "Cosiga",
    },
    "1992.5.28" => {
      name: "Oscar Luigi",
      dynasty: "Scalfaro",
    },
    "1999.5.18" => {
      name: "Carlo Azeglio",
      dynasty: "Ciampi",
    },
    "2006.5.15" => {
      name: "Giorgio",
      dynasty: "Napolitano",
    },
    "2015.2.3" => {
      name: "Sergio",
      dynasty: "Mattarella",
    },
  },
  e_france: {
    "1799.11.10" => {name: "Napoleon", dynasty: "Bonaparte", lived: "1769.8.15 - 1821.5.5"},
    # 7 July 1815, backdating to Congress of Vienna
    "1815.6.9"          => {name: "Louis", dynasty: "Bourbon"},
    "1824.9.16" => {name: "Charles", dynasty: "Bourbon"},
    "1830.8.9"     => {name: "Louis Philippe", dynasty: "Orléans"},
    # Second republic, second Empire from 1852.12.2
    "1848.2.24" => {name: "Napoleon", dynasty: "Bonaparte", lived: "1808.4.20 - 1873.1.9"},
    # 3rd Republic
    # Backdated, really 1871.8.31
    "1870.9.4" =>  {name: "Adolphe", dynasty: "Thiers", lived: "1797 - 1877"},
    "1873.5.24" =>  {name: "Patrice", dynasty: "de Mac-Mahon", lived: "1808 - 1893"},
    "1879.1.30" =>  {name: "Jules", dynasty: "Grévy", lived: "1807 - 1891"},
    "1887.12.3" =>  {name: "Marie François Sadi", dynasty: "Carnot", lived: "1837 - 1894"},
    "1894.6.27" =>  {name: "Jean", dynasty: "Casimir-Perier", lived: "1847 - 1907"},
    "1895.1.17" =>  {name: "Félix", dynasty: "Faure", lived: "1841 - 1899"},
    "1899.2.18" =>  {name: "Émile", dynasty: "Loubet", lived: "1838 - 1929"},
    "1906.2.18" =>  {name: "Armand", dynasty: "Fallières", lived: "1841 - 1931"},
    "1913.2.18" =>  {name: "Raymond", dynasty: "Poincaré", lived: "1860 - 1934"},
    "1920.2.18" =>  {name: "Paul", dynasty: "Deschanel", lived: "1855 - 1922"},
    "1920.9.23" =>  {name: "Alexandre", dynasty: "Millerand", lived: "1859 - 1943"},
    "1924.6.13" =>  {name: "Gaston", dynasty: "Doumergue", lived: "1863 - 1937"},
    "1931.6.13" =>  {name: "Paul", dynasty: "Doumer", lived: "1857 - 1932"},
    "1932.5.10" =>  {name: "Albert", dynasty: "Lebrun", lived: "1871 - 1950"},
    # Vichy
    "1940.7.11"=>{name: "Philippe", dynasty: "Pétain", lived: "1856 - 1951"},
    # 4th Republic
    # 1947.1.16, backdated
    end_ww2: {name: "Vincent", dynasty: "Auriol", lived: "1884 - 1966"},
    "1954.1.16"=>{name: "René", dynasty: "Coty", lived: "1882 - 1962"},
    # 5th Republic
    "1959.1.8"=>{name: "Charles", dynasty: "de Gaulle", lived: "1890 - 1970"},
    "1969.6.20"=>{name: "Georges", dynasty: "Pompidou", lived: "1911 - 1974"},
    "1974.5.27"=>{name: "Valéry Giscard", dynasty: "d'Estaing", lived: "1926 -"},
    "1981.5.21"=>{name: "François", dynasty: "Mitterrand", lived: "1916 - 1996"},
    "1995.5.17"=>{name: "Jacques", dynasty: "Chirac", lived: "1932 -"},
    "2007.5.16"=>{name: "Nicolas", dynasty: "Sarkozy", lived: "1955 -"},
    "2012.5.15"=>{name: "François", dynasty: "Hollande", lived: "1954 -"},
  },
  e_india: {
    "1947.8.15"   => {name: "Jawharlal", dynasty: "Nehru", lived: "1889 - 1964"},
    "1964.6.9"    => {name: "Lal Bahadur", dynasty: "Shatri", lived: "1904 - 1966"},
    "1966.1.24"   => {name: "Indira", dynasty: "Gandhi", lived: "1917 - 1984", female: true},
    "1977.3.24"   => {name: "Morarji", dynasty: "Desai", lived: "1896 - 1995"},
    "1979.7.28"   => {name: "Charan", dynasty: "Singh", lived: "1902 - 1987"},
    "1980.1.14"   => {use: "Indira 1"},
    "1984.10.31"  => {name: "Rajiv", dynasty: "Gandhi", lived: "1944 - 1991"},
    "1989.12.2"   => {name: "Vishwanath Pratap", dynasty: "Singh", lived: "1931.6.25 - 2008.11.27"},
    "1990.11.10"  => {name: "Chandra", dynasty: "Shekhar", lived: "1927 - 2007"},
    "1991.6.21"   => {name: "Pamulaparti Venkata Narasimha", dynasty: "Rao", lived: "1921 - 2004"},
    "1996.5.16"   => {name: "Atal Bihari", dynasty: "Vajpayee", lived: "1924 -"},
    "1996.6.1"    => {name: "Haradanahalli Doddegowda Deve", dynasty: "Gowda", lived: "1933.5.18 -"},
    "1997.4.21"   => {name: "Inder Kumar", dynasty: "Gujral", lived: "1919.12.4 - 2012.11.30"},
    "1998.3.19"   => {use: "Atal Bihari 1"},
    "2004.5.22"   => {name: "Manmohan", dynasty: "Singh", lived: "1932 -"},
    "2014.5.26"   => {name: "Narendra", dynasty: "Modi", lived: "1950 -"},
  },
  e_spain: {
    "1665.9.17"   => {name: "Charles", dynasty: "Habsburg", lived: "1661.11.6 - 1700.11.1"},
    "1700.11.1"  => {name: "Philip", dynasty: "Bourbon"},
    "1724.1.14"   => {name: "Louis", dynasty: "Bourbon", father: "Philip 1"},
    "1724.9.6"    => {use: "Philip 1"},
    "1746.7.9"    => {name: "Ferdinand", dynasty: "Bourbon", father: "Philip 1"},
    "1759.8.10"   => {name: "Charles", dynasty: "Bourbon", father: "Philip 1"},
    "1788.12.14"  => {name: "Charles", dynasty: "Bourbon", father: "Charles 2"},
    "1808.3.19"   => {name: "Ferdinand", dynasty: "Bourbon", father: "Charles 3"},
    "1808.6.6"    => {name: "Joseph", dynasty: "Bonaparte"},
    "1813.12.11"  => {use: "Ferdinand 2"},
    "1833.9.29"   => {name: "Isabella", dynasty: "Bourbon", female: true, father: "Ferdinand 2"},
    "1870.11.16"  => {name: "Amadeo", dynasty: "Savoy", lived: "1845.5.30 - 1890.1.18"},
    "1874.12.29"  => {name: "Alfonso", dynasty: "Bourbon", lived: "1857.11.28 - 1885.11.25"},
    # Birth backdated hard as posthumous, actual 1886.5.17
    "1885.11.25"  => {name: "Alfonso", dynasty: "Bourbon", lived: "1885.11.25 - 1941.2.28"},
    # Simplify republic
    "1931.4.14"   => {name: "Niceto", dynasty: "Alcalá-Zamora", lived: "1877.7.6 - 1949.2.18"},
    "1936.10.1"   => {name: "Francisco", dynasty: "Franco", lived: "1892.12.4 - 1975.11.20"},
    "1975.11.20"  => {name: "Juan Carlos", dynasty: "Bourbon", lived: "1938.1.5 -"},
    "2014.6.19"   => {name: "Felipe", dynasty: "Bourbon", lived: "1968.1.30 -"},
  },
  e_carpathia: {
    "1804.8.11"  => {name: "Francis", dynasty: "Habsburg", lived: "1768.2.12 - 1835.3.2"},
    "1835.3.2"   => {name: "Ferdinand", dynasty: "Habsburg", lived: "1793.4.19 - 1875.6.29"},
    # Can't find day date, just month
    "1848.12.1"  => {name: "Francis Joseph", dynasty: "Habsburg", lived: "1830.8.18 - 1916.11.21"},
    "1916.11.21" => {name: "Charles", dynasty: "Habsburg", lived: "1911.10.21 - 1922.4.1"},
    "1918.11.11" => nil,
  },
  k_bavaria: {
    # Backfill
    "1918.11.11" => {name: "Karl", dynasty: "Seitz"},
    "1920.12.9"  => {name: "Michael", dynasty: "Hainisch"},
    "1928.12.10" => {name: "Wilhelm", dynasty: "Miklas"},
    anschluss: nil,
    end_ww2: {name: "Karl", dynasty: "Renner", lived: "- 1950.12.31"},
    # Backfill, predecessor died in office
    "1950.12.31" => {name: "Theodor", dynasty: "Körner", lived: "- 1957.1.4"},
    # Backfill, predecessor died in office
    "1957.1.4" => {name: "Adolf", dynasty: "Schärf", lived: "- 1965.2.28"},
    # Backfill, predecessor died in office
    "1965.2.28" => {name: "Fratz", dynasty: "Jonas"},
    # Backfill, predecessor died in office
    "1974.7.8" => {name: "Rudolf", dynasty: "Kirchschläger"},
    "1986.7.8" => {name: "Kurt", dynasty: "Waldheim"},
    "1992.7.8" => {name: "Thomas", dynasty: "Klestil"},
    # Backfill, predecessor died in office, why the fuck do they keep electing barely alive presidents?
    "2004.7.8" => {name: "Heinz", dynasty: "Fischer"},
  },
  k_lanka: {
    # Prime Ministers
    # Supposedly started 1947.9.24, postdating to 1948.2.4
    :sri_lanka_independence => {name: "Don Stephen", dynasty: "Senanayake", lived: "1884 - 1952"},
    "1952.3.26" => {name: "Dudley", dynasty: "Senanayake", lived: "1911 - 1973"},
    "1953.10.12" => {name: "John", dynasty: "Kotelawala", lived: "1897 - 1980"},
    "1956.4.12" => {name: "Solomon", dynasty: "Bandaranaike", lived: "1899 - 1959"},
    "1959.9.26" => {name: "Wijeyananda", dynasty: "Dahanayake", lived: "1902 - 1997"},
    "1960.3.21" => {use: "Dudley 1"},
    "1960.7.21" => {name: "Sirimavo", dynasty: "Bandaranaike", lived: "1916 - 2000", female: true},
    "1965.3.25" => {use: "Dudley 1"},
    "1970.5.29" => {use: "Sirimavo 1"}, # She continues next term after presidency established as prime minister, but that no longer matters
    # Presidency established
    "1972.5.22" => {name: "William", dynasty: "Gopallawa", lived: "1897 - 1981"},
    "1978.2.4" => {name: "Junius Richard", dynasty: "Jayewardene", lived: "1906 - 1996"},
    "1989.1.2" => {name: "Ranasinghe", dynasty: "Premadasa", lived: "1924 - 1993"},
    "1993.5.1" => { name: "Dingiri Banda", dynasty: "Wijetunga", lived: "1916 - 2008" },
    "1994.11.12" => {name: "Chandrika", dynasty: "Kumaratunga", lived: "1945-", female: true },
    "2005.11.19" => {name: "Mahinda", dynasty: "Rajapaksa", lived: "1945-" },
    "2015.1.9" => {name: "Maithripala", dynasty: "Sirisena", lived: "1951-" },
  },
  k_croatia: {
    croatia_independence: {name: "Franjo", dynasty: "Tudman", lived: "1922 - 1999"},
    # Backdated from 18 February 2000, skipping two active presidents
    "1999.12.10" => {name: "Stjepan", dynasty: "Mesic", lived: "1934-" },
    "2010.2.19" => {name: "Ivo", dynasty: "Josipovic", lived: "1957-" },
    "2015.2.19" => {name: "Kolinda", dynasty: "Grabar-Kitarovic", female: true, lived: "1968-"},
  },
  k_cuman: {
    fall_soviet_union: {name: "Nursultan", dynasty: "Nazarbayev", lived: "1940.7.6-"},
  },
  k_khiva: {
    fall_soviet_union: {name: "Islam", dynasty: "Karimov", lived: "1938.1.30-"},
  },
  d_dihistan: {
    fall_soviet_union: {name: "Saparmurat", dynasty: "Niyazov", lived: "1940.2.19 - 2006.12.21"},
    "2006.12.21" => {name: "Gurbanguly", dynasty: "Berdimuhamedow", lived: "1957.6.29-"},
  },
  k_frisia: {
    "1815.3.16" => {name: "William", dynasty: "Orange-Nassau", lived: "1772.8.24 - 1843.12.12"},
    "1840.10.7" => {name: "William", dynasty: "Orange-Nassau", father: "William 1", lived: "1792.12.6 - 1849.3.17"},
    "1849.3.17" => {name: "William", dynasty: "Orange-Nassau", father: "William 2", lived: "1817.2.19 - 1890.11.23"},
    "1890.11.23" => {name: "Wilhelmina", dynasty: "Orange-Nassau", father: "William 3", female: true, lived: "1880.8.31 - 1962.11.28"},
    "1948.9.4" => {name: "Juliana", dynasty: "Orange-Nassau", mother: "Wilhelmina 1", female: true, lived: "1909.4.30 - 2004.3.20"},
    "1980.4.30" => {name: "Beatrix", dynasty: "Orange-Nassau", mother: "Juliana 1", female: true, lived: "1938.1.31 -"},
    "2013.4.30" => {name: "William-Alexander", dynasty: "Orange-Nassau", mother: "Beatrix 1", lived: "1967.4.27-"},
  },
  d_flanders: {
    belgium_independence: {name: "Leopold", dynasty: "Saxe-Coburg and Gotha", lived: "1790.12.16 - 1865.12.10"},
    "1865.12.10" => {name: "Leopold", dynasty: "Saxe-Coburg and Gotha", father: "Leopold 1", lived: "1835.4.9 - 1909.12.17"},
    # nephew of Leopold 2, can't model that yet
    "1909.12.17" => {name: "Albert", dynasty: "Saxe-Coburg and Gotha", lived: "1875.4.8 - 1934.2.17"},
    "1934.2.17" => {name: "Leopold", dynasty: "Saxe-Coburg and Gotha", father: "Albert 1", lived: "1901.11.3 - 1983.9.25"},
    "1951.7.17" => {name: "Baudouin", dynasty: "Saxe-Coburg and Gotha", father: "Leopold 3", lived: "1930.9.7 - 1993.7.31"},
    "1993.7.31" => {name: "Albert", dynasty: "Saxe-Coburg and Gotha", father: "Leopold 3", lived: "1934.6.6 -"},
    "2013.7.21" => {name: "Philippe", dynasty: "Saxe-Coburg and Gotha", father: "Albert 2", lived: "1960.4.15-"},
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
    "1905.6.7"   => {name: "Haakon", dynasty: "Schleswig-Holstein-Sonderburg-Glücksburg", lived: "1872.8.3 - 1957.9.21"},
    "1957.9.21"  => {name: "Olav", dynasty: "Schleswig-Holstein-Sonderburg-Glücksburg", father: "Haakon 1", lived: "1903.7.2 - 1991.1.17"},
    "1991.1.17"  => {name: "Harald", dynasty: "Schleswig-Holstein-Sonderburg-Glücksburg", father: "Olav 1", lived: "1937.2.21 -"},
  },
  d_nefoud: {
    "1902.1.13" => {name: "Abdulaziz", dynasty: "Saud", lived: "1876.11.26 - 1953.11.9"},
    end_ww1: nil,
  },
  k_arabia: {
    # "Emirate of Nejd and Hasa" etc., maybe I should differentiate those titles
    # It's total bullshit backdating before "1902.1.13" when he got first duchy
    end_ww1: {use: "d_nefoud Abdulaziz 1" },
    "1953.11.9" => {name: "Saud", dynasty: "Saud", father: "d_nefoud Abdulaziz 1", lived: "1902.1.12 - 1969.2.23"},
    "1964.11.2" => {name: "Faisal", dynasty: "Saud", father: "d_nefoud Abdulaziz 1", lived: "1906.4.14 - 1975.3.25"},
    "1975.3.25" => {name: "Khalid", dynasty: "Saud", father: "d_nefoud Abdulaziz 1", lived: "1913.2.13 - 1982.6.13"},
    "1982.6.13" => {name: "Fahd", dynasty: "Saud", father: "d_nefoud Abdulaziz 1", lived: "1921.3.16 - 2005.8.1"},
    "2005.8.1" => {name: "Abdullah", dynasty: "Saud", father: "d_nefoud Abdulaziz 1", lived: "1924.8.1 - 2015.1.23"},
    "2015.1.23" => {name: "Salman", dynasty: "Saud", father: "d_nefoud Abdulaziz 1", lived: "1935.12.31 -"},
  },
  c_kuwait: {
    kuwait_independence: {name: "Abdullah Salem Al-Mubarak", dynasty: "Al-Sabah", lived: "1895 - 1965"},
    "1965.11.24" => {name: "Sabah Salem Al-Mubarak", dynasty: "Al-Sabah", lived: "1913 - 1977"},
    "1977.12.31" => {name: "Jaber Al-Ahmad Al-Jaber", dynasty: "Al-Sabah", lived: "1926 - 2006"},
    "2006.1.15" => {name: "Saad Abdullah Al-Salem", dynasty: "Al-Sabah", lived: "1930 - 2008"},
    "2006.1.29" => {name: "Sabah Al-Ahmad Al-Jaber", dynasty: "Al-Sabah", lived: "1929 -"},
  },
  c_alania: {
    fall_soviet_union: {
      name: "Dzhokhar", dynasty: "Dudayev",
      lived: "1944.2.15 - 1996.4.21",
    },
    "1996.4.21" => {
      name: "Zelimkhan", dynasty: "Yandarbiyev",
      lived: "1952.9.12 - 2004.2.13",
    },
    "1997.2.12" => {
      name: "Aslan", dynasty: "Maskhadov",
      lived: "1951.9.21 - 2005.3.8",
    },
    fall_chechnya: nil,
  },
  k_ruthenia: {
    fall_soviet_union: {
      name: "Leonid", dynasty: "Kravchuk",
      lived: "1934.1.10 -",
    },
    "1994.7.19" => {
      name: "Leonid", dynasty: "Kuchma",
      lived: "1938.8.9 -",
    },
    "2005.1.23" => {
      name: "Viktor", dynasty: "Yushchenko",
      lived: "1954.2.23 -",
    },
    "2010.2.25" => {
      name: "Viktor", dynasty: "Yanukovych",
      lived: "1950.7.9 -",
    },
    # acting, but timing is pretty important
    "2014.2.23" => {
      name: "Oleksandr", dynasty: "Turchynov",
      lived: "31 March 1964 -",
    },
    "2014.6.7" => {
      name: "Petro", dynasty: "Poroshenko",
      lived: "1965.9.26 -",
    },
  },
  d_vitebsk: {
    fall_soviet_union: {
      name: "Stanislav", dynasty: "Shushkevich",
      lived: "1934.12.15 -",
    },
    # Skipping two acting chairmen of supreme soviet, not backdating
    "1994.7.20" => {
      name: "Alexander",
      dynasty: "Lukashenko",
      lived: "1954.8.30 -",
    }
  },
  d_luxembourg: {
    "1890.11.23" => {
      name: "Adolphe",
      lived: "1817.7.24 - 1905.11.17",
    },
    "1905.11.17" => {
      name: "Guillaume",
      lived: "1852.4.22 - 1912.2.25",
      father: "Adolphe",
    },
    "1912.2.25" => {
      name: "Marie-Adelaide",
      lived: "1894.6.14 - 1924.1.24",
      female: true,
    },
    "1919.1.14" => {
      name: "Charlotte",
      lived: "1896.1.23 - 1985.7.9",
      female: true,
    },
    "1964.11.12" => {
      name: "Jean",
      lived: "1921.1.5 -",
      mother: "Charlotte",
    },
    "2000.10.7" => {
      name: "Henri",
      lived: "1955.4.16 -",
      father: "Jean",
    },
  },
  d_lithuanians: {
    # From 11 March 1990, chairman of supreme soviet
    fall_soviet_union: {name: "Vytautas", dynasty: "Landsbergis"},
    "1993.2.25" => {name: "Algirdas", dynasty: "Brazauskas"},
    "1998.2.26" => {name: "Valdas", dynasty: "Adamkus"},
    "2003.2.26" => {name: "Rolandas", dynasty: "Paksas"},
    # backdated to skip acting president
    "2004.4.6" => {use: "Valdas 1"},
    "2009.7.12" => {name: "Dalia", dynasty: "Grybauskaite", female: true},
  },
  d_nyitra: {
    # 2 March 1993, backdating
    "1993.1.1" => {name: "Michal", dynasty: "Kovac"},
    # 15 June 1999, backdating
    "1998.3.2" => {name: "Rudolf", dynasty: "Schuster"},
    "2004.6.15" => {name: "Ivan", dynasty: "Gasparovic"},
    "2014.6.15" => {name: "Andrej", dynasty: "Kiska"},
  },
  k_georgia: {
    # A lot of backdating
    fall_soviet_union: {name: "Eduard", dynasty: "Shevardnadze", lived: "1928.1.25 - 2014.7.7"},
    "2003.11.23" => {name: "Mikheil", dynasty: "Saakashvili", lived: "1967.12.21 -"},
    "2013.11.17" => {name: "Giorgi", dynasty: "Margvelashvili", lived: "1969.9.4-"}
  },
  d_azerbaijan: {
    # actually 28 May 1918
    end_ww1: {name: "Mammad Amin", dynasty: "Rasulzade"},
    "1918.12.7" => {name: "Alimardan", dynasty: "Topchubashov"},
    # End date is somewhat dubious
    "1920.5.11" => nil,
    # 3 October 1993, backdating, but Heydar Aliyev was sort of leader of Azerbaijan since 1969
    fall_soviet_union: { name: "Heydar", dynasty: "Aliyev", lived: "1923.5.10 - 2003.12.12" },
    "2003.10.31" => { name: "Ilham", dynasty: "Aliyev", father: "Heydar 1", lived: "1961.12.24-" },
  },
  d_esthonia: {
    # 6 October 1992, backdating
    fall_soviet_union: {name: "Lennart Georg", dynasty: "Meri"},
    "2001.10.8" => {name: "Arnold", dynasty: "Rüütel"},
    "2006.10.9" => {name: "Toomas Hendrik", dynasty: "Ilves"},
  },
  k_poland: {
    end_ww1: {name: "Jozef", dynasty: "Pilsudski", lived: "1867.12.5 - 1935.5.12"},
    "1922.12.11" => {name: "Gabriel", dynasty: "Narutowicz", lived: "1865.3.17 - 1922.12.16"},
    "1922.12.16" => {name: "Stanislaw", dynasty: "Wojciechowski", lived: "1869.3.15 - 1953.4.9"},
    # Not officially, but everybody knows who ruled
    "1926.5.14" => {use: "Jozef 1"},
    "1935.5.12" => {name: "Ignacy", dynasty: "Moscicki", lived: "1867.12.1 - 1946.10.2"},
    # government in exile
    "1939.9.30" => {name: "Wladyslaw", dynasty: "Raczkiewicz", lived: "1885.1.28 - 1947.6.6"},

    # Communist Poland had no clear head of state, by design
    # First secretaries, except Jaruzelski gets to keep his post during transition
    # December 22, 1948, backdating
    end_ww2: {name: "Boleslaw", dynasty: "Bierut", lived: "1892.4.18 - 1956.3.12"},
    "1956.3.12" => {name: "Edward", dynasty: "Ochab", lived: "1906.8.16 - 1989.5.1"},
    "1956.10.21" => {name: "Wladyslaw", dynasty: "Gomulka", lived: "1905.2.6 - 1982.9.1"},
    "1970.12.20" => {name: "Edward", dynasty: "Gierek", lived: "1913.1.6 - 2001.7.29"},
    "1980.9.6" => {name: "Stanislaw", dynasty: "Kania", lived: "1927.3.8 -"},
    "1981.10.18" => {name: "Wojciech", dynasty: "Jaruzelski", lived: "1923.7.6 - 2014.5.25"},
    "1990.12.22" => {name: "Lech", dynasty: "Walesa", lived: "1943.9.29 -"},
    "1995.12.23" => {name: "Aleksander", dynasty: "Kwasniewski", lived: "1954.11.15 -"},
    "2005.12.23" => {name: "Lech", dynasty: "Kaczynski", lived: "1949.6.18 - 2010.4.10"},
    # acting, then actual, skipping other acting presidents
    "2010.4.10" => {name: "Bronislaw", dynasty: "Komorowski", lived: "1952.6.4 -"},
    "2015.8.6" => {name: "Andrzej", dynasty: "Duda", lived: "1972.5.16 -"},
  },
  k_mesopotamia: {
    "1958.7.14" => {name: "Muhammad Najib", dynasty: "ar-Ruba'i", lived: "1904 - 1965"},
    "1963.2.8" => {name: "Abdul Salam", dynasty: "Arif", lived: "1921.3.21 - 1966.4.13"},
    # brother of previous
    "1966.4.13"=> {name: "Abdul Rahman", dynasty: "Arif", lived: "1916.4.14 - 2007.8.24"},
    "1968.7.17" => {name: "Ahmed Hassan", dynasty: "al-Bakr", lived: "1914.7.1 - 1982.10.4"},
    "1979.7.16" => {name: "Saddam", dynasty: "Hussein", lived: "1937.4.28 - 2006.12.30"},
    # Backdating hard
    "2003.4.9" => {name: "Jalal", dynasty: "Talabani", lived: "1933.11.12-"},
    "2014.7.24" => {name: "Fuad", dynasty: "Masum", lived: "1938.1.1-"},
  },
  k_syria: {
    "1971.2.22" => {name: "Hafez", dynasty: "al-Assad", lived: "1930.10.6 - 2000.6.10"},
    "2000.6.10" => {name: "Bashar", dynasty: "al-Assad", lived: "1965.9.11-", father: "Hafez 1"},
  },
  # Backdating everybody to their predecessor's death / resignation
  k_papal_state: {
    "1799.8.29" => {
      name: "Pius", dynasty: "Chiaramonti",
      lived: "1742.8.14 - 1823.8.20",
    },
    "1823.8.20" => {
      name: "Leo", dynasty: "della Genga",
      lived: "1760.8.22 - 1829.2.10",
    },
    "1829.2.10" => {
      name: "Pius", dynasty: "Castiglioni",
      lived: "1761.11.20 - 1830.11.30",
    },
    "1830.11.30" => {
      name: "Gregory", dynasty: "Cappellari",
      lived: "1765.9.18 - 1846.6.1",
    },
    "1846.6.1" => {
      name: "Pius", dynasty: "Mastai-Ferretti",
      lived: "1792.5.13 - 1878.2.7",
    },
    "1878.2.7" => {
      name: "Leo", dynasty: "Pecci",
      lived: "1810.3.2 - 1903.7.20",
    },
    "1903.7.20" => {
      name: "Pius", dynasty: "Sarto",
      lived: "1835.6.2 - 1914.8.20",
    },
    "1914.8.20" => {
      name: "Benedict", dynasty: "della Chiesa",
      lived: "1854.11.21 - 1922.1.22",
    },
    "1922.1.22" => {
      name: "Pius", dynasty: "Ratti",
      lived: "1857.5.31 - 1939.2.10",
    },
    "1939.2.10" => {
      name: "Pius", dynasty: "Pacelli",
      lived: "1876.3.2 - 1958.10.9",
    },
    "1958.10.9" => {
      name: "John", dynasty: "Roncalli",
      lived: "1881.11.25 - 1963.6.3",
    },
    "1963.6.3" => {
      name: "Paul", dynasty: "Montini",
      lived: "1897.9.26 - 1978.8.6",
    },
    "1978.8.6" => {
      name: "John Paul", dynasty: "Luciani",
      lived: "1912.10.17 - 1978.9.28",
    },
    "1978.9.28" => {
      name: "John Paul", dynasty: "Wojtyla",
      culture: :polish,
      lived: "1920.5.18 - 2005.4.2",
    },
    "2005.4.2" => {
      name: "Benedict", dynasty: "Ratzinger",
      culture: :german,
      lived: "1927.4.16 -", # Popes, abdicating? WTF is this?
    },
    "2013.2.28" => {
      name: "Francis", dynasty: "Bergoglio",
      culture: :castillan,
      lived: "1936.12.17 -",
    },
  },
  d_krete: {
    # 21 December 1898, backdating to foundation
    "1898.12.13" => {
      # He's a royal but it was High Commissioner post
      name: "George",
      dynasty: "Schleswig-Holstein-Sonderburg-Glücksburg",
      lived: "1869.6.24 - 1957.11.25",
    },
    "1906.10.1" => {
      name: "Alexandros",
      dynasty: "Zaimis",
      lived: "1855.11.9 - 1936.9.15",
    },
    "1913.5.30" => nil,
  },
  d_bavaria: {
    "1679.5.26" => {
      name: "Maximilian Emanuel",
      dynasty: "Wittelsbach",
    },
    "1726.2.26" => {
      name: "Charles Albert",
      dynasty: "Wittelsbach",
    },
    "1745.1.20" => {
      name: "Maximilian Joseph",
      dynasty: "Wittelsbach",
    },
    "1777.12.30" => {
      name: "Charles Theodore",
      dynasty: "Wittelsbach",
    },
    "1799.2.16" => {
      name: "Maximilian",
      dynasty: "Wittelsbach",
    },
    "1825.10.13" => {
      name: "Ludwig",
      dynasty: "Wittelsbach",
    },
    "1848.3.20" => {
      name: "Maximilian",
      dynasty: "Wittelsbach",
    },
    "1864.3.10" => {
      name: "Ludwig",
      dynasty: "Wittelsbach",
    },
    german_unification: nil,
    # They continued as German vassals until end of WW1
  },
  d_saxony: {
    "1763.12.17" => {
      name: "Frederick Augustus",
      dynasty: "Wettin",
      lived: "1750.12.23 - 1827.5.5",
    },
    "1827.5.5" => {
      name: "Anthon",
      dynasty: "Wettin",
      lived: "1755.12.27 - 1836.6.6",
    },
    "1836.6.6" => {
      name: "Frederick Augustus",
      dynasty: "Wettin",
      lived: "1797.5.18 - 1854.8.9",
    },
    "1854.8.9" => {
      name: "John",
      dynasty: "Wettin",
      lived: "1801.12.12 - 1873.10.29",
    },
    german_unification: nil,
    # They continued as German vassals until end of WW1
  },
  # There was actually Hesse-Kassel and Hesse-Darmstandt
  d_franconia: {
    "1813.10.30" => {
      name: "William",
      dynasty: "Hesse",
      lived: "1743.6.3 - 1821.2.27",
    },
    "1821.2.27" => {
      name: "William",
      dynasty: "Hesse",
      lived: "1777.7.28 - 1847.11.20",
    },
    "1847.11.20" => {
      name: "Frederick William",
      dynasty: "Hesse",
      lived: "1802.8.20 - 1875.1.6",
    },
    prussia_annexes_hannover: nil,
  },
  k_sicily: {
    "1816.12.12" => {
      name: "Ferdinand",
      dynasty: "Bourbon",
      lived: "1751.1.12 - 1825.1.4",
    },
    "1825.1.4" => {
      name: "Francis",
      dynasty: "Bourbon",
      lived: "1777.8.14 - 1830.11.8",
      father: "Ferdinand 1",
    },
    "1830.11.8" => {
      name: "Ferdinand",
      dynasty: "Bourbon",
      lived: "1810.1.12 - 1859.5.22",
      father: "Francis 1",
    },
    "1859.5.22" => {
      name: "Francis",
      dynasty: "Bourbon",
      lived: "1836.1.16 - 1894.12.27",
      father: "Ferdinand 2",
    },
    italy_unification: nil,
  },
  c_parma: {
    "1814.4.11" => {
      name: "Marie Louise",
      dynasty: "Habsburg",
      lived: "1791.12.12 - 1847.12.17",
      female: true,
    },
    "1847.12.17" => {
      name: "Charles",
      dynasty: "Bourbon",
      lived: "1799.12.22 - 1883.4.16",
      mother: "Marie Louise 1",
    },
    "1849.5.17" => {
      name: "Charles",
      dynasty: "Bourbon",
      lived: "1823.1.14 - 1854.3.27",
      father: "Charles 1",
    },
    "1854.3.27" => {
      name: "Robert",
      dynasty: "Bourbon",
      lived: "1848.7.9 - 1907.11.16",
      father: "Charles 1",
    },
    italy_unification: nil,
  },
  d_carinthia: {
    # Backdating, actually 23 December 1991
    "1991.7.7" => {
      name: "Milan",
      dynasty: "Kucan",
    },
    "2002.12.22" => {
      name: "Janez",
      dynasty: "Drnovsek",
    },
    "2007.12.23" => {
      name: "Danilo",
      dynasty: "Türk",
    },
    "2012.12.22" => {
      name: "Borut",
      dynasty: "Pahor",
    },
  },
  d_oultrejourdain: {
    "1921.4.1" => {
      name: "Abdullah",
      dynasty: "Hashemite",
      lived: "1882.2.1 - 1951.7.20",
      traits: ["sayyid"],
    },
    "1951.7.20" => {
      name: "Talal",
      dynasty: "Hashemite",
      lived: "1909.2.26 - 1972.7.7",
      father: "Abdullah 1",
      traits: ["sayyid"],
    },
    "1952.8.11" => {
      name: "Hussein",
      dynasty: "Hashemite",
      lived: "1935.11.14 - 1999.2.7",
      father: "Talal 1",
      traits: ["sayyid"],
    },
    "1999.2.7" => {
      name: "Abdullah",
      dynasty: "Hashemite",
      lived: "1962.1.30-",
      father: "Hussein 1",
      traits: ["sayyid"],
    },
  },
  d_sunni: {
    "1695.2.6" => { use: "e_seljuk_turks Mustafa 1" },
    "1703.8.22" => { use: "e_seljuk_turks Ahmed 1" },
    "1730.10.2" => { use: "e_seljuk_turks Mahmud 1" },
    "1754.12.13" => { use: "e_seljuk_turks Osman 1" },
    "1757.10.30" => { use: "e_seljuk_turks Mustafa 2" },
    "1774.1.21" => { use: "e_seljuk_turks Abdulhamid 1" },
    "1789.4.7" => { use: "e_seljuk_turks Selim 1" },
    "1807.5.29" => { use: "e_seljuk_turks Mustafa 3" },
    "1808.7.28" => { use: "e_seljuk_turks Mahmud 2" },
    "1839.7.1" => { use: "e_seljuk_turks Abdulmecid 1" },
    "1861.6.25" => { use: "e_seljuk_turks Abdulaziz 1" },
    "1876.5.30" => { use: "e_seljuk_turks Mehmed Murad 1" },
    "1876.8.31" => { use: "e_seljuk_turks Abdulhamid 2" },
    "1909.4.27" => { use: "e_seljuk_turks Mehmed 1" },
    "1918.7.4" => { use: "e_seljuk_turks Mehmed 2" },
    "1922.11.1" => nil,
    caliphate_reborn: {
      name: "Abu Bakr",
      dynasty: "al-Baghdadi",
      lived: "1971.7.28-",
      traits: ["cruel", "zealous"],
      events: {
        caliphate_reborn: PropertyList[
          "effect", PropertyList[
            "spawn_unit", PropertyList[
              "province", 711, # Sinjar
              "owner", "ROOT",
              "troops", PropertyList[
                "light_infantry", [1385, 1385],
                "heavy_infantry", [1220, 1220],
                "archers", [610, 610],
                "light_cavalry", [270, 270],
              ],
              "attrition", 0.5,
            ],
            "spawn_unit", PropertyList[
              "province", 711, # Sinjar
              "owner", "ROOT",
              "troops", PropertyList[
                "light_infantry", [1385, 1385],
                "heavy_infantry", [1220, 1220],
                "archers", [610, 610],
                "light_cavalry", [270, 270],
              ],
              "attrition", 0.5,
            ],
            "spawn_unit", PropertyList[
              "province", 711, # Sinjar
              "owner", "ROOT",
              "troops", PropertyList[
                "light_infantry", [1385, 1385],
                "heavy_infantry", [1220, 1220],
                "archers", [610, 610],
                "light_cavalry", [270, 270],
              ],
              "attrition", 0.5,
            ],
          ],
        ],
      },
    },
  },
}

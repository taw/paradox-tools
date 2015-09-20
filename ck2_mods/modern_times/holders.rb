ModernTimesDatabase::HOLDERS = {
  # Dynasty changed names twice, but whatever
  e_britannia: {
    "1689.2.13" => {
      name: "William",
      dynasty: "Stuart",
      birth: "1650.11.4",
      death: "1702.3.8",
    },
    # From 1 May 1707 as UK, but let's not pretend Scotland mattered before
    "1702.3.8" => {
      name: "Anne",
      dynasty: "Stuart",
      birth: "1665.2.6",
      death: "1714.8.1",
      female: true,
    },
    "1714.8.1" => {
      name: "George",
      dynasty: "Windsor",
      birth: "1660.5.28",
      death: "1727.6.11",
    },
    "1727.6.11" => {
      name: "George",
      dynasty: "Windsor",
      father: "George 1",
      birth: "1683.10.30",
      death: "1760.10.25",
    },
    "1760.10.25" => {
      name: "George",
      dynasty: "Windsor",
      # grandfather: "George 2",
      birth: "1738.6.4",
      death: "1820.1.29",
    },
    "1820.1.29" => {
      name: "George",
      dynasty: "Windsor",
      father: "George 3",
      birth: "1762.8.12",
      death: "1830.6.26",
    },
    "1830.6.26" => {
      name: "William",
      dynasty: "Windsor",
      birth: "1765.8.21",
      death: "1837.6.20",
      father: "George 3",
    },
    "1837.6.20" => {
      birth: "1819.5.24",
      death: "1901.1.22",
      name: "Victoria",
      female: true,
      dynasty: "Windsor",
      # granddaughter of George 3
    },
    "1901.1.22" => {
      birth: "1841.11.9",
      death: "1910.5.6",
      name: "Edward",
      dynasty: "Windsor",
      mother: "Victoria",
    },
    "1910.5.6" => {
      birth: "1865.6.3",
      death: "1936.1.20",
      name: "George",
      dynasty: "Windsor",
      father: "Edward",
    },
    "1936.1.20" => {
      birth: "1894.6.23",
      death: "1972.5.28",
      name: "Edward",
      dynasty: "Windsor",
      father: "George 5",
    },
    "1936.12.11" => {
      birth: "1895.12.14",
      death: "1952.2.6",
      name: "George",
      dynasty: "Windsor",
      father: "George 5",
    },
    "1952.2.6" => {
      birth: "1926.4.21",
      death: :never,
      name: "Elizabeth",
      dynasty: "Windsor",
      female: true,
      father: "George 6",
    },
  },
  e_germany: {
    "18 January 1871" => {
      name: "Wilhelm",
      dynasty: "Hohenzollern",
      birth: "22 March 1797",
      death: "9 March 1888",
    },
    "9 March 1888" => {
      name: "Friedrich",
      dynasty: "Hohenzollern",
      birth: "18 October 1831",
      death: "15 June 1888",
      father: "Wilhelm 1",
    },
    "1888.6.15" => {
      birth: "1859.1.27",
      death: "1941.6.4",
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
      dynasty: "von Hindenburg",
      death: "1934.8.2",
    },
    "1934.8.2" => {
      name: "Adolf",
      dynasty: "Hitler",
      death: "1945.4.30",
    },
    "1945.4.30" => {
      name: "Karl",
      dynasty: "Doenitz",
      death: "1980.12.24",
    },
    # Now this is bullshit on so many levels...
    # German "presidents" do nothing, so choosing chancellor as much more prominent person
    # Backdating a lot
    "1945.5.23" => {
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
      birth: "1918.12.23",
    },
    "1982.10.1" => {
      name: "Helmut",
      dynasty: "Kohl",
      birth: "1930.4.3",
    },
    "1998.10.27" => {
      name: "Gerhard",
      dynasty: "Schroeder",
      birth: "1944.4.7",
    },
    "2005.11.22" => {
      name: "Angela",
      dynasty: "Merkel",
      female: true,
    }
  },
  e_russia: {
    "2 June 1682" => {
      name: "Peter",
      dynasty: "Romanov",
      birth: "9 June 1672",
      death: "8 February 1725",
    },
    "8 February 1725" => {
      name: "Catherine",
      dynasty: "Romanov",
      birth: "15 April 1684",
      death: "17 May 1727",
      female: true,
    },
    "17 May 1727" => {
      name: "Peter",
      dynasty: "Romanov",
      birth: "23 October 1715",
      death: "30 January 1730",
    },
    "30 January 1730" => {
      name: "Anna",
      dynasty: "Romanov",
      birth: "7 February 1693",
      death: "28 October 174",
      female: true,
    },
    "28 October 1740" => {
      name: "Ivan",
      dynasty: "Romanov",
      birth: "23 August 1740",
      death: "16 July 1764",
    },
    "6 December 1741" => {
      name: "Elizabeth",
      dynasty: "Romanov",
      birth: "29 December 1709",
      death: "5 January 1762",
      female: true,
    },
    "9 January 1762" => {
      name: "Peter",
      dynasty: "Romanov",
      birth: "21 February 1728",
      death: "17 July 1762",
    },
    "9 July 1762" => {
      name: "Catherine",
      dynasty: "Romanov",
      birth: "2 May 1729",
      death: "17 November 1796",
      female: true,
    },
    "17 November 1796" => {
      name: "Paul",
      dynasty: "Romanov",
      birth: "1 October 1754",
      death: "23 March 1801",
    },
    "23 March 1801" => {
      name: "Alexander",
      dynasty: "Romanov",
      birth: "23 December 1777",
      death: "1 December 1825",
    },
    "1 December 1825" => {
      name: "Nicholas",
      dynasty: "Romanov",
      birth: "6 July 1796",
      death: "2 March 1855",
    },
    "2 March 1855" => {
      name: "Alexander",
      dynasty: "Romanov",
      birth: "29 April 1818",
      death: "13 March 1881",
    },
    "13 March 1881" => {
      name: "Alexander",
      dynasty: "Romanov",
      birth: "10 March 1845",
      death: "1 November 1894",
    },
    "1894.11.1" => {
      name: "Nicholas",
      dynasty: "Romanov",
      birth: "1868.5.6",
      death: "1918.7.17",
    },
    # Not really ruling ever, but alternative is interregnum
    "1917.3.15" => {
      name: "Michael",
      dynasty: "Romanov",
      birth: "1878.10.22",
      death: "1918.6.12",
    },
    # Backdating
    "1918.6.12" => {
      name: "Vladimir",
      dynasty: "Lenin",
      death: "1924.1.21",
    },
    "1924.1.21" => {
      name: "Joseph",
      dynasty: "Stalin",
      death: "1953.3.5",
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
      birth: "1931.2.1",
      death: "2007.4.23",
    },
    "1999.12.31" => {
      name: "Vladimir",
      dynasty: "Putin",
      birth: "1952",
    },
    "2008.5.7" => {
      name: "Dmitry",
      dynasty: "Medvedev",
      birth: "1965",
    },
    "2012.5.7" => { use: "Vladimir 2" },
  },
  k_denmark: {
    "1863.11.29" => {
      name: "Christian",
      dynasty: "Schleswig-Holstein-Sonderburg-Glücksburg",
      birth: "1818.4.8",
      death: "1906.1.29",
    },
    "1906.1.29" => {
      name: "Frederick",
      dynasty: "Schleswig-Holstein-Sonderburg-Glücksburg",
      birth: "1843.6.3",
      death: "1912.5.14",
      father: "Christian 1",
    },
    "1912.5.14" => {
      name: "Christian",
      dynasty: "Schleswig-Holstein-Sonderburg-Glücksburg",
      birth: "1870.9.26",
      death: "1947.4.20",
      father: "Frederick 1",
    },
    "1947.4.20" => {
      name: "Frederick",
      dynasty: "Schleswig-Holstein-Sonderburg-Glücksburg",
      birth: "1899.3.11",
      death: "1972.1.14",
      father: "Christian 2",
    },
    "1972.1.14" => {
      name: "Margrethe",
      dynasty: "Schleswig-Holstein-Sonderburg-Glücksburg",
      female: true,
      birth: "1940.4.16",
      death: :never,
      father: "Frederick 2",
    }
  },
  k_sweden: {
    "1818.2.5" => {
      name: "Charles John",
      dynasty: "Bernadotte",
      birth: "1763.1.26",
      death: "1844.3.8",
      culture: :frankish,
      # Went Church of Sweden from Catholic
    },
    "1844.3.8" => {
      name: "Oscar",
      dynasty: "Bernadotte",
      birth: "1763.1.26",
      death: "1859.7.8",
      father: "Charles John",
    },
    "1859.7.8" => {
      name: "Charles",
      dynasty: "Bernadotte",
      birth: "May 1826",
      death: "1872.9.8",
      father: "Oscar 1"
    },
    "1872.9.18" => {
      name: "Oscar",
      dynasty: "Bernadotte",
      birth: "1829.1.21",
      death: "1907.12.8",
      father: "Oscar 1"
    },
    "1907.12.8" => {
      name: "Gustaf",
      dynasty: "Bernadotte",
      birth: "1858.6.16",
      death: "1950.10.29",
      father: "Oscar 2",
    },
    "1950.10.29" => {
      name: "Gustaf Adolf",
      dynasty: "Bernadotte",
      birth: "1882.11.11",
      death: "1973.9.15",
      father: "Gustaf",
    },
    "1973.9.15" => {
      name: "Carl Gustaf",
      dynasty: "Bernadotte",
      birth: "1946.4.30",
      father: "Gustaf Adolf",
    },
  },
  e_persia: {
    "18 February 1785" => {
      name: "Jafar",
      dynasty: "Zand",
    },
    "23 January 1789" => {
      name: "Lotf Ali",
      dynasty: "Zand",
    },
    "20 March 1794" => {
      name: "Mohammad",
      dynasty: "Qajar",
    },
    "17 June 1797" => {
      name: "Fat'h Ali",
      dynasty: "Qajar",
    },
    "23 October 1834" => {
      name: "Mohammad",
      dynasty: "Qajar",
    },
    "5 September 1848" => {
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
      birth: "1902.9.22",
    },
    "1989.6.4" => {
      name: "Ali",
      dynasty: "Khamenei",
      birth: "1939.7.17",
    },
  },
  e_seljuk_turks: {
    "6 February 1695" => {
      name: "Mustafa",
      dynasty: "Ottoman",
    },
    "22 August 1703" => {
      name: "Ahmed",
      dynasty: "Ottoman",
    },
    "2 October 1730" => {
      name: "Mahmud",
      dynasty: "Ottoman",
    },
    "13 December 1754" => {
      name: "Osman",
      dynasty: "Ottoman",
    },
    "30 October 1757" => {
      name: "Mustafa",
      dynasty: "Ottoman",
    },
    "21 January 1774" => {
      name: "Abdulhamid",
      dynasty: "Ottoman",
    },
    "7 April 1789" => {
      name: "Selim",
      dynasty: "Ottoman",
    },
    "29 May 1807" => {
      name: "Mustafa",
      dynasty: "Ottoman",
    },
    "28 July 1808" => {
      name: "Mahmud",
      dynasty: "Ottoman",
    },
    "1 July 1839" => {
      name: "Abdulmecid",
      dynasty: "Ottoman",
    },
    "25 June 1861" => {
      name: "Abdulaziz",
      dynasty: "Ottoman",
    },
    "30 May 1876" => {
      name: "Mehmed Murad",
      dynasty: "Ottoman",
    },
    "1876.8.31" => {
      name: "Abdulhamid",
      dynasty: "Ottoman",
      death: "1918.2.10",
    },
    "1909.4.27" => {
      name: "Mehmed",
      dynasty: "Ottoman",
    },
    "1918.7.4" => {
      name: "Mehmed",
      dynasty: "Ottoman",
      death: "1926.5.16",
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
      birth: "1917",
      death: "2015",
    },
    "1989.11.9" => {
      name: "Torgut",
      dynasty: "Ozal",
      birth: "1927",
      death: "1993",
    },
    "1993.5.16" => {
      name: "Suleyman",
      dynasty: "Demirel",
      birth: "1924",
      death: "2015",
    },
    "2000.5.16" => {
      name: "Ahmet Necdet",
      dynasty: "Sezer",
      birth: "1941",
    },
    "2007.8.28" => {
      name: "Abdullah",
      dynasty: "Gul",
      birth: "1950",
    },
    "2014.8.28"  => {
      name: "Recep Tayyip",
      dynasty: "Erdogan",
      birth: "1954",
    },
  },
  e_italy: {
    # Title created
    "1861.3.17" => {
      name: "Victor Emmanuel",
      dynasty: "Savoy",
      birth: "1820.3.14",
      death: "1878.1.9",
    },
    "1878.1.9" => {
      name: "Umberto",
      dynasty: "Savoy",
      father: "Victor Emmanuel 1",
      birth: "1844.3.14",
      death: "1900.7.29",
    },
    "1900.7.29" => {
      name: "Victor Emmanuel",
      dynasty: "Savoy",
      father: "Umberto",
      birth: "1869.11.11",
      death: "1947.12.28",
    },
    "1946.5.9" => {
      name: "Umberto",
      dynasty: "Savoy",
      father: "Victor Emmanuel 2",
      birth: "1904.9.15",
      death: "1983.3.18",
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
    "10 November 1799" => {name: "Napoleon", dynasty: "Bonaparte", birth: "15 August 1769", death: "5 May 1821"},
    # 7 July 1815, backdating to Congress of Vienna
    "1815.6.9"          => {name: "Louis", dynasty: "Bourbon"},
    "16 September 1824" => {name: "Charles", dynasty: "Bourbon"},
    "9 August 1830"     => {name: "Louis Philippe", dynasty: "Orléans"},
    # Second republic, second Empire from 1852.12.2
    "24 February 1848" => {name: "Napoleon", dynasty: "Bonaparte", birth: "20 April 1808", death: "9 January 1873"},
    # 3rd Republic
    # Backdated, really 1871.8.31
    "4 September 1870" =>  {name: "Adolphe", dynasty: "Thiers", birth: "1797", death: "1877"},
    "1873.5.24" =>  {name: "Patrice", dynasty: "de Mac-Mahon", birth: "1808", death: "1893"},
    "1879.1.30" =>  {name: "Jules", dynasty: "Grévy", birth: "1807", death: "1891"},
    "1887.12.3" =>  {name: "Marie François Sadi", dynasty: "Carnot", birth: "1837", death: "1894"},
    "1894.6.27" =>  {name: "Jean", dynasty: "Casimir-Perier", birth: "1847", death: "1907"},
    "1895.1.17" =>  {name: "Félix", dynasty: "Faure", birth: "1841", death: "1899"},
    "1899.2.18" =>  {name: "Émile", dynasty: "Loubet", birth: "1838", death: "1929"},
    "1906.2.18" =>  {name: "Armand", dynasty: "Fallières", birth: "1841", death: "1931"},
    "1913.2.18" =>  {name: "Raymond", dynasty: "Poincaré", birth: "1860", death: "1934"},
    "1920.2.18" =>  {name: "Paul", dynasty: "Deschanel", birth: "1855", death: "1922"},
    "1920.9.23" =>  {name: "Alexandre", dynasty: "Millerand", birth: "1859", death: "1943"},
    "1924.6.13" =>  {name: "Gaston", dynasty: "Doumergue", birth: "1863", death: "1937"},
    "1931.6.13" =>  {name: "Paul", dynasty: "Doumer", birth: "1857", death: "1932"},
    "1932.5.10" =>  {name: "Albert", dynasty: "Lebrun", birth: "1871", death: "1950"},
    # Vichy
    "1940.7.11"=>{name: "Philippe", dynasty: "Pétain", birth: "1856", death: "1951"},
    # 4th Republic
    "1947.1.16"=>{name: "Vincent", dynasty: "Auriol", birth: "1884", death: "1966"},
    "1954.1.16"=>{name: "René", dynasty: "Coty", birth: "1882", death: "1962"},
    # 5th Republic
    "1959.1.8"=>{name: "Charles", dynasty: "de Gaulle", birth: "1890", death: "1970"},
    "1969.6.20"=>{name: "Georges", dynasty: "Pompidou", birth: "1911", death: "1974"},
    "1974.5.27"=>{name: "Valéry Giscard", dynasty: "d'Estaing", birth: "1926"},
    "1981.5.21"=>{name: "François", dynasty: "Mitterrand", birth: "1916", death: "1996"},
    "1995.5.17"=>{name: "Jacques", dynasty: "Chirac", birth: "1932"},
    "2007.5.16"=>{name: "Nicolas", dynasty: "Sarkozy", birth: "1955"},
    "2012.5.15"=>{name: "François", dynasty: "Hollande", birth: "1954"},
  },
  e_india: {
    "1947.8.15"  => {name: "Jawharlal", dynasty: "Nehru", birth: "1889", death: "1964"},
    "1964.6.9"     => {name: "Lal Bahadur", dynasty: "Shatri", birth: "1904", death: "1966"},
    "1966.1.24" => {name: "Indira", dynasty: "Gandhi", birth: "1917", death: "1984", female: true},
    "1977.3.24"   => {name: "Morarji", dynasty: "Desai", birth: "1896", death: "1995"},
    "1979.7.28"    => {name: "Charan", dynasty: "Singh", birth: "1902", death: "1987"},
    "1980.1.14" => {use: "Indira 1"},
    "1984.10.31" => {name: "Rajiv", dynasty: "Gandhi", birth: "1944", death: "1991"},
    "1989.12.2" => {name: "Vishwanath Pratap", dynasty: "Singh", birth: "1931.6.25", death: "2008.11.27"},
    "1990.11.10"=> {name: "Chandra", dynasty: "Shekhar", birth: "1927", death: "2007"},
    "1991.6.21"    => {name: "Pamulaparti Venkata Narasimha", dynasty: "Rao", birth: "1921", death: "2004"},
    "1996.5.16"     => {name: "Atal Bihari", dynasty: "Vajpayee", birth: "1924", death: :never},
    "1996.6.1"     => {name: "Haradanahalli Doddegowda Deve", dynasty: "Gowda", birth: "1933.5.18", death: :never},
    "1997.4.21"   => {name: "Inder Kumar", dynasty: "Gujral", birth: "1919.12.4", death: "2012.11.30"},
    "1998.3.19"   => {use: "Atal Bihari 1"},
    "2004.5.22"     => {name: "Manmohan", dynasty: "Singh", birth: "1932", death: :never},
    "2014.5.26"     => {name: "Narendra", dynasty: "Modi", birth: "1950", death: :never},
  },
  e_spain: {
    "1665.9.17" => {name: "Charles", dynasty: "Habsburg", birth: "1661.11.6", death: "1700.11.1"},
    "1700.11.16"  => {name: "Philip", dynasty: "Bourbon"},
    "1724.1.14"   => {name: "Louis", dynasty: "Bourbon", father: "Philip 1"},
    "1724.9.6"  => {use: "Philip 1"},
    "1746.7.9"       => {name: "Ferdinand", dynasty: "Bourbon", father: "Philip 1"},
    "1759.8.10"    => {name: "Charles", dynasty: "Bourbon", father: "Philip 1"},
    "1788.12.14"  => {name: "Charles", dynasty: "Bourbon", father: "Charles 2"},
    "1808.3.19"     => {name: "Ferdinand", dynasty: "Bourbon", father: "Charles 3"},
    "1808.6.6"       => {name: "Joseph", dynasty: "Bonaparte"},
    "1813.12.11"  => {use: "Ferdinand 2"},
    "1833.9.29" => {name: "Isabella", dynasty: "Bourbon", female: true, father: "Ferdinand 2"},
    "1870.11.16" => {name: "Amadeo", dynasty: "Savoy", birth: "1845.5.30", death: "1890.1.18"},
    "1874.12.29" => {name: "Alfonso", dynasty: "Bourbon", birth: "1857.11.28", death: "1885.11.25"},
    "1886.5.17"      => {name: "Alfonso", dynasty: "Bourbon", birth: "1886.5.17", death: "1941.2.28"},
    # Simplify republic
    "1931.4.14"    => {name: "Niceto", dynasty: "Alcalá-Zamora", birth: "1877.7.6", death: "1949.2.18"},
    "1936.10.1"   => {name: "Francisco", dynasty: "Franco", birth: "December 4, 1892", death: "November 20, 1975"},
    "1975.11.22" => {name: "Juan Carlos", dynasty: "Bourbon", birth: "1938.1.5", death: :never},
    "2014.6.19"     => {name: "Felipe", dynasty: "Bourbon", birth: "1968.1.30", death: :never},
  },
  e_carpathia: {
    "1804.8.11" => {name: "Francis", dynasty: "Habsburg", birth: "1768.2.12", death: "1835.3.2"},
    "1835.3.2"   => {name: "Ferdinand", dynasty: "Habsburg", birth: "1793.4.19", death: "1875.6.29"},
    # Can't find day date, just month
    "1848.12.1" => {name: "Francis Joseph", dynasty: "Habsburg", birth: "1830.8.18", death: "1916.11.21"},
    "1916.11.21" => {name: "Charles", dynasty: "Habsburg", birth: "1911.10.21", death: "1922.4.1"},
    # Backfill
  },
  k_bavaria: {
    "1918.11.11" => {name: "Karl", dynasty: "Seitz"},
    "1920.12.9"  => {name: "Michael", dynasty: "Hainisch"},
    "1928.12.10" => {name: "Wilhelm", dynasty: "Miklas"},
    anschluss: nil,
    end_ww2: {name: "Karl", dynasty: "Renner", death: "1950.12.31"},
    # Backfill, predecessor died in office
    "1950.12.31" => {name: "Theodor", dynasty: "Körner", death: "1957.1.4"},
    # Backfill, predecessor died in office
    "1957.1.4" => {name: "Adolf", dynasty: "Schärf", death: "1965.2.28"},
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
    :sri_lanka_independence => {name: "Don Stephen", dynasty: "Senanayake", birth: "1884", death: "1952"},
    "1952.3.26" => {name: "Dudley", dynasty: "Senanayake", birth: "1911", death: "1973"},
    "1953.10.12" => {name: "John", dynasty: "Kotelawala", birth: "1897", death: "1980"},
    "1956.4.12" => {name: "Solomon", dynasty: "Bandaranaike", birth: 1899, death: 1959},
    "1959.9.26" => {name: "Wijeyananda", dynasty: "Dahanayake", birth: "1902", death: "1997"},
    "1960.3.21" => {use: "Dudley 1"},
    "1960.7.21" => {name: "Sirimavo", dynasty: "Bandaranaike", birth: "1916", death: "2000", female: true},
    "1965.3.25" => {use: "Dudley 1"},
    "1970.5.29" => {use: "Sirimavo 1"}, # She continues next term after presidency established as prime minister, but that no longer matters
    # Presidency established
    "1972.5.22" => {name: "William", dynasty: "Gopallawa", birth: 1897, death: 1981},
    "1978.2.4" => {name: "Junius Richard", dynasty: "Jayewardene", birth: 1906, death: 1996},
    "1989.1.2" => {name: "Ranasinghe", dynasty: "Premadasa", birth: 1924, death: 1993},
    "1993.5.1" => { name: "Dingiri Banda", dynasty: "Wijetunga", birth: "1916", death: "2008" },
    "1994.11.12" => {name: "Chandrika", dynasty: "Kumaratunga", birth: "1945", female: true },
    "2005.11.19" => {name: "Mahinda", dynasty: "Rajapaksa", birth: "1945" },
    "2015.1.9" => {name: "Maithripala", dynasty: "Sirisena", birth: "1951" },
  },
  k_croatia: {
    croatia_independence: {name: "Franjo", dynasty: "Tudman", birth: "1922", death: "1999"},
    # Backdated from 18 February 2000, skipping two active presidents
    "1999.12.10" => {name: "Stjepan", dynasty: "Mesic", birth: "1934" },
    "2010.2.19" => {name: "Ivo", dynasty: "Josipovic", birth: "1957" },
    "2015.2.19" => {name: "Kolinda", dynasty: "Grabar-Kitarovic", female: true, birth: 1968},
  },
  k_cuman: {
    fall_soviet_union: {name: "Nursultan", dynasty: "Nazarbayev", birth: "1940.7.6"},
  },
  k_khiva: {
    fall_soviet_union: {name: "Islam", dynasty: "Karimov", birth: "January 30, 1938"},
  },
  d_dihistan: {
    fall_soviet_union: {name: "Saparmurat", dynasty: "Niyazov", birth: "1940.2.19", death: "2006.12.21"},
    "2006.12.21" => {name: "Gurbanguly", dynasty: "Berdimuhamedow", birth: "June 29, 1957"},
  },
  k_frisia: {
    "1815.3.16" => {name: "William", dynasty: "Orange-Nassau", birth: "1772.8.24", death: "1843.12.12"},
    "1840.10.7" => {name: "William", dynasty: "Orange-Nassau", father: "William 1", birth: "1792.12.6", death: "1849.3.17"},
    "1849.3.17" => {name: "William", dynasty: "Orange-Nassau", father: "William 2", birth: "1817.2.19", death: "1890.11.23"},
    "1890.11.23" => {name: "Wilhelmina", dynasty: "Orange-Nassau", father: "William 3", female: true, birth: "1880.8.31", death: "1962.11.28"},
    "1948.9.4" => {name: "Juliana", dynasty: "Orange-Nassau", mother: "Wilhelmina 1", female: true, birth: "1909.4.30", death: "2004.3.20"},
    "1980.4.30" => {name: "Beatrix", dynasty: "Orange-Nassau", mother: "Juliana 1", female: true, birth: "1938.1.31", death: :never},
    "2013.4.30" => {name: "William-Alexander", dynasty: "Orange-Nassau", mother: "Beatrix 1", birth: "1967.4.27"},
  },
  d_flanders: {
    belgium_independence: {name: "Leopold", dynasty: "Saxe-Coburg and Gotha", birth: "1790.12.16", death: "1865.12.10"},
    "1865.12.10" => {name: "Leopold", dynasty: "Saxe-Coburg and Gotha", father: "Leopold 1", birth: "1835.4.9", death: "1909.12.17"},
    # nephew of Leopold 2, can't model that yet
    "1909.12.17" => {name: "Albert", dynasty: "Saxe-Coburg and Gotha", birth: "1875.4.8", death: "1934.2.17"},
    "1934.2.17" => {name: "Leopold", dynasty: "Saxe-Coburg and Gotha", father: "Albert 1", birth: "1901.11.3", death: "1983.9.25"},
    "1951.7.17" => {name: "Baudouin", dynasty: "Saxe-Coburg and Gotha", father: "Leopold 3", birth: "1930.9.7", death: "1993.7.31"},
    "1993.8.9" => {name: "Albert", dynasty: "Saxe-Coburg and Gotha", father: "Leopold 3", birth: "1934.6.6", death: :never},
    "2013.7.21" => {name: "Philippe", dynasty: "Saxe-Coburg and Gotha", father: "Albert 2", birth: "1960.4.15"},
  },
  k_norway: {
    norway_independence: {name: "Haakon", dynasty: "Schleswig-Holstein-Sonderburg-Glücksburg", birth: "1872.8.3", death: "1957.9.21"},
    "1957.9.21" => {name: "Olav", dynasty: "Schleswig-Holstein-Sonderburg-Glücksburg", father: "Haakon 1", birth: "1903.7.2", death: "1991.1.17"},
    "1991.1.17" => {name: "Harald", dynasty: "Schleswig-Holstein-Sonderburg-Glücksburg", father: "Olav 1", birth: "1937.2.21", death: :never},
  },
  d_nefoud: {
    start: {name: "Abdulaziz", dynasty: "Saud", birth: "1876.11.26", death: "1953.11.9"},
  },
  k_arabia: {
    # "Emirate of Nejd and Hasa" etc., maybe I should differentiate those titles
    # It's total bullshit backdating before "1902.1.13" when he got first duchy
    end_ww1: {use: "d_nefoud Abdulaziz 1" },
    "1953.11.9" => {name: "Saud", dynasty: "Saud", father: "d_nefoud Abdulaziz 1", birth: "1902.1.12", death: "1969.2.23"},
    "1964.11.2" => {name: "Faisal", dynasty: "Saud", father: "d_nefoud Abdulaziz 1", birth: "1906.4.14", death: "1975.3.25"},
    "1975.3.25" => {name: "Khalid", dynasty: "Saud", father: "d_nefoud Abdulaziz 1", birth: "1913.2.13", death: "1982.6.13"},
    "1982.6.13" => {name: "Fahd", dynasty: "Saud", father: "d_nefoud Abdulaziz 1", birth: "1921.3.16", death: "2005.8.1"},
    "2005.8.1" => {name: "Abdullah", dynasty: "Saud", father: "d_nefoud Abdulaziz 1", birth: "1924.8.1", death: "2015.1.23"},
    "2015.1.23" => {name: "Salman", dynasty: "Saud", father: "d_nefoud Abdulaziz 1", birth: "1935.12.31", death: :never},
  },
  c_kuwait: {
    kuwait_independence: {name: "Abdullah Salem Al-Mubarak", dynasty: "Al-Sabah", birth: "1895", death: "1965"},
    "1965.11.24" => {name: "Sabah Salem Al-Mubarak", dynasty: "Al-Sabah", birth: "1913", death: "1977"},
    "1977.12.31" => {name: "Jaber Al-Ahmad Al-Jaber", dynasty: "Al-Sabah", birth: "1926", death: "2006"},
    "2006.1.15" => {name: "Saad Abdullah Al-Salem", dynasty: "Al-Sabah", birth: "1930", death: "2008"},
    "2006.1.29" => {name: "Sabah Al-Ahmad Al-Jaber", dynasty: "Al-Sabah", birth: "1929", death: :never},
  },
  c_alania: {
    fall_soviet_union: {
      name: "Dzhokhar", dynasty: "Dudayev",
      birth: "15 February 1944", death: "21 April 1996",
    },
    "21 April 1996" => {
      name: "Zelimkhan", dynasty: "Yandarbiyev",
      birth: "September 12, 1952", death: "February 13, 2004",
    },
    "February 12, 1997" => {
      name: "Aslan", dynasty: "Maskhadov",
      birth: "21 September 1951", death: "8 March 2005",
    },
  },
  k_ruthenia: {
    fall_soviet_union: {
      name: "Leonid", dynasty: "Kravchuk",
      birth: "January 10, 1934", death: :never,
    },
    "19 July 1994" => {
      name: "Leonid", dynasty: "Kuchma",
      birth: "9 August 1938", death: :never,
    },
    "23 January 2005" => {
      name: "Viktor", dynasty: "Yushchenko",
      birth: "February 23, 1954", death: :never,
    },
    "25 February 2010" => {
      name: "Viktor", dynasty: "Yanukovych",
      birth: "9 July 1950", death: :never,
    },
    # acting, but timing is pretty important
    "23 February 2014" => {
      name: "Oleksandr", dynasty: "Turchynov",
      birth: " 31 March 1964", death: :never,
    },
    "7 June 2014" => {
      name: "Petro", dynasty: "Poroshenko",
      birth: "26 September 1965", death: :never,
    },
  },
  d_vitebsk: {
    fall_soviet_union: {
      name: "Stanislav", dynasty: "Shushkevich",
      birth: "December 15, 1934", death: :never,
    },
    # Skipping two acting chairmen of supreme soviet, not backdating
    "20 July 1994" => {
      name: "Alexander",
      dynasty: "Lukashenko",
      birth: "30 August 1954",
      death: :never,
    }
  },
  # Backdating everybody to their predecessor's death / resignation
  k_papal_state: {
    "20 July 1903" => {
      name: "Pius", dynasty: "Sarto",
      birth: "2 June 1835",
      death: "20 August 1914",
    },
    "20 August 1914" => {
      name: "Benedict", dynasty: "della Chiesa",
      birth: "21 November 1854",
      death: "22 January 1922",
    },
    "22 January 1922" => {
      name: "Pius", dynasty: "Ratti",
      birth: "31 May 1857",
      death: "10 February 1939",
    },
    "10 February 1939" => {
      name: "Pius", dynasty: "Pacelli",
      birth: "2 March 1876",
      death: "9 October 1958",
    },
    "9 October 1958" => {
      name: "John", dynasty: "Roncalli",
      birth: "25 November 1881",
      death: "3 June 1963",
    },
    "3 June 1963" => {
      name: "Paul", dynasty: "Montini",
      birth: "26 September 1897",
      death: "6 August 1978",
    },
    "6 August 1978" => {
      name: "John Paul", dynasty: "Luciani",
      birth: "17 October 1912",
      death: "28 September 1978",
    },
    "28 September 1978" => {
      name: "John Paul", dynasty: "Wojtyla",
      culture: :polish,
      birth: "18 May 1920",
      death: "2 April 2005",
    },
    "2 April 2005" => {
      name: "Benedict", dynasty: "Ratzinger",
      culture: :german,
      birth: "16 April 1927",
      death: :never, # Popes, abdicating? WTF is this?
    },
    "28 February 2013" => {
      name: "Francis", dynasty: "Bergoglio",
      culture: :castillan,
      birth: "17 December 1936",
      death: :never,
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
      birth: "1971.7.28",
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

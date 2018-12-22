ModernTimesDatabase::HOLDERS_AFRICA = {
  k_mauretania: {
    "1757.11.10" => {
      name: "Mohammed | Alaouite", # 1
      lived: "1710 - 1790.4.9",
    },
    "1790.4.9" => {
      name: "Yazid | Alaouite",
      lived: "1750 - 1792.2.23",
      father: "Mohammed 1",
    },
    "1792.2.23" => {
      name: "Slimane | Alaouite",
      lived: "1760 - 1822.11.28",
      father: "Mohammed 1",
    },
    "1822.11.28" => {
      name: "Abd al-Rahman | Alaouite",
      lived: "1778 - 1859.8.24",
      # nephew of previous ruler
    },
    "1859.8.24" => {
      name: "Mohammed | Alaouite", # 2
      lived: "1802 - 1873.9.16",
      father: "Abd al-Rahman 1",
    },
    "1873.9.16" => {
      name: "Hassan | Alaouite", # 1
      lived: "1836 - 1894.6.7",
      father: "Mohammed 2",
    },
    "1894.6.7" => {
      name: "Abdelaziz | Alaouite",
      lived: "1878.2.24 - 1943.6.10",
      father: "Hassan 1",
    },
    "1908.1.4" => {
      name: "Abdelhafid | Alaouite",
      lived: "1876.2.24 - 1937.4.4",
      father: "Hassan 1",
    },
    # French protectorate, but royal line still formally active
    "1912.3.30" => nil,
    # Ignoring times when under foreign rule
    "1956.10.29" => { # 3
      name: "Mohammed | Alaouite",
      lived: "1927.11.17 - 1961.2.26",
    },
    "1961.2.26" => {
      name: "Hassan | Alaouite", # 2
      lived: "1929.7.9 - 1999.7.23",
      father: "Mohammed 3"
    },
    "1999.7.23" => { # 4
      name: "Mohammed | Alaouite",
      lived: "1963.8.21 - ",
      father: "Hassan 2",
    },
  },
  d_tripolitania: {
    "1951.12.24" => {
      name: "Idris | Senussi",
      lived: "1889.3.12 - 1983.5.25",
    },
    "1969.9.1" => {
      name: "Muammar Gaddafi",
      lived: "1942 - 2011.10.20",
    },
    # Claimant crowned himself much earlier, but counting from assassination
    "2011.10.20" => {
      name: "Mustafa Abdul-Jalil",
      lived: "1952-",
    },
    "2012.8.9" => {
      name: "Mohammed Magariaf",
      lived: "1940-",
    },
    "2013.6.25" => {
      name: "Nouri Abusahmai",
      lived: "?", # wikipedia doesn't even know birth yeah...
    },
    "2014.8.5" => {
      name: "Aguila Saleh | Issa",
      lived: "1944-",
    },
    "2016.3.30" => {
      name: "Fayez | al-Sarraj",
      lived: "1960-",
    },
  },
  d_tunis: {
    # Backdating
    "1956.3.20" => {
      name: "Habib Bourguiba",
      lived: "1903.8.3 - 2000.4.6",
    },
    "1987.11.7" => {
      name: "Zine El Abidine | Ben Ali",
      lived: "1936.9.3 -",
    },
    # Backdating
    "2011.1.14" => {
      name: "Moncef Marzouki",
      lived: "1945.7.7-",
    },
    "2014.12.31" => {
      name: "Beji Caid | Essebsi",
      lived: "1926.11.29-",
    },
  },
  d_alger: {
    # Because there's coups and silliness, acting/provisional ones included too
    # Backdating
    "1962.4.8" => {
      name: "Abderrahmane Farès",
      lived: "1911.1.30 - 1991.5.13",
    },
    "1962.9.25" => {
      name: "Ferhat Abbas",
      lived: "1899.10.24 - 1985.12.24",
    },
    "1963.9.15" => { # Official #1
      name: "Ahmed | Ben Bella",
      lived: "1916.12.25 - 2012.4.11",
    },
    "1965.6.19" => { # Official #2
      name: "Houari Boumediene",
      lived: "1932.8.23 - 1978.12.27",
    },
    "1978.12.27" => {
      name: "Rabah Bitat",
      lived: "1925.12.19 - 2000.4.10",
    },
    "1979.2.9" => { # Official #3
      name: "Chadli Bendjedid",
      lived: "1929.4.14 - 2012.10.6",
    },
    # Not sure there's a point including these one
    "1992.1.11" => {
      name: "Abdelmalek Benhabyles",
      lived: "1921.4.27-",
    },
    "1992.1.14" => {
      name: "Mohamed Boudiaf",
      lived: "1919.6.23 - 1992.6.29",
    },
    # backdating
    "1992.6.29" => {
      name: "Ali Kafi",
      lived: "1928.10.7 - 2013.4.16",
    },
    "1994.1.31" => { # Official #4
      name: "Liamine Zéroual",
      lived: "1941.7.3-",
    },
    "1999.4.27" => { # Official #5
      name: "Abdelaziz Bouteflika",
      lived: "1937.3.2-",
    },
  },
  k_nubia: { # Sudan
    # Simplifying Sovereignty Council situation
    "1956.1.1"   => { name: "Ibrahim Abboud", lived: "1900.10.26 - 1983.9.8" },
    "1964.11.16" => { name: "Sirr Al-Khatim | Al-Khalifa", lived: "1919.1.1 - 2006.2.18" },
    "1964.12.3"  => { name: "Ismail al-Azhari", lived: "1900.10.20 - 1969.8.26" },
    "1969.5.25"  => { name: "Gaafar Nimeiry", lived: "1930.1.1 - 2009.5.30" },
    "1985.4.6"   => { name: "Abdel Rahman Swar | al-Dahab", lived: "1934 -" },
    "1986.5.6"   => { name: "Ahmad Ali | Al-Mirghani", lived: "1941.8.16 - 2008.11.2" },
    "1989.6.30"  => { name: "Omar al-Bashir", lived: "1944.1.1 -" },
  },
  k_egypt: {
    "1805.6.18"  => { name: "Muhammad Ali | Muhammad Ali", lived: "1769.3.4 - 1849.8.2" },
    "1848.7.20"  => { name: "Ibrahim | Muhammad Ali", lived: "1789 - 1848.11.10", father: "Muhammad Ali 1" },
    "1848.11.10"  => { name: "Abbas Helmi | Muhammad Ali", lived: "1812.7.1 - 1854.7.13" },
    "1854.7.13"  => { name: "Muhammad Sa'id | Muhammad Ali", lived: "1822.3.17 - 1863.1.18" },
    "1863.1.18"   => { name: "Isma'il | Muhammad Ali", lived: "1830.12.31 - 1895.3.2" },
    "1879.6.26"  => { name: "Muhammad Tawfiq | Muhammad Ali", lived: "1852.11.15 - 1892.1.7" },
    "1892.1.7"   => { name: "Abbas Helmi | Muhammad Ali", lived: "1874.7.14 - 1944.12.19" },
    "1914.12.19" => { name: "Hussein Kamel | Muhammad Ali", lived: "November 1853 - 1917.10.9" },
    # Kings
    "1917.10.9" => { name: "Ahmed Fuad | Muhammad Ali", lived: "1868.3.26 - 1936.4.28" },
    "1936.4.28" => { name: "Farouk | Muhammad Ali", lived: "1920.2.11 - 1965.3.18", father: "Ahmed Fuad 1" }, # 1
    "1952.7.26" => { name: "Ahmed Fuad | Muhammad Ali", lived: "1952.1.16 -", father: "Farouk 1" },
    # Peres"residents
    "1953.6.18"  => { name: "Muhammad Naguib", lived: "1901.2.20 - 1984.8.28" },
    "1954.11.14" => { name: "Gamal Abdel | Nasser", lived: "1918.1.15 - 1970.9.28" },
    "1970.9.28"  => { name: "Anwar Sadat", lived: "1948.12.25 - 1981.10.6" },
    # backdating
    "1981.10.6" => { name: "Hosni Mubarak", lived: "1928.5.4 -" },
    "2012.6.30" => { name: "Mohamed Morsi", lived: "1951.8.8 -" },
    # backdating
    "2013.7.3" => { name: "Abdel Fattah | el-Sisi", lived: "1954.11.19 -" },
  },
  # Many dackdated a few days to fill gaps
  k_hausaland: { # Niger
    # backdating from 1960.11.10
    "1960.8.3" => { name: "Hamani Diori", lived: "1916.6.6 - 1989.4.23" },
    "1974.4.15" => { name: "Seyni Kountché", lived: "1931.7.1 - 1987.11.10" },
    "1987.11.10" => { name: "Ali Saibou", lived: "1940.6.17 - 2011.10.31" },
    "1993.4.16" => { name: "Mahamane Ousmane", lived: "1950.1.20 -" },
    "1996.1.27" => { name: "Ibrahim Baré | Maïnassara", lived: "1949.5.9 - 1999.4.9" },
    "1999.4.9" => { name: "Daouda Malam | Wanké", lived: "1946.5.6 - 2004.9.15" },
    "1999.12.22" => { name: "Mamadou Tandja", lived: "1938 -" },
    "2010.2.18" => { name: "Salou Djibo", lived: "1965.4.15 -" },
    "2011.4.7" => { name: "Mahamadou Issoufou", lived: "1952 -" },
  },
  k_kanem: { # Chad
    "1960.8.11" => {name: "François Tombalbaye", lived: "1918.6.15 – 1975.4.13"},
    "1975.4.13" => { name: "Félix Malloum", lived: "1932.9.10 – 2009.6.12"},
    "1979.3.23" => {name: "Goukouni Oueddei", lived: "1944 -" },
    "1979.4.29" => {name: "Lol Mahamat | Choua", lived: "1939.6.15 -" },
    "1979.9.3" => {use: "Goukouni 1"},
    "1982.6.7" => {name: "Hissène Habré", lived: "1942.9.13 -" },
    "1990.12.2" => {name: "Idriss Déby", lived: "1952.6.18 -"},
  }
}

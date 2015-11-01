ModernTimesDatabase::HOLDERS_AFRICA = {
  k_mauretania: {
    "1757.11.10" => {
      name: "Mohammed | Alaouite", # 1
      lived: "1710 – 1790.4.9",
    },
    "1790.4.9" => {
      name: "Yazid | Alaouite",
      lived: "1750 – 1792.2.23",
      father: "Mohammed 1",
    },
    "1792.2.23" => {
      name: "Slimane | Alaouite",
      lived: "1760 – 1822.11.28",
      father: "Mohammed 1",
    },
    "1822.11.28" => {
      name: "Abd al-Rahman | Alaouite",
      lived: "1778 – 1859.8.24",
      # nephew of previous ruler
    },
    "1859.8.24" => {
      name: "Mohammed | Alaouite", # 2
      lived: "1802 – 1873.9.16",
      father: "Abd al-Rahman 1",
    },
    "1873.9.16" => {
      name: "Hassan | Alaouite", # 1
      lived: "1836 – 1894.6.7",
      father: "Mohammed 2",
    },
    "1894.6.7" => {
      name: "Abdelaziz | Alaouite",
      lived: "1878.2.24 – 1943.6.10",
      father: "Hassan 1",
    },
    "1908.1.4" => {
      name: "Abdelhafid | Alaouite",
      lived: "1876.2.24 – 1937.4.4",
      father: "Hassan 1",
    },
    # French protectorate, but royal line still formally active
    "1912.3.30" => nil,
    # Ignoring times when under foreign rule
    "1956.10.29" => { # 3
      name: "Mohammed | Alaouite",
      lived: "1927.11.17 – 1961.2.26",
    },
    "1961.2.26" => {
      name: "Hassan | Alaouite", # 2
      lived: "1929.7.9 – 1999.7.23",
      father: "Mohammed 3"
    },
    "1999.7.23" => { # 4
      name: "Mohammed | Alaouite",
      lived: "1963.8.21 – ",
      father: "Hassan 2",
    },
  },
  d_tripolitania: {
    "1951.12.24" => {
      name: "Idris | Senussi",
      lived: "1889.3.12 – 1983.5.25",
    },
    "1969.9.1" => {
      name: "Muammar Gaddafi",
      lived: "1942 – 2011.10.20",
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
      # wikipedia doesn't even know birth yeah...
    },
    "2014.8.5" => {
      name: "Aguila Saleh | Issa",
      lived: "1944-",
    },
  },
  d_tunis: {
    # Backdating
    "1956.3.20" => {
      name: "Habib Bourguiba",
      lived: "1903.8.3 – 2000.4.6",
    },
    "1987.11.7" => {
      name: "Zine El Abidine | Ben Ali",
      lived: "1936.9.3 -",
    },
    # Backdating
    "2011.1.14" => {
      name: "Moncef Marzouki",
      lived: "1945.7.7–",
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
      lived: "1911.1.30 – 1991.5.13",
    },
    "1962.9.25" => {
      name: "Ferhat Abbas",
      lived: "1899.10.24 – 1985.12.24",
    },
    "1963.9.15" => { # Official #1
      name: "Ahmed | Ben Bella",
      lived: "1916.12.25 – 2012.4.11",
    },
    "1965.6.19" => { # Official #2
      name: "Houari Boumediene",
      lived: "1932.8.23 – 1978.12.27",
    },
    "1978.12.27" => {
      name: "Rabah Bitat",
      lived: "1925.12.19 – 2000.4.10",
    },
    "1979.2.9" => { # Official #3
      name: "Chadli Bendjedid",
      lived: "1929.4.14 – 2012.10.6",
    },
    # Not sure there's a point including these one
    "1992.1.11" => {
      name: "Abdelmalek Benhabyles",
      lived: "1921.4.27-",
    },
    "1992.1.14" => {
      name: "Mohamed Boudiaf",
      lived: "1919.6.23 – 1992.6.29",
    },
    # backdating
    "1992.6.29" => {
      name: "Ali Kafi",
      lived: "1928.10.7 – 2013.4.16",
    },
    "1994.1.31" => { # Official #4
      name: "Liamine Zéroual",
      lived: "1941.7.3-",
    },
    "1999.4.27" => { # Official #5
      name: "Abdelaziz Bouteflika",
      lived: "1937.3.2–",
    },
  },
  k_nubia: { # Sudan
    # Simplifying Sovereignty Council situation
    "1956.1.1"   => { name: "Ibrahim Abboud", lived: "1900.10.26 – 1983.9.8" },
    "1964.11.16" => { name: "Sirr Al-Khatim | Al-Khalifa", lived: "1919.1.1 - 2006.2.18" },
    "1964.12.3"  => { name: "Ismail al-Azhari", lived: "1900.10.20 – 1969.8.26" },
    "1969.5.25"  => { name: "Gaafar Nimeiry", lived: "1930.1.1 – 2009.5.30" },
    "1985.4.6"   => { name: "Abdel Rahman Swar | al-Dahab", lived: "1934 -" },
    "1986.5.6"   => { name: "Ahmad Ali | Al-Mirghani", lived: "1941.8.16 - 2008.11.2" },
    "1989.6.30"  => { name: "Omar al-Bashir", lived: "1944.1.1 -" },
  },
}

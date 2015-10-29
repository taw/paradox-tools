ModernTimesDatabase::HOLDERS_AFRICA = {
  k_mauretania: {
    "1757.11.10" => {
      name: "Mohammed | Alaouite", # 1
      lived: "1710 – 9 April 1790",
    },
    "1790.4.9" => {
      name: "Yazid | Alaouite",
      lived: "1750 – 23 February 1792",
      father: "Mohammed 1",
    },
    "1792.2.23" => {
      name: "Slimane | Alaouite",
      lived: "1760 – 28 November 1822",
      father: "Mohammed 1",
    },
    "1822.11.28" => {
      name: "Abd al-Rahman | Alaouite",
      lived: "1778 – 24 August 1859",
      # nephew of previous ruler
    },
    "1859.8.24" => {
      name: "Mohammed | Alaouite", # 2
      lived: "1802 – 16 September 1873",
      father: "Abd al-Rahman 1",
    },
    "1873.9.16" => {
      name: "Hassan | Alaouite", # 1
      lived: "1836 – 7 June 1894",
      father: "Mohammed 2",
    },
    "1894.6.7" => {
      name: "Abdelaziz | Alaouite",
      lived: "24 February 1878 – 10 June 1943",
      father: "Hassan 1",
    },
    "1908.1.4" => {
      name: "Abdelhafid | Alaouite",
      lived: "24 February 1876 – 4 April 1937",
      father: "Hassan 1",
    },
    # French protectorate, but royal line still formally active
    "1912.3.30" => nil,
    # Ignoring times when under foreign rule
    "1956.10.29" => { # 3
      name: "Mohammed | Alaouite",
      lived: "17 November 1927 – 26 February 1961",
    },
    "1961.2.26" => {
      name: "Hassan | Alaouite", # 2
      lived: "9 July 1929 – 23 July 1999",
      father: "Mohammed 3"
    },
    "1999.7.23" => { # 4
      name: "Mohammed | Alaouite",
      lived: "21 August 1963 – ",
      father: "Hassan 2",
    },
  },
  d_tripolitania: {
    "1951.12.24" => {
      name: "Idris | Senussi",
      lived: "12 March 1889 – 25 May 1983",
    },
    "1969.9.1" => {
      name: "Muammar Gaddafi",
      lived: "1942 – 20 October 2011",
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
      lived: "3 August 1903 – 6 April 2000",
    },
    "1987.11.7" => {
      name: "Zine El Abidine | Ben Ali",
      lived: "1936.9.3 -",
    },
    # Backdating
    "2011.1.14" => {
      name: "Moncef Marzouki",
      lived: "7 July 1945–",
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
      lived: "January 30, 1911 – May 13, 1991",
    },
    "1962.9.25" => {
      name: "Ferhat Abbas",
      lived: "24 October 1899 – 24 December 1985",
    },
    "1963.9.15" => { # Official #1
      name: "Ahmed | Ben Bella",
      lived: "25 December 1916 – 11 April 2012",
    },
    "1965.6.19" => { # Official #2
      name: "Houari Boumediene",
      lived: "23 August 1932 – 27 December 1978",
    },
    "1978.12.27" => {
      name: "Rabah Bitat",
      lived: "19 December 1925 – 10 April 2000",
    },
    "1979.2.9" => { # Official #3
      name: "Chadli Bendjedid",
      lived: "14 April 1929 – 6 October 2012",
    },
    # Not sure there's a point including these one
    "1992.1.11" => {
      name: "Abdelmalek Benhabyles",
      lived: "1921.4.27-",
    },
    "1992.1.14" => {
      name: "Mohamed Boudiaf",
      lived: "23 June 1919 – 29 June 1992",
    },
    # backdating
    "1992.6.29" => {
      name: "Ali Kafi",
      lived: "7 October 1928 – 16 April 2013",
    },
    "1994.1.31" => { # Official #4
      name: "Liamine Zéroual",
      lived: "1941.7.3-",
    },
    "1999.4.27" => { # Official #5
      name: "Abdelaziz Bouteflika",
      lived: "2 March 1937–",
    },
  },
}

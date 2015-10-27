ModernTimesDatabase::HOLDERS_AFRICA = {
  k_mauretania: {
    "10 November 1757" => {
      name: "Mohammed | Alaouite", # 1
      lived: "1710 – 9 April 1790",
    },
    "9 April 1790" => {
      name: "Yazid | Alaouite",
      lived: "1750 – 23 February 1792",
      father: "Mohammed 1",
    },
    "23 February 1792" => {
      name: "Slimane | Alaouite",
      lived: "1760 – 28 November 1822",
      father: "Mohammed 1",
    },
    "28 November 1822" => {
      name: "Abd al-Rahman | Alaouite",
      lived: "1778 – 24 August 1859",
      # nephew of previous ruler
    },
    "24 August 1859" => {
      name: "Mohammed | Alaouite", # 2
      lived: "1802 – 16 September 1873",
      father: "Abd al-Rahman 1",
    },
    "16 September 1873" => {
      name: "Hassan | Alaouite", # 1
      lived: "1836 – 7 June 1894",
      father: "Mohammed 2",
    },
    "7 June 1894" => {
      name: "Abdelaziz | Alaouite",
      lived: "24 February 1878 – 10 June 1943",
      father: "Hassan 1",
    },
    "4 January 1908" => {
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
    "26 February 1961" => {
      name: "Hassan | Alaouite", # 2
      lived: "9 July 1929 – 23 July 1999",
      father: "Mohammed 3"
    },
    "23 July 1999" => { # 4
      name: "Mohammed | Alaouite",
      lived: "21 August 1963 – ",
      father: "Hassan 2",
    },
  },
  d_tripolitania: {
    "24 December 1951" => {
      name: "Idris | Senussi",
      lived: "12 March 1889 – 25 May 1983",
    },
    "1 September 1969" => {
      name: "Muammar Gaddafi",
      lived: "1942 – 20 October 2011",
    },
    # Claimant crowned himself much earlier, but counting from assassination
    "20 October 2011" => {
      name: "Mustafa Abdul-Jalil",
      lived: "1952-",
    },
    "9 August 2012" => {
      name: "Mohammed Magariaf",
      lived: "1940-",
    },
    "25 June 2013" => {
      name: "Nouri Abusahmai",
      # wikipedia doesn't even know birth yeah...
    },
    "5 August 2014" => {
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
    "7 November 1987" => {
      name: "Zine El Abidine | Ben Ali",
      lived: "3 September 1936 -",
    },
    # Backdating
    "14 January 2011" => {
      name: "Moncef Marzouki",
      lived: "7 July 1945–",
    },
    "31 December 2014" => {
      name: "Beji Caid | Essebsi",
      lived: "29 November 1926-",
    },
  },
  d_alger: {
    # Because there's coups and silliness, acting/provisional ones included too
    # Backdating
    "1962.4.8" => {
      name: "Abderrahmane Farès",
      lived: "January 30, 1911 – May 13, 1991",
    },
    "25 September 1962" => {
      name: "Ferhat Abbas",
      lived: "24 October 1899 – 24 December 1985",
    },
    "15 September 1963" => { # Official #1
      name: "Ahmed | Ben Bella",
      lived: "25 December 1916 – 11 April 2012",
    },
    "19 June 1965" => { # Official #2
      name: "Houari Boumediene",
      lived: "23 August 1932 – 27 December 1978",
    },
    "27 December 1978" => {
      name: "Rabah Bitat",
      lived: "19 December 1925 – 10 April 2000",
    },
    "9 February 1979" => { # Official #3
      name: "Chadli Bendjedid",
      lived: "14 April 1929 – 6 October 2012",
    },
    # Not sure there's a point including these one
    "11 January 1992" => {
      name: "Abdelmalek Benhabyles",
      lived: "27 April 1921-",
    },
    "14 January 1992" => {
      name: "Mohamed Boudiaf",
      lived: "23 June 1919 – 29 June 1992",
    },
    # backdating
    "29 June 1992" => {
      name: "Ali Kafi",
      lived: "7 October 1928 – 16 April 2013",
    },
    "31 January 1994" => { # Official #4
      name: "Liamine Zéroual",
      lived: "3 July 1941-",
    },
    "27 April 1999" => { # Official #5
      name: "Abdelaziz Bouteflika",
      lived: "2 March 1937–",
    },
  },
}

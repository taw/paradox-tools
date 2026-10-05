ModernTimesDatabase::Holders.define do
  # Dynasty changed names twice, but whatever
  title "e_britannia" do
    ruler "1689.2.13",
      name: "William | Stuart",
      lived: "1650.11.4 - 1702.3.8"
    # From 1 May 1707 as UK, but let's not pretend Scotland mattered before
    ruler "1702.3.8",
      name: "Anne | Stuart",
      lived: "1665.2.6 - 1714.8.1",
      female: true
    ruler "1714.8.1",
      name: "George | Windsor",
      lived: "1660.5.28 - 1727.6.11"
    ruler "1727.6.11",
      name: "George | Windsor",
      father: "George 1",
      lived: "1683.10.30 - 1760.10.25"
    character "Frederick Prince of Wales",
      name: "Frederick | Windsor",
      lived: "1707.1.31 - 1751.3.31",
      father: "George 2"
    ruler "1760.10.25",
      name: "George | Windsor",
      father: "Frederick Prince of Wales",
      lived: "1738.6.4 - 1820.1.29",
      events: {
        crowning: PropertyList[
          "prestige", 2000,
        ],
      }
    ruler "1820.1.29",
      name: "George | Windsor",
      father: "George 3",
      lived: "1762.8.12 - 1830.6.26",
      events: {
        crowning: PropertyList[
          "prestige", 2000,
        ],
      }
    ruler "1830.6.26",
      name: "William | Windsor",
      lived: "1765.8.21 - 1837.6.20",
      father: "George 3",
      events: {
        crowning: PropertyList[
          "prestige", 2000,
        ],
      }
    character "Edward Duke of Kent",
      name: "Edward | Windsor",
      lived: "1767.11.2 - 1820.1.23",
      father: "George 3"
    ruler "1837.6.20",
      lived: "1819.5.24 - 1901.1.22",
      name: "Victoria | Windsor",
      female: true,
      father: "Edward Duke of Kent",
      health: 7,
      events: {
        crowning: PropertyList[
          "prestige", 2000,
        ],
      }
      # granddaughter of George 3
    ruler "1901.1.22",
      lived: "1841.11.9 - 1910.5.6",
      name: "Edward | Windsor",
      mother: "Victoria",
      events: {
        crowning: PropertyList[
          "prestige", 2000,
        ],
      }
    ruler "1910.5.6",
      lived: "1865.6.3 - 1936.1.20",
      name: "George | Windsor",
      father: "Edward",
      events: {
        crowning: PropertyList[
          "prestige", 2000,
        ],
      }
    ruler "1936.1.20",
      lived: "1894.6.23 - 1972.5.28",
      name: "Edward | Windsor",
      father: "George 5",
      events: {
        crowning: PropertyList[
          "prestige", 2000,
        ],
      }
    ruler "1936.12.11",
      lived: "1895.12.14 - 1952.2.6",
      name: "George | Windsor",
      father: "George 5",
      events: {
        crowning: PropertyList[
          "prestige", 2000,
        ],
      }
    ruler "1952.2.6",
      lived: "1926.4.21 - 2022.9.8",
      name: "Elizabeth | Windsor",
      female: true,
      father: "George 6"
    ruler "2022.9.8",
      lived: "1948.11.14 -",
      name: "Charles | Windsor",
      mother: "Elizabeth 1"
  end
  title "k_scotland" do
    ruler "1999.5.7",
      name: "Donald | Dewar",
      lived: "1937.8.21 - 2000.10.11"
    # backdating from 2000.10.27, Jim Wallace was acting First Minister in between
    ruler "2000.10.11",
      name: "Henry | McLeish",
      lived: "1948.6.15 -"
    ruler "2001.11.22",
      name: "Jack | McConnell",
      lived: "1960.6.30 -"
    ruler "2007.5.16",
      name: "Alex | Salmond",
      lived: "1954.12.31 - 2024.10.12"
    ruler "2014.11.20",
      name: "Nicola | Sturgeon",
      lived: "1970.7.19 -",
      female: true
    ruler "2023.3.29",
      name: "Humza | Yousaf",
      lived: "1985.4.7 -"
    ruler "2024.5.8",
      name: "John | Swinney",
      lived: "1964.4.13 -"
  end
  title "k_wales" do
    ruler "1999.5.12",
      name: "Alun | Michael",
      lived: "1943.8.22 -"
    ruler "2000.2.9",
      name: "Rhodri | Morgan",
      lived: "1939.9.29 - 2017.5.17"
    ruler "2009.12.9",
      name: "Carwyn | Jones",
      lived: "1967.3.21 -"
    ruler "2018.12.13",
      name: "Mark | Drakeford",
      lived: "1954.9.19 -"
    ruler "2024.3.20",
      name: "Vaughan | Gething",
      lived: "1974.3.15 -"
    ruler "2024.8.6",
      name: "Eluned | Morgan",
      lived: "1967.2.16 -",
      female: true
  end
  title "k_ireland" do
    ruler :ireland_independence,
      name: "Éamon | de Valera",
      lived: "1882.10.14 - 1975.8.29"
    ruler "1922.1.9",
      name: "Michael Collins",
      lived: "1890.10.16 - 1922.8.22"
    # Before that it's a bit messy
    ruler "1922.8.22",
      name: "William Thomas | Cosgrave",
      lived: "1880 - 1965"
    ruler "1932.3.9", use: "Éamon 1"
    ruler "1948.2.18",
      name: "John Aloysius | Costello",
      lived: "1891 - 1976"
    ruler "1951.6.13", use: "Éamon 1"
    ruler "1954.6.2", use: "John Aloysius 1"
    ruler "1957.3.20", use: "Éamon 1"
    ruler "1959.6.23",
      name: "Seán Lemass",
      lived: "1899 - 1971"
    ruler "1966.11.10",
      name: "Jack Lynch",
      lived: "1917 - 1999"
    ruler "1973.3.14",
      name: "Liam Cosgrave",
      lived: "1920.4.13 - 2017.10.4",
      father: "William Thomas 1"
    ruler "1977.7.5", use: "Jack 1"
    ruler "1979.12.11",
      name: "Charles Haughey",
      lived: "1925 - 2006"
    ruler "1981.6.30",
      name: "Garret FitzGerald",
      lived: "1926 - 2011"
    ruler "1982.3.9", use: "Charles 1"
    ruler "1982.12.14", use: "Garret 1"
    ruler "1987.3.10", use: "Charles 1"
    ruler "1992.2.11",
      name: "Albert Reynolds",
      lived: "1932 - 2014"
    ruler "1994.12.15",
      name: "John Bruton",
      lived: "1947.5.18 - 2024.2.6"
    ruler "1997.6.26",
      name: "Bertie Ahern",
      lived: "1951.9.12 -"
    ruler "2008.5.7",
      name: "Brian Cowen",
      lived: "1960.1.10 -"
    ruler "2011.3.9",
      name: "Enda Kenny",
      lived: "1951.4.24 -"
    ruler "2017.6.14",
      name: "Leo Varadkar",
      lived: "1979.1.18 -"
    ruler "2020.6.27",
      name: "Micheál Martin",
      lived: "1960.8.16 -"
    ruler "2022.12.17", use: "Leo 1"
    ruler "2024.4.9",
      name: "Simon Harris",
      lived: "1986.10.17 -"
    ruler "2025.1.23", use: "Micheál 1"
  end
end

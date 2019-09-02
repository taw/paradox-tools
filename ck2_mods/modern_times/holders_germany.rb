ModernTimesDatabase::HOLDERS_GERMANY = {
  d_brunswick: {
    congress_of_vienna: {use: "e_britannia George 3"},
    "1820.1.29" => {use: "e_britannia George 4"},
    "1830.6.26" => {use: "e_britannia William 2"},
    "1837.6.20" => {name: "Ernest Augustus | Windsor", lived: "1771.6.5 - 1851.11.18", father: "e_britannia George 3"},
    "1851.11.18" => {name: "George | Windsor", lived: "1819.5.27 - 1878.6.12", father: "Ernest Augustus 1"},
    "1866.9.20" => nil,
  },
  k_pomerania: {
    # There's one previous Frederick William here
    "1786.8.17" => {
      name: "Friedrich Wilhelm | Hohenzollern",
      lived: "1744.9.25 - 1797.11.16",
    },
    "1797.11.16" => {
      name: "Friedrich Wilhelm | Hohenzollern",
      lived: "1770.7.3 - 1840.6.7",
      father: "Friedrich Wilhelm 1",
    },
    "1840.6.7" => {
      name: "Friedrich Wilhelm | Hohenzollern",
      lived: "1795.10.15 - 1861.1.2",
      father: "Friedrich Wilhelm 2",
    },
    "1861.1.2" => {
      name: "Wilhelm | Hohenzollern",
      lived: "1797.3.22 - 1888.3.9",
      father: "Friedrich Wilhelm 2",
    },
    "1871.1.18" => nil,
    # Reboot as East Germany
    end_ww2: {
      name: "Wilhelm | Pieck",
      lived: "1876-1960",
    },
    "1950.7.25" => {
      name: "Walter | Ulbricht",
      lived: "1893-1973",
    },
    "1971.5.3" => {
      name: "Erich | Honecker",
      lived: "1912-1994",
    },
    "1989.10.18" => {
      name: "Egon | Krenz",
      lived: "1937-",
    },
    german_reunification: nil,
  },
  c_weimar: {
    "1707.5.10" => {
      name: "Ernst August | Sachsen-Weimar-Eisenach",
      lived: "1688.4.19 - 1748.1.19",
    },
    "1748.1.19" => {
      name: "Ernst August | Sachsen-Weimar-Eisenach",
      lived: "1737.6.2 - 1758.5.28",
      father: "Ernst August 1",
    },
    "1758.5.28" => {
      name: "Karl August | Sachsen-Weimar-Eisenach",
      lived: "1757.9.3 - 1828.6.14",
      father: "Ernst August 2",
    },
    "1828.6.14" => {
      name: "Karl Friedrich | Sachsen-Weimar-Eisenach",
      lived: "1783.2.2 - 1853.7.8",
      father: "Karl August 1",
    },
    "1853.7.8" => {
      name: "Karl Alexander | Sachsen-Weimar-Eisenach",
      lived: "1818.6.24 - 1901.1.5",
      father: "Karl Friedrich 1",
    },
    german_unification: nil,
  },
  d_mecklemburg: {
    "1692.6.21" => {
      name: "Friedrich Wilhelm | Mecklenburg",
      lived: "1675.3.28 - 1713.7.31",
    },
    "1713.7.31" => {
      name: "Karl Leopold | Mecklenburg",
      lived: "1678.11.26 - 1747.11.28",
    },
    "1728.1.1" => { # Amazingly whole internet doesn't know better than year date :-/
      name: "Christian Ludwig | Mecklenburg",
      lived: "1683.11.15 - 1756.5.30",
    },
    "1756.5.30" => {
      name: "Friedrich | Mecklenburg",
      lived: "1717.11.9 - 1785.4.24",
      father: "Christian Ludwig 1",
    },
    "1785.4.24" => {
      name: "Friedrich Franz | Mecklenburg", # 1
      lived: "1756.12.10 - 1837.2.1",
    },
    "1837.2.1" => {
      name: "Paul Friedrich | Mecklenburg",
      lived: "1800.9.15 - 1842.3.7",
    },
    "1842.3.7" => {
      name: "Friedrich Franz | Mecklenburg", # 2
      lived: "1823.2.28 - 1883.4.15",
      father: "Paul Friedrich 1",
    },
    "1883.4.15" => {
      name: "Friedrich Franz | Mecklenburg", # 3
      lived: "1851.3.19 - 1897.4.10",
      father: "Friedrich Franz 2",
    },
    "1897.4.10" => {
      name: "Friedrich Franz | Mecklenburg", # 4
      lived: "1882.4.9 - 1945.11.17",
      father: "Friedrich Franz 3",
    },
    end_ww1: nil,
  },
  e_germany: {
    "1871.1.18" => {use: "k_pomerania Wilhelm 1"},
    "1888.3.9" => {
      name: "Friedrich | Hohenzollern",
      lived: "1831.10.18 - 1888.6.15",
      father: "k_pomerania Wilhelm 1",
      religion: :protestant,
    },
    "1888.6.15" => {
      lived: "1859.1.27 - 1941.6.4",
      name: "Wilhelm | Hohenzollern",
      father: "Friedrich 1",
      religion: :protestant,
    },
    # Backdate, ignore interregnum
    "1918.11.28" => {
      name: "Friedrich | Ebert",
      lived: "1871.2.4 - 1925.2.28",
      religion: :catholic,
    },
    # Ignore temporary ones, backdating
    "1925.2.28" => {
      name: "Paul | von Hindenburg", lived: "1847.10.2 - 1934.8.2",
      religion: :protestant,
    },
    "1934.8.2" => {
      name: "Adolf | Hitler", lived: "1889.4.20 - 1945.4.30",
      religion: :catholic,
      health: 7,
      traits: ["ambitious", "wroth"],
      events: {
        crowning: PropertyList[
          "effect", PropertyList["set_character_flag", "horde_invader"],
          "prestige", 1000, # enough to start 2 wars
        ],
      },
    },
    "1945.4.30" => {
      name: "Karl | Doenitz", lived: "- 1980.12.24",
      religion: :protestant,
    },
    end_ww2: nil,
    german_reunification: {use: "k_germany Helmut 2"},
    "1998.10.27" => {
      name: "Gerhard | Schröder",
      lived: "1944.4.7 -",
      religion: :protestant,
    },
    "2005.11.22" => {
      name: "Angela | Merkel",
      lived: "1954.7.17 -",
      female: true,
      religion: :protestant,
    },
  },
  k_germany: {
    # Now this is bullshit on so many levels...
    # German "presidents" do nothing, so choosing chancellor as much more prominent person
    # Backdating a lot
    end_ww2: {
      name: "Konrad | Adenauer",
      lived: "1876.1.5 - 1967.4.19",
      religion: :catholic,
    },
    "1963.10.17" => {
      name: "Ludwig | Erhard",
      lived: "1897.2.4 - 1977.5.5",
      religion: :protestant,
    },
    "1966.12.1" => {
      name: "Kurt Georg | Kiesinger",
      lived: "1904.4.6 - 1988.3.9",
      religion: :catholic,
    },
    "1969.10.22" => {
      name: "Willy | Brandt",
      lived: "1913.12.18 - 1992.10.8",
      religion: :protestant,
    },
    "1974.5.16" => { # 1
      name: "Helmut | Schmidt",
      lived: "1918.12.23 - 2015.11.10",
      religion: :protestant,
    },
    "1982.10.1" => { # 2
      name: "Helmut | Kohl",
      lived: "1930.4.3 - 2017.6.16",
      religion: :catholic,
    },
    german_reunification: nil,
  },
  d_bavaria: {
    "1597.10.15" => {
      name: "Maximilian | Wittelsbach", #1
      lived: "1573.4.17 - 1651.9.27",
    },
    "1651.9.27" => {
      name: "Ferdinand Maria | Wittelsbach",
      lived: "1636.10.31 - 1679.5.26",
      father: "Maximilian 1",
    },
    "1679.5.26" => {
      name: "Maximilian Emanuel | Wittelsbach",
      lived: "1662.7.11 - 1726.2.26",
      father: "Ferdinand Maria",
    },
    "1726.2.26" => {
      name: "Karl Albert | Wittelsbach",
      lived: "1697.8.6 - 1745.1.20",
      father: "Maximilian Emanuel",
    },
    "1745.1.20" => {
      name: "Maximilian Joseph | Wittelsbach",
      lived: "1727.3.28 - 1777.12.30",
      father: "Karl Albert 1",
    },
    "1777.12.30" => {
      name: "Karl Theodor | Wittelsbach",
      lived: "1724.12.11 - 1799.2.16",
    },
    "1799.2.16" => {
      name: "Maximilian | Wittelsbach", # 2
      lived: "1756.5.27 - 1825.10.13",
      # distant cousin of previous rulers
    },
    "1825.10.13" => {
      name: "Ludwig | Wittelsbach", # 1
      lived: "1786.8.25 - 1868.2.29",
      father: "Maximilian 2",
    },
    "1848.3.20" => {
      name: "Maximilian | Wittelsbach", # 3
      lived: "1811.11.28 - 1864.3.10",
      father: "Ludwig 1",
    },
    "1864.3.10" => {
      name: "Ludwig | Wittelsbach", # 2
      lived: "1845.8.25 - 1886.6.13",
      father: "Maximilian 3",
    },
    "1886.6.13" => {
      name: "Otto | Wittelsbach",
      lived: "1848.4.27 - 1916.10.11",
      father: "Maximilian 2",
    },
    "1913.11.5" => {
      name: "Ludwig | Wittelsbach", # 3
      lived: "1845.1.7 - 1921.10.18",
      # grandson of Ludwig 1
    },
    end_ww1: nil,
  },
  d_lausitz: {
    "1694.4.27" => {
      name: "August | Wettin", #1
      lived: "1670.5.12 - 1733.2.1",
    },
    "1733.2.1" => {
      name: "August | Wettin", #2
      lived: "1696.10.17 - 1763.10.5",
    },
    "1763.10.5" => {
      name: "Friedrich Christian | Wettin",
      lived: "1722.9.5 - 1763.12.17",
      father: "August 2",
    },
    "1763.12.17" => {
      name: "Friedrich August | Wettin", #1
      lived: "1750.12.23 - 1827.5.5",
      father: "Friedrich Christian",
    },
    "1827.5.5" => {
      name: "Anton | Wettin",
      lived: "1755.12.27 - 1836.6.6",
      father: "Friedrich Christian",
    # brother of previous
    },
    "1836.6.6" => {
      name: "Friedrich August | Wettin", #2
      lived: "1797.5.18 - 1854.8.9",
    # nephew of previous
    },
    "1854.8.9" => {
      name: "Johann | Wettin", #1
      lived: "1801.12.12 - 1873.10.29",
    # brother of previous
    },
    "1873.10.29" => {
      name: "Albert | Wettin",
      lived: "1828.4.23 - 1902.6.19",
      father: "Johann 1",
    },
    "1902.6.19" => {
      name: "Georg | Wettin",
      lived: "1832.8.8 - 1904.10.15",
      father: "Johann 1",
    },
    "1904.10.15" => {
      name: "Friedrich August | Wettin", #3
      lived: "1865.5.25 - 1932.2.18",
      father: "Georg 1",
    },
    end_ww1: nil,
  },
  # There was actually Hessen-Kassel and Hessen-Darmstadt
  d_franconia: {
    "1813.10.30" => {
      name: "Wilhelm | Hessen",
      lived: "1743.6.3 - 1821.2.27",
    },
    "1821.2.27" => {
      name: "Wilhelm | Hessen", #2
      lived: "1777.7.28 - 1847.11.20",
      father: "Wilhelm 1",
    },
    "1847.11.20" => {
      name: "Friedrich Wilhelm | Hessen",
      lived: "1802.8.20 - 1875.1.6",
      father: "Wilhelm 2",
    },
    prussia_annexes_hannover: nil,
  },
  # Austria/Österreich
  k_bavaria: {
    # Backfill
    "1918.11.11" => {name: "Karl | Seitz", lived: "1869.9.4 - 1950.2.3"},
    "1920.12.9" => {name: "Michael | Hainisch", lived: "1858.8.15 - 1940.2.26"},
    "1928.12.10" => {name: "Wilhelm | Miklas", lived: "1872.10.15 - 1956.3.20"},
    anschluss: nil,
    end_ww2: {name: "Karl | Renner", lived: "1870.12.14 - 1950.12.31"},
    # Backfill, predecessor died in office
    "1950.12.31" => {name: "Theodor | Körner", lived: "1873.4.24 - 1957.1.4"},
    # Backfill, predecessor died in office
    "1957.1.4" => {name: "Adolf | Schärf", lived: "1890.4.20 - 1965.2.28"},
    # Backfill, predecessor died in office
    "1965.2.28" => {name: "Franz | Jonas", lived: "1899.10.4 - 1974.4.24"},
    # Backfill, predecessor died in office
    "1974.4.24" => {name: "Rudolf | Kirchschläger", lived: "1915.3.20 - 2000.3.30"},
    "1986.7.8" => {name: "Kurt | Waldheim", lived: "1918.12.21 - 2007.6.14"},
    "1992.7.8" => {name: "Thomas | Klestil", lived: "1932.11.4 - 2004.7.6"},
    # Backfill, predecessor died in office, why the fuck do they keep electing barely alive presidents?
    "2004.7.6" => {name: "Heinz | Fischer", lived: "1938.10.9 -"},
    # Member of presidential council, pick one of three arbitrarily
    "2016.7.8" => {name: "Doris | Bures", lived: "1962.8.3 -", female: true},
    # New president
    "2017.1.26" => {name: "Alexander | Van der Bellen", lived: "1944.1.18 -"},
  },
  # Württemberg
  d_swabia: {
    "1733.10.31" => {
      name: "Karl Alexander | Württemberg",
      lived: "1684.5.24 - 1737.3.12",
    },
    "1737.3.12" => {
      name: "Karl Eugen | Württemberg",
      lived: "1728.2.11 - 1793.10.24",
      father: "Karl Alexander",
    },
    "1793.10.24" => {
      name: "Ludwig Eugen | Württemberg",
      lived: "1731.1.6 - 1795.5.20",
      father: "Karl Alexander",
    },
    "1795.5.20" => {
      name: "Friedrich Eugen | Württemberg",
      lived: "1732.1.21 - 1797.12.23",
      father: "Karl Alexander",
    },
    # as duke, elector, then king
    "1797.12.23" => {
      name: "Friedrich | Württemberg", #1
      lived: "1754.11.6 - 1816.10.30",
      father: "Friedrich Eugen",
    },
    "1816.10.30" => {
      name: "Wilhelm | Württemberg", # 1
      lived: "1781.9.27 - 1864.6.25",
      father: "Friedrich 1",
    },
    "1864.6.25" => {
      name: "Karl | Württemberg",
      lived: "1823.3.6 - 1891.10.6",
      father: "Wilhelm 1",
    },
    "1891.10.6" => {
      name: "Wilhelm | Württemberg", # 2
      lived: "1848.2.25 - 1921.10.2",
    # nephew of previous
    },
    end_ww1: nil,
  },
  d_baden: {
    "1738.5.12" => {name: "Karl Friedrich | Zähringen", lived: "1728.11.22 - 1811.6.10"},
    "1811.6.10" => {name: "Karl | Zähringen", lived: "1786.7.8 - 1818.12.8"},
    "1818.12.8" => {name: "Ludwig | Zähringen", lived: "1763.2.9 - 1830.3.30", father: "Karl Friedrich 1"},
    "1830.3.30" => {name: "Leopold | Zähringen", lived: "1790.8.29 - 1852.4.24", father: "Karl Friedrich 1"},
    "1852.4.24" => {name: "Ludwig | Zähringen", lived: "1824.8.15 - 1858.1.22", father: "Leopold 1"},
    "1858.1.22" => {name: "Friedrich | Zähringen", lived: "1826.9.9 - 1907.9.28", father: "Leopold 1"},
    "1907.9.28" => {name: "Friedrich | Zähringen", lived: "1857.7.9 - 1928.8.9", father: "Friedrich 1"},
    end_ww1: nil,
  },
  c_anhalt: { # There were like 5 gavelkinded Anhalts
    "1693.8.7" => {
      name: "Leopold | Askanier", # 1
      lived: "1676.7.3 - 1747.4.7",
    },
    "1747.4.7" => {
      name: "Leopold | Askanier", # 2
      lived: "1700.12.25 - 1751.12.16",
      father: "Leopold 1",
    },
    "1751.12.16" => {
      name: "Leopold | Askanier", # 3
      lived: "1740.8.10 - 1817.8.9",
      father: "Leopold 2",
    },
    # Anhalt-Dessau initially
    # Anhalt-Dessau and Anhalt-Köthen from 1847
    # Anhalt-Dessau-Köthen from 1853
    # United Anhalt from 1863
    # grandfather of previous
    "1817.8.9" => {
      name: "Leopold | Askanier", # 4
      lived: "1794.10.1 - 1871.5.22",
    },
    german_unification: nil,
  },
  c_oldenburg: {
    # 1810-1813 under France
    congress_of_vienna: {
      name: "Wilhelm | Holstein-Gottorp",
      lived: "1754.1.3 - 1823.7.2",
    },
    "1823.7.2" => {
      # cousin of previous, nephew of prevprev
      name: "Peter | Holstein-Gottorp", #1
      lived: "1755.1.17 - 1829.5.21",
    },
    "1829.5.21" => {
      name: "August | Holstein-Gottorp",
      lived: "1783.7.13 - 1853.2.27",
      father: "Peter 1",
    },
    "1853.2.27" => {
      name: "Peter | Holstein-Gottorp", #2
      lived: "1827.7.8 - 1900.6.13",
      father: "August",
    },
    "1900.6.13" => {
      name: "Friedrich August | Holstein-Gottorp", #2
      lived: "1852.11.16 - 1931.2.24",
      father: "Peter 2",
    },
    end_ww1: nil,
  },
}

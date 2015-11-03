ModernTimesDatabase::HOLDERS_MIDDLE_EAST = {
  k_persia: {
    "1785.2.18" => {
      name: "Jafar | Zand",
      lived: "- 1789.1.23", # wikipedia has no birth
    },
    "1789.1.23" => {
      name: "Sayed Murad | Zand",
      lived: "- 1789.5.10", # wikipedia has no birth
    },
    "1789.5.10" => {
      name: "Lotf Ali | Zand",
      lived: "1769 – 1794.3.20",
    },
    "1794.3.20" => {
      name: "Mohammad | Qajar",
      lived: "1742 – 1797.6.17",
    },
    "1797.6.17" => {
      name: "Fat'h Ali | Qajar",
      lived: "1772.9.5 – 1834.10.23",
    },
    "1834.10.23" => {
      name: "Mohammad | Qajar",
      lived: "1808.1.5 – 1848.9.5",
    },
    "1848.9.5" => {
      name: "Naser al-Din | Qajar",
      lived: "1831.7.16 – 1896.5.1",
    },
    "1896.5.1" => {
      name: "Mozaffar al-Din | Qajar",
      lived: "1853.3.23 – 1907.1.3",
    },
    "1907.1.3" => {
      name: "Mohammad Ali | Qajar",
      lived: "1872.6.21 – 1925.4.5",
    },
    "1909.6.16" => {
      name: "Ahmad | Qajar",
      lived: "1898.1.21 – 1930.2.21",
    },
    "1925.12.15" => {
      name: "Reza | Pahlavi",
      lived: "1878.3.15 – 1944.7.26",
    },
    "1941.9.16" => {
      name: "Mohammad Reza | Pahlavi",
      lived: "1919.10.26 – 1980.7.27",
    },
    "1979.2.11" => {
      name: "Ruhollah | Khomeini",
      lived: "1902.9.22 - 1989.6.3",
      traits: ["zealous"],
      health: 7, # way too old to survive Iran-Iraq War otherwise
    },
    "1989.6.3" => {
      name: "Ali | Khamenei",
      lived: "1939.7.17 -",
      traits: ["zealous"],
    },
  },
  e_arabia: {
    "1695.2.6" => { # 1 (actually 2)
      name: "Mustafa | Ottoman", lived: "1664.2.6 – 1703.12.30", #  father: "Mehmed",
      events: { "1700.1.1" => PropertyList["decadence", 10]}, # 25 -> 35
    },
    "1703.8.22" => {
      name: "Ahmed | Ottoman", lived: "1673.12.31 – 1736.7.1", # father: "Mehmed",
    },
    "1730.10.2" => { # 1
      name: "Mahmud | Ottoman", lived: "1696.8.2  – 1754.12.13", father: "Mustafa 1",
      events: { "1750.1.1" => PropertyList["decadence", 10]}, # 35 -> 45
    },
    "1754.12.13" => {
      name: "Osman | Ottoman", lived: "1699.1.3 – 1757.10.30", father: "Mustafa 1",
    },
    "1757.10.30" => { # 2
      name: "Mustafa | Ottoman", lived: "1717.1.18 – 1774.1.21", father: "Ahmed 1",
    },
    "1774.1.21" => {
      name: "Abdülhamid | Ottoman", lived: "1725.3.20 – 1789.4.7", father: "Ahmed 1",
    },
    "1789.4.7" => {
      name: "Selim | Ottoman", lived: "1761.12.24 – 1808.7.29", father: "Mustafa 2",
      events: { "1800.1.1" => PropertyList["decadence", 10]}, # 45 -> 55
    },
    "1807.5.29" => { # 3
      name: "Mustafa | Ottoman", lived: "1779.9.8 – 1808.11.16", father: "Abdülhamid 1",
    },
    "1808.7.28" => { # 2
      name: "Mahmud | Ottoman", lived: "1789.7.20 – 1839.7.1", father: "Abdülhamid 1",
    },
    "1839.7.1" => {
      name: "Abdülmecid | Ottoman", lived: "1823.4.25 – 1861.6.25", father: "Mahmud 2",
      events: { "1850.1.1" => PropertyList["decadence", 20]}, # 55 -> 75
    },
    "1861.6.25" => {
      name: "Abdulaziz | Ottoman", lived: "1830.2.18 – 1876.6.4", father: "Mahmud 2",
    },
    "1876.5.30" => {
      name: "Mehmed Murad | Ottoman", lived: "1840.9.21 – 1904.8.29", father: "Abdülmecid 1",
    },
    "1876.8.31" => {
      name: "Abdulhamid | Ottoman", lived: "1842.9.22 – 1918.2.10", father: "Abdülmecid 1",
      events: { "1900.1.1" => PropertyList["decadence", 20]}, # 75 -> 95, enjoy
    },
    "1909.4.27" => {
      name: "Mehmed | Ottoman", lived: "1844.11.2 – 1918.7.3", father: "Abdülmecid 1",
    },
    "1918.7.3" => {
      name: "Mehmed | Ottoman", lived: "1861.1.14 – 1926.5.16", father: "Abdülmecid 1",
    },
    "1922.11.1" => nil,
  },
  k_anatolia: {
    # There was a caliph Abdulmecid II for 1922-1924, consider maybe?
    # Dates are changed to fill the gaps
    "1922.11.1" => {
      name: "Mustafa Kemal | Atatürk",
      lived: "1881.5.19 – 1938.11.10",
      health: 6,
    },
    # backtading
    "1938.11.10" => {
      name: "Ismet | Inonu",
      lived: "1884.9.24 – 1973.12.25",
    },
    "1950.5.22" => {
      name: "Celal | Bayar",
      lived: "1883.5.16 – 1986.8.22",
    },
    # Skipping National Unity Committee
    "1961.10.10" => {
      name: "Cemal | Gursel",
      lived: "1895 – 1966.9.14",
    },
    "1966.3.28" => {
      name: "Cevdet | Sunay",
      lived: "1899.2.10 – 1982.5.22",
    },
    "1973.4.6" => {
      name: "Fahri | Koruturk",
      lived: "1903.8.3 – 1987.10.12",
    },
    #  From "1982.11.9", before as chairman of National Security Council
    "1980.9.12" => {
      name: "Kenan | Evren",
      lived: "1917.7.17 – 2015.5.9",
    },
    "1989.11.9" => {
      name: "Torgut | Ozal",
      lived: "1927.10.13 – 1993.4.17",
    },
    # backdating
    "1993.4.17" => {
      name: "Suleyman | Demirel",
      lived: "1924.11.1 – 2015.6.17",
    },
    "2000.5.16" => {
      name: "Ahmet Necdet | Sezer",
      lived: "1941.9.13 -",
    },
    "2007.8.28" => {
      name: "Abdullah | Gul",
      lived: "1950.10.29 -",
    },
    "2014.8.28"  => {
      name: "Recep Tayyip | Erdogan",
      lived: "1954.2.26 -",
    },
  },
  k_israel: {
    "1948.5.14" => {
      name: "David Ben-Gurion",
      lived: "1886–1973",
    },
    "1954.1.26" => {
      name: "Moshe Sharett",
      lived: "1894–1965",
    },
    "1955.11.3" => {use: "David 1"},
    "1963.6.26" => {
      name: "Levi Eshkol",
      lived: "1895–1969",
    },
    # skipping Yigal Allon, backdating
    # actually started 17 March 1969
    "1969.2.26" => {
      name: "Golda Meir",
      lived: "1898–1978",
      female: true,
    },
    "1974.6.3" => {
      name: "Yitzhak Rabin",
      lived: "1922–1995",
    },
    "1977.6.20" => {
      name: "Menachem Begin",
      lived: "1913–1992",
    },
    "1983.10.10" => {
      name: "Yitzhak Shamir", # Yitzhak 2
      lived: "1915–2012",
    },
    "1984.9.13" => {
      name: "Shimon Peres",
      lived: "1923–",
    },
    "1986.10.20" => {use: "Yitzhak 2" }, # Shamir
    "1992.7.13" => {use: "Yitzhak 1"}, # Rabin
    "1995.11.22" => {use: "Shimon 1"},
    "1996.6.18" => {
      name: "Benjamin Netanyahu",
      lived: "1949–",
    },
    "1999.7.6" => {
      name: "Ehud Barak",
      lived: "1942–",
    },
    "2001.3.7" => {
      name: "Ariel Sharon",
      lived: "1928–2014",
    },
    "2006.4.14" => {
      name: "Ehud Olmert",
      lived: "1945–",
    },
    "2009.3.31" => {use: "Benjamin 1"},
  },
  d_sunni: {
    "1695.2.6" => { use_all: "e_arabia" },
    "1922.11.1" => nil,
    caliphate_reborn: {
      name: "Abu Bakr | al-Baghdadi",
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
  k_afghanistan: {
    # There's a lot of year dates, fixing them all at 1.1. arbitrarily
    # Durrani Empire
    "1747.1.1"  => { name: "Ahmad | Durrani", lived: "1722 – 1772.10.16" },
    "1772.10.16" => { name: "Timur | Durrani", lived: "1748 – 1793.5.18", father: "Ahmad 1" },
    "1793.5.18" => { name: "Zaman | Durrani", lived: "1770 – 1844" , father: "Timur 1" },
    "1801.7.25" => { name: "Mahmud | Durrani", lived: "1769 – 1829.4.18", father: "Timur 1" },
    "1803.7.13" => { name: "Shuja | Durrani", lived: "1785.11.4 – 1842.4.5", father: "Timur 1" },
    "1809.5.3" => { use: "Mahmud 1" },
    "1818.1.1" => { name: "Ali | Durrani", lived: "?", father: "Timur 1" }, # no life dates
    "1819.1.1" => { name: "Ayub | Durrani", lived: "- 1837.10.1", father: "Timur 1" },
    # emirs
    "1823.1.1" => { name: "Dost Mohammad | Barakzai", lived: "1793.12.23 – 1863.6.9" },
    "1839.8.2" => { use: "Shuja 1" },
    "1842.4.5" => { name: "Akbar | Barakzai", lived: "1816–1845.1.1", father: "Dost Mohammad 1" },
    "1845.1.1" => { use: "Dost Mohammad 1" },
    "1863.6.9" => { name: "Sher Ali | Barakzai", lived: "1825 - 1879.2.21", father: "Dost Mohammad 1" },
    # wikipedia only has year date
    "1865.1.1" => { name: "Mohammad Afzal | Barakzai", lived: "1811 – 1867.10.7", father: "Dost Mohammad 1" },
    "1867.10.7" => { name: "Mohammad Azam | Barakzai", lived: "- 1868.2.21", father: "Dost Mohammad 1" },
    "1868.2.21" => { use: "Sher Ali 1" },
    "1879.2.21" => { name: "Mohammad Yaqub | Barakzai", lived: "1849 – 1923.11.15", father: "Sher Ali 1" },
    "1879.10.12" => { name: "Mohammad Ayub | Barakzai", lived: "1857 – 1914.4.7", father: "Sher Ali 1" },

    "1880.5.31" => { name: "Abdur Rahman | Barakzai", lived: "1844 – 1901.10.1", father: "Mohammad Afzal 1" },
    "1901.10.1" => { name: "Habibullah | Barakzai", lived: "1872.6.3 – 1919.2.20", father: "Abdur Rahman 1" },
    "1919.2.20" => { name: "Nasrullah | Barakzai", lived: "1874–1920", father: "Abdur Rahman 1" },
    # kings
    "1919.2.28" => { name: "Amanullah | Barakzai", lived: "June 1892 – 1960.4.25", father: "Habibullah 1" },
    "1929.1.14" => { name: "Inayatullah | Barakzai", lived: "1888.10.20 – 1946.8.12", father: "Habibullah 1" },
    "1929.1.17" => { name: "Habibullah | Kalakani", lived: "1891.1.19 – 1929.11.1" }, # non-dynastic
    "1929.10.16" => { name: "Mohammed Nadir | Barakzai", lived: "1883.4.9 – 1933.11.8" },
    "1933.11.8" => { name: "Mohammed Zahir | Barakzai", lived: "1914.10.15 – 2007.7.23", father: "Mohammed Nadir 1" },
    # republic
    # revolutionary council chairmen
    "1973.7.7" => { name: "Mohammed Daoud", lived: "1909.7.18 – 1978.4.28" },
    "1978.4.28" => { name: "Abdul Qadir", lived: "1944 – 2014.4.22" },
    "1978.4.30" => { name: "Nur Muhammad | Taraki", lived: "1917.7.15 – 1979.9.14" },
    "1979.9.14" => { name: "Hafizullah Amin", lived: "1929.8.1 – 1979.12.27" },
    "1979.12.27" => { name: "Babrak Karmal", lived: "1929.1.6 – 1 or 3 December 1996" },
    "1986.11.24" => { name: "Haji Mohammad | Chamkani", lived: "1947 -" },
    # presidents
    "1987.9.30" => { name: "Mohammad Najibullah", lived: "February 1947 – 1996.9.28" },
    "1992.4.16" => { name: "Abdul Rahim | Hatif", lived: "1926.5.20 – 2013.8.19" },
    # islamic state (Taliban)
    "1992.4.28" => { name: "Sibghatullah Mojaddedi", lived: "1926 -" },
    "1992.6.28" => { name: "Burhanuddin Rabbani", lived: "1940.9.20 – 2011.9.20" },
    "1996.9.27" => { name: "Mohammed Omar", lived: "1962 – 2013.4.23" },
    # transitional islamic state (non-Taliban)
    "2001.11.13" => { use: "Burhanuddin 1" },
    "2001.12.22" => { name: "Hamid Karzai", lived: "1957.12.24 -" },
    "2014.9.29" => { name: "Mohammad Ashraf | Ghani", lived: "1949 -" },
  },
}

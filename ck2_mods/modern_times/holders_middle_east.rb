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
    },
    "1703.8.22" => {
      name: "Ahmed | Ottoman", lived: "1673.12.31 – 1736.7.1", # father: "Mehmed",
    },
    "1730.10.2" => { # 1
      name: "Mahmud | Ottoman", lived: "1696.8.2  – 1754.12.13", father: "Mustafa 1",
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
    },
    "1807.5.29" => { # 3
      name: "Mustafa | Ottoman", lived: "1779.9.8 – 1808.11.16", father: "Abdülhamid 1",
    },
    "1808.7.28" => { # 2
      name: "Mahmud | Ottoman", lived: "1789.7.20 – 1839.7.1", father: "Abdülhamid 1",
    },
    "1839.7.1" => {
      name: "Abdülmecid | Ottoman", lived: "1823.4.25 – 1861.6.25", father: "Mahmud 2",
    },
    "1861.6.25" => {
      name: "Abdulaziz | Ottoman", lived: "1830.2.18 – 1876.6.4", father: "Mahmud 2",
    },
    "1876.5.30" => {
      name: "Mehmed Murad | Ottoman", lived: "1840.9.21 – 1904.8.29", father: "Abdülmecid 1",
    },
    "1876.8.31" => {
      name: "Abdulhamid | Ottoman", lived: "1842.9.22 – 1918.2.10", father: "Abdülmecid 1",
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
  d_oultrejourdain: {
    # Backdating hard from "1921.4.1"
    "1918.11.11" => {
      name: "Abdullah | Hashemite",
      lived: "1882.2.1 - 1951.7.20",
      father: "d_medina Hussein ibn Ali 1",
      traits: ["sayyid"],
    },
    "1951.7.20" => {
      name: "Talal | Hashemite",
      lived: "1909.2.26 - 1972.7.7",
      father: "Abdullah 1",
      traits: ["sayyid"],
    },
    "1952.8.11" => {
      name: "Hussein | Hashemite",
      lived: "1935.11.14 - 1999.2.7",
      father: "Talal 1",
      traits: ["sayyid"],
    },
    "1999.2.7" => {
      name: "Abdullah | Hashemite",
      lived: "1962.1.30-",
      father: "Hussein 1",
      traits: ["sayyid"],
    },
  },
  k_mesopotamia: {
    # First ruler is son of "d_medina Hussein ibn Ali 1"

    "1958.7.14" => {name: "Muhammad Najib | ar-Ruba'i", lived: "1904 - 1965"},
    "1963.2.8" => {name: "Abdul Salam | Arif", lived: "1921.3.21 - 1966.4.13"},
    # brother of previous
    "1966.4.13"=> {name: "Abdul Rahman | Arif", lived: "1916.4.14 - 2007.8.24"},
    "1968.7.17" => {name: "Ahmed Hassan | al-Bakr", lived: "1914.7.1 - 1982.10.4"},
    "1979.7.16" => {name: "Saddam | Hussein", lived: "1937.4.28 - 2006.12.30", traits: ["cynical", "paranoid"], health: 6},
    # Backdating hard
    "2003.4.9" => {name: "Jalal | Talabani", lived: "1933.11.12-"},
    "2014.7.24" => {name: "Fuad | Masum", lived: "1938.1.1-"},
  },
  k_syria: {
    "1971.2.22" => {name: "Hafez | al-Assad", lived: "1930.10.6 - 2000.6.10"},
    "2000.6.10" => {name: "Bashar | al-Assad", lived: "1965.9.11-", father: "Hafez 1"},
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
  d_nefoud: {
    "1902.1.13" => {name: "Abdulaziz | Saud", lived: "1876.11.26 - 1953.11.9"},
    end_ww1: nil,
  },
  k_arabia: {
    # "Emirate of Nejd and Hasa" etc., maybe I should differentiate those titles
    # It's total bullshit backdating before "1902.1.13" when he got first duchy
    end_ww1: {use: "d_nefoud Abdulaziz 1" },
    "1953.11.9" => {name: "Saud | Saud", father: "d_nefoud Abdulaziz 1", lived: "1902.1.12 - 1969.2.23"},
    "1964.11.2" => {name: "Faisal | Saud", father: "d_nefoud Abdulaziz 1", lived: "1906.4.14 - 1975.3.25"},
    "1975.3.25" => {name: "Khalid | Saud", father: "d_nefoud Abdulaziz 1", lived: "1913.2.13 - 1982.6.13"},
    "1982.6.13" => {name: "Fahd | Saud", father: "d_nefoud Abdulaziz 1", lived: "1921.3.16 - 2005.8.1"},
    "2005.8.1" => {name: "Abdullah | Saud", father: "d_nefoud Abdulaziz 1", lived: "1924.8.1 - 2015.1.23"},
    "2015.1.23" => {name: "Salman | Saud", father: "d_nefoud Abdulaziz 1", lived: "1935.12.31 -"},
  },
  c_kuwait: {
    kuwait_independence: {name: "Abdullah Salem Al-Mubarak | Al-Sabah", lived: "1895 - 1965"},
    "1965.11.24" => {name: "Sabah Salem Al-Mubarak | Al-Sabah", lived: "1913 - 1977"},
    "1977.12.31" => {name: "Jaber Al-Ahmad Al-Jaber | Al-Sabah", lived: "1926 - 2006"},
    "2006.1.15" => {name: "Saad Abdullah Al-Salem | Al-Sabah", lived: "1930 - 2008"},
    "2006.1.29" => {name: "Sabah Al-Ahmad Al-Jaber | Al-Sabah", lived: "1929 -"},
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
  d_medina: {
    "1918.11.11" => {
      name: "Hussein ibn Ali | Hashemite",
      lived: "1854 – 1931.6.4",
      traits: ["sayyid"],
    },
    "1924.10.3" => {
      name: "Ali bin Hussein | Hashemite",
      lived: "1879–1935",
      father: "Hussein ibn Ali 1",
      traits: ["sayyid"],
    },
    "1926.1.8" => nil,
  },
  k_egypt: {
    "1805.6.18"  => { name: "Muhammad Ali | Muhammad Ali", lived: "1769.3.4 – 1849.8.2" },
    "1848.7.20"  => { name: "Ibrahim | Muhammad Ali", lived: "1789 – 1848.11.10", father: "Muhammad Ali 1" },
    "1848.11.10"  => { name: "Abbas Helmi | Muhammad Ali", lived: "1812.7.1 – 1854.7.13" },
    "1854.7.13"  => { name: "Muhammad Sa'id | Muhammad Ali", lived: "1822.3.17 – 1863.1.18" },
    "1863.1.18"   => { name: "Isma'il | Muhammad Ali", lived: "1830.12.31 – 1895.3.2" },
    "1879.6.26"  => { name: "Muhammad Tawfiq | Muhammad Ali", lived: "1852.11.15 – 1892.1.7" },
    "1892.1.7"   => { name: "Abbas Helmi | Muhammad Ali", lived: "1874.7.14 – 1944.12.19" },
    "1914.12.19" => { name: "Hussein Kamel | Muhammad Ali", lived: "November 1853 – 1917.10.9" },
    # Kings
    "1917.10.9" => { name: "Ahmed Fuad | Muhammad Ali", lived: "1868.3.26 - 1936.4.28" },
    "1936.4.28" => { name: "Farouk | Muhammad Ali", lived: "1920.2.11 – 1965.3.18", father: "Ahmed Fuad 1" }, # 1
    "1952.7.26" => { name: "Ahmed Fuad | Muhammad Ali", lived: "1952.1.16 -", father: "Farouk 1" },
    # Peres"residents
    "1953.6.18"  => { name: "Muhammad Naguib", lived: "1901.2.20 – 1984.8.28" },
    "1954.11.14" => { name: "Gamal Abdel | Nasser", lived: "1918.1.15 – 1970.9.28" },
    "1970.9.28"  => { name: "Anwar Sadat", lived: "1948.12.25 – 1981.10.6" },
    # backdating
    "1981.10.6" => { name: "Hosni Mubarak", lived: "1928.5.4 -" },
    "2012.6.30" => { name: "Mohamed Morsi", lived: "1951.8.8 -" },
    # backdating
    "2013.7.3" => { name: "Abdel Fattah | el-Sisi", lived: "1954.11.19 -" },
  },
}

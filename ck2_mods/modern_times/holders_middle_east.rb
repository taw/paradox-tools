ModernTimesDatabase::HOLDERS_MIDDLE_EAST = {
  k_persia: {
    "1785.2.18" => {
      name: "Jafar | Zand",
    },
    "1789.1.23" => {
      name: "Lotf Ali | Zand",
    },
    "1794.3.20" => {
      name: "Mohammad | Qajar",
    },
    "1797.6.17" => {
      name: "Fat'h Ali | Qajar",
    },
    "1834.10.23" => {
      name: "Mohammad | Qajar",
    },
    "1848.9.5" => {
      name: "Naser al-Din | Qajar",
    },
    "1896.5.1" => {
      name: "Mozaffar al-Din | Qajar",
    },
    "1907.1.3" => {
      name: "Mohammad Ali | Qajar",
    },
    "1909.6.16" => {
      name: "Ahmad | Qajar",
    },
    "1925.12.15" => {
      name: "Reza | Pahlavi",
    },
    "1941.9.16" => {
      name: "Mohammad Reza | Pahlavi",
    },
    "1979.2.11" => {
      name: "Ruhollah | Khomeini",
      lived: "1902.9.22 - 1989.6.3",
    },
    "1989.6.3" => {
      name: "Ali | Khamenei",
      lived: "1939.7.17 -",
    },
  },
  e_arabia: {
    "1695.2.6" => {
      name: "Mustafa | Ottoman",
    },
    "1703.8.22" => {
      name: "Ahmed | Ottoman",
    },
    "1730.10.2" => {
      name: "Mahmud | Ottoman",
    },
    "1754.12.13" => {
      name: "Osman | Ottoman",
    },
    "1757.10.30" => {
      name: "Mustafa | Ottoman",
    },
    "1774.1.21" => {
      name: "Abdulhamid | Ottoman",
    },
    "1789.4.7" => {
      name: "Selim | Ottoman",
    },
    "1807.5.29" => {
      name: "Mustafa | Ottoman",
    },
    "1808.7.28" => {
      name: "Mahmud | Ottoman",
    },
    "1839.7.1" => {
      name: "Abdulmecid | Ottoman",
    },
    "1861.6.25" => {
      name: "Abdulaziz | Ottoman",
    },
    "1876.5.30" => {
      name: "Mehmed Murad | Ottoman",
    },
    "1876.8.31" => {
      name: "Abdulhamid | Ottoman", lived: "- 1918.2.10",
    },
    "1909.4.27" => {
      name: "Mehmed | Ottoman",
    },
    "1918.7.4" => {
      name: "Mehmed | Ottoman", lived: "- 1926.5.16",
    },
    "1922.11.1" => nil,
  },
  k_anatolia: {
    # There was a caliph Abdulmecid II for 1922-1924, consider maybe?
    # Dates are changed to fill the gaps
    "1922.11.1" => {
      name: "Mustafa Kemal | Ataturk",
    },
    "1938.11.11" => {
      name: "Ismet | Inonu",
    },
    "1950.5.22" => {
      name: "Celal | Bayar",
    },
    # Skipping National Unity Committee
    "1961.10.10" => {
      name: "Cemal | Gursel",
    },
    "1966.3.28" => {
      name: "Cevdet | Sunay",
    },
    "1973.4.6" => {
      name: "Fahri | Koruturk",
    },
    # Skipping National ecurity Council
    "1982.11.9" => {
      name: "Kenan | Evren",
      lived: "1917 - 2015",
    },
    "1989.11.9" => {
      name: "Torgut | Ozal",
      lived: "1927 - 1993",
    },
    "1993.5.16" => {
      name: "Suleyman | Demirel",
      lived: "1924 - 2015",
    },
    "2000.5.16" => {
      name: "Ahmet Necdet | Sezer",
      lived: "1941 -",
    },
    "2007.8.28" => {
      name: "Abdullah | Gul",
      lived: "1950 -",
    },
    "2014.8.28"  => {
      name: "Recep Tayyip | Erdogan",
      lived: "1954 -",
    },
  },
  d_oultrejourdain: {
    "1921.4.1" => {
      name: "Abdullah | Hashemite",
      lived: "1882.2.1 - 1951.7.20",
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
    "1958.7.14" => {name: "Muhammad Najib | ar-Ruba'i", lived: "1904 - 1965"},
    "1963.2.8" => {name: "Abdul Salam | Arif", lived: "1921.3.21 - 1966.4.13"},
    # brother of previous
    "1966.4.13"=> {name: "Abdul Rahman | Arif", lived: "1916.4.14 - 2007.8.24"},
    "1968.7.17" => {name: "Ahmed Hassan | al-Bakr", lived: "1914.7.1 - 1982.10.4"},
    "1979.7.16" => {name: "Saddam | Hussein", lived: "1937.4.28 - 2006.12.30"},
    # Backdating hard
    "2003.4.9" => {name: "Jalal | Talabani", lived: "1933.11.12-"},
    "2014.7.24" => {name: "Fuad | Masum", lived: "1938.1.1-"},
  },
  k_syria: {
    "1971.2.22" => {name: "Hafez | al-Assad", lived: "1930.10.6 - 2000.6.10"},
    "2000.6.10" => {name: "Bashar | al-Assad", lived: "1965.9.11-", father: "Hafez 1"},
  },
  d_sunni: {
    "1695.2.6" => { use: "e_arabia Mustafa 1" },
    "1703.8.22" => { use: "e_arabia Ahmed 1" },
    "1730.10.2" => { use: "e_arabia Mahmud 1" },
    "1754.12.13" => { use: "e_arabia Osman 1" },
    "1757.10.30" => { use: "e_arabia Mustafa 2" },
    "1774.1.21" => { use: "e_arabia Abdulhamid 1" },
    "1789.4.7" => { use: "e_arabia Selim 1" },
    "1807.5.29" => { use: "e_arabia Mustafa 3" },
    "1808.7.28" => { use: "e_arabia Mahmud 2" },
    "1839.7.1" => { use: "e_arabia Abdulmecid 1" },
    "1861.6.25" => { use: "e_arabia Abdulaziz 1" },
    "1876.5.30" => { use: "e_arabia Mehmed Murad 1" },
    "1876.8.31" => { use: "e_arabia Abdulhamid 2" },
    "1909.4.27" => { use: "e_arabia Mehmed 1" },
    "1918.7.4" => { use: "e_arabia Mehmed 2" },
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
}

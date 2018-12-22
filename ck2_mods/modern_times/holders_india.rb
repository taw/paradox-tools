ModernTimesDatabase::HOLDERS_INDIA = {
  e_offmap_china: {
    # Somewhat dubious when to start counting Qing, will only matter if we move back that far, which is unlikely
    # Wikipedia gives crowning dates leaving gaps, so we backdate everyone to death of their predecessor
    "1616.2.17" => {name: "Nurhaci | Qing", lived: "1559.2.21 - 1626.9.30" },
    "1626.9.30" => {name: "Hong Taiji | Qing", lived: "1592.11.28 - 1643.9.21", father: "Nurhaci" },
    "1643.9.21" => {name: "Fulin | Qing", lived: "1638.3.15 - 1661.2.5", father: "Hong Taiji" },
    "1661.2.5" => {name: "Xuanye | Qing", lived: "1654.5.4 - 1722.12.20", father: "Fulin" },
    "1722.12.20" => {name: "Yinzhen | Qing", lived: "1678.12.13 - 1735.10.8", father: "Xuanye" },
    "1735.10.8" => {name: "Hongli | Qing", lived: "1711.9.25 - 1799.2.7", father: "Yinzhen" },
    "1799.2.7" => {name: "Yongyan | Qing", lived: "1760.11.13 - 1820.9.2", father: "Hongli" },
    "1820.9.2" => {name: "Minning | Qing", lived: "1782.9.16 - 1850.2.25", father: "Yongyan" },
    "1850.2.25" => {name: "Yizhu | Qing", lived: "1831.7.17 - 1861.8.22", father: "Minning" },
    "1861.8.22" => {name: "Zaichun | Qing", lived: "1856.4.27 - 1875.1.12", father: "Yizhu" },
    # adopted by Yizhu who was his uncle
    "1875.1.12" => {name: "Zaitian | Qing", lived: "1871.8.14 - 1908.11.14", father: "Yizhu" },
    # adopted by both previous emperors, Zaitian was his uncle
    "1908.11.14" => {name: "Puyi | Qing", lived: "1906.2.7 - 1967.10.17", father: "Zaitian" },

    # Republican China
    # Picking up the most prominent of various office holders
    "1912.2.12" => { name: "Sun | Yat-sen", lived: "1866.11.12 - 1925.3.12" },
    "1912.3.10" => { name: "Shikai | Yuan", lived: "1859.9.16 - 1916.6.6" },

    # Now there's a decade of bullshit, there was no real Chinese government here,
    # so here's a 3 times president.
    # This could be fixed I guess.
    "1916.6.6" => { name: "Yuanhong | Li", lived: "1864.10.19 - 1928.6.3" },

    # Proper KMT governent
    "1928.2.7" => { name: "Yankai | Tan", lived: "1880.1.25 - 1930.9.22" },
    "1928.10.10" => { name: "Kai-shek | Chiang", lived: "1887.10.31 - 1975.4.5" },

    # Communist China
    # https://en.wikipedia.org/wiki/Paramount_leader
    # Mao kept as ruler for as long as he lived
    "1949.10.1" => { name: "Zedong | Mao", lived: "1893.12.26 - 1976.9.9" },
    "1976.9.9" => { name: "Guofeng | Hua", lived: "1921.2.16 - 2008.8.20" },
    "1978.12.22" => { name: "Xiaoping | Deng", lived: "1904.8.22 - 1997.2.19" },
    "1992.10.19" => { name: "Zemin | Jiang", lived: "1926.8.17 -" },
    "2002.11.15" => { name: "Jintao | Hu", lived: "1942.12.21 -" },
    "2012.11.15" => { name: "Jinping | Xi", lived: "1953.6.15 -" },
  },
  e_tibet: {
    # Dalai Lamas
    # The whole system is bullshit, with interregnums and child reigns
    # We make up a lot of dates here:
    # * everyone is Dalai Lama from birth
    # * everyone lives a bit longer to fill in the interregnum

    # Lungtok and before only year dates
    "1805.1.1" => { name: "Lungtok | Gyatso", lived: "1805.1.1 - 1816.3.29" },
    "1816.3.29" => { name: "Tsultrim | Gyatso", lived: "1816.3.29 - 1838.11.1" },
    "1838.11.1" => { name: "Khedrup | Gyatso", lived: "1838.11.1 - 1857.1.26" },
    "1857.1.26" => { name: "Trinley | Gyatso", lived: "1857.1.26 - 1876.2.12" },
    "1876.2.12" => { name: "Thubten | Gyatso", lived: "1876.2.12 - 1935.7.6"},
    "1935.7.6"  => { name: "Tenzin | Gyatso", lived: "1935.7.6 -"},
  },
  # Without "Bir Bikram" and other middle names, they look bad in UI
  k_nepal: {
    "1768.9.25"  => { name: "Prithvi Narayan | Shah", lived: "1723.1.7 - 1775.1.11" },
    "1775.1.11"  => { name: "Pratap Singh | Shah", lived: "1751.4.16 - 1777.11.17", father: "Prithvi Narayan" },
    "1777.11.17" => { name: "Rana Bahadur | Shah", lived: "1775.5.25 - 1806.4.25", father: "Pratap Singh" },
    "1799.3.8"   => { name: "Girvan Yuddha | Shah", lived: "1797.10.19 - 1816.11.20", father: "Rana Bahadur" },
    "1816.11.20" => { name: "Rajendra | Shah", lived: "1813.12.3 - 1881.7.10", father: "Girvan Yuddha" },
    "1847.5.12"  => { name: "Surendra | Shah", lived: "1829.10.20 - 1881.5.17", father: "Rajendra" },
    # grandson of Surendra Bikram
    "1881.5.17"  => { name: "Prithvi | Shah", lived: "1875.8.18 - 1911.12.11" },
    "1911.12.11" => { name: "Tribhuvan | Shah", lived: "1906.6.30 - 1955.3.13", father: "Prithvi" },
    # grandson of Tribhuvan
    "1950.11.7"  => { name: "Gyanendra | Shah", lived: "1947.7.7 -" },
    "1951.1.7"   => { use: "Tribhuvan" },
    "1955.3.14"  => { name: "Mahendra | Shah", lived: "1920.6.11 - 1972.1.31", father: "Tribhuvan" },
    "1972.1.31"  => { name: "Birendra | Shah", lived: "1945.12.28 - 2001.6.1", father: "Mahendra" },
    "2001.6.1"   => { name: "Dipendra | Shah", lived: "1971.6.27 - 2001.6.4", father: "Birendra" },
    "2001.6.4"   => { use: "Gyanendra", },
    # end of monarchy, backdating presidents to fill the gap
    "2008.5.28"  => { name: "Ram Baran | Yadav", lived: "1948.2.4 -" },
    "2015.10.29" => { name: "Bidhya Devi | Bhandari", lived: "1961.6.19 -", female: true },
  },
  d_bhutan: {
    "1907.12.17" => { name: "Ugyen | Wangchuck", lived: "1862 - 1926.8.21" },
    "1926.8.21"  => { name: "Jigme | Wangchuck", lived: "1905 - 1952.3.24", father: "Ugyen" },
    "1952.3.24"  => { name: "Jigme Dorji | Wangchuck", lived: "1929.5.2 - 1972.7.21", father: "Jigme" },
    "1972.7.21"  => { name: "Jigme Singye | Wangchuck", lived: "1955.11.11 -", father: "Jigme Dorji" },
    "2006.12.14" => { name: "Jigme Khesar Namgyel | Wangchuck", lived: "1980.2.21 -", father: "Jigme Singye" },
  },
  e_india: {
    third_maratha_war: { use_all: "e_britannia" },
    "1947.8.15"   => {name: "Jawharlal | Nehru", lived: "1889 - 1964"},
    "1964.6.9"    => {name: "Lal Bahadur | Shatri", lived: "1904 - 1966"},
    "1966.1.24"   => {name: "Indira | Gandhi", lived: "1917 - 1984", female: true},
    "1977.3.24"   => {name: "Morarji | Desai", lived: "1896 - 1995"},
    "1979.7.28"   => {name: "Charan | Singh", lived: "1902 - 1987"},
    "1980.1.14"   => {use: "Indira 1"},
    "1984.10.31"  => {name: "Rajiv | Gandhi", lived: "1944 - 1991"},
    "1989.12.2"   => {name: "Vishwanath Pratap | Singh", lived: "1931.6.25 - 2008.11.27"},
    "1990.11.10"  => {name: "Chandra | Shekhar", lived: "1927 - 2007"},
    "1991.6.21"   => {name: "Pamulaparti Venkata Narasimha | Rao", lived: "1921 - 2004"},
    "1996.5.16"   => {name: "Atal Bihari | Vajpayee", lived: "1924 -"},
    "1996.6.1"    => {name: "Haradanahalli Doddegowda Deve | Gowda", lived: "1933.5.18 -"},
    "1997.4.21"   => {name: "Inder Kumar | Gujral", lived: "1919.12.4 - 2012.11.30"},
    "1998.3.19"   => {use: "Atal Bihari 1"},
    "2004.5.22"   => {name: "Manmohan | Singh", lived: "1932 -"},
    "2014.5.26"   => {name: "Narendra | Modi", lived: "1950 -"},
  },
  e_rajastan: { # Mughals
    "1806.11.19" => {
      name: "Akbar | Timurid",
      lived: "1760.4.22 - 1837.9.28",
    },
    # Demote them to king of Delhi or something? there's one more under Britain
    third_maratha_war: nil,
  },
  e_deccan: { # Marathas
    "11th December 1777" => {
      name: "Shahu | Bhonsle",
      lived: "1763 - 1808.5.3",
    },
    "1808.5.3" => {
      name: "Pratap Singh | Bhonsle",
      lived: "1793.1.18 - 1847.10.14",
      father: "Shahu 1",
    },
    third_maratha_war: nil,
  },
  k_lanka: {
    # Prime Ministers
    # Supposedly started 1947.9.24, postdating to 1948.2.4
    :sri_lanka_independence => {name: "Don Stephen | Senanayake", lived: "1884 - 1952"},
    "1952.3.26" => {name: "Dudley | Senanayake", lived: "1911 - 1973"},
    "1953.10.12" => {name: "John | Kotelawala", lived: "1897 - 1980"},
    "1956.4.12" => {name: "Solomon | Bandaranaike", lived: "1899 - 1959"},
    "1959.9.26" => {name: "Wijeyananda | Dahanayake", lived: "1902 - 1997"},
    "1960.3.21" => {use: "Dudley 1"},
    "1960.7.21" => {name: "Sirimavo | Bandaranaike", lived: "1916 - 2000", female: true},
    "1965.3.25" => {use: "Dudley 1"},
    "1970.5.29" => {use: "Sirimavo 1"}, # She continues next term after presidency established as prime minister, but that no longer matters
    # Presidency established
    "1972.5.22" => {name: "William | Gopallawa", lived: "1897 - 1981"},
    "1978.2.4" => {name: "Junius Richard | Jayewardene", lived: "1906 - 1996"},
    "1989.1.2" => {name: "Ranasinghe | Premadasa", lived: "1924 - 1993"},
    "1993.5.1" => { name: "Dingiri Banda | Wijetunga", lived: "1916 - 2008" },
    "1994.11.12" => {name: "Chandrika | Kumaratunga", lived: "1945-", female: true },
    "2005.11.19" => {name: "Mahinda | Rajapaksa", lived: "1945-" },
    "2015.1.9" => {name: "Maithripala | Sirisena", lived: "1951-" },
  },
  c_maldives: {
    # 1953+ presidents and sultans under Britain
    maldives_independence: {
      name: "Muhammad Fareed | Didi",  # as sultan, others are presidents
      lived: "1901-1969",
    },
    "1968.11.11" => {
      name: "Ibrahim | Nasir",
      lived: "1926-2008",
    },
    "1978.11.11" => {
      name: "Maumoon Abdul | Gayoom",
      lived: "1937-",
    },
    "2008.11.11" => {
      name: "Mohamed | Nasheed",
      lived: "1967-"
    },
    "2012.2.7" => {
      name: "Mohammed Waheed | Hassan",
      lived: "1953-",
    },
    "2013.11.17" => {
      name: "Abdulla | Yameen",
      lived: "1959-",
    },
  },
  k_punjab: {
    "1801.4.12" => {
      name: "Ranjit Singh",
      lived: "1780.11.13 - 1839.6.27",
    },
    "1839.6.27" => {
      name: "Kharak Singh",
      lived: "1801.2.22 - 1840.11.5",
      father: "Ranjit 1",
    },
    "1839.10.8" => {
      name: "Nau Nihal | Singh",
      lived: "1821.3.9 - 1840.11.6",
      father: "Kharak 1",
    },
    # Chand Kaur ruled as a regent for pregnant daugher, let's skip this stuff and backdate
    "1840.11.6" => {
      name: "Sher Singh",
      lived: "1807.12.4 - 1843.9.15",
      father: "Ranjit 1",
    },
    "1843.9.15" => {
      name: "Duleep Singh",
      lived: "1838.9.6 - 1893.10.22",
      father: "Ranjit 1",
    },
    "1849.3.29" => nil,
  },
  k_baluchistan: { # Pakistan
    # Governor-Generals initially
    "1947.8.15" => { name: "Muhammad Ali | Jinnah", lived: "1876.12.25 - 1948.9.11" },
    # actually "1948.11.13", backdating
    "1948.9.11" => { name: "Khawaja Nazimuddin", lived: "1894.7.19 - 1964.10.22" },
    "1951.10.19"=> { name: "Ghulam Muhammad", lived: "1895.4.20 - 1956.9.12" },
    # became presidents since 1956.3.23, presidents from that time on
    "1955.8.7"  => { name: "Iskander Mirza", lived: "1899.11.13 - 1969.11.13" },
    "1958.10.27" => { name: "Ayub Khan", lived: "1907.5.14 -1974.4.19" },
    "1969.3.25"  => { name: "Yahya Khan", lived: "February 1917 - 1980.8.10" },
    "1971.12.20" => { name: "Zulfikar Ali | Bhutto", lived: "1928.1.5 - 1979.4.4" },
    "1973.8.14"  => { name: "Fazal Ilahi | Chaudhry", lived: "1904.1.1 - 1982.6.2" },
    "1978.9.16"  => { name: "Muhammad Zia-ul-Haq", lived: "1924.8.12 - 1988.8.17" },
    "1988.8.17"  => { name: "Ghulam Ishaq | Khan", lived: "1915.1.20 - 2006.10.27" },
    "1993.7.18"  => { name: "Wasim Sajjad", lived: "1941.3.30 -" },
    "1993.11.14" => { name: "Farooq Leghari", lived: "1940.5.29 - 2010.10.20" },
    "1997.12.2"  => { use: "Wasim 1" },
    "1998.1.1"   => { name: "Muhammad Rafiq | Tarar", lived: "1929.11.2 -" },
    "2001.6.20"  => { name: "Pervez Musharraf", lived: "1943.8.11 -" },
    "2008.8.18"  => { name: "Muhammad Mian | Soomro", lived: "1950.8.19 -" },
    "2008.9.9"   => { name: "Asif Ali | Zardari", lived: "1955.7.26 -" },
    "2013.9.9"   => { name: "Mamnoon Hussain", lived: "1940.12.23 -" },
  },
}

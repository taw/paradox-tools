ModernTimesDatabase::HOLDERS_ARABIA = {
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
  d_arabia_felix: {
    #  Mutawakkilite Kingdom of Yemen, imams
    # ruling from 4 June 1904
    "1918.10.30" => {
      name: "Yahya |  Rassid",
      lived: "1869.6.18 - 1948.2.17"
    },
    "1948.2.17" => {
      name: "Ahmad | Rassid",
      lived: "1891.6.18 - 1962.9.18",
      father: "Yahya 1"
    },
    "1962.9.18" => {
      name: "Muhammad Al-Badr | Rassid",
      lived: "1926.2.15 - 1996.8.6",
      father: "Ahmad 1",
    },
    # Yemen Arab Republic
    "1962.9.27" => { name: "Abdullah as-Sallal", lived: "1917.1.9 – 1994.3.5" },
    "1967.11.5" => { name: "Abdul Rahman | al-Iryani", lived: "1908 - 1998.3.14" },
    "1974.6.13" => { name: "Ibrahim al-Hamdi", lived: "1943 - 1977.10.11" },
    "1977.10.11"=> { name: "Ahmad al-Ghashmi", lived: "1938 – 1978.6.24" },
    "1978.6.24" => { name: "Abdul Karim Abdullah | al-Arashi", lived: "1934.12.1 - 2006.6.10" },
    "1978.7.18" => { name: "Ali Abdullah | Saleh", lived: "1942.3.21 -" },
    "1990.5.22" => nil,
  },
  d_sanaa: {
    "1967.11.30" => { name: "Qahtan Muhammad | al-Shaabi", lived: "1920–1981" },
    "1969.6.23"  => { name: "Salim Rubai | Ali", lived: "1935 – 1978.6.26" },
    "1978.6.26"  => { name: "Ali Nasir | Muhammad", lived: "1939 -" },
    "1978.12.27" => { name: "Abdul Fattah | Ismail", lived: "1939 – 1986.1.13" },
    "1980.4.26"  => { use: "Ali Nasir 1" },
    "1986.1.24"  => { name: "Haidar Abu Bakr | al-Attas", lived: "1939.4.5 -" },
    # Unification
    "1990.5.22" => { use: "d_arabia_felix Ali Abdullah 1" },
    "2012.2.27" => { name: "Abd Rabbuh Mansur | Hadi", lived: "1945.9.1 -" },
  },
  d_oman: {
    "1806.9.14" => { name: "Said | al Said", lived: "1797.6.5 – 1856.10.19" },
    "1856.10.19"=> { name: "Thuwaini | al Said", lived: "1821 - 1866.2.11", father: "Said 1" },
    "1866.2.11" => { name: "Salim | al Said", lived: "- 1876.12.7", father: "Thuwaini 1" },
    # distant relative, said killed in 1870, but next ruler from Jan 1871...
    "1868.10.3" => { name: "Azzan | al Said", lived: "- 1871.1.30" },
    "1871.1.30" => { name: "Turki | al Said", lived: "1832 – 1888.6.4", father: "Said 1" },
    "1888.6.4"  => { name: "Faisal | al Said", lived: "1864 – 1913.10.4", father: "Turki 1" },
    "1892.3.13" => nil,
    # from "1970.7.23", initially under UK
    "1971.12.2" => { name: "Qaboos | al Said", lived: "1940.11.18 -" },
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
  k_iraq: {
    # Backdating
    "1920.4.25" => {
      name: "Faisal | Hashemite",
      lived: "1885.5.20 – 1933.9.8",
      father: "d_medina Hussein ibn Ali 1",
      traits: ["sayyid"],
    },
    "1933.9.8" => {
      name: "Ghazi | Hashemite",
      lived: "1912.5.2 – 1939.4.4",
      father: "Faisal 1",
      traits: ["sayyid"],
    },
    "1939.4.4" => {
      name: "Faisal | Hashemite",
      lived: "1935.5.2 – 1958.7.14",
      father: "Ghazi 1",
      traits: ["sayyid"],
    },

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
    # a lot of one-day rulers, skipping them
    "1946.4.17"  => { name: "Shukri al-Quwatli", lived: "1891 – 1967.6.30" },
    "1949.3.30"  => { name: "Husni al-Za'im", lived: "1897 – 1949.8.14" },
    "1949.8.14"  => { name: "Hashim al-Atassi", lived: "1875 – 1960.12.5" },
    "1951.12.2"  => { name: "Fawzi Selu", lived: "1905–1972" },
    "1953.7.11"  => { name: "Adib Shishakli", lived: "1909 - 1964.9.27" },
    "1954.2.25"  => { name: "Hashim al-Atassi", lived: "1875 – 1960.12.5" },
    "1958.2.22"  => { use: "k_egypt Gamal Abdel 1" },
    "1961.9.29"  => { name: "Maamun al-Kuzbari", lived: "1914–1998" },
    "1961.11.20" => { name: "Izzat al-Nuss", lived: "1900–1972" },
    "1961.12.14" => { name: "Nazim al-Kudsi", lived: "1906.2.14 – 1998.2.6" },
    "1963.3.9"   => { name: "Lu'ay al-Atassi", lived: "1926–November 2003" },
    "1963.7.27"  => { name: "Amin al-Hafiz", lived: "1918 – 2009.12.17" },
    "1966.2.25"  => { name: "Nureddin al-Atassi", lived: "1929 – 1992.12.3" },
    "1970.11.18" => { name: "Ahmad al-Khatib", lived: "1933–1982" },
    "1971.2.22"  => { name: "Hafez | al-Assad", lived: "1930.10.6 - 2000.6.10"},
    "2000.6.10"  => { name: "Bashar | al-Assad", lived: "1965.9.11-", father: "Hafez 1"},
  },
  d_galilee: {
    # Ignore all before independence
    "1943.11.22" => { name: "Bechara Khoury", lived: "1890.8.10 – 1964.1.11" },
    "1952.9.18"  => { name: "Fuad Chehab", lived: "1902.3.19 - 1973.4.25" },
    "1952.9.23"  => { name: "Camille Chamoun", lived: "1900.4.3 – 1987.8.7" },
    "1958.9.23"  => { use: "Fuad 1" },
    "1964.9.23"  => { name: "Charles Helou", lived: "1913.9.25 – 2001.1.7" },
    "1970.9.23"  => { name: "Suleiman Frangieh", lived: "1910.6.15 – 1992.7.23" },
    "1976.9.23"  => { name: "Elias Sarkis", lived: "1924.7.20 – 1985.6.27" },
    "1982.8.23"  => { name: "Bachir Gemayel", lived: "1947.11.10 – 1982.9.14" },
    # backdating from 1982.9.23
    # brother of Bachir Gemayel
    "1982.9.14"  => { name: "Amine Gemayel", lived: "1942.1.22 -" },
    # Ignoring Selim Hoss conflict here
    "1988.9.22"  => { name: "Michel Aoun", lived: "1935.2.18 -" },
    "1989.11.5"  => { name: "René Moawad", lived: "1925.4.17 – 1989.11.22" },
    "1989.11.22" => { name: "Selim Hoss", lived: "1929.12.20 -" },
    "1989.11.24" => { name: "Elias Hrawi", lived: "1926.9.4 - 2006.7.7" },
    "1998.11.24" => { name: "Émile Lahoud", lived: "1936.1.12 -" },
    "2007.11.24" => { name: "Fouad Siniora", lived: "1943.11.22 -" },
    "2008.5.5"   => { name: "Michel Suleiman", lived: "1948.11.21 -" },
    "2014.5.25"  => { name: "Tammam Salam", lived: "1945.5.13 -" },
  },
  c_bahrein: { # Qatar
    # Start count from independence, there were sheiks under British protectorate before that
    "1971.9.1"  => { name: "Ahmad | Al Thani", lived: "1920 – 1977.11.25" },
    "1972.2.22" => { name: "Khalifa | Al Thani", lived: "1932.9.17 – 2016.10.23" },
    "1995.6.27" => { name: "Hamad | Al Thani", lived: "1952.1.1 -", father: "Khalifa" },
    "2013.6.25" => { name: "Tamim | Al Thani", lived: "1980.6.3 -", father: "Hamad" },
  },
  c_uwal: { # Bahrain
    # Hakims of Bahrain until Britain took over, ignoring co-regents
    # Wikipedia has only year dates and very little extra info
    # death dates totally fictional
    "1783.1.1" => { name: "Ahmed | Al Khalifa", lived: "- 1796.1.1" },
    "1796.1.1" => { name: "Abdullah | Al Khalifa", lived: "- 1843.1.1" },
    "1843.1.1" => { name: "Muhammad | Al Khalifa", lived: "- 1868.1.1" },
    # No idea what happened with these 2 short rulers, Wikipedia got nothing
    "1868.1.1" => { name: "Ali | Al Khalifa", lived: "- 1869.9.1" },
    "1869.9.1" => { name: "Muhammad | Al Khalifa", lived: "- 1869.12.1" },
    # real dates at least...
    "1869.12.1" => { name: "Isa | Al Khalifa", lived: "1848 - 1932.12.9" },
    # British protectorate
    "1880.12.22" => nil,
    # From "1961.11.2" sheik under Britain
    "1971.8.15" => {
      name: "Isa | Al Khalifa",
      lived: "1933.6.3 – 1999.3.6",
    },
    # From 2002 as king
    "1999.3.6" => {
      name: "Hamad | Al Khalifa",
      father: "Isa 1",
      lived: "1950.1.28 -",
    },
  },
}

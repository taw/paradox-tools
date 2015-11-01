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
    # from "1970.7.23", initially under UK
    "1971.12.2" => { name: "Qaboos bin Said | al Said", lived: "1940.11.18 -" },
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
}

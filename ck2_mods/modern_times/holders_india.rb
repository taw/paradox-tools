ModernTimesDatabase::HOLDERS_INDIA = {
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
      lived: "1901–1969",
    },
    "1968.11.11" => {
      name: "Ibrahim | Nasir",
      lived: "1926–2008",
    },
    "1978.11.11" => {
      name: "Maumoon Abdul | Gayoom",
      lived: "1937–",
    },
    "2008.11.11" => {
      name: "Mohamed | Nasheed",
      lived: "1967–"
    },
    "2012.2.7" => {
      name: "Mohammed Waheed | Hassan",
      lived: "1953–",
    },
    "2013.11.17" => {
      name: "Abdulla | Yameen",
      lived: "1959–",
    },
  },
  k_punjab: {
    "1801.4.12" => {
      name: "Ranjit Singh",
      lived: "13 November 1780 – 27 June 1839",
    },
    "1839.6.27" => {
      name: "Kharak Singh",
      lived: "22 February 1801 – 5 November 1840",
      father: "Ranjit 1",
    },
    "1839.10.8" => {
      name: "Nau Nihal | Singh",
      lived: "9 March 1821 – 6 November 1840",
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
      lived: "6 September 1838 – 22 October 1893",
      father: "Ranjit 1",
    },
    "1849.3.29" => nil,
  },
}

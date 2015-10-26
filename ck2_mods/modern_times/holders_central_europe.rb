ModernTimesDatabase::HOLDERS_CENTRAL_EUROPE = {
  e_carpathia: {
    "1804.8.11"  => {name: "Francis | Habsburg", lived: "1768.2.12 - 1835.3.2"},
    "1835.3.2"   => {name: "Ferdinand | Habsburg", lived: "1793.4.19 - 1875.6.29"},
    # Can't find day date, just month
    "1848.12.1"  => {name: "Francis Joseph | Habsburg", lived: "1830.8.18 - 1916.11.21"},
    "1916.11.21" => {name: "Charles | Habsburg", lived: "1911.10.21 - 1922.4.1"},
    "1918.11.11" => nil,
  },
  d_nyitra: {
    # 2 March 1993, backdating
    "1993.1.1" => {name: "Michal | Kovac"},
    # 15 June 1999, backdating
    "1998.3.2" => {name: "Rudolf | Schuster"},
    "2004.6.15" => {name: "Ivan | Gasparovic"},
    "2014.6.15" => {name: "Andrej | Kiska"},
  },
  k_poland: {
    end_ww1: {name: "Jozef | Pilsudski", lived: "1867.12.5 - 1935.5.12"},
    "1922.12.11" => {name: "Gabriel | Narutowicz", lived: "1865.3.17 - 1922.12.16"},
    "1922.12.16" => {name: "Stanislaw | Wojciechowski", lived: "1869.3.15 - 1953.4.9"},
    # Not officially, but everybody knows who ruled
    "1926.5.14" => {use: "Jozef 1"},
    "1935.5.12" => {name: "Ignacy | Moscicki", lived: "1867.12.1 - 1946.10.2"},
    # government in exile
    "1939.9.30" => {name: "Wladyslaw | Raczkiewicz", lived: "1885.1.28 - 1947.6.6"},

    # Communist Poland had no clear head of state, by design
    # First secretaries, except Jaruzelski gets to keep his post during transition
    # December 22, 1948, backdating
    end_ww2: {name: "Boleslaw | Bierut", lived: "1892.4.18 - 1956.3.12"},
    "1956.3.12" => {name: "Edward | Ochab", lived: "1906.8.16 - 1989.5.1"},
    "1956.10.21" => {name: "Wladyslaw | Gomulka", lived: "1905.2.6 - 1982.9.1"},
    "1970.12.20" => {name: "Edward | Gierek", lived: "1913.1.6 - 2001.7.29"},
    "1980.9.6" => {name: "Stanislaw | Kania", lived: "1927.3.8 -"},
    "1981.10.18" => {name: "Wojciech | Jaruzelski", lived: "1923.7.6 - 2014.5.25"},
    "1990.12.22" => {name: "Lech | Walesa", lived: "1943.9.29 -"},
    "1995.12.23" => {name: "Aleksander | Kwasniewski", lived: "1954.11.15 -"},
    "2005.12.23" => {name: "Lech | Kaczynski", lived: "1949.6.18 - 2010.4.10"},
    # acting, then actual, skipping other acting presidents
    "2010.4.10" => {name: "Bronislaw | Komorowski", lived: "1952.6.4 -"},
    "2015.8.6" => {name: "Andrzej | Duda", lived: "1972.5.16 -"},
  },
  c_krakowskie: {
    congress_of_vienna: { name: "Stanislaw | Wodzicki", lived: "1764.7.27 - 1843.3.14" },
    "1833.3.24" => { name: "Kasper | Wieloglowski", lived: "- 1847" },
    "1836.2.25" => { name: "Jozef | Haller", lived: "1783 - 1850.12.3" },
    "1839.4.27" => { name: "Jan | Schindler", lived: "1802.9.3 - 1890.4.4" },
    fall_krakow_uprising: nil,
  },
  d_krete: {
    # 21 December 1898, backdating to foundation
    "1898.12.13" => {
      # He's a royal but it was High Commissioner post
      name: "George | Schleswig-Holstein-Sonderburg-Glücksburg",
      lived: "1869.6.24 - 1957.11.25",
    },
    "1906.10.1" => {
      name: "Alexandros | Zaimis",
      lived: "1855.11.9 - 1936.9.15",
    },
    "1913.5.30" => nil,
  },
  d_carinthia: {
    # Backdating, actually 23 December 1991
    "1991.7.7" => {
      name: "Milan | Kucan",
    },
    "2002.12.22" => {
      name: "Janez | Drnovsek",
    },
    "2007.12.23" => {
      name: "Danilo | Türk",
    },
    "2012.12.22" => {
      name: "Borut | Pahor",
    },
  },
  k_croatia: {
    croatia_independence: {name: "Franjo | Tudman", lived: "1922 - 1999"},
    # Backdated from 18 February 2000, skipping two active presidents
    "1999.12.10" => {name: "Stjepan | Mesic", lived: "1934-" },
    "2010.2.19" => {name: "Ivo | Josipovic", lived: "1957-" },
    "2015.2.19" => {name: "Kolinda | Grabar-Kitarovic", female: true, lived: "1968-"},
  },
}

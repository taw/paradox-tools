ModernTimesDatabase::HOLDERS_CENTRAL_EUROPE = {
  e_carpathia: {
    "1804.8.11"  => {name: "Francis | Habsburg", lived: "1768.2.12 - 1835.3.2"},
    "1835.3.2"   => {name: "Ferdinand | Habsburg", lived: "1793.4.19 - 1875.6.29"},
    # Can't find day date, just month
    "1848.12.1"  => {name: "Francis Joseph | Habsburg", lived: "1830.8.18 - 1916.11.21"},
    "1916.11.21" => {name: "Charles | Habsburg", lived: "1911.10.21 - 1922.4.1"},
    "1918.11.11" => nil,
  },
  k_hungary: {
    # Backdating hard
    end_ww1: {
      name: "Miklós Horthy",
      lived: "1868–1957",
    },
    # Government of National Unity all time
    "15 October 1944" => {
      name: "Ferenc Szálasi",
      lived: "1897–1946",
    },
    # Communist,
    # General Secretary since February, but only count after Ferenc Szálasi is gone
    "28 March 1945" => {
      name: "Mátyás Rákosi",
      lived: "1892–1971",
    },
    "18 July 1956" => {
      name: "Ernő Gerő",
      lived: "1898–1980",
    },
    "25 October 1956" => {
      name: "János Kádár",
      lived: "1912–1989",
    },
    "27 May 1988" => {
      name: "Károly Grósz",
      lived: "1930–1996",
    },
    "26 June 1989" => {
      name: "Rezső Nyers",
      lived: "1923–",
    },
    # Post-Communist
    # Provisional, backdated
    "7 October 1989" => {
      name: "Mátyás Szűrös",
      lived: "1933–",
    },
    "2 May 1990" => {
      name: "Árpád Göncz",
      lived: "1922–2015",
    },
    "4 August 2000" => {
      name: "Ferenc Mádl",
      lived: "1931–2011",
    },
    "5 August 2005" => {
      name: "László Sólyom",
      lived: "1942–",
    },
    "6 August 2010" => {
      name: "Pál Schmitt",
      lived: "1942–",
    },
    # backdating from 10 April 2012
    "2 April 2012" => {
      name: "János Áder",
      lived: "1959–",
    },
  },
  d_nyitra: {
    # Slovak State under Nazis
    "1939.3.15" => {
      name: "Jozef Tiso",
      lived: "13 October 1887 – 18 April 1947",
    },
    "1945.5.8" => nil,
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
  c_danzig: {
    # Präsident des Senats
    end_ww1: {
      name: "Heinrich Sahm",
      lived: "12 September 1877 – 3 October 1939",
    },
    "10 January 1931" => {
      name: "Ernst Ziehm",
      lived: "1 May 1867 - 7 July 1962",
    },
    "June 20, 1933" => {
      name: "Hermann Rauschning",
      lived: "7 August 1887 – February 8, 1982",
    },
    "23 November 1934" => {
      name: "Arthur Greiser",
      lived: "22 January 1897 – 21 July 1946",
    },
    end_ww2: nil,
  },
  k_dacia: {
    # actually "20 April 1866", ignore until he gets independent
    treaty_of_berlin: {
      name: "Carol | Hohenzollern-Sigmaringen",
      lived: "20 April 1839 – 10 October 1914",
    },
    # nephew of Carol 1
    "10 October 1914" => {
      name: "Ferdinand | Hohenzollern-Sigmaringen",
      lived: "24 August 1865 – 20 July 1927",
    },
    # This is just dumb, Ferdinand's son Carol renounced right to throne
    # in favour of his son Michael, then decided to go back on it
    # DSL can't currently support this
    "20 July 1927" => {
      name: "Michael | Hohenzollern-Sigmaringen",
      lived: "25 October 1921-",
      # father: "Carol 2",
    },
    "8 June 1930" => {
      name: "Carol | Hohenzollern-Sigmaringen",
      lived: "15 October 1893 – 4 April 1953",
      father: "Ferdinand 1",
    },
    "6 September 1940" => {
      use: "Michael 1",
    },
    # Communists
    "30 December 1947" => {
      name: "Constantin Ion | Parhon",
      lived: "1874–1969",
    },
    "12 June 1952" => {
      name: "Petru Groza",
      lived: "1884–1958",
    },
    # Backdating from 1958.1.11
    "7 January 1958" => {
      name: "Ion Gheorghe | Maurer",
      lived: "1902–2000",
    },
    "21 March 1961" => {
      name: "Gheorghe Gheorghiu-Dej",
      lived: "November 8, 1901 – March 19, 1965",
    },
    # Backdating from 1965.3.24
    "19 March 1965" => {
      name: "Chivu Stoica",
      lived: "1908–1975",
    },
    "9 December 1967" => {
      name: "Nicolae Ceaușescu",
      lived: "26 January 1918 – 25 December 1989",
    },
    # Backdating from 1989.12.26
    "22 December 1989" => {
      name: "Ion Iliescu",
      lived: "1930–",
    },
    "29 November 1996" => {
      name: "Emil Constantinescu",
      lived: "1939–",
    },
    "20 December 2000" => { use: "Ion 1" },
    # Twice suspended by parliament, we don't care about that
    "20 December 2004" => {
      name: "Traian Băsescu",
      lived: "1951–",
    },
    "21 December 2014" => {
      name: "Klaus Iohannis",
      lived: "1959–",
    },
  },
}

ModernTimesDatabase::Holders.define do
  title "e_carpathia" do
    ruler "1804.8.11", name: "Franz | Habsburg", lived: "1768.2.12 - 1835.3.2"
    ruler "1835.3.2", name: "Ferdinand | Habsburg", lived: "1793.4.19 - 1875.6.29", father: "Franz 1"
    # Can't find day date, just month
    character "Archduke Franz Karl", name: "Franz Karl | Habsburg", lived: "1802.12.17 - 1878.3.8", father: "Franz 1"
    ruler "1848.12.1", name: "Franz Joseph | Habsburg", lived: "1830.8.18 - 1916.11.21", health: 6, father: "Archduke Franz Karl"
    character "Archduke Karl Ludwig", name: "Karl Ludwig | Habsburg", lived: "1833.7.30 - 1896.5.19", father: "Archduke Franz Karl"
    character "Archduke Otto", name: "Otto | Habsburg", lived: "1865.4.21 - 1906.11.1", father: "Archduke Karl Ludwig"
    ruler "1916.11.21", name: "Karl | Habsburg", lived: "1887.8.17 - 1922.4.1", father: "Archduke Otto"
    vacant "1918.11.11"
  end
  title "k_hungary" do
    # Backdating hard
    ruler :end_ww1,
      name: "Miklós Horthy",
      lived: "1868.6.18 - 1957.2.9"
    # Government of National Unity all time
    ruler "1944.10.15",
      name: "Ferenc Szálasi",
      lived: "1897.1.6 - 1946.3.12"
    # Communist,
    # General Secretary since February, but only count after Ferenc Szálasi is gone
    ruler "1945.3.28",
      name: "Mátyás Rákosi",
      lived: "1892.3.9 - 1971.2.5"
    ruler "1956.7.18",
      name: "Ernő Gerő",
      lived: "1898.7.8 - 1980.3.12"
    ruler "1956.10.25",
      name: "János Kádár",
      lived: "1912.5.26 - 1989.7.6"
    ruler "1988.5.27",
      name: "Károly Grósz",
      lived: "1930.8.1 - 1996.1.7"
    ruler "1989.6.26",
      name: "Rezső Nyers",
      lived: "1923.3.21 - 2018.6.22"
    # Post-Communist
    # Provisional, backdated
    ruler "1989.10.7",
      name: "Mátyás Szűrös",
      lived: "1933.9.11 -"
    ruler "1990.5.2",
      name: "Árpád Göncz",
      lived: "1922.2.10 - 2015.10.6"
    ruler "2000.8.4",
      name: "Ferenc Mádl",
      lived: "1931.1.29 - 2011.5.29"
    ruler "2005.8.5",
      name: "László Sólyom",
      lived: "1942.1.3 - 2023.10.8"
    ruler "2010.8.6",
      name: "Pál Schmitt",
      lived: "1942.5.13 -"
    # backdating from 10 April 2012
    ruler "2012.4.2",
      name: "János Áder",
      lived: "1959.5.9 -"
    ruler "2022.5.10",
      name: "Katalin Novák",
      lived: "1977.9.6 -",
      female: true
    # backdating from 5 March 2024, skipping acting president László Kövér
    ruler "2024.2.26",
      name: "Tamás Sulyok",
      lived: "1956.3.24 -"
  end
  title "d_nyitra" do
    # Slovak State under Nazis
    ruler "1939.3.15",
      name: "Jozef Tiso",
      lived: "1887.10.13 - 1947.4.18"
    vacant "1945.5.8"
    # 2 March 1993, backdating
    ruler "1993.1.1", name: "Michal | Kovac", lived: "1930.8.5 - 2016.10.5"
    # 15 June 1999, backdating
    ruler "1998.3.2", name: "Rudolf | Schuster", lived: "1934.1.4 -"
    ruler "2004.6.15", name: "Ivan | Gasparovic", lived: "1941.3.27 -"
    ruler "2014.6.15", name: "Andrej | Kiska", lived: "1963.2.2 -"
    ruler "2019.6.15", name: "Zuzana | Caputova", lived: "1973.6.21 -", female: true
    ruler "2024.6.15", name: "Peter | Pellegrini", lived: "1975.10.6 -"
  end
  title "k_poland" do
    copy_rulers :duchy_warsaw, from: "d_lausitz"
    vacant :congress_of_vienna # Generate
    ruler :end_ww1, name: "Jozef | Pilsudski", lived: "1867.12.5 - 1935.5.12", health: 6
    ruler "1922.12.11", name: "Gabriel | Narutowicz", lived: "1865.3.17 - 1922.12.16"
    ruler "1922.12.16", name: "Stanislaw | Wojciechowski", lived: "1869.3.15 - 1953.4.9"
    # Not officially, but everybody knows who ruled
    ruler "1926.5.14", use: "Jozef 1"
    ruler "1935.5.12", name: "Ignacy | Moscicki", lived: "1867.12.1 - 1946.10.2"
    # government in exile
    ruler "1939.9.30", name: "Wladyslaw | Raczkiewicz", lived: "1885.1.28 - 1947.6.6"

    # Communist Poland had no clear head of state, by design
    # First secretaries, except Jaruzelski gets to keep his post during transition
    # December 22, 1948, backdating
    ruler :end_ww2, name: "Boleslaw | Bierut", lived: "1892.4.18 - 1956.3.12"
    ruler "1956.3.12", name: "Edward | Ochab", lived: "1906.8.16 - 1989.5.1"
    ruler "1956.10.21", name: "Wladyslaw | Gomulka", lived: "1905.2.6 - 1982.9.1"
    ruler "1970.12.20", name: "Edward | Gierek", lived: "1913.1.6 - 2001.7.29"
    ruler "1980.9.6", name: "Stanislaw | Kania", lived: "1927.3.8 - 2020.3.3"
    ruler "1981.10.18", name: "Wojciech | Jaruzelski", lived: "1923.7.6 - 2014.5.25"
    ruler "1990.12.22", name: "Lech | Walesa", lived: "1943.9.29 -", health: 6
    ruler "1995.12.23", name: "Aleksander | Kwasniewski", lived: "1954.11.15 -"
    ruler "2005.12.23", name: "Lech | Kaczynski", lived: "1949.6.18 - 2010.4.10"
    # acting, then actual, skipping other acting presidents
    ruler "2010.4.10", name: "Bronislaw | Komorowski", lived: "1952.6.4 -"
    ruler "2015.8.6", name: "Andrzej | Duda", lived: "1972.5.16 -"
    ruler "2025.8.6", name: "Karol | Nawrocki", lived: "1983.3.3 -"
  end
  title "c_krakowskie" do
    ruler :congress_of_vienna, name: "Stanislaw | Wodzicki", lived: "1764.7.27 - 1843.3.14"
    ruler "1833.3.24", name: "Kasper | Wieloglowski", lived: "- 1847"
    ruler "1836.2.25", name: "Jozef | Haller", lived: "1783 - 1850.12.3"
    ruler "1839.4.27", name: "Jan | Schindler", lived: "1802.9.3 - 1890.4.4"
    vacant :fall_krakow_uprising
  end
  title "c_danzig" do
    # Präsident des Senats
    ruler :end_ww1,
      name: "Heinrich Sahm",
      lived: "1877.9.12 - 1939.10.3"
    ruler "1931.1.10",
      name: "Ernst Ziehm",
      lived: "1867.5.1 - 1962.7.7"
    ruler "1933.6.20",
      name: "Hermann Rauschning",
      lived: "1887.8.7 - 1982.2.8"
    ruler "1934.11.23",
      name: "Arthur Greiser",
      lived: "1897.1.22 - 1946.7.21"
    vacant :end_ww2
  end
  title "k_dacia" do
    # actually "1866.4.20", ignore until he gets independent
    ruler :treaty_of_berlin,
      name: "Karl | Hohenzollern-Sigmaringen",
      culture: "german",
      lived: "1839.4.20 - 1914.10.10"
    # nephew of Carol 1
    ruler "1914.10.10",
      name: "Ferdinand | Hohenzollern-Sigmaringen",
      culture: "german",
      lived: "1865.8.24 - 1927.7.20"
    # This is just dumb, Ferdinand's son Carol renounced right to throne
    # in favour of his son Michael, then decided to go back on it
    # DSL can't currently support this
    ruler "1927.7.20",
      name: "Michael | Hohenzollern-Sigmaringen",
      culture: "german",
      lived: "1921.10.25 - 2017.12.5",
      father: "Karl 2"
    ruler "1930.6.8",
      name: "Karl | Hohenzollern-Sigmaringen",
      culture: "german",
      lived: "1893.10.15 - 1953.4.4",
      father: "Ferdinand 1"
    ruler "1940.9.6",
      use: "Michael 1"
    # Communists
    ruler "1947.12.30",
      name: "Constantin Ion | Parhon",
      lived: "1874.10.15 - 1969.8.9"
    ruler "1952.6.12",
      name: "Petru Groza",
      lived: "1884.12.7 - 1958.1.7"
    # Backdating from 1958.1.11
    ruler "1958.1.7",
      name: "Ion Gheorghe | Maurer",
      lived: "1902.9.23 - 2000.2.8"
    ruler "1961.3.21",
      name: "Gheorghe Gheorghiu-Dej",
      lived: "1901.11.8 - 1965.3.19"
    # Backdating from 1965.3.24
    ruler "1965.3.19",
      name: "Chivu Stoica",
      lived: "1908.8.8 - 1975.2.18"
    ruler "1967.12.9",
      name: "Nicolae Ceaușescu",
      lived: "1918.1.26 - 1989.12.25"
    # Backdating from 1989.12.26
    ruler "1989.12.22",
      name: "Ion Iliescu",
      lived: "1930.3.3 - 2025.8.5"
    ruler "1996.11.29",
      name: "Emil Constantinescu",
      lived: "1939.11.19 -"
    ruler "2000.12.20", use: "Ion 1"
    # Twice suspended by parliament, we don't care about that
    ruler "2004.12.20",
      name: "Traian Băsescu",
      lived: "1951.11.4 -"
    ruler "2014.12.21",
      name: "Klaus Iohannis",
      lived: "1959.6.13 -"
    # Acting after Iohannis resigned
    ruler "2025.2.12",
      name: "Ilie Bolojan",
      lived: "1969.3.17 -"
    ruler "2025.5.26",
      name: "Nicușor Dan",
      lived: "1969.12.20 -"
  end
  title "k_bohemia" do
    # backdating from "1918.11.14"
    ruler "1918.10.28", name: "Tomáš Garrigue | Masaryk", lived: "1850.3.7 - 1937.9.14"
    ruler "1935.12.18", name: "Edvard Beneš", lived: "1884.5.17 - 1948.9.3"
    # backdating
    ruler "1938.10.5", name: "Emil Hácha", lived: "1872.7.12 - 1945.6.27"
    vacant "1939.3.15"

    # Communist
    ruler "1945.5.8", name: "Klement Gottwald", lived: "1896.11.23 - 1953.3.14"
    ruler "1953.3.14", name: "Antonín Novotný", lived: "1904.12.10 - 1975.1.28"
    ruler "1968.1.5", name: "Alexander Dubček", lived: "1921.11.27 - 1992.11.7"
    ruler "1969.4.17", name: "Gustáv Husák", lived: "1913.1.10 - 1991.11.18"
    ruler "1987.12.17", name: "Miloš Jakeš", lived: "1922.8.12 - 2020.7.10"
    ruler "1989.11.24", name: "Karel Urbánek", lived: "1941.3.22 -"

    # Post-Communist since 1989;
    # Czech Republic from 1993
    ruler "1989.12.10", name: "Václav Havel", lived: "1936.10.5 - 2011.12.18"
    ruler "2003.3.7", name: "Václav Klaus", lived: "1941.6.19 -"
    ruler "2013.3.8", name: "Miloš Zeman", lived: "1944.9.28 -"
    ruler "2023.3.9", name: "Petr Pavel", lived: "1961.11.1 -"
  end
end

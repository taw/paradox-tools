ModernTimesDatabase::HOLDERS = {
  # Dynasty changed names twice, but whatever
  e_britannia: {
    "1837.6.20" => {
      birth: "1819.5.24",
      death: "1901.1.22",
      name: "Victoria",
      female: true,
      dynasty: "Windsor",
    },
    "1901.1.22" => {
      birth: "1841.11.9",
      death: "1910.5.6",
      name: "Edward",
      dynasty: "Windsor",
      mother: "Victoria",
    },
    "1910.5.6" => {
      birth: "1865.6.3",
      death: "1936.1.20",
      name: "George",
      dynasty: "Windsor",
      father: "Edward",
    },
    "1936.1.20" => {
      birth: "1894.6.23",
      death: "1972.5.28",
      name: "Edward",
      dynasty: "Windsor",
      father: "George 1",
    },
    "1936.12.11" => {
      birth: "1895.12.14",
      death: "1952.2.6",
      name: "George",
      dynasty: "Windsor",
      father: "George 1",
    },
    "1952.2.6" => {
      birth: "1926.4.21",
      death: :never,
      name: "Elizabeth",
      dynasty: "Windsor",
      female: true,
      father: "George 2",
    },
  },
  e_germany: {
    "1888.6.15" => {
      birth: "1859.1.27",
      death: "1941.6.4",
      name: "Wilhelm",
      dynasty: "Hohenzollern",
    },
    # Backdate, ignore interregnum
    "1918.11.28" => {
      name: "Friedrich",
      dynasty: "Ebert",
    },
    # Ignore temporary ones
    "1925.5.12" => {
      name: "Paul",
      dynasty: "von Hindenburg",
      death: "1934.8.2",
    },
    "1934.8.2" => {
      name: "Adolf",
      dynasty: "Hitler",
      death: "1945.4.30",
    },
    "1945.4.30" => {
      name: "Karl",
      dynasty: "Doenitz",
      death: "1980.12.24",
    },
    # Now this is bullshit on so many levels...
    # German "presidents" do nothing, so choosing chancellor as much more prominent person
    # Backdating a lot
    "1945.5.23" => {
      name: "Konrad",
      dynasty: "Adenauer",
    },
    "1963" => {
      name: "Ludwig",
      dynasty: "Erhard",
    },
    "1966" => {
      name: "Kurt Georg",
      dynasty: "Kiesinger",
    },
    "1969" => {
      name: "Willy",
      dynasty: "Brandt",
    },
    "1974" => {
      name: "Helmut",
      dynasty: "Schmidt",
      birth: "1918.12.23",
    },
    "1982" => {
      name: "Helmut",
      dynasty: "Kohl",
      birth: "1930.4.3",
    },
    "1998" => {
      name: "Gerhard",
      dynasty: "Schroeder",
      birth: "1944.4.7",
    },
    "2005" => {
      name: "Angela",
      dynasty: "Merkel",
      female: true,
    }
  },
  e_russia: {
    "1894.11.1" => {
      name: "Nicholas",
      dynasty: "Romanov",
      birth: "1868.5.6",
      death: "1918.7.17",
    },
    # Not really ruling ever, but alternative is interregnum
    "1917.3.15" => {
      name: "Michael",
      dynasty: "Romanov",
      birth: "1878.10.22",
      death: "1918.6.12",
    },
    # Backdating
    "1918.6.12" => {
      name: "Vladimir",
      dynasty: "Lenin",
      death: "1924.1.21",
    },
    "1924.1.21" => {
      name: "Joseph",
      dynasty: "Stalin",
      death: "1953.3.5",
    },
    "1953.3.5" => {
      name: "Georgy",
      dynasty: "Malenkov",
    },
    "1955.2.8" => {
      name: "Nikita",
      dynasty: "Khrushchev",
    },
    "1964.10.14" => {
      name: "Leonid",
      dynasty: "Brezhnev",
    },
    "1982.10.12" => {
      name: "Yuri",
      dynasty: "Andropov",
    },
    "1984.2.13" => {
      name: "Konstantin",
      dynasty: "Chernenko"
    },
    # Skipping Gennady Yanayev 3-day plot silliness
    "1985.3.11" => {
      name: "Mikhail",
      dynasty: "Gorbachev",
    },
    "1991.12.25" => {
      name: "Boris",
      dynasty: "Yeltsin",
      birth: "1931.2.1",
      death: "2007.4.23",
    },
    # Putin -> Medvedev -> Putin, but script doesn't support it yet
    "1999.12.31" => {
      name: "Vladimir",
      dynasty: "Putin",
    },
  },
  k_denmark: {
    "1863.11.29" => {
      name: "Christian",
      dynasty: "Schleswig-Holstein-Sonderburg-Glucksburg",
      birth: "1818.4.8",
      death: "1906.1.29",
    },
    "1906.1.29" => {
      name: "Frederick",
      dynasty: "Schleswig-Holstein-Sonderburg-Glucksburg",
      birth: "1843.6.3",
      death: "1912.5.14",
      father: "Christian 1",
    },
    "1912.5.14" => {
      name: "Christian",
      dynasty: "Schleswig-Holstein-Sonderburg-Glucksburg",
      birth: "1870.9.26",
      death: "1947.4.20",
      father: "Frederick 1",
    },
    "1947.4.20" => {
      name: "Frederick",
      dynasty: "Schleswig-Holstein-Sonderburg-Glucksburg",
      birth: "1899.3.11",
      death: "1972.1.14",
      father: "Christian 2",
    },
    "1972.1.14" => {
      name: "Margrethe",
      dynasty: "Schleswig-Holstein-Sonderburg-Glucksburg",
      female: true,
      birth: "1940.4.16",
      death: :never,
      father: "Frederick 2",
    }
  },
  k_sweden: {
    "1872.9.18" => {
      name: "Oscar",
      dynasty: "Bernadotte",
      birth: "1829.1.21",
      death: "1907.12.8",
    },
    "1907.12.8" => {
      name: "Gustaf",
      dynasty: "Bernadotte",
      birth: "1858.6.16",
      death: "1950.10.29",
      father: "Oscar",
    },
    "1950.10.29" => {
      name: "Gustaf Adolf",
      dynasty: "Bernadotte",
      birth: "1882.11.11",
      death: "1973.9.15",
      father: "Gustaf",
    },
    "1973.9.15" => {
      name: "Carl Gustaf",
      dynasty: "Bernadotte",
      birth: "1946.4.30",
      father: "Gustaf Adolf",
    },
  },
  e_persia: {
    "1896.5.1" => {
      name: "Mozaffar al-Din",
      dynasty: "Qajar",
    },
    "1907.1.3" => {
      name: "Mohammad Ali",
      dynasty: "Qajar",
    },
    "1909.6.16" => {
      name: "Ahmad",
      dynasty: "Qajar",
    },
    "1925.12.15" => {
      name: "Reza",
      dynasty: "Pahlavi",
    },
    "1941.9.16" => {
      name: "Mohammad Reza",
      dynasty: "Pahlavi",
    },
    "1979.2.11" => {
      name: "Ruhollah",
      dynasty: "Khomeini",
      birth: "1902.9.22",
    },
    "1989.6.4" => {
      name: "Ali",
      dynasty: "Khamenei",
      birth: "1939.7.17",
    },
  },
  e_seljuk_turks: {
    "31 August 1876" => {
      name: "Abdulhamid",
      dynasty: "Ottoman",
      death: "10 February 1918",
    },
    "27 April 1909" => {
      name: "Mehmed",
      dynasty: "Ottoman",
    },
    "4 July 1918" => {
      name: "Mehmed",
      dynasty: "Ottoman",
      death: "16 May 1926",
    },
    # There was a caliph Abdulmecid II for 1922-1924, consider maybe?
    # Dates are changed to fill the gaps
    "1 November 1922" => {
      name: "Mustafa Kemal",
      dynasty: "Ataturk",
    },
    "11 November 1938" => {
      name: "Ismet",
      dynasty: "Inonu",
    },
    "22 May 1950" => {
      name: "Celal",
      dynasty: "Bayar",
    },
    # Skipping National Unity Committee
    "10 October 1961" => {
      name: "Cemal",
      dynasty: "Gursel",
    },
    "28 March 1966" => {
      name: "Cevdet",
      dynasty: "Sunay",
    },
    "6 April 1973" => {
      name: "Fahri",
      dynasty: "Koruturk",
    },
    # Skipping National ecurity Council
    "9 November 1982" => {
      name: "Kenan",
      dynasty: "Evren",
      birth: "1917",
      death: "2015",
    },
    "9 November 1989" => {
      name: "Torgut",
      dynasty: "Ozal",
      birth: "1927",
      death: "1993",
    },
    "16 May 1993" => {
      name: "Suleyman",
      dynasty: "Demirel",
      birth: "1924",
      death: "2015",
    },
    "16 May 2000" => {
      name: "Ahmet Necdet",
      dynasty: "Sezer",
      birth: "1941",
    },
    "28 August 2007" => {
      name: "Abdullah",
      dynasty: "Gul",
      birth: "1950",
    },
    "28 August 2014"  => {
      name: "Recep Tayyip",
      dynasty: "Erdogan",
      birth: "1954",
    },
  },
  e_italy: {
    # Title created
    "17 March 1861" => {
      name: "Victor Emmanuel",
      dynasty: "Savoy",
      birth: "14 March 1820",
      death: "9 January 1878",
    },
    "9 January 1878" => {
      name: "Umberto",
      dynasty: "Savoy",
      father: "Victor Emmanuel 1",
      birth: "14 March 1844",
      death: "29 July 1900",
    },
    "29 July 1900" => {
      name: "Victor Emmanuel",
      dynasty: "Savoy",
      father: "Umberto",
      birth: "11 November 1869",
      death: "28 December 1947",
    },
    "9 May 1946" => {
      name: "Umberto",
      dynasty: "Savoy",
      father: "Victor Emmanuel 2",
      birth: "15 September 1904",
      death: "18 March 1983",
    },
    # Preidents
    "12 June 1946" => {
      name: "Enrico",
      dynasty:  "De Nicola",
    },
    "12 May 1948" => {
      name: "Luigi",
      dynasty: "Einaudi",
    },
    "11 May 1955" => {
      name: "Giovanni",
      dynasty: "Gronchi",
    },
    "11 May 1962" => {
      name: "Antonio",
      dynasty: "Segni",
    },
    "29 December 1964" => {
      name: "Giuseppe",
      dynasty: "Saragat",
    },
    "29 December 1971" => {
      name: "Giovanni",
      dynasty: "Leone",
    },
    "9 July 1978" => {
      name: "Sandro",
      dynasty: "Pertini",
    },
    "3 July 1985" => {
      name: "Francesco",
      dynasty: "Cosiga",
    },
    "28 May 1992" => {
      name: "Oscar Luigi",
      dynasty: "Scalfaro",
    },
    "18 May 1999" => {
      name: "Carlo Azeglio",
      dynasty: "Ciampi",
    },
    "15 May 2006" => {
      name: "Giorgio",
      dynasty: "Napolitano",
    },
    "3 February 2015" => {
      name: "Sergio",
      dynasty: "Mattarella",
    },

  },
  d_sunni: {
    caliphate_reborn: {
      name: "Abu Bakr",
      dynasty: "al-Baghdadi",
      birth: "1971.7.28",
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
}

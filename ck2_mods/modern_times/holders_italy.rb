ModernTimesDatabase::HOLDERS_ITALY = {
  k_italy: {
    "1802.6.4" => {
      name: "Victor Emmanuel | Savoy",
      lived: "1759.7.24 - 1824.1.10",
    },
    "1821.3.12" => {
      name: "Charles Felix | Savoy",
      lived: "1765.4.6 - 1831.4.27",
    },
    "1831.4.27" => {
      name: "Charles Albert | Savoy",
      lived: "1798.10.2 - 1849.3.23",
    },
    "1849.3.23" => {
      name: "Victor Emmanuel | Savoy",
      lived: "1820.3.14 - 1878.1.9",
      father: "Charles Albert 1",
    },
    "1861.3.17" => nil,
  },
  e_italy: {
    # Title created
    "1861.3.17" => { use: "k_italy Victor Emmanuel 2" },
    "1878.1.9" => {
      name: "Umberto | Savoy",
      father: "k_italy Victor Emmanuel 2",
      lived: "1844.3.14 - 1900.7.29",
    },
    "1900.7.29" => {
      name: "Victor Emmanuel | Savoy",
      father: "Umberto",
      lived: "1869.11.11 - 1947.12.28",
    },
    "1946.5.9" => {
      name: "Umberto | Savoy",
      father: "e_italy Victor Emmanuel 1",
      lived: "1904.9.15 - 1983.3.18",
    },
    # Preidents
    "1946.6.12" => {
      name: "Enrico | De Nicola",
      lived: "1877.11.9 – 1959.10.1",
    },
    "1948.5.12" => {
      name: "Luigi | Einaudi",
      lived: "1874.3.24 – 1961.10.30",
    },
    "1955.5.11" => {
      name: "Giovanni | Gronchi",
      lived: "1887.9.10 – 1978.10.17",
    },
    "1962.5.11" => {
      name: "Antonio | Segni",
      lived: "1891.2.2 – 1972.12.1",
    },
    "1964.12.29" => {
      name: "Giuseppe | Saragat",
      lived: "1898.9.19 – 1988.6.11",
    },
    "1971.12.29" => {
      name: "Giovanni | Leone",
      lived: "1908.11.3 – 2001.11.9",
    },
    "1978.7.9" => {
      name: "Sandro | Pertini",
      lived: "1896.9.25 – 1990.2.24",
    },
    "1985.7.3" => {
      name: "Francesco | Cosiga",
      lived: "1928.7.26 – 2010.8.17",
    },
    "1992.5.28" => {
      name: "Oscar Luigi | Scalfaro",
      lived: "1918.9.9 – 2012.1.29",
    },
    "1999.5.18" => {
      name: "Carlo Azeglio | Ciampi",
      lived: "1920.12.9 -",
    },
    "2006.5.15" => {
      name: "Giorgio | Napolitano",
      lived: "1925.6.29 -",
    },
    "2015.2.3" => {
      name: "Sergio | Mattarella",
      lived: "1941.7.23 -",
    },
  },
  k_sicily: {
    "1816.12.12" => {
      name: "Ferdinand | Bourbon",
      lived: "1751.1.12 - 1825.1.4",
    },
    "1825.1.4" => {
      name: "Francis | Bourbon",
      lived: "1777.8.14 - 1830.11.8",
      father: "Ferdinand 1",
    },
    "1830.11.8" => {
      name: "Ferdinand | Bourbon",
      lived: "1810.1.12 - 1859.5.22",
      father: "Francis 1",
    },
    "1859.5.22" => {
      name: "Francis | Bourbon",
      lived: "1836.1.16 - 1894.12.27",
      father: "Ferdinand 2",
    },
    italy_unification: nil,
  },
  # I'm really confused by Lucca / Parma situation
  # Maria Louisa Bourbon != Marie Louise Habsburg
  c_lucca: {
    "1815.6.9" => {
      name: "Maria Luisa | Bourbon",
      lived: "1782.7.6 – 1824.3.13",
      female: true,
    },
    "1824.3.13" => {
      name: "Charles | Bourbon",
      lived: "1799.12.22 - 1883.4.16",
      mother: "Maria Luisa 1",
    },
    # Actually deposed two months earlier ???
    "1847.12.17" => nil,
  },
  c_parma: {
    "1814.4.11" => {
      name: "Marie Louise | Habsburg",
      lived: "1791.12.12 - 1847.12.17",
      female: true,
    },
    "1847.12.17" => {
      use: "c_lucca Charles 1",
    },
    "1849.5.17" => {
      name: "Charles | Bourbon",
      lived: "1823.1.14 - 1854.3.27",
      father: "c_lucca Charles 1",
    },
    "1854.3.27" => {
      name: "Robert | Bourbon",
      lived: "1848.7.9 - 1907.11.16",
      father: "Charles 1",
    },
    italy_unification: nil,
  },
  # Backdating everybody to their predecessor's death / resignation
  k_papal_state: {
    "1799.8.29" => {
      name: "Pius | Chiaramonti",
      lived: "1742.8.14 - 1823.8.20",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1823.8.20" => {
      name: "Leo | della Genga",
      lived: "1760.8.22 - 1829.2.10",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1829.2.10" => {
      name: "Pius | Castiglioni",
      lived: "1761.11.20 - 1830.11.30",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1830.11.30" => {
      name: "Gregory | Cappellari",
      lived: "1765.9.18 - 1846.6.1",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1846.6.1" => {
      name: "Pius | Mastai-Ferretti",
      lived: "1792.5.13 - 1878.2.7",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1878.2.7" => {
      name: "Leo | Pecci",
      lived: "1810.3.2 - 1903.7.20",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1903.7.20" => {
      name: "Pius | Sarto",
      lived: "1835.6.2 - 1914.8.20",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1914.8.20" => {
      name: "Benedict | della Chiesa",
      lived: "1854.11.21 - 1922.1.22",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1922.1.22" => {
      name: "Pius | Ratti",
      lived: "1857.5.31 - 1939.2.10",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1939.2.10" => {
      name: "Pius | Pacelli",
      lived: "1876.3.2 - 1958.10.9",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1958.10.9" => {
      name: "John | Roncalli",
      lived: "1881.11.25 - 1963.6.3",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1963.6.3" => {
      name: "Paul | Montini",
      lived: "1897.9.26 - 1978.8.6",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1978.8.6" => {
      name: "John Paul | Luciani",
      lived: "1912.10.17 - 1978.9.28",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1978.9.28" => {
      name: "John Paul | Wojtyla",
      culture: :polish,
      lived: "1920.5.18 - 2005.4.2",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "2005.4.2" => {
      name: "Benedict | Ratzinger",
      culture: :german,
      lived: "1927.4.16 -", # Popes, abdicating? WTF is this?
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "2013.2.28" => {
      name: "Francis | Bergoglio",
      culture: :castillan,
      lived: "1936.12.17 -",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
  },
  # Prime Ministers
  # Choosing presidents runs into problem of queen being one for quite long
  # Ignoring all pre-independence ones
  c_malta: {
    "1964.9.21" => {
      name: "Giorgio | Borg Olivier",
      lived: "1911.7.5 – 1980.10.29",
    },
    "1971.6.21" => {
      name: "Dom Mintoff",
      lived: "1916.8.6 – 2012.8.20",
    },
    "1984.12.22" => {
      name: "Karmenu | Mifsud Bonnici",
      lived: "1933.7.17-",
    },
    "1987.5.12" => {
      name: "Edward | Fenech Adami",
      lived: "1934.2.7-",
    },
    "1996.10.28" => {
      name: "Alfred Sant",
      lived: "1948.2.28-",
    },
    "1998.9.6" => {use: "Edward 1"}, # Edward Fenech Adami
    "2004.3.23" => {
      name: "Lawrence Gonzi",
      lived: "1953.7.1-",
    },
    "2013.3.11" => {
      name: "Joseph Muscat",
      lived: "1974.1.22-",
    },
  },
  d_toscana: {
    "1814.4.27" => { name: "Ferdinando | Habsburg", lived: "1769.5.6 – 1824.6.18" },
    "1824.6.18" => { name: "Leopoldo | Habsburg", lived: "1797.10.3 – 1870.1.29", father: "Ferdinando 1" },
    "1859.7.21" => { name: "Ferdinando | Habsburg", lived: "1835.6.10 – 1908.1.17", father: "Leopoldo 1" },
    "1859.11.10" => nil,
  },
}

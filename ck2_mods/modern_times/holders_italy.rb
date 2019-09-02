ModernTimesDatabase::HOLDERS_ITALY = {
  k_italy: {
    "1773.2.20" => {
      name: "Vittorio Amadeo | Savoia",
      lived: "1726.6.26 - 1796.10.16",
    },
    "1796.5.24" => {
      name: "Carlo Emanuele | Savoia",
      lived: "1751.5.24 - 1819.10.6",
      father: "Vittorio  Amadeo"
    },
    "1802.6.4" => {
      name: "Vittorio Emanuele | Savoia",
      lived: "1759.7.24 - 1824.1.10",
      father: "Vittorio  Amadeo"
    },
    "1821.3.12" => {
      name: "Carlo Felice | Savoia",
      lived: "1765.4.6 - 1831.4.27",
      father: "Vittorio  Amadeo"
    },
    "1831.4.27" => {
      name: "Carlo Alberto | Savoia",
      lived: "1798.10.2 - 1849.3.23",
    },
    "1849.3.23" => {
      name: "Vittorio Emanuele | Savoia",
      lived: "1820.3.14 - 1878.1.9",
      father: "Carlo Alberto 1",
    },
    "1861.3.17" => nil,
  },
  e_italy: {
    # Title created
    "1861.3.17" => { use: "k_italy Vittorio Emanuele 2" },
    "1878.1.9" => {
      name: "Umberto | Savoia",
      father: "k_italy Vittorio Emanuele 2",
      lived: "1844.3.14 - 1900.7.29",
    },
    "1900.7.29" => {
      name: "Vittorio Emanuele | Savoia",
      father: "Umberto",
      lived: "1869.11.11 - 1947.12.28",
    },
    "1946.5.9" => {
      name: "Umberto | Savoia",
      father: "e_italy Vittorio Emanuele 1",
      lived: "1904.9.15 - 1983.3.18",
    },
    # Preidents
    "1946.6.12" => {
      name: "Enrico | De Nicola",
      lived: "1877.11.9 - 1959.10.1",
    },
    "1948.5.12" => {
      name: "Luigi | Einaudi",
      lived: "1874.3.24 - 1961.10.30",
    },
    "1955.5.11" => {
      name: "Giovanni | Gronchi",
      lived: "1887.9.10 - 1978.10.17",
    },
    "1962.5.11" => {
      name: "Antonio | Segni",
      lived: "1891.2.2 - 1972.12.1",
    },
    "1964.12.29" => {
      name: "Giuseppe | Saragat",
      lived: "1898.9.19 - 1988.6.11",
    },
    "1971.12.29" => {
      name: "Giovanni | Leone",
      lived: "1908.11.3 - 2001.11.9",
    },
    "1978.7.9" => {
      name: "Sandro | Pertini",
      lived: "1896.9.25 - 1990.2.24",
    },
    "1985.7.3" => {
      name: "Francesco | Cosiga",
      lived: "1928.7.26 - 2010.8.17",
    },
    "1992.5.28" => {
      name: "Oscar Luigi | Scalfaro",
      lived: "1918.9.9 - 2012.1.29",
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
    "1734.6.2" => { use: "e_spain Carlos 2" },
    "1759.10.6" => {
      name: "Ferdinando | Bourbon",
      lived: "1751.1.12 - 1825.1.4",
      father: "e_spain Carlos 2",
    },
    "1806.3.30" => {
      name: "Joseph | Bonaparte",
      culture: "frankish"
      lived: "1768.1.7 - 1844.7.28",
    },
    "1808.8.1" => {
      name: "Joachim | Murat",
      culture: "frankish"
      lived: "1767.3.25 - 1815.10.13",
    },
    congress_of_vienna: {
      use: "Ferdinando 1",
    },
    "1825.1.4" => {
      name: "Francesco | Bourbon",
      lived: "1777.8.14 - 1830.11.8",
      father: "Ferdinando 1",
    },
    "1830.11.8" => {
      name: "Ferdinando | Bourbon",
      lived: "1810.1.12 - 1859.5.22",
      father: "Francesco 1",
    },
    "1859.5.22" => {
      name: "Francesco | Bourbon",
      lived: "1836.1.16 - 1894.12.27",
      father: "Ferdinando 2",
    },
    italy_unification: nil,
  },
  d_sicily: {
    "1734.6.2" => { use_all: "k_sicily" },
    "1806.3.30" => { use: "k_sicily Ferdinand 1" },
    congress_of_vienna: { use_all: "k_sicily" },
    italy_unification: nil,
  },
  # I'm really confused by Lucca / Parma situation
  # Maria Louisa Bourbon != Marie Louise Habsburg
  c_lucca: {
    "1815.6.9" => {
      name: "Maria Luisa | Bourbon",
      lived: "1782.7.6 - 1824.3.13",
      culture: "castillian",
      father: "e_spain Carlos 3",
      female: true,
    },
    "1824.3.13" => {
      name: "Carlo | Bourbon",
      lived: "1799.12.22 - 1883.4.16",
      father: "d_toscana Lodovico",
      mother: "Maria Luisa 1",
    },
    # Actually deposed two months earlier ???
    "1847.12.17" => nil,
  },
  c_parma: {
    "1748.10.18" => {
      name: "Felipe | Bourbon",
      culture: "castillian"
      father: "e_spain Felipe 1",
      lived: "1720.3.15 - 1765.7.18",
    },
    "1765.7.18" => {
      name: "Ferdinando | Bourbon",
      lived: "1751.1.20 - 1802.10.9",
    },
    "1802.10.9" => nil,
    "1814.4.11" => {
      name: "Marie Louise | Habsburg",
      lived: "1791.12.12 - 1847.12.17",
      father: "e_carpathia Franz 1",
      female: true,
    },
    "1847.12.17" => {
      use: "c_lucca Carlo 1",
    },
    "1849.5.17" => {
      name: "Carlo | Bourbon",
      lived: "1823.1.14 - 1854.3.27",
      father: "c_lucca Carlo 1",
    },
    "1854.3.27" => {
      name: "Roberto | Bourbon",
      lived: "1848.7.9 - 1907.11.16",
      father: "Carlo 1",
    },
    italy_unification: nil,
  },
  # Backdating everybody to their predecessor's death / resignation
  k_papal_state: {
    "1592.2.2" => {
      name: "Clemens | Aldobrandini",
      lived: "1536.2.24 - 1605.4.1",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1605.4.1" => {
      name: "Leo | de' Medici",
      lived: "1535.6.2 - 1605.5.16",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1605.5.16" => {
      name: "Paulus | Borghese",
      lived: "1550.9.17 - 1621.2.9",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1621.2.9" => {
      name: "Gregorius | Ludovisi",
      lived: "1554.1.9 - 1623.8.6",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1623.8.6" => {
      name: "Urbanus | Barberini",
      lived: "1568.4.5 - 1644.9.15",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1644.9.15" => {
      name: "Innocentius | Pamphili",
      lived: "1574.5.6 - 1655.4.7",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1655.4.7" => {
      name: "Alexander | Chigi",
      lived: "1599.2.13 - 1667.6.20",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1667.6.20" => {
      name: "Clemens | Rospigliosi",
      lived: "1600.1.28 - 1670.4.29",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1670.4.29" => {
      name: "Clemens | Altieri",
      lived: "1590.7.13 - 1676.9.21",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1676.9.21" => {
      name: "Innocentius | Odescalchi",
      lived: "1611.5.16 - 1689.10.6",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1689.10.6" => {
      name: "Alexander | Ottoboni",
      lived: "1610.4.22 - 1691.7.21",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1691.7.21" => {
      name: "Innocentius | Pignatelli",
      lived: "1615.3.13 - 1700.11.23",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1700.11.23" => {
      name: "Clemens | Albani",
      lived: "1649.7.23 - 1721.5.8",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1721.5.8" => {
      name: "Innocentius | di Conti",
      lived: "1655.5.13 - 1724.5.29",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1724.5.29" => {
      name: "Benedictus | Orsini",
      lived: "1649.2.2 - 1730.7.21",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1730.7.21" => {
      name: "Clemens | Corsini",
      lived: "1652.4.7 - 1740.8.17",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1740.8.17" => {
      name: "Benedictus | Lambertini",
      lived: "1675.3.31 - 1758.7.6",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1758.7.6" => {
      name: "Clemens | della Torre di Rezzonico",
      lived: "1693.3.7 - 1769.5.19",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1769.5.19" => {
      name: "Clemens | Ganganelli",
      lived: "1705.10.31 - 1775.2.15",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1775.2.15" => {
      name: "Pius | Braschi",
      lived: "1717.12.25 - 1799.8.29",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
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
      name: "Gregorius | Cappellari",
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
      name: "Benedictus | della Chiesa",
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
      name: "Ioannes | Roncalli",
      lived: "1881.11.25 - 1963.6.3",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1963.6.3" => {
      name: "Paulus | Montini",
      lived: "1897.9.26 - 1978.8.6",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1978.8.6" => {
      name: "Ioannes Paulus | Luciani",
      lived: "1912.10.17 - 1978.9.28",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "1978.9.28" => {
      name: "Ioannes Paulus | Wojtyla",
      culture: :polish,
      lived: "1920.5.18 - 2005.4.2",
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "2005.4.2" => {
      name: "Benedictus | Ratzinger",
      culture: :german,
      lived: "1927.4.16 -", # Popes, abdicating? WTF is this?
      traits: ["mastermind_theologian"],
      events: { crowning: PropertyList["piety", 500] },
    },
    "2013.2.28" => {
      name: "Franciscus | Bergoglio",
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
      lived: "1911.7.5 - 1980.10.29",
    },
    "1971.6.21" => {
      name: "Dom Mintoff",
      lived: "1916.8.6 - 2012.8.20",
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
    "1801.3.21" => { name: "Lodovico | Bourbon", lived: "1769.5.6 - 1824.6.18", father: "c_parma Ferdinando" },
    "1803.5.27" => { use: "c_lucca Carlo" },
    "1814.4.27" => { name: "Ferdinando | Habsburg", lived: "1769.5.6 - 1824.6.18" },
    "1824.6.18" => { name: "Leopoldo | Habsburg", lived: "1797.10.3 - 1870.1.29", father: "Ferdinando 1" },
    "1859.7.21" => { name: "Ferdinando | Habsburg", lived: "1835.6.10 - 1908.1.17", father: "Leopoldo 1" },
    "1859.11.10" => nil,
  },
}

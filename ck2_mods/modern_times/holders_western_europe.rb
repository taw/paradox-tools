ModernTimesDatabase::HOLDERS_WESTERN_EUROPE = {
  e_france: {
    "1799.11.10" => {name: "Napoleon | Bonaparte", lived: "1769.8.15 - 1821.5.5"},
    # 7 July 1815, backdating to Congress of Vienna
    "1815.6.9"  => {name: "Louis | Bourbon", lived: "1755.11.17 - 1824.9.16"},
    "1824.9.16" => {name: "Charles | Bourbon", lived: "1757.10.9 - 1836.11.6"}, # younger brother of previous
    "1830.8.9"  => {name: "Louis Philippe | Orléans", lived: "1773.10.6 - 1850.8.26"},
    # Second republic, second Empire from 1852.12.2
    "1848.2.24" => {name: "Napoleon | Bonaparte", lived: "1808.4.20 - 1873.1.9"},
    # 3rd Republic
    # Backdated, really 1871.8.31
    "1870.9.4" =>  {name: "Adolphe | Thiers", lived: "1797 - 1877"},
    "1873.5.24" =>  {name: "Patrice | de Mac-Mahon", lived: "1808 - 1893"},
    "1879.1.30" =>  {name: "Jules | Grévy", lived: "1807 - 1891"},
    "1887.12.3" =>  {name: "Marie François Sadi | Carnot", lived: "1837 - 1894"},
    "1894.6.27" =>  {name: "Jean | Casimir-Perier", lived: "1847 - 1907"},
    "1895.1.17" =>  {name: "Félix | Faure", lived: "1841 - 1899"},
    "1899.2.18" =>  {name: "Émile | Loubet", lived: "1838 - 1929"},
    "1906.2.18" =>  {name: "Armand | Fallières", lived: "1841 - 1931"},
    "1913.2.18" =>  {name: "Raymond | Poincaré", lived: "1860 - 1934"},
    "1920.2.18" =>  {name: "Paul | Deschanel", lived: "1855 - 1922"},
    "1920.9.23" =>  {name: "Alexandre | Millerand", lived: "1859 - 1943"},
    "1924.6.13" =>  {name: "Gaston | Doumergue", lived: "1863 - 1937"},
    "1931.6.13" =>  {name: "Paul | Doumer", lived: "1857 - 1932"},
    "1932.5.10" =>  {name: "Albert | Lebrun", lived: "1871 - 1950"},
    # Vichy
    "1940.7.11" => {name: "Philippe | Pétain", lived: "1856 - 1951"},
    # 4th Republic
    # 1947.1.16, backdated
    end_ww2: {name: "Vincent | Auriol", lived: "1884 - 1966"},
    "1954.1.16" => {name: "René | Coty", lived: "1882 - 1962"},
    # 5th Republic
    "1959.1.8" => {name: "Charles | de Gaulle", lived: "1890 - 1970"},
    "1969.6.20" => {name: "Georges | Pompidou", lived: "1911 - 1974"},
    "1974.5.27" => {name: "Valéry Giscard | d'Estaing", lived: "1926 -"},
    "1981.5.21" => {name: "François | Mitterrand", lived: "1916 - 1996"},
    "1995.5.17" => {name: "Jacques | Chirac", lived: "1932 -"},
    "2007.5.16" => {name: "Nicolas | Sarkozy", lived: "1955 -"},
    "2012.5.15" => {name: "François | Hollande", lived: "1954 -"},
    "2017.5.14" => {name: "Emmanuel Macron", lived: "1977.12.21 -"},
  },
  e_spain: {
    "1665.9.17"   => {name: "Charles | Habsburg", lived: "1661.11.6 - 1700.11.1"},
    "1700.11.1"  => {name: "Philip | Bourbon", lived: "1683.12.19 - 1746.7.9"},
    "1724.1.14"   => {name: "Louis | Bourbon", father: "Philip 1", lived: "1707.8.25 - 1724.8.31"},
    # backdating
    "1724.8.31"    => {use: "Philip 1"},
    "1746.7.9"    => {name: "Ferdinand | Bourbon", father: "Philip 1", lived: "1713.9.23 - 1759.8.10"},
    "1759.8.10"   => {name: "Charles | Bourbon", father: "Philip 1", lived: "1716.1.20 - 1788.12.14"},
    "1788.12.14"  => {name: "Charles | Bourbon", father: "Charles 2", lived: "1748.11.11 - 1819.1.20"},
    "1808.3.19"   => {name: "Ferdinand | Bourbon", father: "Charles 3", lived: "1784.10.14 - 1833.9.29"},
    "1808.6.6"    => {name: "Joseph | Bonaparte", lived: "1768.1.7 - 1844.7.28"},
    "1813.12.11"  => {use: "Ferdinand 2"},
    "1833.9.29"   => {name: "Isabella | Bourbon", female: true, father: "Ferdinand 2", lived: "1830.10.10 - 1904.4.10"},
    "1870.11.16"  => {name: "Amadeo | Savoy", lived: "1845.5.30 - 1890.1.18"},
    "1874.12.29"  => {name: "Alfonso | Bourbon", lived: "1857.11.28 - 1885.11.25"},
    # Birth backdated hard as posthumous, actual 1886.5.17
    "1885.11.25"  => {name: "Alfonso | Bourbon", lived: "1885.11.25 - 1941.2.28"},
    # Simplify republic
    "1931.4.14"   => {name: "Niceto | Alcalá-Zamora", lived: "1877.7.6 - 1949.2.18"},
    "1936.10.1"   => {name: "Francisco | Franco", lived: "1892.12.4 - 1975.11.20"},
    "1975.11.20"  => {name: "Juan Carlos | Bourbon", lived: "1938.1.5 -"},
    "2014.6.19"   => {name: "Felipe | Bourbon", lived: "1968.1.30 -"},
  },
  k_portugal: {
    "1640.12.1" => {name: "John | Braganza", lived: "1603.3.18 - 1656.11.6"},
    "1656.11.6" => {name: "Alphonse | Braganza", lived: "1643.8.21 - 1683.9.12", father: "John 1"},
    "1683.9.12" => {name: "Peter | Braganza", lived: "1648.4.26 - 1706.12.9", father: "John 1"},
    "1706.12.9" => {name: "John | Braganza", lived: "1689.10.22 - 1750.7.31", father: "Peter 1"},
    "1750.7.31" => {name: "Joseph | Braganza", lived: "1714.6.6 - 1777.2.24", father: "John 2"},
    "1777.2.24" => {name: "Mary | Braganza", lived: "1734.12.17 - 1816.3.20", father: "Joseph 1", female: true},
    "1816.3.20" => {name: "John | Braganza", lived: "1767.5.13 - 1826.3.10", mother: "Mary 1"},
    "1826.3.10" => {name: "Peter | Braganza", lived: "1798.10.12 - 1834.9.24", father: "John 3"},
    "1826.5.2" => {name: "Mary | Braganza", lived: "1819.4.4 - 1853.11.15", father: "Peter 2"},
    "1853.11.15" => {name: "Peter | Braganza", lived: "1837.9.16 - 1861.11.11", mother: "Mary 2"},
    "1861.11.11" => {name: "Louis | Braganza", lived: "1838.10.31 - 1889.10.19", father: "Peter 3"},
    "1889.10.19" => {name: "Charles | Braganza", lived: "1863.9.28 - 1908.2.1", father: "Louis 1"},
    "1908.2.1" => {name: "Manuel | Braganza", lived: "1889.11.15 - 1932.7.2", father: "Charles 1"},
    # Presidents
    "1910.10.5" => {
      name: "Teofilo | Braga", lived: "1843.2.24 - 1924.1.28",
    },
    "1911.8.24" => {
      name: "Manuel | de Arriaga", lived: "1840.7.8 - 1917.3.5",
    },
    "1915.5.29" => {
      use: "Teofilo 1",
    },
    "1915.10.5" => {
      name: "Bernardino | Machado", lived: "1851.3.28 - 1944.4.29",
    },
    "1917.12.12" => {
      name: "Sidónio | Pais", lived: "1872.5.1 - 1918.12.14",
    },
    "1918.12.14" => {
      name: "Joao | do Canto e Castro", lived: "1862.5.19 - 1934.3.14",
    },
    "1919.10.5" => {
      name: "António José | de Almeida", lived: "1866.7.27 - 1929.10.31",
    },
    "1923.10.6" => {
      name: "Manuel Teixeira | Gomes", lived: "1860.5.27 - 1941.10.18",
    },
    "1925.12.11" => {
      use: "Bernardino 1",
    },
    "1926.5.31" => {
      name: "Jose Mendes | Cabecadas", lived: "1883.8.19 - 1965.6.11",
    },
    "1926.6.17" => {
      name: "Manuel Gomes | da Costa", lived: "1863.1.14 - 1929.12.17",
    },
    "1926.7.9" => {
      name: "Oscar | Carmona", lived: "1869.11.24 - 1951.4.18",
    },
    "1951.4.18" => {
      name: "Antonio de Oliveira | Salazar", lived: "1889.4.28 - 1970.7.27",
    },
    "1951.7.21" => {
      name: "Francisco Craveiro | Lopes", lived: "1894.4.12 - 1964.9.2",
    },
    "1958.8.9" => {
      name: "Americo | Tomas", lived: "1894.11.19 - 1987.9.18",
    },
    "1974.4.25" => {
      name: "Antonio | de Spinola", lived: "1910.4.11 - 1996.8.13",
    },
    "1974.9.30" => {
      name: "Francisco da Costa | Gomes", lived: "1914.6.30 - 2001.7.31",
    },
    "1976.7.14" => {
      name: "Antonio Ramalho | Eanes", lived: "1935.1.25 -",
    },
    "1986.3.9" => {
      name: "Mario | Soares", lived: "1924.12.7 -",
    },
    "1996.3.9" => {
      name: "Jorge | Sampaio", lived: "1939.9.18 -",
    },
    "2006.3.9" => {
      name: "Aníbal Cavaco | Silva", lived: "1939.7.15 -",
    },
    "2016.3.9" => {
      name: "Marcelo Rebelo | de Sousa", lived: "1948.12.2 -",
    },
  },
  k_frisia: {
    "1815.3.16" => {name: "William | Orange-Nassau", lived: "1772.8.24 - 1843.12.12"},
    "1840.10.7" => {name: "William | Orange-Nassau", father: "William 1", lived: "1792.12.6 - 1849.3.17"},
    "1849.3.17" => {name: "William | Orange-Nassau", father: "William 2", lived: "1817.2.19 - 1890.11.23"},
    "1890.11.23" => {name: "Wilhelmina | Orange-Nassau", father: "William 3", female: true, lived: "1880.8.31 - 1962.11.28"},
    "1948.9.4" => {name: "Juliana | Orange-Nassau", mother: "Wilhelmina 1", female: true, lived: "1909.4.30 - 2004.3.20"},
    "1980.4.30" => {name: "Beatrix | Orange-Nassau", mother: "Juliana 1", female: true, lived: "1938.1.31 -"},
    "2013.4.30" => {name: "William-Alexander | Orange-Nassau", mother: "Beatrix 1", lived: "1967.4.27-"},
  },
  d_flanders: {
    belgium_independence: {name: "Leopold | Saxe-Coburg and Gotha", lived: "1790.12.16 - 1865.12.10"},
    "1865.12.10" => {name: "Leopold | Saxe-Coburg and Gotha", father: "Leopold 1", lived: "1835.4.9 - 1909.12.17"},
    # nephew of Leopold 2, can't model that yet
    "1909.12.17" => {name: "Albert | Saxe-Coburg and Gotha", lived: "1875.4.8 - 1934.2.17"},
    "1934.2.17" => {name: "Leopold | Saxe-Coburg and Gotha", father: "Albert 1", lived: "1901.11.3 - 1983.9.25"},
    "1951.7.17" => {name: "Baudouin | Saxe-Coburg and Gotha", father: "Leopold 3", lived: "1930.9.7 - 1993.7.31"},
    "1993.7.31" => {name: "Albert | Saxe-Coburg and Gotha", father: "Leopold 3", lived: "1934.6.6 -"},
    "2013.7.21" => {name: "Philippe | Saxe-Coburg and Gotha", father: "Albert 2", lived: "1960.4.15-"},
  },
  d_luxembourg: {
    "1890.11.23" => {
      name: "Adolphe | Nassau-Weilburg",
      lived: "1817.7.24 - 1905.11.17",
      religion: "reformed",
    },
    "1905.11.17" => {
      name: "Guillaume | Nassau-Weilburg",
      lived: "1852.4.22 - 1912.2.25",
      father: "Adolphe",
      religion: "reformed",
    },
    "1912.2.25" => {
      name: "Marie-Adelaide | Nassau-Weilburg",
      lived: "1894.6.14 - 1924.1.24",
      religion: "catholic",
      female: true,
    },
    "1919.1.14" => {
      name: "Charlotte | Nassau-Weilburg",
      lived: "1896.1.23 - 1985.7.9",
      religion: "catholic",
      female: true,
    },
    "1964.11.12" => {
      name: "Jean | Nassau-Weilburg",
      lived: "1921.1.5 -",
      mother: "Charlotte",
      religion: "catholic",
    },
    "2000.10.7" => {
      name: "Henri | Nassau-Weilburg",
      lived: "1955.4.16 -",
      father: "Jean",
      religion: "catholic",
    },
  },
}

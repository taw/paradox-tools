ModernTimesDatabase::HOLDERS_WESTERN_EUROPE = {
  e_france: {
    "1799.11.10" => {name: "Napoleon | Bonaparte", lived: "1769.8.15 - 1821.5.5"},
    # 7 July 1815, backdating to Congress of Vienna
    "1815.6.9"  => {name: "Louis | Bourbon"},
    "1824.9.16" => {name: "Charles | Bourbon"},
    "1830.8.9"  => {name: "Louis Philippe | Orléans"},
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
    "1940.7.11"=>{name: "Philippe | Pétain", lived: "1856 - 1951"},
    # 4th Republic
    # 1947.1.16, backdated
    end_ww2: {name: "Vincent | Auriol", lived: "1884 - 1966"},
    "1954.1.16"=>{name: "René | Coty", lived: "1882 - 1962"},
    # 5th Republic
    "1959.1.8"=>{name: "Charles | de Gaulle", lived: "1890 - 1970"},
    "1969.6.20"=>{name: "Georges | Pompidou", lived: "1911 - 1974"},
    "1974.5.27"=>{name: "Valéry Giscard | d'Estaing", lived: "1926 -"},
    "1981.5.21"=>{name: "François | Mitterrand", lived: "1916 - 1996"},
    "1995.5.17"=>{name: "Jacques | Chirac", lived: "1932 -"},
    "2007.5.16"=>{name: "Nicolas | Sarkozy", lived: "1955 -"},
    "2012.5.15"=>{name: "François | Hollande", lived: "1954 -"},
  },
  e_spain: {
    "1665.9.17"   => {name: "Charles | Habsburg", lived: "1661.11.6 - 1700.11.1"},
    "1700.11.1"  => {name: "Philip | Bourbon"},
    "1724.1.14"   => {name: "Louis | Bourbon", father: "Philip 1"},
    "1724.9.6"    => {use: "Philip 1"},
    "1746.7.9"    => {name: "Ferdinand | Bourbon", father: "Philip 1"},
    "1759.8.10"   => {name: "Charles | Bourbon", father: "Philip 1"},
    "1788.12.14"  => {name: "Charles | Bourbon", father: "Charles 2"},
    "1808.3.19"   => {name: "Ferdinand | Bourbon", father: "Charles 3"},
    "1808.6.6"    => {name: "Joseph | Bonaparte"},
    "1813.12.11"  => {use: "Ferdinand 2"},
    "1833.9.29"   => {name: "Isabella | Bourbon", female: true, father: "Ferdinand 2"},
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
    "1 December 1640" => {name: "John | Braganza", lived: "18 March 1603 – 6 November 1656"},
    "6 November 1656" => {name: "Alphonse | Braganza", lived: "21 August 1643 – 12 September 1683", father: "John 1"},
    "12 September 1683" => {name: "Peter | Braganza", lived: "26 April 1648 – 9 December 1706", father: "John 1"},
    "9 December 1706" => {name: "John | Braganza", lived: "22 October 1689 – 31 July 1750", father: "Peter 1"},
    "31 July 1750" => {name: "Joseph | Braganza", lived: "6 June 1714 – 24 February 1777", father: "John 2"},
    "24 February 1777" => {name: "Mary | Braganza", lived: "17 December 1734 - 20 March 1816", father: "Joseph 1", female: true},
    "20 March 1816" => {name: "John | Braganza", lived: "13 May 1767 – 10 March 1826", mother: "Mary 1"},
    "10 March 1826" => {name: "Peter | Braganza", lived: "12 October 1798 – 24 September 1834", father: "John 3"},
    "2 May 1826" => {name: "Mary | Braganza", lived: "4 April 1819 – 15 November 1853", father: "Peter 2"},
    "15 November 1853" => {name: "Peter | Braganza", lived: "16 September 1837 – 11 November 1861", mother: "Mary 2"},
    "11 November 1861" => {name: "Louis | Braganza", lived: "31 October 1838 – 19 October 1889", father: "Peter 3"},
    "19 October 1889" => {name: "Charles | Braganza", lived: "28 September 1863 – 1 February 1908", father: "Louis 1"},
    "1 February 1908" => {name: "Manuel | Braganza", lived: "15 November 1889 – 2 July 1932", father: "Charles 1"},
    # Presidents
    "5 October 1910" => {
      name: "Teofilo | Braga", lived: "24 February 1843 – 28 January 1924",
    },
    "August 24, 1911" => {
      name: "Manuel | de Arriaga", lived: "July 8, 1840 – March 5, 1917",
    },
    "May 29, 1915" => {
      use: "Teofilo 1",
    },
    "October 5, 1915" => {
      name: "Bernardino | Machado", lived: "28 March 1851 – 29 April 1944",
    },
    "December 12, 1917" => {
      name: "Sidónio | Pais", lived: "1 May 1872 - 14 December 1918",
    },
    "December 14, 1918" => {
      name: "Joao | do Canto e Castro", lived: "May 19, 1862 - March 14, 1934",
    },
    "October 5, 1919" => {
      name: "António José | de Almeida", lived: "27 July 1866 – 31 October 1929",
    },
    "October 6, 1923" => {
      name: "Manuel Teixeira | Gomes", lived: "May 27, 1860 – October 18, 1941",
    },
    "December 11, 1925" => {
      use: "Bernardino 1",
    },
    "May 31, 1926" => {
      name: "Jose Mendes | Cabecadas", lived: "August 19, 1883 – June 11, 1965",
    },
    "June 17, 1926" => {
      name: "Manuel Gomes | da Costa", lived: "January 14, 1863 – December 17, 1929",
    },
    "July 9, 1926" => {
      name: "Oscar | Carmona", lived: "24 November 1869 – 18 April 1951",
    },
    "April 18, 1951" => {
      name: "Antonio de Oliveira | Salazar", lived: "28 April 1889 – 27 July 1970",
    },
    "July 21, 1951" => {
      name: "Francisco Craveiro | Lopes", lived: "12 April 1894 – 2 September 1964",
    },
    "August 9, 1958" => {
      name: "Americo | Tomas", lived: "19 November 1894 – 18 September 1987",
    },
    "April 25, 1974" => {
      name: "Antonio | de Spinola", lived: "April 11, 1910 – August 13, 1996",
    },
    "September 30, 1974" => {
      name: "Francisco da Costa | Gomes", lived: "30 June 1914 – 31 July 2001",
    },
    "July 14, 1976" => {
      name: "Antonio Ramalho | Eanes", lived: "25 January 1935 -",
    },
    "March 9, 1986" => {
      name: "Mario | Soares", lived: "7 December 1924 -",
    },
    "March 9, 1996" => {
      name: "Jorge | Sampaio", lived: "18 September 1939 -",
    },
    "March 9, 2006" => {
      name: "Aníbal Cavaco | Silva", lived: "15 July 1939 -",
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

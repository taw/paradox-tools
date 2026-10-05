ModernTimesDatabase::Holders.define do
  title "d_nefoud" do
    ruler "1902.1.13", name: "Abdulaziz | Saud", lived: "1876.11.26 - 1953.11.9"
    vacant :end_ww1
  end
  title "k_arabia" do
    # "Emirate of Nejd and Hasa" etc., maybe I should differentiate those titles
    # It's total bullshit backdating before "1902.1.13" when he got first duchy
    ruler :end_ww1, use: "d_nefoud Abdulaziz 1"
    ruler "1953.11.9", name: "Saud | Saud", father: "d_nefoud Abdulaziz 1", lived: "1902.1.12 - 1969.2.23"
    ruler "1964.11.2", name: "Faisal | Saud", father: "d_nefoud Abdulaziz 1", lived: "1906.4.14 - 1975.3.25"
    ruler "1975.3.25", name: "Khalid | Saud", father: "d_nefoud Abdulaziz 1", lived: "1913.2.13 - 1982.6.13"
    ruler "1982.6.13", name: "Fahd | Saud", father: "d_nefoud Abdulaziz 1", lived: "1921.3.16 - 2005.8.1"
    ruler "2005.8.1", name: "Abdullah | Saud", father: "d_nefoud Abdulaziz 1", lived: "1924.8.1 - 2015.1.23"
    ruler "2015.1.23", name: "Salman | Saud", father: "d_nefoud Abdulaziz 1", lived: "1935.12.31 -"
  end
  title "c_kuwait" do
    ruler :kuwait_independence, name: "Abdullah Salem Al-Mubarak | Al-Sabah", lived: "1895 - 1965.11.24"
    ruler "1965.11.24", name: "Sabah Salem Al-Mubarak | Al-Sabah", lived: "1913.4.12 - 1977.12.31"
    ruler "1977.12.31", name: "Jaber Al-Ahmad Al-Jaber | Al-Sabah", lived: "1926.6.29 - 2006.1.15"
    ruler "2006.1.15", name: "Saad Abdullah Al-Salem | Al-Sabah", lived: "1930.5.13 - 2008.5.13", father: "Abdullah Salem Al-Mubarak 1"
    ruler "2006.1.29", name: "Sabah Al-Ahmad Al-Jaber | Al-Sabah", lived: "1929.6.16 - 2020.9.29"
    # brother of previous
    ruler "2020.9.29", name: "Nawaf Al-Ahmad Al-Jaber | Al-Sabah", lived: "1937.6.25 - 2023.12.16"
    # brother of previous
    ruler "2023.12.16", name: "Mishal Al-Ahmad Al-Jaber | Al-Sabah", lived: "1940.9.27 -"
  end
  title "d_arabia_felix" do
    #  Mutawakkilite Kingdom of Yemen, imams
    # ruling from 4 June 1904
    ruler "1918.10.30",
      name: "Yahya |  Rassid",
      lived: "1869.6.18 - 1948.2.17"
    ruler "1948.2.17",
      name: "Ahmad | Rassid",
      lived: "1891.6.18 - 1962.9.18",
      father: "Yahya 1"
    ruler "1962.9.18",
      name: "Muhammad Al-Badr | Rassid",
      lived: "1926.2.15 - 1996.8.6",
      father: "Ahmad 1"
    # Yemen Arab Republic
    ruler "1962.9.27", name: "Abdullah as-Sallal", lived: "1917.1.9 - 1994.3.5"
    ruler "1967.11.5", name: "Abdul Rahman | al-Iryani", lived: "1908 - 1998.3.14"
    ruler "1974.6.13", name: "Ibrahim al-Hamdi", lived: "1943 - 1977.10.11"
    ruler "1977.10.11", name: "Ahmad al-Ghashmi", lived: "1938 - 1978.6.24"
    ruler "1978.6.24", name: "Abdul Karim Abdullah | al-Arashi", lived: "1934.12.1 - 2006.6.10"
    ruler "1978.7.18", name: "Ali Abdullah | Saleh", lived: "1947.3.21 - 2017.12.4"
    vacant "1990.5.22"
  end
  title "d_sanaa" do
    ruler "1967.11.30", name: "Qahtan Muhammad | al-Shaabi", lived: "1920 - 1981"
    ruler "1969.6.23", name: "Salim Rubai | Ali", lived: "1935 - 1978.6.26"
    ruler "1978.6.26", name: "Ali Nasir | Muhammad", lived: "1939.12.31 -"
    ruler "1978.12.27", name: "Abdul Fattah | Ismail", lived: "1939 - 1986.1.13"
    ruler "1980.4.26", use: "Ali Nasir 1"
    ruler "1986.1.24", name: "Haidar Abu Bakr | al-Attas", lived: "1939.4.5 -"
    # Unification
    ruler "1990.5.22", use: "d_arabia_felix Ali Abdullah 1"
    ruler "2012.2.27", name: "Abd Rabbuh Mansur | Hadi", lived: "1945.9.1 -"
    # Chairman of the Presidential Leadership Council
    ruler "2022.4.7", name: "Rashad | al-Alimi", lived: "1954.1.15 -"
  end
  title "d_oman" do
    ruler "1806.9.14", name: "Said | al Said", lived: "1797.6.5 - 1856.10.19"
    ruler "1856.10.19", name: "Thuwaini | al Said", lived: "1821 - 1866.2.11", father: "Said 1"
    ruler "1866.2.11", name: "Salim | al Said", lived: "- 1876.12.7", father: "Thuwaini 1"
    # distant relative, said killed in 1870, but next ruler from Jan 1871...
    ruler "1868.10.3", name: "Azzan | al Said", lived: "- 1871.1.30"
    ruler "1871.1.30", name: "Turki | al Said", lived: "1832 - 1888.6.4", father: "Said 1"
    ruler "1888.6.4", name: "Faisal | al Said", lived: "1864 - 1913.10.4", father: "Turki 1"
    vacant "1892.3.13"
    # from "1970.7.23", initially under UK
    # Sultans 1913-1932 and 1932-1970
    character "Taimur bin Feisal", name: "Taimur | al Said", lived: "1886 - 1965.1.28", father: "Faisal 1"
    character "Said bin Taimur", name: "Said | al Said", lived: "1910.8.13 - 1972.10.19", father: "Taimur bin Feisal"
    character "Tariq bin Taimur", name: "Tariq | al Said", lived: "1921.6.30 - 1980.12.28", father: "Taimur bin Feisal"
    ruler "1971.12.2", name: "Qaboos | al Said", lived: "1940.11.18 - 2020.1.10", father: "Said bin Taimur"
    # cousin of previous, backdating from 2020.1.11
    ruler "2020.1.10", name: "Haitham | al Said", lived: "1955.10.11 -", father: "Tariq bin Taimur"
  end
  title "d_medina" do
    ruler "1918.11.11",
      name: "Hussein ibn Ali | Hashemite",
      lived: "1854 - 1931.6.4",
      traits: ["sayyid"]
    ruler "1924.10.3",
      name: "Ali bin Hussein | Hashemite",
      lived: "1879 - 1935",
      father: "Hussein ibn Ali 1",
      traits: ["sayyid"]
    vacant "1926.1.8"
  end
  title "d_oultrejourdain" do
    # Backdating hard from "1921.4.1"
    ruler "1918.11.11",
      name: "Abdullah | Hashemite",
      lived: "1882.2.1 - 1951.7.20",
      father: "d_medina Hussein ibn Ali 1",
      traits: ["sayyid"]
    ruler "1951.7.20",
      name: "Talal | Hashemite",
      lived: "1909.2.26 - 1972.7.7",
      father: "Abdullah 1",
      traits: ["sayyid"]
    ruler "1952.8.11",
      name: "Hussein | Hashemite",
      lived: "1935.11.14 - 1999.2.7",
      father: "Talal 1",
      traits: ["sayyid"]
    ruler "1999.2.7",
      name: "Abdullah | Hashemite",
      lived: "1962.1.30 -",
      father: "Hussein 1",
      traits: ["sayyid"]
  end
  title "k_iraq" do
    # Backdating
    ruler "1920.4.25",
      name: "Faisal | Hashemite",
      lived: "1885.5.20 - 1933.9.8",
      father: "d_medina Hussein ibn Ali 1",
      traits: ["sayyid"]
    ruler "1933.9.8",
      name: "Ghazi | Hashemite",
      lived: "1912.5.2 - 1939.4.4",
      father: "Faisal 1",
      traits: ["sayyid"]
    ruler "1939.4.4",
      name: "Faisal | Hashemite",
      lived: "1935.5.2 - 1958.7.14",
      father: "Ghazi 1",
      traits: ["sayyid"]

    ruler "1958.7.14", name: "Muhammad Najib | ar-Ruba'i", lived: "1904 - 1965"
    ruler "1963.2.8", name: "Abdul Salam | Arif", lived: "1921.3.21 - 1966.4.13"
    # brother of previous
    ruler "1966.4.13", name: "Abdul Rahman | Arif", lived: "1916.4.14 - 2007.8.24"
    ruler "1968.7.17", name: "Ahmed Hassan | al-Bakr", lived: "1914.7.1 - 1982.10.4"
    ruler "1979.7.16", name: "Saddam | Hussein", lived: "1937.4.28 - 2006.12.30", traits: ["cynical", "paranoid"], health: 6
    # Backdating hard
    ruler "2003.4.9", name: "Jalal | Talabani", lived: "1933 - 2017.10.3"
    ruler "2014.7.24", name: "Fuad | Masum", lived: "1938.7.1 -"
    ruler "2018.10.2", name: "Barham | Salih", lived: "1960.9.8 -"
    ruler "2022.10.17", name: "Abdul Latif | Rashid", lived: "1944.8.10 -"
  end
  title "k_syria" do
    # a lot of one-day rulers, skipping them
    ruler "1946.4.17", name: "Shukri al-Quwatli", lived: "1891 - 1967.6.30"
    ruler "1949.3.30", name: "Husni al-Za'im", lived: "1897 - 1949.8.14"
    ruler "1949.8.14", name: "Hashim al-Atassi", lived: "1875 - 1960.12.5"
    ruler "1951.12.2", name: "Fawzi Selu", lived: "1905 - 1972"
    ruler "1953.7.11", name: "Adib Shishakli", lived: "1909 - 1964.9.27"
    ruler "1954.2.25", use: "Hashim 1"
    ruler "1958.2.22", use: "k_egypt Gamal Abdel 1"
    ruler "1961.9.29", name: "Maamun al-Kuzbari", lived: "1914 - 1998"
    ruler "1961.11.20", name: "Izzat al-Nuss", lived: "1900 - 1972"
    ruler "1961.12.14", name: "Nazim al-Kudsi", lived: "1906.2.14 - 1998.2.6"
    ruler "1963.3.9", name: "Lu'ay al-Atassi", lived: "1926 - 2003.11.1" # death day unknown
    ruler "1963.7.27", name: "Amin al-Hafiz", lived: "1918 - 2009.12.17"
    ruler "1966.2.25", name: "Nureddin al-Atassi", lived: "1929 - 1992.12.3"
    ruler "1970.11.18", name: "Ahmad al-Khatib", lived: "1933 - 1982"
    ruler "1971.2.22", name: "Hafez | al-Assad", lived: "1930.10.6 - 2000.6.10"
    ruler "2000.6.10", name: "Bashar | al-Assad", lived: "1965.9.11 -", father: "Hafez 1"
    # Fall of the Assad regime, de facto leader, formally President from 2025.1.29
    ruler "2024.12.8", name: "Ahmed | al-Sharaa", lived: "1982.10.29 -"
  end
  title "d_galilee" do
    # Ignore all before independence
    ruler "1943.11.22", name: "Bechara Khoury", lived: "1890.8.10 - 1964.1.11"
    ruler "1952.9.18", name: "Fuad Chehab", lived: "1902.3.19 - 1973.4.25"
    ruler "1952.9.23", name: "Camille Chamoun", lived: "1900.4.3 - 1987.8.7"
    ruler "1958.9.23", use: "Fuad 1"
    ruler "1964.9.23", name: "Charles Helou", lived: "1913.9.25 - 2001.1.7"
    ruler "1970.9.23", name: "Suleiman Frangieh", lived: "1910.6.15 - 1992.7.23"
    ruler "1976.9.23", name: "Elias Sarkis", lived: "1924.7.20 - 1985.6.27"
    ruler "1982.8.23", name: "Bachir Gemayel", lived: "1947.11.10 - 1982.9.14"
    # backdating from 1982.9.23
    # brother of Bachir Gemayel
    ruler "1982.9.14", name: "Amine Gemayel", lived: "1942.1.22 -"
    # Ignoring Selim Hoss conflict here
    ruler "1988.9.22", name: "Michel Aoun", lived: "1935.2.18 -"
    ruler "1989.11.5", name: "René Moawad", lived: "1925.4.17 - 1989.11.22"
    ruler "1989.11.22", name: "Selim Hoss", lived: "1929.12.20 - 2024.8.25"
    ruler "1989.11.24", name: "Elias Hrawi", lived: "1926.9.4 - 2006.7.7"
    ruler "1998.11.24", name: "Émile Lahoud", lived: "1936.1.12 -"
    ruler "2007.11.24", name: "Fouad Siniora", lived: "1943.7.19 -"
    ruler "2008.5.25", name: "Michel Suleiman", lived: "1948.11.21 -"
    # Acting President
    ruler "2014.5.25", name: "Tammam Salam", lived: "1945.5.13 -"
    ruler "2016.10.31", use: "Michel 1" # Michel Aoun, returning
    # Acting President (caretaker cabinet), presidential vacancy
    ruler "2022.10.31", name: "Najib Mikati", lived: "1955.11.24 -"
    ruler "2025.1.9", name: "Joseph Aoun", lived: "1964.1.10 -"
  end
  title "c_bahrein" do # Qatar
    # Start count from independence, there were sheiks under British protectorate before that
    ruler "1971.9.1", name: "Ahmad | Al Thani", lived: "1920 - 1977.11.25"
    ruler "1972.2.22", name: "Khalifa | Al Thani", lived: "1932.9.17 - 2016.10.23"
    ruler "1995.6.27", name: "Hamad | Al Thani", lived: "1952.1.1 -", father: "Khalifa"
    ruler "2013.6.25", name: "Tamim | Al Thani", lived: "1980.6.3 -", father: "Hamad"
  end
  title "c_uwal" do # Bahrain
    # Hakims of Bahrain until Britain took over, ignoring co-regents
    # Wikipedia has only year dates and very little extra info
    # death dates totally fictional
    ruler "1783.1.1", name: "Ahmed | Al Khalifa", lived: "- 1796.1.1"
    ruler "1796.1.1", name: "Abdullah | Al Khalifa", lived: "- 1843.1.1", father: "Ahmed 1"
    # Co-rulers with Abdullah, birth year estimated, died before 1821.9.28 (or 1825)
    character "Salman bin Ahmad", name: "Salman | Al Khalifa", lived: "1770 - 1821", father: "Ahmed 1"
    character "Khalifa bin Salman", name: "Khalifa | Al Khalifa", lived: "1795 - 1834.5.31", father: "Salman bin Ahmad" # birth year approximate
    ruler "1843.1.1", name: "Muhammad | Al Khalifa", lived: "- 1868.1.1", father: "Khalifa bin Salman"
    # No idea what happened with these 2 short rulers, Wikipedia got nothing
    ruler "1868.1.1", name: "Ali | Al Khalifa", lived: "- 1869.9.1", father: "Khalifa bin Salman"
    ruler "1869.9.1", name: "Muhammad | Al Khalifa", lived: "- 1869.12.1", father: "Abdullah 1"
    # real dates at least...
    ruler "1869.12.1", name: "Isa | Al Khalifa", lived: "1848 - 1932.12.9", father: "Ali 1"
    # British protectorate
    vacant "1880.12.22"
    # From "1961.11.2" sheik under Britain
    # Hakims 1932-1942 and 1942-1961
    character "Hamad bin Isa", name: "Hamad | Al Khalifa", lived: "1872.2.6 - 1942.2.20", father: "Isa 1"
    character "Salman bin Hamad", name: "Salman | Al Khalifa", lived: "1894.10.10 - 1961.11.2", father: "Hamad bin Isa"
    ruler "1971.8.15",
      name: "Isa | Al Khalifa",
      lived: "1933.6.3 - 1999.3.6",
      father: "Salman bin Hamad"
    # From 2002 as king
    ruler "1999.3.6",
      name: "Hamad | Al Khalifa",
      father: "Isa 2",
      lived: "1950.1.28 -"
  end
end

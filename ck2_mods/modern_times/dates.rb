# "Treaty of X" naming is a bit silly, as there are frequent conflicts
# There were a lot of peace treaties at end of WW1 but it's easier to just do it in one go, at least for now
# TODO: models both Balkan Wars properly

module ModernTimesDatabase::Dates
  # Easy dates
  @dates = {
    ### Special tags
    reset_date: "1450.1.1",
    today: "2015.9.1",
    game_end: "2999.12.31",

    times_immemorial: "1600.1.1",
    title_holders_until: "2020.12.31", # how far to generate title holders

    ### Special tags that need killing
    forever_ago: "1700.1.1", # Few plans to go back earlier than this

    ### Actual dates:
    end_of_ottoman_empire: "1922.11.1",
    st_petersburg_founding: "1703.5.12", # They literally moved their capital there before peace deal gave them Ingria
    junior_juz_russian: "1731.1.1", # year date
    oman_persian: "1743.1.1", # can't find anything more than year
    middle_juz_russian: "1798.1.1", # year date
    sudan_turkish: "1821.1.1", # approximate
    senior_juz_russian: "1824.1.1", # year date
    aden_city_british: "1839.1.1", # month date only
    aden_protectorate: "1869.1.1", # year date only
    british_somaliland: "1884.1.1", # year only
    italian_somaliland: "1889.1.1", # year only
    french_mali: "1892.1.1", # year only
    scotland_union: "1603.3.24",
    urbino_papal: "1626.1.1", # year only
    peace_of_westphalia: "1648.10.24",
    mantua_austrian: "1708.7.5",
    treaty_of_utrech: "1713.4.1", # "March and April 1713"
    treaty_of_passarowitz: "1718.7.21",
    treaty_of_nystad: "1721.9.10",
    treaty_of_resht: "1732.1.21",
    silesia_prussian: "1742.7.28",
    durrani_afghanistan: "1747.10.1", # month date
    oman_not_persian: "1747.6.19", # death of Nader Shah
    fall_dzungar: "1758.1.1",
    sindh_independent: "1762.1.1", # year date, and really it should probably be a tributary
    french_corsica: "1768.5.15",
    poland_1_partition: "1772.9.22",
    treaty_of_kucuk_kaynarca: "1774.7.21",
    treaty_of_versailles: "1783.1.20", # Was multiple times, but this was actual peace treaty
    bahrain_1783_invasion: "1783.7.23",
    treaty_of_jassy: "1792.1.9",
    poland_2_partition: "1793.1.23",
    poland_3_partition: "1795.10.24",
    sri_lanka_british: "1795.2.8",
    treaty_of_campo_formio: "1797.10.18",
    avignon_annexation: "1797.2.19", # Treaty of Tolentino, de facto 12 September 1791
    sikh_empire_founded: "1799.7.7",
    malta_british: "1800.9.4",
    peace_of_pressburg: "1805.12.26",
    hre_disbanded: "1806.8.6",
    free_danzig_napoleonic: "1807.7.21",
    duchy_warsaw: "1807.7.22",
    treaty_of_shoenbrunn: "1809.10.14",
    duchy_warsaw_expansion: "1809.10.14",
    end_of_swedish_finland: "1809.9.17",
    treaty_of_bucharest_1812: "1812.5.28",
    treaty_of_gulistan: "1813.1.1",
    free_danzig_napoleonic_end: "1814.1.2",
    end_of_danish_norway: "1814.5.17",
    congress_of_vienna: "1815.6.9",
    kalat_independent: "1817.1.1", # year date, total silliness either way
    end_1_saudi_state: "1818.4.1", # approximate
    third_maratha_war: "1818.6.3",
    general_maritime_treaty: "1820.1.8",
    treaty_of_turkmenchai: "1828.2.10",
    treaty_of_adrianople: "1829.9.14", # Ottomans "ceded" Circassia to Russia, but Circassians would have none of that
    algeria_french: "1830.7.5",
    belgium_independence: "1831.7.21", # Actually crowning of Leopold
    greece_independence: "1832.5.7",
    conquest_of_sindh: "1843.3.1", # month date and fairly dubious at that
    fall_krakow_uprising: "1846.11.16", # treaty signed between Russia and Austria
    end_of_lucca: "1847.12.17", # There was also a bit of extra Napoleonic complexity here
    second_sikh_war: "1849.3.29",
    treaty_of_zurich: "1859.11.10",
    italy_unification: "1861.3.17",
    treaty_of_vienna_1864: "1864.10.30",
    cephalonia_greek: "1864.3.29",
    russia_circassia_war: "1864.6.2",
    treaty_of_vienna_1866: "1866.10.12",
    prussia_annexes_hannover: "1866.8.23",
    capture_of_rome: "1870.9.20",
    german_unification: "1871.1.18",
    bukhara_russian: "1873.1.1", # year date
    khiva_russian: "1873.8.12",
    baluchistan_agency: "1877.1.1", # year date
    cyprus_convention: "1878.6.4",
    treaty_of_berlin: "1878.7.13",
    bahrain_british: "1880.12.22", # Gradual process, date for British foreign policy veto
    tunisia_french: "1881.5.12",
    convention_of_constantinople: "1881.7.2",
    british_egypt: "1882.9.1",
    spanish_sahara: "1884.12.26",
    eastern_rumelia_unification: "1885.9.18",
    eritrea_italian: "1889.3.10",
    luxembourg_independence: "1890.11.23",
    oman_british: "1892.3.13",
    djibouti_french: "1896.5.20",
    crete_independence: "1898.12.13",
    kuwait_british: "1899.11.23", # Gradual process, date for British foreign policy veto
    mauritania_french: "1903.5.12", # Was under French influence earlier
    norway_independence: "1905.6.7",
    libya_italian: "1912.10.18", # First Treaty of Lausanne
    morocco_protectorate: "1912.3.30", # sp/fr
    treaty_of_bucharest: "1913.10.10", # Second Balkan Wars
    treaty_of_london: "1913.5.30", # First Balkan Wars
    finland_independence: "1917.12.6",
    czechoslovakia_independence: "1918.10.28",
    north_yemen_independence: "1918.10.30",
    end_ww1: "1918.11.11",
    montenegro_serbian: "1918.12.1",
    south_tirol_annexation: "1920.10.10",
    annexation_armenia: "1920.12.2",
    british_iraq: "1920.4.25",
    annexation_azerbaijan: "1920.5.11",
    treaty_of_sevres: "1920.8.10",
    treaty_of_ankara: "1921.10.20",
    ireland_independence: "1921.12.6",
    annexation_georgia: "1921.3.17",
    egypt_independence: "1922.2.28",
    silesian_uprising: "1922.5.15", # actually Geneva convension for Upper Silesia
    treaty_of_lausanne: "1923.7.24",
    mongolia_independence: "1924.11.26",
    hejaz_saudi: "1926.1.8",
    iraq_independence: "1932.10.3",
    anschluss: "1938.3.12",
    munich_agreement: "1938.9.30",
    protectorate_of_bohemia_and_moravia: "1939.3.15",
    memel_german: "1939.3.20",
    albania_italian: "1939.4.12",
    soviet_partition_of_romania: "1940.7.4",
    annexation_lithuania: "1940.8.3",
    annexation_latvia: "1940.8.5",
    annexation_estonia: "1940.8.6",
    eritrea_british: "1941.4.1", # Battle of Keren; or I could make it formal at end of WW2
    lebanon_independence: "1943.11.22",
    iceland_independence: "1944.6.17",
    end_ww2: "1945.5.8",
    syria_independence: "1946.4.17",
    jordan_independence: "1946.6.17",
    india_independence: "1947.8.15",
    sri_lanka_independence: "1948.2.4",
    israel_independence: "1948.5.14",
    eritrea_ethiopian: "1950.12.2",
    libya_independence: "1951.12.24",
    crimea_ukrainian: "1954.2.19",
    sudan_independence: "1956.1.1",
    french_morocco_independence: "1956.10.29",
    tunisia_independence: "1956.3.20",
    # south_spanish_morocco_end: "1956.4.7", # Too small to matter on the map probably
    north_spanish_morocco_end: "1958.4.1",
    cyprus_independence: "1960.10.1",
    mauritania_independence: "1960.11.28",
    mali_independence: "1960.6.20",
    somalia_independence: "1960.7.1",
    goa_annexation: "1961.12.19",
    kuwait_independence: "1961.6.19",
    algeria_indepnedence: "1962.4.8",
    malta_independence: "1964.9.21",
    maldives_independence: "1965.7.26",
    south_yemen_independence: "1967.11.30",
    six_day_war: "1967.6.10",
    oman_independence: "1971.12.2", # GeaCron thinks so, there was supposedly some "1962: Great Britain declares Muscat and Oman an independent nation."
    bangladesh_independence: "1971.12.16",
    bahrain_independence: "1971.8.15",
    north_cyprus_invasion: "1974.8.18",
    madrid_accords: "1975.11.14",
    djibouti_independence: "1977.6.27",
    egypt_israel_peace: "1979.3.26",
    iranian_revolution: "1979.4.1",
    yemen_unification: "1990.5.22",
    german_reunification: "1990.9.29",
    croatia_independence: "1991.10.8",
    fall_soviet_union: "1991.12.26",
    slovenia_independence: "1991.7.7",
    macedonia_independence: "1991.9.8",
    czechoslovakia_dissolution: "1993.1.1",
    bosnia_independence: "1993.3.3",
    eritrea_independence: "1993.5.24",
    abkhazia_war: "1993.9.27",
    scotland_devolution: "1999.5.7", # first first minister
    fall_chechnya: "2000.5.1", # approximate
    montenegro_independence: "2006.6.3",
    crimea_invasion: "2014.4.17",
    caliphate_reborn: "2014.6.29",
  }

  def self.[](date)
    case date
    when nil
      nil
    when :never
      :never # Magic placeholder, maybe fix them someday
    when Date
      date
    when String
      Date.parse(date)
    when Symbol
      raise "No date #{date.inspect}" unless @dates[date]
      Date.parse(@dates[date])
    else
      raise
    end
  end
end

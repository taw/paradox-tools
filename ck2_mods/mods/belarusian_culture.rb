class BelarusianCultureGameModification < CK2GameModification
  def belarusian_culture
    # Based on severian
    PropertyList[
      "graphical_cultures", ["easternslavicgfx"],
      "color", [0.5, 0.8, 0.3],
      "male_names", ["Briachislav_Bretislaus", "Demid", "Dobrynia", "Fedot_Theodat", "Gleb", "Igor", "Iliya", "Iziaslav", "Lev_Leo", "Mitrofan", "Mstislav_Mstislav", "Nikita", "Putiata", "Radoslav", "Rodislav", "Rogvolod", "Rostislav", "Ruslan", "Stanislav_Stanislav", "Sudislav", "Svetozar", "Sviatopolk_Svatopluk", "Sviatoslav_Sviatoslav", "Terentiy", "Trifon", "Viacheslav", "Vladimir_Vladimir", "Vladislav_Vladislav", "Voislav", "Volodar", "Vseslav", "Vsevolod", "Vyshata", "Vysheslav", "Yaropolk", "Yaroslav_Jaroslav", "Yefimiy", "Yelisey", "Yeremey", "Yevstafiy"],
      "female_names", ["Boleslava", "Darya", "Dobrava", "Dobronega", "Dobroslava", "Yefimia_Euphemia", "Yefrosinia_Euphrosyne", "Fevronia", "Gorislava", "Gradislava", "Gremislava", "Liubava", "Liudmila", "Malfrida", "Malusha", "Maria_Maria", "Marina", "Olena_Helen", "Olga", "Pereyaslava", "Praskovya", "Praxida", "Prebrana", "Predslava", "Premyslava", "Pribislava", "Rogneda", "Rostislava", "Sbyslava", "Sviatoslava", "Tatyana", "Ulita", "Ulyana", "Varvara", "Vasilisa", "Veleslava", "Verkhoslava", "Vseslava", "Viacheslava", "Yaroslava", "Zabava", "Zvenislava"],
      "from_dynasty_prefix", "of ",
      "male_patronym", "ovich",
      "female_patronym", "ovna",
      "prefix", false,
      "pat_grf_name_chance", 50,
      "mat_grf_name_chance", 40,
      "father_name_chance", 0,
      "pat_grm_name_chance", 30,
      "mat_grm_name_chance", 30,
      "mother_name_chance", 0,
      "modifier", "default_culture_modifier",
    ]
  end

  def apply!
    create_mod_file!("common/cultures/10_belarusian.txt", PropertyList[
      "east_slavic", PropertyList[
        "belarusian", belarusian_culture
      ]
    ])
    localization! "modern_times_belarusian",
      "belarusian" => "Belarusian"
  end
end

# TODO: cultural retinue [???]
class BrazilianCultureGameModification < CK2GameModification
  def surnames
    # http://familypedia.wikia.com/wiki/List_of_most_common_surnames
    %Q[
      Acquarone
      Alberton
      Alencar
      Alvin
      Álvares
      Amaral
      Andrade
      Antonelli
      Antunes
      Azevedo
      Baricelli
      Becker
      Bernardes
      Bettencourt
      Bevilacqua
      Bianchi
      Boglietti
      Buonfiglioli
      Buongiovanni
      Borges
      Bourgeois
      Branco
      Brito
      Bruno
      Burnier
      Buzatto
      Cabral
      Câmara
      Cardoso
      Carvalho
      Castelli
      Castro
      Cavalcanti
      Cavalcante
      Chaves
      Cicarelli
      Cisoto
      Cohen
      Costa
      Couto
      Cruz
      Conceição
      Mata
      Jesus
      de Vielmond
      del Sarto
      del Vecchio
      Dias
      Bosque
      Nascimento
      Passos
      Du Bois
      Du Champs
      Duris
      du Vale
      Fagundes
      Fernandes
      Ferreira
      Fischer
      Garcia
      Giachetto
      Gianechinni
      Gil
      Gomes
      Habib
      Haddad
      Henriques
      Hilbert
      Jayme
      Jaime
      Jensen
      Kalil
      Kobayashi
      Kozlowski
      Kovalic
      Kowalsky
      Krieger
      Levi
      Lima
      Lins
      Lira
      Lombardi
      Lombardini
      Lombardo
      Lombardelli
      Lopes
      Malfitano
      Martins
      Matsumoto
      Matos
      Mayer
      Meano
      Mean
      Medeiros
      Mendez
      Mendonça
      Menezes
      Meyer
      Michel
      Michelsen
      Moniz
      Muniz
      Moraes
      Morais
      Moreira
      Moreau
      Moretti
      Müller
      Nakamura
      Nakashima
      Nakata
      Neves
      Nogueira
      Oliveira
      Pai
      Paixão
      Peltier
      Pereira
      Petit
      Pinto
      Pires
      Popovic
      Rego
      Reis
      Ribeiro
      Ricci
      Rodrigues
      Rossi
      Russo
      Sá
      Sanchez
      San Girard
      Santos
      Sato
      Scheidt
      Schmidt
      Schneider
      Schultz
      Serrano
      Silva
      Silveira
      Siqueira
      Soares
      Sousa
      Souza
      Suzuki
      Tavares
      Teixeira
      Tozzi
      Tucci
      Valmor
      Valverde
      Van der Ley
      Van Helden
      Vasconcelos
      Vaz
      Venâncio
      Ventura
      Venturini
      Vilas Boas
      Vila Lobos
      Vila Nova
      Vila Real
      von Dorff
      Wabner
      Wagner
      Watanabe
      Weber
      Westphalen
      Xavier
      Ximenes
      Yamaguchi
      Yamamoto
      Zambrotta
      Zanini
      Zimmerman
    ].split("\n").map(&:strip)
  end

  def male_names
    # From portuguese
    [
      "Afonso_Alphonse",
      "Aires",
      "Álvaro_Oliver",
      "Bermudo_Vermudo",
      "Diogo_Diaco",
      "Egas",
      "Estêvão_Stephen",
      "Fernão_Ferdinand",
      "Fernando_Ferdinand",
      "Garcia_Garcia",
      "Gil_Egidius",
      "Gomes_Gomez",
      "Gonçalo_Gonzalo",
      "Guterre_Walter",
      "Henrique_Henry",
      "Hermígio",
      "João_John",
      "Lopo_Lupo",
      "Lourenço_Laurence",
      "Martim_Martin",
      "Mem_Mendo",
      "Mendo_Mendo",
      "Monio_Munio",
      "Muno_Munio",
      "Nuno_Nuno",
      "Paio_Pelagius",
      "Pedro_Peter",
      "Pero_Peter",
      "Pôncio_Pons",
      "Rodrigo_Roderick",
      "Rui_Roderick",
      "Sancho_Sancho",
      "Soeiro_Suero",
      "Raimundo_Raymond",
      "Vasco_Vasco",
      "Vicente_Vincent",
    ]
  end

  def female_names
    # From portuguese
    [
      "Aldara_Alduara",
      "Aldonça_Aldonza",
      "Beatriz_Beatrice",
      "Berengária_Berengaria",
      "Branca_Blanche",
      "Constança_Constance",
      "Dórdia",
      "Elvira_Elvira",
      "Estevainha_Stephania",
      "Fruilhe_Fronilde",
      "Gontinha",
      "Gontroda_Gotruda",
      "Guiomar",
      "Inês_Agnes",
      "Joana_Joan",
      "Leonor_Eleanor",
      "Mafalda_Matilda",
      "Margarida_Margaret",
      "Maria_Maria",
      "Marinha_Marine",
      "Mor_Mayor",
      "Ouroana",
      "Sancha_Sancha",
      "Teresa_Teresa",
      "Urraca_Urraca",
    ]
  end

  def brazilian_culture
    # Based on Portuguese
    PropertyList[
      "graphical_cultures", ["southerngfx"],
      "color", [0.65, 0.5, 0.05], # Darker Portuguese
      "male_names", male_names,
      "female_names", female_names,
      "from_dynasty_prefix", "de ",
      "male_patronym", "es",
      "female_patronym", "es",
      "grammar_transform", "spanish",
      "modifier", "default_culture_modifier",
      "pat_grf_name_chance", 55,
      "mat_grf_name_chance", 5,
      "father_name_chance", 30,
      "pat_grm_name_chance", 60,
      "mat_grm_name_chance", 15,
      "mother_name_chance", 15,
    ]
  end

  def create_dynasties!
    # There's no ID management here...
    base_id = 92_000_000
    dynasties = PropertyList[]
    surnames.each_with_index do |surname, i|
      dynasties.add! base_id+i, PropertyList[
        "name", surname,
        "culture", "brazilian",
      ]
    end
    create_mod_file!("common/dynasties/10_brazilian.txt", dynasties)
  end

  def apply!
    create_mod_file!("common/cultures/10_brazilian.txt", PropertyList[
      "iberian", PropertyList[
        "brazilian", brazilian_culture
      ]
    ])
    create_dynasties!
    localization! "modern_times_brazilian",
      "brazilian" => "Brazilian"
  end
end

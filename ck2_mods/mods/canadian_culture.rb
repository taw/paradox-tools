# inherits to get #male_names and #female_names
class CanadianCultureGameModification < AmericanCultureGameModification
  def surnames
    # Vancouver only, couldn't find all Canada
    # http://www.al6400.com/blog/100-most-common-surnames-in-vancouver/
    %W[
      Lee
      Wong
      Chan
      Smith
      Kim
      Chen
      Gill
      Li
      Brown
      Johnson
      Wang
      Wilson
      Leung
      Anderson
      Lam
      Jones
      Taylor
      Singh
      Liu
      Williams
      Ng
      Wu
      Ho
      Campbell
      Chow
      Macdonald
      Miller
      Chang
      Huang
      Lin
      Cheung
      Martin
      Lau
      Young
      Thompson
      Scott
      Nguyen
      Cheng
      Zhang
      Yu
      Stewart
      Yang
      Sidhu
      Sandhu
      White
      Park
      Robinson
      Moore
      Dhaliwal
      Clark
      Mitchell
      Tang
      Walker
      McDonald
      Ross
      Johnston
      Reid
      Grewal
      Chu
      Ma
      Thomas
      Hall
      Lai
      Chung
      Wright
      Choi
      Dhillon
      Jackson
      Baker
      Evans
      Robertson
      King
      Bell
      Davis
      Lo
      Graham
      Wood
      Fraser
      Roberts
      Harris
      Watson
      Peters
      Friesen
      Tam
      Mann
      Lewis
      Lim
      Clarke
      Phillips
      Yeung
      Hill
      Nelson
      Davies
      Murray
      Grant
      Brar
      Morrison
      Tran
      Fung
      Hamilton
    ]
  end

  def canadian_culture
    # Based on English
    PropertyList[
      "graphical_cultures", ["englishgfx"],
      "color", [0.7, 0.1, 0.1], # darker shade of English
      "male_names", male_names,
      "female_names", female_names,
      "from_dynasty_prefix", "of ",
      "bastard_dynasty_prefix", "Fitz",
      "modifier", "default_culture_modifier",
      "pat_grf_name_chance", 30,
      "mat_grf_name_chance", 10,
      "father_name_chance", 25,
      "pat_grm_name_chance", 20,
      "mat_grm_name_chance", 40,
      "mother_name_chance", 5,
    ]
  end

  def create_dynasties!
    # There's no ID management here...
    base_id = 91_000_000
    dynasties = PropertyList[]
    surnames.each_with_index do |surname, i|
      dynasties.add! base_id+i, PropertyList[
        "name", surname,
        "culture", "canadian",
      ]
    end
    create_mod_file!("common/dynasties/10_canadian.txt", dynasties)
  end

  def apply!
    create_mod_file!("common/cultures/10_canadian.txt", PropertyList[
      "west_germanic", PropertyList[
        "canadian", canadian_culture
      ]
    ])
    create_dynasties!
    localization! "modern_times_canadian",
      "canadian" => "Canadian"
  end
end

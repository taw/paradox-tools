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

  def create_retinues!
    # Just relabelled Altaic "Horse Archer"
    retinue = parse("common/retinue_subunits/00_retinue_subunits.txt")["RETTYPE_CUL_ALTAIC"]
    retinue["potential"] = PropertyList[
      "is_nomadic", false,
      "culture", "canadian",
    ]
    create_mod_file! "common/retinue_subunits/10_canadian.txt", PropertyList[
      "RETTYPE_CUL_CANADIAN", retinue,
    ]
  end

  def create_buildings!
    buildings = PropertyList[]
    parse("common/buildings/00_CastleCulture.txt")["castle"].each do |name, building|
      next unless name =~ /\Aca_culture_group_altaic_(\d+)\z/
      level = $1.to_i
      building["potential"] = PropertyList["FROM", PropertyList["culture", "canadian"]]
      building["desc"] = "ca_culture_canadian_1_desc"
      if building["upgrades_from"]
        building["upgrades_from"] = "ca_culture_canadian_#{level-1}"
      end
      buildings.add! "ca_culture_canadian_#{level}", building
    end
    create_mod_file!("common/buildings/10_canadian.txt", PropertyList["castle", buildings])
  end

  def apply!
    create_mod_file!("common/cultures/10_canadian.txt", PropertyList[
      "west_germanic", PropertyList[
        "canadian", canadian_culture
      ]
    ])
    create_dynasties!
    create_retinues!
    create_buildings!
    localization! "modern_times_canadian",
      "canadian" => "Canadian",
      "RETTYPE_CUL_CANADIAN" => "Mounties",
      "ca_culture_canadian_1" => "Mounties Riding Ground",
      "ca_culture_canadian_2" => "Mounties Riding Ground",
      "ca_culture_canadian_3" => "Mounties Riding Ground",
      "ca_culture_canadian_4" => "Mounties Riding Ground",
      "ca_culture_canadian_1_desc" => "Royal Canadian Mounted Police enforces Canadian law - when necessary also abroad."
  end
end

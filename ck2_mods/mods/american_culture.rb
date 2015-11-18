# TODO: cultural retinue (like Marines or something?)
class AmericanCultureGameModification < CK2GameModification
  def surnames
    # https://en.wikipedia.org/wiki/List_of_most_common_surnames_in_North_America#United_States
    %W[
      Smith
      Johnson
      Williams
      Brown
      Jones
      Miller
      Davis
      Garcia
      Rodriguez
      Wilson
      Martinez
      Anderson
      Taylor
      Thomas
      Hernandez
      Moore
      Martin
      Jackson
      Thompson
      White
      Lopez
      Lee
      Gonzalez
      Harris
      Clark
      Lewis
      Robinson
      Walker
      Perez
      Hall
      Young
      Allen
      Sanchez
      Wright
      King
      Scott
      Green
      Baker
      Adams
      Nelson
      Hill
      Ramirez
      Campbell
      Mitchell
      Roberts
      Carter
      Phillips
      Evans
      Turner
      Torres
      Parker
      Collins
      Edwards
      Stewart
      Flores
      Morris
      Nguyen
      Murphy
      Rivera
      Cook
      Rogers
      Morgan
      Peterson
      Cooper
      Reed
      Bailey
      Bell
      Gomez
      Kelly
      Howard
      Ward
      Cox
      Diaz
      Richardson
      Wood
      Watson
      Brooks
      Bennett
      Gray
      James
      Reye
      Cruz
      Hughes
      Price
      Myers
      Long
      Foster
      Sanders
      Ross
      Morales
      Powell
      Sullivan
      Russell
      Ortiz
      Jenkins
      Gutierrez
      Perry
      Butler
      Barnes
      Fisher
    ]
  end

  # https://www.ssa.gov/oact/babynames/decades/century.html
  def male_names
    %W[
      James
      John
      Robert
      Michael
      William
      David
      Richard
      Joseph
      Charles
      Thomas
      Christopher
      Daniel
      Matthew
      Donald
      Anthony
      Mark
      Paul
      Steven
      George
      Kenneth
      Andrew
      Edward
      Joshua
      Brian
      Kevin
      Ronald
      Timothy
      Jason
      Jeffrey
      Ryan
      Gary
      Nicholas
      Eric
      Jacob
      Stephen
      Jonathan
      Larry
      Frank
      Scott
      Justin
      Brandon
      Raymond
      Gregory
      Samuel
      Benjamin
      Patrick
      Jack
      Dennis
      Alexander
      Jerry
      Tyler
      Henry
      Douglas
      Aaron
      Peter
      Jose
      Walter
      Adam
      Zachary
      Nathan
      Harold
      Kyle
      Carl
      Arthur
      Gerald
      Roger
      Keith
      Lawrence
      Jeremy
      Terry
      Albert
      Joe
      Sean
      Willie
      Christian
      Jesse
      Austin
      Billy
      Bruce
      Ralph
      Bryan
      Ethan
      Roy
      Eugene
      Jordan
      Louis
      Wayne
      Alan
      Harry
      Russell
      Juan
      Dylan
      Randy
      Philip
      Vincent
      Noah
      Bobby
      Howard
      Gabriel
      Johnny
    ]
  end

  def female_names
    %W[
      Mary
      Patricia
      Jennifer
      Elizabeth
      Linda
      Barbara
      Susan
      Margaret
      Jessica
      Sarah
      Dorothy
      Karen
      Nancy
      Betty
      Lisa
      Sandra
      Ashley
      Kimberly
      Donna
      Helen
      Carol
      Michelle
      Emily
      Amanda
      Melissa
      Deborah
      Laura
      Stephanie
      Rebecca
      Sharon
      Cynthia
      Kathleen
      Anna
      Shirley
      Ruth
      Amy
      Angela
      Brenda
      Virginia
      Pamela
      Catherine
      Katherine
      Nicole
      Christine
      Samantha
      Janet
      Debra
      Carolyn
      Rachel
      Heather
      Maria
      Diane
      Julie
      Joyce
      Emma
      Frances
      Evelyn
      Joan
      Martha
      Christina
      Kelly
      Lauren
      Victoria
      Judith
      Alice
      Ann
      Cheryl
      Jean
      Doris
      Megan
      Marie
      Andrea
      Kathryn
      Jacqueline
      Gloria
      Teresa
      Sara
      Janice
      Hannah
      Julia
      Rose
      Theresa
      Grace
      Judy
      Beverly
      Olivia
      Denise
      Marilyn
      Amber
      Danielle
      Brittany
      Diana
      Mildred
      Jane
      Madison
      Lori
      Tiffany
      Kathy
      Tammy
      Kayla
    ]
  end

  def american_culture
    # Based on English
    PropertyList[
      "graphical_cultures", ["englishgfx"],
      "color", [0.9, 0.3, 0.3], # brighter shade of English
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
    base_id = 90_000_000
    dynasties = PropertyList[]
    surnames.each_with_index do |surname, i|
      dynasties.add! base_id+i, PropertyList[
        "name", surname,
        "culture", "american",
      ]
    end
    create_mod_file!("common/dynasties/10_american.txt", dynasties)
  end

  def apply!
    create_mod_file!("common/cultures/10_american.txt", PropertyList[
      "west_germanic", PropertyList[
        "american", american_culture
      ]
    ])
    create_dynasties!
    localization! "modern_times_american",
      "american" => "American"
  end
end

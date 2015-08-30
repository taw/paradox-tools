require_relative "holy_sites"

class HolySitesVanillaGameModification < HolySitesGameModification
  # Based on history, CK2 precedence, and gameplay considerations
  # Many CK2 locations mapped to vaguely similar EU4 provinces as map correspondence is not very high
  # Better suggestions welcome
  # Protestant/Reformed set to same as Catholic because we don't know where they'll trigger
  def holy_site_info
    {
      groups: {
        catholic:              :western_christian,
        protestant:            :western_christian,
        reformed:              :western_christian,
        inti:                  :new_world,
        nahuatl:               :new_world,
        mesoamerican_religion: :new_world,
      },
      sites: {
        christian:    ["Roma", "Jerusalem", "Constantinople"],
        western_christian: ["Galicia / Santiago de Compostela", "Kent / Cantenbury"],
        orthodox:     ["Thessaloniki / Mount Athos", "Kiev"],
        coptic:       ["Alexandria", "Tigre / Ark of the Covenant"],

        muslim:       ["Mecca", "Jerusalem", "Constantinople", "Cordoba", "Hillah / Karbala"],
        # Varanasi, Chidambaram, Angkor Wat - Hindu
        # Palitana - Jain
        # Harmandir Sahib - Sikh
        dharmic:     ["Jaunpur / Varanasi", "Coromandel / Chidambaram", "Baroda / Palitana", "Angkor / Angkor Wat", "Lahore / Harmandir Sahib"],

        # These are not amazing, but they'll have to do:
        eastern:     ["Bihar / Bodhgaya / 558", "Angkor / Angkor Wat", "Qingzhou / Qufu", "Owari / Ise Jingu", "West Gyeongsang / Bulguksa"],

        # Adapted from CK2
        norse_pagan_reformed:   ["Zeeland", "Hannover / Paderborn / 1758", "Sjaelland", "Trondelag", "Uppland / Uppsala"],
        jewish:                 ["Jerusalem", "Sinai", "Damascus", "Hamadan", "Dhofar / Salahah"],

        # One site moved way east as EU4 map has more Tengri land
        tengri_pagan_reformed: ["Pest", "Crimea", "Astrakhan", "Alty-Kuduk", "Barguzinsky"],
        zoroastrian: ["Zanjan", "Bushehr", "Bojnord", "Bam", "Balkh"],
        # Old world sites are Sunset Invasion siliness
        # New world sites are one per religion so they have reason to fight each other
        new_world: ["London", "Ile-de-France / Paris", "Mexico", "Belize", "Cuzco"],
        # Not getting any ever, these are generic groupings not real religions
        shamanism:    [],
        animism:      [],
        totemism:     [],
      }
    }
  end
end

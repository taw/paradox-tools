require_relative "holy_sites_vanilla"

class HolySitesETGameModification < HolySitesVanillaGameModification
  def holy_site_info
    # TODO:
    # ["hellenic", "hellenism"]
    # ["hellenic", "zamolxism"]
    # ["hellenic", "nabataean"]
    # ["celtic_pagan", "druidism"]
    # ["slavic_pagan", "romuva"]
    # ["slavic_pagan", "slavic"]
    # ["finnic_pagan", "suomenusko"]
    # ["african_pagan", "egyptian"]
    # ["african_pagan", "african"] - not getting any
    # ["mesopotamian", "ashurism"]
    # ["mesopotamian", "south_arabian"]
    #
    # and fix early Christian religions
    {
      groups: {
        catholic:              :western_christian,
        protestant:            :western_christian,
        reformed:              :western_christian,
        orthodox:              :eastern_christian,
        nestorian:             :eastern_christian,
        arianism:              :eastern_christian,
        chalcedonism:          :eastern_christian,
        inti:                  :new_world,
        nahuatl:               :new_world,
        mesoamerican_religion: :new_world,
      },
      sites: {
        # All 8 Christian churches want 3 obvious holy sites
        # I can't think of good assignment for the last two
        # Making Arian/Nostorian/Chalcedonian use Orthodox sites is really just a temporary solution
        western_christian: ["Roma", "Judea / Jerusalem", "Thrace / Constantinople", "Galicia / Santiago de Compostela", "Kent / Cantenbury"],
        eastern_christian: ["Roma", "Judea / Jerusalem", "Thrace / Constantinople", "Salonica / Mount Athos / 2007", "Kiev"],
        coptic:            ["Roma", "Judea / Jerusalem", "Thrace / Constantinople", "Alexandria", "Tigre / Ark of the Covenant"],

        muslim:                ["Mecca", "Judea / Jerusalem", "Thrace / Constantinople", "Cordoba", "Karbala"],
        tengri_pagan_reformed: super[:sites][:tengri_pagan_reformed],
        dharmic:               ["Jaunpur / Varanasi", "Coromandel / Chidambaram", "Baroda / Palitana", "Siem Reap / Angkor Wat", "Punjab / Harmandir Sahib"],
        jewish:                ["Judea / Jerusalem", "Sinai", "Damascus", "Hamadan", "Dhofar / Salahah"],
        german_pagan:          super[:sites][:norse_pagan_reformed],
        # These are one group in vanilla, ET splits them, they're getting same sites anyway
        eastern:               ["Bihar / Bodhgaya / 558", "Siem Reap / Angkor Wat", "Qingzhou / Qufu", "Owari / Ise Jingu", "Sangju / Bulguksa"],
        buddhic:               ["Bihar / Bodhgaya / 558", "Siem Reap / Angkor Wat", "Qingzhou / Qufu", "Owari / Ise Jingu", "Sangju / Bulguksa"],
        # There's american_pagan grouping, but I don't want it for totemism/south_american
        new_world:             super[:sites][:new_world],
        iranian:               ["Zanjan", "Rushehr / Bushehr", "Bojnord", "Bam", "Balkh"],

        # Not getting any ever, these are generic groupings not real religions
        shamanism:      [],
        animism:        [],
        totemism:       [],
        south_american: [],
        african:        [],
        # Obviously
        selular:        [],
      }
    }
  end
end

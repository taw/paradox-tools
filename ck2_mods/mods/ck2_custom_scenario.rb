require_relative "base"

class CK2CustomScenarioGameModification < CK2GameModification
  def titles_to_clean_up
    # Do not destory papacy/patriarchy as they are important for game to function
    # Destroy caliphates as they are overly territorial and can be recreated quite easily
    @titles_to_clean_up ||= Set[*begin
      glob("history/titles/[ek]_*.txt").map{|path|
        path.basename(".txt").to_s
      } - ["k_papal_state", "k_orthodox"] + ["d_sunni", "d_shiite"]
    end]
  end

  def no_kingdoms_empires_and_nomads!
    glob("history/titles/*.txt").each do |path|
      title = path.basename(".txt").to_s
      if titles_to_clean_up.include?(title)
        patch_mod_file!(path) do |node|
          node.each do |date, attrs|
            attrs.delete! "holder"
            attrs.delete! "historical_nomad"
            attrs.delete! "liege"
          end
          node.delete!{|prop| prop.val.empty?}
        end
      else
        patch_mod_file!(path) do |node|
          node.each do |date, attrs|
            next unless attrs.is_a?(PropertyList)
            attrs.delete! "historical_nomad"
            attrs.delete! do |prop|
              prop.key == "liege" and titles_to_clean_up.include?(prop.val)
            end
          end
          node.delete!{|prop| prop.val.empty?}
        end
      end
    end
  end

  def no_wars!
    patch_mod_files!("history/wars/*.txt") do |node|
      node.delete!{true}
    end
  end

  def more_merchant_republics!
    # These will become cities, not all of them will become merchant republics,
    # only few of them with duke level holder
    provinces = [
      "802 - Alexandria",
      "468 - Ragusa",
      "858 - Aden",
      "868 - Muscat",
      "641 - Hormuz",
      "649 - Basra",
      "1297 - Debul",
      "1127 - Navasarika",
      "1114 - Mahoyadapuram",
      "1221 - Vijayawada",
      "1236 - Candradvipa",
      "158 - Porto",
      "78 - Brugge",
      "80 - Holland"
      # Would be nice, but not feudal:
      # "368 - Danzig",
      # "596 - Tana",
    ]
    provinces.each do |path|
      patch_mod_file!("history/provinces/#{path}.txt") do |node|
        # This is terribly hacky
        entries = node.send(:entries)
        first_settlement = entries.index{|prop| prop.key =~ /\Ab_/ }
        first_city       = entries.index{|prop| prop.key =~ /\Ab_/ and prop.val == "city"}
        first_castle     = entries.index{|prop| prop.key =~ /\Ab_/ and prop.val == "castle"}
        raise "Can't make #{path} a republic" unless first_city and first_settlement == first_castle
        city = entries[first_city,1]
        entries[first_city,1]   = []
        entries[first_castle,0] = city
      end
    end
  end

  def apply!
    no_kingdoms_empires_and_nomads!
    no_wars!
    more_merchant_republics!
  end
end

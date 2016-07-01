require_relative "base"

class AdjustCharacterReligionGameModification < CK2GameModification
  def title_religion
    unless @title_religion
      @title_religion = {}
      iterate_mod_files!("history/provinces/*.txt") do |node|
        religion = node["religion"]
        holdings = [
          node["title"],
          *[node.keys + node.values.grep(PropertyList).map(&:keys)].flatten.grep(/\Ab_/),
        ]
        holdings.each do |h|
          @title_religion[h] = religion
        end
      end
    end
    @title_religion
  end

  def title_based_character_religion
    unless @title_based_character_religion
      character_religion = {}
      glob("history/titles/*.txt").each do |path|
        title = path.basename(".txt").to_s
        node = parse(path)
        religion = title_religion[title]

        unless religion
          # warn "Can't determine religion of title: #{title}"
          next
        end

        node.each do |date, events|
          next if events.empty?
          if events["holder"] and events["holder"] != 0
            id = events["holder"]
            character_religion[id] ||= Hash.new(0)
            character_religion[id][religion] += 1
          end
        end
      end

      @title_based_character_religion = {}
      character_religion.each do |id,stats|
        # Tie breaker by alphabet
        best_match = stats.keys.min_by{|k| [-stats[k], k]}
        @title_based_character_religion[id] = best_match
      end
    end
    @title_based_character_religion
  end

  def relations_to_hash(relations)
    ht = {}
    relations.each do |r1,r2,a,b|
      ht[a] ||= Hash.new(0)
      ht[a][b] += r1
      ht[b] ||= Hash.new(0)
      ht[b][a] += r2
    end
    ht
  end

  def relation_based_character_religion
    unless @relation_based_character_religion
      dynasties = {}
      relations = []
      @relation_based_character_religion = title_based_character_religion.dup
      characters = []

      # Order of inference
      # * children from fathers
      # * children from mothers
      # * parents from children
      # * spouses
      # * employees
      glob("history/characters/*.txt").each do |path|
        node = parse(path)
        node.each do |id, character|
          characters << id
          if character["dynasty"]
            (dynasties[character["dynasty"]] ||= []) << id
          end
          relations << [10000, 100, id, character["father"]] if character["father"]
          relations << [1000, 100, id, character["mother"]] if character["mother"]
          character.each do |key, val|
            next unless val.is_a?(PropertyList)
            relations << [10, 10, id, val["add_spouse"]] if val["add_spouse"]
            relations << [1, 0, id, val["employer"]] if val["employer"]
          end
        end
      end

      relations = relations_to_hash(relations)

      # Propagation time
      while true
        todo = characters - @relation_based_character_religion.keys
        changed = false
        # puts "Iteration: #{todo.size}"
        todo.each do |id|
          next unless relations[id]
          religion_inference = Hash.new(0)
          relations[id].each do |id2, rel|
            religion2 = @relation_based_character_religion[id2]
            next unless religion2
            religion_inference[religion2] += rel
          end
          next if religion_inference.empty?
          best_match = religion_inference.keys.min_by{|k| [-religion_inference[k],k] }
          @relation_based_character_religion[id] = best_match
          changed = true
        end
        break unless changed
      end

      # That does much less than expected
      dynasties.each do |_, dynasty|
        religion_inference = Hash.new(0)
        dynasty.each do |id|
          if @relation_based_character_religion[id]
            religion_inference[@relation_based_character_religion[id]] += 1
          end
        end
        next if religion_inference.empty?
        best_match = religion_inference.keys.min_by{|k| [-religion_inference[k],k] }
        dynasty.each do |id|
          @relation_based_character_religion[id] ||= best_match
        end
      end
      todo = characters - @relation_based_character_religion.keys
      # puts "Dynastic inference down to: #{todo.size}"
    end
    @relation_based_character_religion
  end

  def adjust_character_religions!
    patch_file!("history/characters/serbian.txt", force_create: true) do |content|
      content.sub("841.1.1.=", "841.1.1=")
    end

    religions = Hash.new(0)
    patch_mod_files!("history/characters/*.txt") do |node|
      node.each do |id, character|
        # If we have nothing, just leave it as is. It's pobably semi-reasonable anyway
        if relation_based_character_religion[id]
          character["religion"] = relation_based_character_religion[id]
          character.each do |key, val|
            next unless val.is_a?(PropertyList)
            val.delete! "religion"
          end
        end
        religions[character["religion"]] += 1
      end
    end
  end

  def apply!
    adjust_character_religions!
  end
end

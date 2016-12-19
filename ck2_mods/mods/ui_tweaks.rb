require_relative "base"

class UITweaksGameModification < CK2GameModification
  def setup_sensible_important_decisions_list!
    patch_mod_files!("decisions/*.txt") do |node|
      node.each do |category, decisions|
        next unless category == "decisions"
        decisions.each do |name, decision|
          time_specific  = !!(decision["allow"].to_s =~ /month|war/)
          focus_specific = !!(decision["potential"].to_s =~ /has_focus/)

          if ["ask_help_to_manage_titles", "conscript_merchant_ships"].include?(name)
            decision.delete! "is_high_prio"
          # expel_jews/borrow_money_jews are available all time and no longer that OP
          # welcome_jews is time specific
          elsif ["welcome_jews"].include?(name) or time_specific or focus_specific
            decision.add! "is_high_prio", true
          elsif decision["is_high_prio"]
            # The rest are OK
          else
            # The rest are OK
          end
        end
      end
    end
  end

  def mark_more_titles_as_high_priority!
    patch_mod_file!("common/minor_titles/00_minor_titles.txt") do |node|
      node.each do |title_name, title|
        next if title["is_high_prio"] # Already tagged
        # No special reason to be an ass
        # Titles with 0 opinion are mostly special stuff
        next unless (title["opinion_effect"] || 0) > 0
        title["is_high_prio"] = true
      end
    end
  end

  def disable_fucking_hints!
    patch_mod_file!("common/hints.txt") do |node|
      node.each do |name, hint|
        hint.delete! "sticky"
      end
    end
  end

  def bigger_war_box!
    patch_mod_file!("interface/waroverview.gui") do |node|
      waricon_box = node["guiTypes"].find_all("windowType").find{|n| n["name"] == "waricon_box"}
      waricon_box["position"]["x"] -= 400
      waricon_box["size"]["x"] += 400
      waricon_box["OverlappingElementsBoxType"]["size"]["x"] += 400
    end
  end

  def show_all_wars_on_map!
    patch_mod_files!("common/cb_types/*.txt") do |node|
      node.each do |name, cb|
        cb.delete! "display_on_map"
      end
    end
  end

  def apply!
    setup_sensible_important_decisions_list!
    disable_fucking_hints!
    mark_more_titles_as_high_priority!
    # bigger_war_box! # Bigger UI conflict
    show_all_wars_on_map!
  end
end

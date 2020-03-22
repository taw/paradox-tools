require_relative "base"

class UITweaksGameModification < CK2GameModification
  def mark_more_titles_as_high_priority!
    patch_mod_file!("common/minor_titles/00_minor_titles.txt") do |node|
      node.each do |title_name, title|
        next if title["is_high_prio"] # Already tagged
        # No special reason to be an ass
        # Titles with 0 opinion are mostly special stuff
        next unless (title["opinion_effect"] || 0) > 0
        # this one backfires horribly if used
        next if title_name == "teacher"
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

  def stop_join_war_spam!
    patch_mod_file!("common/on_actions/00_on_actions.txt") do |node|
      node["CALL_ALLY_INTERACTION_ACCEPT_EVENT"]["events"].delete(238)
      node["CALL_ALLY_INTERACTION_ACCEPT_EVENT"]["events"].delete(41000)
    end
  end

  def apply!
    disable_fucking_hints!
    mark_more_titles_as_high_priority!
    # bigger_war_box! # Bigger UI conflict
    show_all_wars_on_map!
    stop_join_war_spam!
  end
end

require_relative "base"

class SyntaxFixesGameModification < CK2GameModification
  # Not really deletion
  def delete_file!(path)
    patch_file!(path) do |content|
      ""
    end
  end

  def patch_by_regexp!(path, rx, replacement)
    patch_file!(path, reencode: "iso-8859-1") do |content|
      content.gsub(rx, replacement)
    end
  end

  def apply!
    patch_by_regexp!("history/provinces/539 - Marmaros.txt", "895.1.1.", "895.1.1")
    patch_by_regexp!("history/titles/c_ragusa.txt", "936.1.1.", "936.1.1")
    patch_by_regexp!("history/titles/c_assab.txt", "936.1. ", "936.1.1 ")
    patch_by_regexp!("history/titles/c_galich_mersky.txt", "936.1. ", "936.1.1 ")
    patch_by_regexp!("history/titles/d_scholae_palatinae.txt", /\z/, "}")
    patch_by_regexp!("history/titles/d_varangian_guard.txt", /\z/, "}")

    [
      "history/provinces/691 - Al Nasiryah.txt",
      "history/provinces/715 - Al Habbariyah.txt",
      "history/provinces/716 - Ar'ar.txt",
      "history/provinces/722 - Petra.txt",
      "history/provinces/854 - Jask.txt",
      "history/provinces/1634 - Dorogobuzh.txt",
      "history/provinces/1636 - Zvenhyorod.txt",
      "history/provinces/1642 - Tutrakan.txt",
      "history/provinces/1650 - Ovruch.txt",
      "history/provinces/1652 - Kirichi.txt",
      "history/provinces/1659 - Droutsk.txt",
      "history/provinces/1664 - Opochka.txt",
      "history/provinces/1665 - Ostrov.txt",
      "history/provinces/1666 - Haradok.txt",
      "history/provinces/1671 - Mologa.txt",
      "history/provinces/1675 - Prilok.txt",
      "history/provinces/1676 - Tarousa.txt",
      "history/provinces/1681 - Starodub on Klyazma.txt",
      "history/provinces/1682 - Kasimov.txt",
    ].each do |path|
      delete_file!(path)
    end
  end
end

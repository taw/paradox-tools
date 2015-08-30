require_relative "base"

class NoLocalizedRanksGameModification < CK2GameModification
  def apply!
    cat = [
      "",
      "city_",
      "vice_royalty_",
      "tribal_",
      "nomadic_",       # No custom titles weirdly
    ]
    ranks = %W[
      baron_
      baron_female_
      barony_
      barony_of_
      count_
      count_female_
      county_
      county_of_
      duchy_
      duchy_of_
      duke_
      duke_
      duke_female_
      emperor_
      emperor_female_
      emperor_title_queen_mother_female_
      empire_
      empire_of_
      job_chancellor_
      job_marshal_
      job_spymaster_
      job_treasurer_
      king_
      king_female_
      kingdom_
      kingdom_of_
      title_prince_
      title_prince_female_
    ]

    rx = Regexp.new(
      "\\A" +
      "(" + cat.join("|") + ")" +
      "(" + ranks.join("|") + ")" +
      "(" + cultures.join("|") + ")" +
      "\\z"
    )

    patch_localization! do |line|
      key, *fields = line.split(";")
      if cultures.any?{|c| key.end_with?("_adj_#{c}")}
        # No localized titles handles thoes
        line
      elsif key =~ rx # cultures.any?{|c| ranks.any?{|r| key == r + c }}
        # puts [key, fields[0]].join(" ; ")
        nil
      elsif cultures.any?{|c| key.end_with?("_#{c}")}
        # These are unrelated things like "convertto_swedish" "k_cuman" "region_baltic" etc.
        line
      else
        line
      end
    end
  end
end

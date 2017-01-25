require "set"

module Ck2Analyses
  def realm_name(title)
    @data["title"][title]["name"] || title
  rescue
    title
  end

  def valid_titles
    @valid_titles ||= Set[*@data["title"].keys]
  end

  def top_realm_by_title(title)
    title_data = @data["title"][title]
    raise "No such title `#{title}'" unless title_data
    if title_data["liege"]
      top_realm_by_title(title_data["liege"]["title"])
    else
      title
    end
  end
end

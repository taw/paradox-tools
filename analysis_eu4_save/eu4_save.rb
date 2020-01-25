require "set"

class TradeNodeCountryInformation
  attr_reader :tag, :attrs
  def initialize(tag, node)
    @tag = tag
    @attrs = node.to_h
    @attrs.delete("max_demand") # Unclear what it even is
    @attrs.delete("trading_policy_date") # Totally uninteresting
  end

  def empty?
    @attrs.empty?
  end

  def total # trade value - raw
    @attrs["total"]
  end

  def money # trade value - modified by trade efficiency
    @attrs["money"]
  end

  def trade_power
    @attrs["val"] || 0.0
  end

  def collects?
    !!@attrs["total"]
  end

  def collection_multiplier
    return nil unless total and money
    (money / total).round(6)
  end

  def inspect
    "TradeNodeCountryInformation<#{@tag}, #{attrs.inspect}>"
  end
end

# The algorithm can't handle empty nodes correctly
# For example, since there's no information what happens when you add value to autralia node
# it must assume it just dissapears, while actually it would flow into the network

class TradeNode
  attr_reader :incoming, :outgoing
  attr_reader :name, :country_info, :attrs
  attr_reader :incoming_info, :outgoing_info

  # Will be missing for completely uncolonized (like australia)
  def local_value
    @attrs["local_value"] || 0.0
  end

  # value_added_outgoing is always same in saves I checked
  # This is pre-add
  def outgoing_value
    @attrs["outgoing"]
  end

  def incoming_value
    # value is after add
    @incoming_info.map{|n| n[:value]}.inject(0, &:+).round(3)
  end

  def total_value
    (local_value + incoming_value).round(3)
  end

  def retained_value
    (total_value - outgoing_value).round(3)
  end

  def total_power
    @attrs["total"]
  end

  # This is post-multiplied
  def immediate_collector_share
    @immediate_collector_share ||= begin
      result = Hash.new(0)
      country_info.each do |tag, info|
        next if total_value == 0 # treat as dead end
        next unless info.collects?
        result[tag] = (info.money / total_value).round(6)
      end
      result
    end
  end

  # This is post-multiplied
  def immediate_transfer_share
    @immediate_transfer_share ||= begin
      result = Hash.new(0)
      outgoing_info.each do |info|
        next if total_value == 0 # treat as dead end
        destination_name = info[:to]
        value = info[:value]
        result[destination_name] = (info[:value] / total_value).round(6)
      end
      result
    end
  end

  def total_collector_share
    @total_collector_share ||= begin
      result = immediate_collector_share.dup
      immediate_transfer_share.each do |destination_name, destination_transfer_share|
        next if destination_transfer_share == 0
        destination_node = @network[destination_name]
        destination_node.total_collector_share.each do |tag, tag_share|
          result[tag] += tag_share * destination_transfer_share
        end
      end
      result.each_key do |tag|
        result[tag] = result[tag].round(6)
        result.delete(tag) if result[tag] == 0
      end
      result
    end
  end

  def initialize(network, name, node)
    @network = network
    @name = name
    @country_info = {}
    @incoming_info = []
    @outgoing_info = []
    @attrs = {}
    @attrs["steer_power"] = node.find_all("steer_power")
    node.each do |key, value|
      if value.is_a?(PropertyList) and value["max_demand"]
        raise if @country_info[key]
        ci = TradeNodeCountryInformation.new(key, value)
        next if ci.empty?
        @country_info[key] = ci
      elsif key == "incoming"
        raise "Unexpected keys for incoming link" unless value.keys == %W[add value from]
        @incoming_info << {
          add: value["add"],
          value: value["value"],
          from: network.number_to_name(value["from"]),
        }
      elsif key == "steer_power"
        # already set
      else
        raise "Already has key for #{key}" if @attrs[key]
        @attrs[key] = value
      end
    end
  end
end

class TradeNetwork
  attr_reader :nodes

  def inspect
    "TradeNetwork"
  end
  alias_method :to_s, :inspect

  def initialize(node)
    @nodes = {}
    @indexes_to_names = {}

    # Awkwardly node means both "trade node" and "properly list node"
    node_nodes = node.find_all("node")
    node_nodes.each_with_index do |node, i|
      name = node["definitions"]
      @indexes_to_names[i+1] = name
    end

    node_nodes.each_with_index do |node, i|
      name = node["definitions"]
      @nodes[name] = TradeNode.new(self, name, node)
    end

    @nodes.each do |name, node|
      node.incoming_info.each do |info|
        source_name = info[:from]
        source_node = @nodes[source_name]
        source_node.outgoing_info << {add: info[:add], value: info[:value], to: name}
      end
    end
  end

  def number_to_name(key)
    @indexes_to_names[key] or raise "Unknown key #{key}"
  end

  def [](key)
    if key.is_a?(Integer)
      key = number_to_name(key)
    end
    @nodes[key] or raise "Unknown key #{key}"
  end
end

class Country
  attr_reader :tag, :node
  def initialize(tag, node)
    @tag = tag
    @node = node
  end

  def primary_culture
    @primary_culture ||= @node["primary_culture"]
  end

  def accepted_cultures
    @accepted_cultures ||= @node.find_all("accepted_culture")
  end

  def government_rank
    @government_rank ||= @node["government_rank"]
  end

  def institutions
    @institutions ||= @node["institutions"]
  end

  def technology_group
    @technology_group ||= @node["technology_group"]
  end

  def num_of_cities
    @num_of_cities ||= @node["num_of_cities"].to_i
  end

  def idea_groups
    @active_idea_groups ||= @node["active_idea_groups"].enum_for(:each).to_a
  end

  def name
    @node["name"]
  end

  def religion
    @node["religion"]
  end

  def truces
    @truces ||= @node["active_relations"].to_a.select{|x| x.val["truce"]}.map(&:key).to_set
  end

  # This will be only approximate
  def estimated_truce_time
    unless @estimated_truce_time
      @estimated_truce_time = {}
      @node["active_relations"].to_a.select{|x| x.val["truce"]}.each do |ar|
        start = ar.val["last_war"]
        warscore = ar.val["last_warscore"] || 0
        len = 5 + warscore * 0.1
        expires = start + (365.25 * len).round
        @estimated_truce_time[ar.key] = expires
      end
    end
    @estimated_truce_time
  end

  def to_s
    "Country<#{@tag}>"
  end
  alias_method :to_s, :inspect
end

class Province
  attr_reader :id, :node
  def initialize(id, node)
    @id = id
    @node = node
  end

  def city?
    @node["is_city"]
  end

  def development
    (@node["base_tax"] || 0) +
    (@node["base_production"] || 0) +
    (@node["base_manpower"] || 0)
  end

  def base_tax
    @node["base_tax"] || 0
  end

  def base_production
    @node["base_production"] || 0
  end

  def base_manpower
    @node["base_manpower"] || 0
  end

  def owner
    @node["owner"]
  end

  def culture
    @node["culture"]
  end

  def religion
    @node["religion"]
  end

  def local_autonomy
    @node["local_autonomy"] || 0
  end

  def trade_company?
    !!@node["active_trade_company"]
  end

  # What is being constructed is awkwardly indicated by ID not names
  def construction_in_progress?
    !!@node["building_construction"]
  end

  # This should be only of current owner, others are not saved
  def territorial_core?
    @node["territorial_core"]
  end

  def estate
    estate_number = @node["estate"]
    if estate_number
      # There's a lot of new estates now, just count them as "unknown"
      %W[church nobility burghers cossacks tribes dhimmi][estate_number-1] || "unknown"
    else
      nil
    end
  end

  # This is no longer in the saves :-/
  def min_autonomy
    @min_autonomy ||= begin
      if trade_company?
        0.0
      elsif territorial_core?
        75.0
      elsif estate == "tribes"
        50.0
      elsif estate
        25.0
      else
        @node["min_autonomy"] || 0
      end
    end
  end

  def effective_autonomy
    [local_autonomy, min_autonomy].max
  end

  def buildings
    (@node["buildings"] || {}).keys
  end

  def has_manufactory?
    # furnace works differently
    !(%W[farm_estate furnace mills plantations textile tradecompany weapons wharf] & buildings).empty?
  end

  def trade_node_name
    @node["trade"]
  end

  def trade_goods
    @node["trade_goods"]
  end

  def name
    @node["name"]
  end

  def inspect
    "Province<#{@id};#{name}>"
  end
  alias_method :to_s, :inspect
end

class EU4Save
  attr_reader :path, :data
  def initialize(path)
    @path = path
    @data = ParadoxModFile.new(path: @path).parse!
  end

  def countries
    @countries ||= begin
      @data["countries"]
        .enum_for(:each)
        .map{|tag, node| [tag, Country.new(tag, node)] }
        .to_h
    end
  end

  def provinces
    @provinces ||= begin
      @data["provinces"]
        .enum_for(:each)
        .map{|id, node| [-id, Province.new(-id, node)] }
        .to_h
    end
  end

  def institutions
    @institutions ||= @data["institutions"] # => [1, 1, 0, 0, 0, 0, 0]
  end

  def institutions_penalties
    @institutions_penalties ||= @data["institutions_penalties"] # => [0.5, 0.07, 0.0, 0.0, 0.0, 0.0, 0.0]
  end

  def date
    @data["date"]
  end

  def player_tag
    @player_tag ||= @data["countries"].enum_for(:each).find{|k,v| v["human"]}.first
  end

  def aggressive_expansion
    @active_relations ||= begin
      map = {}
      @data["countries"].each do |tag, country|
        next unless country["active_relations"]
        country["active_relations"].each do |tag2, relations|
          relations.find_all("opinion").each do |opinion|
            next unless opinion["modifier"] == "aggressive_expansion"
            next if opinion["current_opinion"] == 0
            map[tag2] ||= {}
            map[tag2][tag] = -opinion["current_opinion"]
          end
        end
      end
      map
    end
  end

  def allies
    @allies ||= @data["diplomacy"]
      .find_all("alliance")
      .map{|x| [x["first"], x["second"]] }
      .flat_map{|a,b| [[a,b],[b,a]] }
      .to_set
  end

  def allies?(tag1, tag2)
    allies.include?([tag1, tag2])
  end

  def subjects
    unless @subjects
      @subjects = {}
      @data["diplomacy"].each do |type, relation|
        next unless relation["subject_type"]
        subject_type = relation["subject_type"]
        overlord = relation["first"]
        subject = relation["second"]
        if @subjects[subject]
          relation1 = "#{subject_type} of #{overlord}"
          overlord2, subject_type2 = @subjects[subject]
          relation2 = "#{subject_type2} of #{overlord2}"
          warn "#{subject} is #{relation1} but it's #{relation2} already"
          next
        end
        @subjects[subject] = [overlord, subject_type]
      end
    end
    @subjects
  end

  def trade_network
    @trade_network ||= TradeNetwork.new(@data["trade"])
  end

  def trade_good_prices
    @trade_good_prices ||= begin
      result = {}
      @data["change_price"].each do |key, value|
        result[key] = value["current_price"]
      end
      result
    end
  end

  def to_s
    "EU4Save<#{@path}>"
  end
  alias_method :to_s, :inspect
end

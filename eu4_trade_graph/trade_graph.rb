require_relative "../lib/paradox_mod_file_serializer"
require "rgl/adjacency"
require "rgl/connected_components"
require "rgl/topsort"

class TradeGraph
  def initialize(node)
    @node = node
  end

  def edges
    result = []
    @node.each do |from, trade_node|
      trade_node.find_all("outgoing").each do |link|
        to = link["name"]
        result << [from, to]
      end
    end
    result
  end

  def find_link(from, to)
    @node[from].find_all("outgoing").find{|n| n["name"] == to}
  end

  def build_link(from, to)
    direct = find_link(from, to)
    backwards = find_link(to, from)
    if direct
      direct
    elsif backwards
      PropertyList[
        "name", to,
        "path", backwards["path"].reverse,
        "control", backwards["control"].each_slice(2).to_a.reverse.flatten,
      ]
    else
      # warn "No link from #{a} to #{b} or backwards"
      PropertyList[
        "name", to,
        "path", [],
        "control", [],
      ]
    end
  end

  def rewrite(updated_edge_list)
    edge_graph = RGL::DirectedAdjacencyGraph[*updated_edge_list.flatten]

    unless valid?(edge_graph)
      raise "Trade Graph is not valid, can't rebuild"
    end

    output = PropertyList[]
    edge_graph.topsort_iterator.each do |node_name|
      orig_node = @node[node_name]
      raise "Unknown keys: #{orig_node.keys}" unless (
        orig_node.keys.to_set - Set["location", "color", "outgoing", "members", "inland", "end", "ai_will_propagate_through_trade"]
      ).empty?
      node = PropertyList[]
      node.add! "location", orig_node["location"]
      copy_attr(node, orig_node, "inland")
      copy_attr(node, orig_node, "color")
      edge_graph.each_adjacent(node_name) do |target_node_name|
        node.add! "outgoing", build_link(node_name, target_node_name)
      end
      node.add! "members", orig_node["members"]
      copy_attr(node, orig_node, "ai_will_propagate_through_trade")
      if edge_graph.each_adjacent(node_name).to_a.empty?
        node.add! "end", true
      end
      output.add! node_name, node
    end

    ParadoxModFileSerializer.serialize(output)
  end

private

  def valid?(edge_graph)
    inv_comp_map = {}
    edge_graph.strongly_connected_components.comp_map.each do |v, n|
      (inv_comp_map[n] ||= []) << v
    end
    inv_comp_map.values.delete_if { |scc| scc.size == 1 }.empty?
  end

  def copy_attr(target, source, attr)
    if source[attr]
      target.add! attr, source[attr]
    end
  end
end

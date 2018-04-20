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
end

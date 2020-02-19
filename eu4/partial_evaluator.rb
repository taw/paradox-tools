class PartialEvaluator
  def call(node)
    case node
    when PropertyList
      node.map{|x| call(x) }
    when Property
      eval_property(node)
    else
      node
    end
  end

  private

  def always_true
    Property["always", true]
  end

  def always_false
    Property["always", false]
  end

  def eval_property(node)
    val = call(node.val)
    case node.key
    when "OR"
      if val.include?(always_true)
        always_true
      else
        val = val.select!{|x| x != Property["always", false]}
        val = PropertyList["always", false] if val.empty?
        if val.size == 1
          val.to_a[0]
        else
          Property.new(node.key, val)
        end
      end
    when "AND"
      if val.include?(always_false)
        always_false
      else
        val = val.select!{|x| x != Property["always", true]}
        val = PropertyList["always", true] if val.empty?
        if val.size == 1
          val.to_a[0]
        else
          Property.new(node.key, val)
        end
      end
    when "potential", "limit"
      # AND-like operators
      if val.include?(always_false)
        val = PropertyList["always", false]
      elsif val.include?(always_true)
        val = val.select!{|x| x != Property["always", true]}
        val = PropertyList["always", true] if val.empty?
      end
      Property.new(node.key, val)
    when "NOT"
      val = call(node.val)
      if val == PropertyList["always", true]
        always_false
      elsif val == PropertyList["always", false]
        always_true
      else
        Property.new(node.key, val)
      end
    when "has_dlc"
      always_true
    when "map_setup"
      # This should go into suclass
      if val == "map_setup_random"
        always_false
      else
        Property.new(node.key, val)
      end
    else
      Property.new(node.key, val)
    end
  end
end

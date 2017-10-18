class ParadoxModFileSerializer
  attr_reader :output
  def initialize
    @output = ""
    @indent = 0
  end

  def line!(str)
    @output << "  " * @indent << str << "\n"
  end

  def primitive?(val)
    case val
    when TrueClass, FalseClass, Numeric, String, Date, Symbol
      true
    else
      false
    end
  end

  def serialize_primitive(val)
    case val
    when TrueClass
      "yes"
    when FalseClass
      "no"
    when Numeric
      val.to_s
    when Date
      "%d.%d.%d" % [val.year, val.month, val.day]
    when Symbol
      serialize_primitive(val.to_s)
    when /\A[A-Za-z0-9_\.:\[\]\<\>\*@]+\z/
      val
    when /\A(\p{Alpha}|\p{Number}|[_\.\-\/\u00A0 '’`\?\\%!:,\[\]+&])*\z/
      # A lot more Strings are allowed, but at some point we'll need to think about escaping them
      '"' + val + '"'
    else
      # Could be String that needs escaping, or something else unusual
      raise "No idea how to serialize #{val.inspect}"
    end
  end

  def serialize_key(key)
    case key
    when TrueClass
      "yes"
    when FalseClass
      "no"
    when Numeric
      key.to_s
    when Date
      "%d.%d.%d" % [key.year, key.month, key.day]
    when Symbol
      serialize_key(key.to_s)
    when /\A[A-Za-z0-9\-_\.:@]+\z/
      key
    when ""
      # CK2 saves have blocks like:
      #
      # troops={
      #   light_infantry_f=
      #   { 274.248 350.000 }
      #   archers_f= { 111.866 150.000 }
      #   ={ 0.174 50.000 }
      # }
      key
    else
      # Can keys be quoted?
      raise "No idea how to serialize #{key.inspect}"
    end
  end

  def print_property_list!(node)
    raise "No idea how to print this" unless node.is_a?(PropertyList)
    node.each do |key,val|
      if val.is_a?(PropertyList)
        line! "#{serialize_key(key)} = {"
        @indent += 1
        print_property_list! val
        @indent -= 1
        line! "}"
      elsif val.is_a?(Array)
        # Empty Array is indistinguishable from empty PropertyList
        if val.all?{|v| primitive?(v)}
          line! "#{serialize_key(key)} = {"
          @indent += 1
          val.each do |v|
            line! serialize_primitive(v)
          end
          @indent -= 1
          line! "}"
        end
      elsif primitive?(val)
        line! "#{key} = #{serialize_primitive(val)}"
      elsif val.is_a?(Property::SpecialValue)
        line! "#{key} #{val.op} #{val.val}"
      else
        raise "Not sure how to serialize #{val.class}"
      end
    end
  end

  def self.serialize(node)
   s = ParadoxModFileSerializer.new
   s.print_property_list!(node)
   s.output
  end
end

class AttrAccessorObject

  def self.my_attr_accessor(*ivars)
    ivars.each do |ivar|
      define_method(ivar) { instance_variable_get("@#{ivar}") }
      define_method("#{ivar}=") do |val|
        instance_variable_set("@#{ivar}", val)
      end
    end
  end

  my_attr_accessor :x, :y
end

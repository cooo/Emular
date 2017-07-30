require "./register.rb"

class Registers

  def initialize
     @v = Array.new(16) { |i| Register.new(i) }
  end

  def []=(loc, val)
    
    if (val.class.eql?(String))
      p "write string: loc:#{loc} val:#{val}"
      @v[loc.hex].value = val.hex.to_s(16).rjust(2, "0")
    else
      p "write decimal: loc:#{loc} val:#{val}"
      @v[loc.hex].value = val.to_s(16).rjust(2, "0")
    end
  end

  def [](loc)
    p "read: loc:#{loc}" 
    @v[loc.hex].value.hex
  end

  def to_s
    result = ""
    @v.each_with_index do |reg, index|
      result += "#{reg}\t\t\t"
      result += "\n" if (index+1)%4==0
    end
    result
  end

end

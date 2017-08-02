require "./register.rb"

class Registers

  def initialize
     @v = Array.new(16) { |i| Register.new("v#{i.to_s(16)}") }
  end

  def []=(loc, val)
    #TODO use decimal internally, instead of string, only at to_s do to_s(16).rjust(2, "0")
    if (val.class.eql?(String))
      p "write string: loc:v#{loc} val:#{val} (#{val.hex})"
      @v[loc.hex].value = val.hex
    else
      p "write decimal: loc:#{loc} val:#{val}"
      @v[loc.hex].value = val
    end
  end

  def [](loc)
    p "read: loc:#{loc} val:#{hex(@v[loc.hex].value)}"
    @v[loc.hex].value
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

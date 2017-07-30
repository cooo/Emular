# Registers are 8 bit, so we use strings with hex value, e.g. "e0"
class Register

  attr_reader :name
  attr_accessor :value

  def initialize(i)
    @name  = "v#{i.to_s(16)}"
    @value = "00"
  end

  # val is a string
  def write(val)
    @value = val
  end

  def read
    @value
  end

  def to_s
    "#{@name}: #{@value}"
  end

end

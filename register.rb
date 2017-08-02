# Registers are 8 bit, so we use strings with hex value, e.g. "e0"
class Register

  attr_reader :name
  attr_accessor :value

  def initialize(name)
    @name  = name
    @value = 0
  end

  def to_s
    "#{@name}: #{hex(@value)}"
  end

end

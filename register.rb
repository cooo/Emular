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

  def tick
    @value -= 1 if @value > 0
  end

end

require "./instructions.rb"
require "./registers.rb"

class Cpu

  FLAG = "f"

  attr_reader :emular   # delegate
  attr_accessor :v  # registers
  
  def initialize(emular)
    @emular = emular
    @v = Registers.new
    @i = Register.new("index")
    @delay_timer = Register.new("dt")
  end

  def instructions
    @instructions ||= Instructions.all
  end

  def execute(opcode)
    instruction = find(opcode)
    puts "#{hex(@emular.pc)} #{instruction}"
    instruction.execute(self)
  end

  def find(opcode)
    instructions.find { |instruction| instruction.match?(opcode) }
  end

  def flag=(set)
    v[FLAG] = set ? 1 : 0
  end

  # index register (16bits)

  def index
    @i
  end

  def i
    @i.value
  end

  def i=(value)
    @i.value = value
  end

  # delay_timer register (8bits)

  def dt
    @delay_timer
  end

  def delay_timer
    @delay_timer.value
  end

  def delay_timer=(value)
    @delay_timer.value = value
  end

end

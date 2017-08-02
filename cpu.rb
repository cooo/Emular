require "./instructions.rb"
require "./registers.rb"

class Cpu

  FLAG = "f"

  attr_reader :emular   # delegate
  attr_accessor :v, :i  # registers
  
  def initialize(emular)
    @emular = emular
    @v = Registers.new
    @i = 0
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
    v[FLAG] = set ? "01" : "00"
  end

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

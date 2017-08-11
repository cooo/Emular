require './cpu.rb'
require './memory.rb'
require './stack.rb'
require './frame_buffer.rb'

class Emular 
  
  attr_reader :cpu
  attr_accessor :pc, :stack, :memory, :frame_buffer

  attr_accessor :keys

  ROM_START = 0x200

  def initialize
    @frame_buffer = FrameBuffer.new
    @cpu = Cpu.new(self)
    @keys = Hash.new(false)
  end

  def attach(debugger)
    @debugger = debugger
    if @debugger
      puts "running with the debugger"
      @debugger.emular = self
    else
      puts "running"
    end
  end

  def debugger
    @debugger
  end

  def rom_start
    ROM_START
  end

  def pc_inc
    @pc += 2
  end

  def reset
    @memory = Memory.new
    @stack = Stack.new
    @frame_buffer.clear
    @pc = ROM_START
    @sp = 0
  end

  def load(rom)
    @rom = rom
    if rom.size>0
      @memory.write(ROM_START, *rom.bytes)
    else
      puts "Warning, you're loading an empty rom"
    end
  end

  def run
    (0..8).each do
      opcode = @memory.fetch(pc)
      cpu.execute(opcode)
    end
  end

end

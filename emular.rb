require './cpu.rb'

class Emular

  attr_reader :use_debugger, :halt
  attr_reader :cpu
  attr_reader :pc, :sp, :stack, :memory, :frame_buffer

  attr_reader :breakpoints

  ROM_START = 0x200
  MEMORY_SIZE = 4096
  SCREEN_WIDTH = 64
  SCREEN_HEIGHT = 32

  def initialize(options)
    @use_debugger = options[:debug]
    @cpu = Cpu.new(self)
    @halt = true

    @breakpoints = []
  end	

  def reset
    @memory = Array.new(MEMORY_SIZE, "00")
    @frame_buffer = Array.new(SCREEN_HEIGHT) { Array.new(SCREEN_WIDTH, 0) }
    @pc = ROM_START
  end

  def load(rom)
    @rom = rom
    if rom.size>0
      memory.insert(ROM_START, *rom.bytes).slice!(MEMORY_SIZE, rom.size)
    else
      puts "Warning, you're loading an empty rom"
    end
  end

  def run

    # frame_buffer[10][3] = 1	# y,x

    if use_debugger
      puts "running with the debugger"
    else
      puts "running"
    end

    emulate = true
    while(true) do
      command = STDIN.gets if use_debugger && @halt
      emulate = debug(command) if command
      if emulate
        opcode = memory[pc] + memory[pc+1]
        puts "pc: #{pc} use_d: #{use_debugger} bp?#{breakpoint?(pc)} halt?: #{@halt}"
        if (use_debugger && breakpoint?(pc))
          @halt = true
          puts "breakpoint hit at #{hex(pc)}"
          command = STDIN.gets
          emulate = debug(command) if command
        end

        cpu.execute(opcode)

        @pc += 2

        if (pc-ROM_START >= @rom.size)
          break
        end
        #render
      end
    end

  end

  def debug(command)
    command = @last_command if command.chomp.empty? && @last_command
    @last_command = command
    
    case command.chomp
    when "s"
      return true
    when "c"
      @halt = false
      puts "running halt: #{@halt}"
      return true
    when "q"
      puts "bye!"
      exit
    when "r"
      p cpu.v
    when /^[b|sb].*/
      breakpoint = command[2..-1].strip
      puts "set breakpoint at #{breakpoint}, see all breakpoints with 'ib'"
      breakpoints.push(breakpoint)
      return false
    when "ib"
      puts "breakpoints:"
      breakpoints.each_with_index do |breakpoint, index|
        puts "#{index}: #{breakpoint}"
      end
      if breakpoints.any?
        puts "delete a breakpoint with db x"
      else
        puts "no breakpoints"
      end
      return false
    when /^db.*$/
      breakpoint = command[2..-1].strip.to_i
      if breakpoint<breakpoints.size
        breakpoints.delete_at(breakpoint)
        puts "breakpoint deleted, #{breakpoints.size} breakpoints left."
      else
        puts "that breakpoint does not exist"
      end
    when /^[l|list].*/
      option = command[2..-1].strip
      puts "list #{option}"
      address = pc
      for i in 0..9
        opcode = memory[address] + memory[address+1]
        instruction = cpu.find(opcode)
        puts "#{breakpoint?(address) ? "* " : "  "} #{hex(address)} #{instruction}"
        address = address + 2
      end
    when "pc"
      puts hex(pc)

    else
      puts "command #{command} not found, try help"
      
    end
    return false
  end

  def hex(dec)
    "0x#{dec.to_s(16)} (#{dec})"
  end

  def breakpoint?(address)
    breakpoints.include?(address.to_s)
  end



  def to_s

    # memory.each do |byte|
    # 	p byte
      
    # end
    
  end

  def render
    frame_buffer.each_with_index do |row, y|
      print y.to_s.rjust(3, " ") + " "
      row.each_with_index do |pos, x|
        print pos
      end
      print "\n"
    end
  end

end

require './cpu.rb'
require './memory.rb'
require './stack.rb'

class Emular

  attr_reader :use_debugger, :halt
  attr_reader :cpu
  attr_accessor :pc, :stack, :memory, :frame_buffer

  attr_reader :breakpoints

  ROM_START = 0x200
  SCREEN_WIDTH = 64
  SCREEN_HEIGHT = 32

  def initialize(options)
    @use_debugger = options[:debug]
    @cpu = Cpu.new(self)
    @halt = true

    @breakpoints = []
  end

  def pc_inc
    @pc += 2
  end

  def reset
    @memory = Memory.new
    @stack = Stack.new
    @frame_buffer = Array.new(SCREEN_HEIGHT) { Array.new(SCREEN_WIDTH, 0) }
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

    # frame_buffer[10][3] = 1	# y,x

    if use_debugger
      puts "running with the debugger"
    else
      puts "running"
    end

    emulate = true
    @do_not_stop = true
    while(true) do
      command = STDIN.gets if (use_debugger && @halt)
      emulate = debug(command) if command
      
      if emulate
        opcode = @memory.fetch(pc)
        #puts "pc: #{pc} use_d: #{use_debugger} bp?#{breakpoint?(pc)} halt?: #{@halt}"
        if (use_debugger && breakpoint?(pc)) && @do_not_stop
          @halt = true
          @do_not_stop = true
          puts "breakpoint hit at #{hex(pc)}"
          next  # skip exec
        end

        cpu.execute(opcode)

        pc_inc

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
      @do_not_stop = false
      return true
    when "c"
      @halt = false
      
      return true
    when "q"
      puts "bye!"
      exit
    when "r", "reg"
      cpu.v.each_with_index do |reg, index|
        print "#{index.to_s(16)}: #{reg}\t\t\t"
        print "\n" if (index+1)%4==0
      end
      puts "i: #{cpu.i}"
      p cpu.v
    when "stack","st"
      puts @stack.to_s
    when /^[b|sb].+$/
      breakpoint = command[2..-1].strip.to_i
      if (breakpoint>=ROM_START && breakpoint<MEMORY_SIZE)
        puts "set breakpoint at #{hex(breakpoint)}, see all breakpoints with 'b'"
        breakpoints.push(breakpoint.to_i)
      else
        puts "invalid breakpoint, should be between (#{ROM_START} and #{MEMORY_SIZE})"
      end
      return false
    when /^b$/
      puts "breakpoints:"
      breakpoints.each_with_index do |breakpoint, index|
        puts "#{index}: #{hex(breakpoint)}"
      end
      if breakpoints.any?
        puts "delete a breakpoint with db x"
      else
        puts "no breakpoints, add one with b xyz where xyz is an address"
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
      options = command.split(/ |,/)
      option_1 = options[1].strip if options.size>1
      option_2 = options[2].strip if options.size>2
            
      offset = 0
      count = 9
      if (option_1=="-")
        puts "list #{option_1}"
        offset = 18
      elsif (option_1 && option_2 && is_numeric?(option_1) )
        puts "list #{option_1},#{option_2}"
        offset = pc - option_1.to_i
        
      elsif (option_1 && is_numeric?(option_1))
        puts "list #{option_1}"
        offset = option_1.to_i
        count = option_1.to_i - 1
      end
      address = pc - offset
      for i in 0..count
        opcode = memory[address] + memory[address+1]
        instruction = cpu.find(opcode)
        puts "#{address==pc ? ">" : " "}#{breakpoint?(address) ? "* " : "  "} #{hex(address)} #{instruction}"
        address = address + 2
      end
    when /^m.*/
      options = command.split(/ |,/)
      option_1 = options[1].strip if options.size>1
      option_2 = options[2].strip if options.size>2
            
      address = 0
      count = 9
      if (option_1 && option_2 && is_numeric?(option_1) && is_numeric?(option_2))
        puts "memory #{option_1},#{option_2}"
        address = option_1.to_i
        count = option_2.to_i
      elsif (option_1 && is_numeric?(option_1))
        puts "memory #{option_1}"
        address = option_1.to_i
        count = 10
      end
      puts "memory from #{address} to #{address+count}"
      puts memory.to_s(address, count)

    when "pc"
      puts hex(pc)
    when "h", "?", "help"
      puts "help:"
      puts "------------------------------------------------------------"
      puts "s       = step, execute one instruction"
      puts "<enter> = repeats last command"
      puts "c       = continue"
      puts "r       = show the registers, v1..vf, index (i)"
      puts "st      = show the stack with the stack pointer (sp)"
      puts "pc      = show the program counter (pc)"
      puts "b       = show the breakpoints"
      puts "b 512   = set a breakpoint at memory location 512 (0x200)"
      puts "db x    = delete breakpoint x (from the list)"
      puts "l       = list next 10 opcodes from memory, starting at pc"
      puts "l -     = list previous 10 opcodes from memory, starting at pc"
      puts "l lines = list <lines> opcodes from memory, surrounding pc"
      puts "l x,    = list 10 opcodes from memory, starting at x"
      puts "l x,y   = list y opcodes from memory, starting at x"
      puts "m x     = list 10 addresses from memory, starting at x"
      puts "m x,y   = list y addresses from memory, starting at x"
      puts "h       = this help"
      puts "q       = quit"
      puts "------------------------------------------------------------"
    else
      puts "command #{command.chomp} not found, try help"
      
    end
    return false
  end

  def is_numeric?(obj) 
    obj.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
  end

  def breakpoint?(address)
    breakpoints.include?(address)
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

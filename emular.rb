
require './cpu.rb'
require './memory.rb'
require './stack.rb'
require './frame_buffer.rb'

class Emular 
  
  attr_reader :use_debugger, :halt
  attr_reader :cpu
  attr_accessor :pc, :stack, :memory, :frame_buffer

  attr_accessor :keys

  attr_reader :breakpoints

  ROM_START = 0x200

  def initialize(options)

    @frame_buffer = FrameBuffer.new
    @use_debugger = options[:debug]
    @cpu = Cpu.new(self)
    @halt = true

    @breakpoints = []

    @keys = Hash.new
    (0..15).each { |key| @keys[key.to_s(16)] = false }

    if use_debugger
      puts "running with the debugger"
    else
      puts "running"
    end

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

  def run2
    p @keys
  end

  def run
    
        # frame_buffer[10][3] = 1	# y,x


    emulate = true
    @do_not_stop = true

    (0..50).each do

      command = STDIN.gets if (use_debugger && @halt)
      emulate = debug(command) if command
      
      if emulate
        opcode = @memory.fetch(pc)
        # puts "use_debugger: #{use_debugger} bp?#{breakpoint?(pc)} do_not_stop?: #{@do_not_stop}"
        if (use_debugger && breakpoint?(pc)) && @do_not_stop
          @halt = true
          @do_not_stop = true
          puts "breakpoint hit at #{hex(pc)}"
          return  # skip exec
        else
          @do_not_stop = true # allow s to do one step
        end

        cpu.execute(opcode)

        pc_inc

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
    when "q", "e", "quit", "exit"
      puts "bye!"
      exit
    when "r", "reg"
      puts cpu.v.to_s
      puts "i: #{hex(cpu.i)} #{cpu.dt}"
    when "stack","st"
      puts @stack.to_s
    when "fb","fr"
      puts @frame_buffer.to_s
    when /^[b|sb].+$/
      breakpoint = command[2..-1].strip.to_i
      if (breakpoint>=ROM_START && breakpoint<@memory.size)
        puts "set breakpoint at #{hex(breakpoint)}, see all breakpoints with 'b'"
        breakpoints.push(breakpoint.to_i)
      else
        puts "invalid breakpoint, should be between (#{ROM_START} and #{@memory.size})"
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
      count = 10
      if (option_1=="-")
        puts "list #{option_1}"
        offset = 18
      elsif (option_1 && option_2 && is_numeric?(option_1) )
        puts "list #{option_1},#{option_2}"
        offset = pc - option_1.to_i
      elsif (option_1 && is_numeric?(option_1))
        puts "list #{option_1}"
        offset = option_1.to_i
        count = option_1.to_i
      end
      address = pc - offset
      count.times do |i|
        opcode = memory.fetch(address)
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
      puts memory.to_s(address, address+count)

    when "pc"
      puts hex(pc)
    when "h", "?", "help"
      puts "help:"
      puts "------------------------------------------------------------"
      puts "s       = step, execute one instruction"
      puts "<enter> = repeats last command"
      puts "c       = continue"
      puts "r       = show the registers, v1..vf and index (i)"
      puts "st      = show the stack with the stack pointer (sp)"
      puts "fb      = display the frame buffer"
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

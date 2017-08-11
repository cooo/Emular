require './command.rb'

class Emular 
  def run
    @debugger.halting
  end
end

class Debugger

  attr_accessor :emular   # delegate
  attr_reader :breakpoints
  attr_accessor :halt

  def initialize
    @breakpoints = []
    @halt = true
    @debug_commands = debug_commands
  end

  def debug_commands
    commands = []
    Dir["./debug_commands/*.rb"].each do |file|
      
      require file

      extension = File.extname(file)
      file_name = File.basename(file, extension)
      command = classify(file_name)
      commands.push(command.new) unless command.eql?(NotFound)
    end
    commands.push(NotFound.new)
    commands
  end

  def halting
    if @halt || breakpoint?(emular.pc)
      puts "breakpoint hit at #{hex(emular.pc)}" if breakpoint?(emular.pc)
      command = STDIN.gets 
      @execute_instruction = debug(command)
    end
    if @execute_instruction
      opcode = @emular.memory.fetch(emular.pc)
      emular.cpu.execute(opcode)
    end
  end

  def debug(command)
    command = @last_command if command.chomp.empty? && @last_command
    @last_command = command
    
    command = @debug_commands.find { |debug_command| debug_command.match?(command.chomp) }
    return command.execute(self)
  end

  def breakpoint?(address)
    breakpoints.include?(address)
  end

  private

    def classify(snake_case)
      camel_case = snake_case.split('_').collect(&:capitalize).join
      Object.const_get(camel_case)
    end
end
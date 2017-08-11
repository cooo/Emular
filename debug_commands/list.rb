class List < Command

  def match
    /^(l|list).*/ =~ @command
  end

  def execute(debugger)
    options = @command.split(/ |,/)
    option_1 = options[1].strip if options.size>1
    option_2 = options[2].strip if options.size>2          
    offset = 0
    count = 10

    if (option_1=="-")
      puts "list #{option_1}"
      offset = 18
    elsif (option_1 && option_2 && is_numeric?(option_1) )
      puts "list #{option_1},#{option_2}"
      offset = debugger.emular.pc - option_1.to_i
    elsif (option_1 && is_numeric?(option_1))
      puts "list #{option_1}"
      offset = option_1.to_i
      count = option_1.to_i
    end
    address = debugger.emular.pc - offset
    count.times do |i|
      opcode = debugger.emular.memory.fetch(address)
      instruction = debugger.emular.cpu.find(opcode)
      puts "#{address==debugger.emular.pc ? ">" : " "}#{debugger.breakpoint?(address) ? "* " : "  "} #{hex(address)} #{instruction}"
      address = address + 2
    end
    return false
  end

end

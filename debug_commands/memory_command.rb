class MemoryCommand < Command

  def match
    /^m.*$/ =~ @command
  end

  def execute(debugger)
    options = @command.split(/ |,/)
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
    puts debugger.emular.memory.to_s(address, address+count)
    return false
  end

end

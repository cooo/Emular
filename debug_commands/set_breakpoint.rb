class SetBreakpoint < Command

  def match
    /^[b|sb].+/ =~ @command
  end

  def execute(debugger)
    breakpoint = @command[2..-1].strip.to_i
    rom_start = debugger.emular.rom_start
    memory_size = debugger.emular.memory.size
    if (breakpoint >= rom_start && breakpoint < memory_size)
      puts "set breakpoint at #{hex(breakpoint)}, see all breakpoints with 'b'"
      debugger.breakpoints.push(breakpoint.to_i)
    else
      puts "invalid breakpoint, should be between (#{rom_start} and #{memory_size})"
    end
    return false
  end

end

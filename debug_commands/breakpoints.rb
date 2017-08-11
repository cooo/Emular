class Breakpoints < Command

  def match
    "b" == @command
  end

  def execute(debugger)
    puts "breakpoints:"
    debugger.breakpoints.each_with_index do |breakpoint, index|
      puts "#{index}: #{hex(breakpoint)}"
    end
    if debugger.breakpoints.any?
      puts "delete a breakpoint with db x"
    else
      puts "no breakpoints, add one with b xyz where xyz is an address"
    end
  end

end

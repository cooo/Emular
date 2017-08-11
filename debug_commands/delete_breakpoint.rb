class DeleteBreakpoint < Command

  def match
    /^db.*$/ =~ @command
  end

  def execute(debugger)
    breakpoint = @command[2..-1].strip.to_i
    if breakpoint < debugger.breakpoints.size
      debugger.breakpoints.delete_at(breakpoint)
      puts "breakpoint deleted, #{debugger.breakpoints.size} breakpoints left."
    else
      puts "that breakpoint does not exist"
    end
  end

end

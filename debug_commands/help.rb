class Help < Command

  def match
    /^(h|\?|help)$/ =~ @command
  end

  def execute(debugger)
    puts "help:"
    puts "------------------------------------------------------------"
    puts "s       = step, execute one instruction"
    puts "<enter> = repeats last command"
    puts "c       = continue"
    puts "r       = show the registers, v1..vf and index (i)"
    puts "k       = shows which keys are down"
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
  end

end

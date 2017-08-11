class ProgramCounter < Command

  def match
    "pc" == @command
  end

  def execute(debugger)
    puts hex(debugger.emular.pc)
  end

end

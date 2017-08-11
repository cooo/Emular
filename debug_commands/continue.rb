class Continue < Command

  def match
    @command == "c"
  end

  def execute(debugger)
    debugger.halt = false
    return true
  end

end

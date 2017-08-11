class Step < Command

  def match
    @command == "s"
  end

  def execute(debugger)
    debugger.halt = true
    return true
  end

end

class StackCommand < Command

  def match
    /^(st|stack)$/ =~ @command
  end

  def execute(debugger)
    puts debugger.emular.stack.to_s
  end

end

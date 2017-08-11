class Exit < Command

  def match
    /^(q|e|exit|quit)$/ =~ @command
  end

  def execute(debugger)
    p "bye!"
    exit
  end

end

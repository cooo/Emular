class NotFound < Command

  def match
    true
  end

  def execute(debugger)
    puts "command #{@command} not found, try help"
  end

end

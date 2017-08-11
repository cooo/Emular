class Keys < Command

  def match
    /^(k|keys)$/ =~ @command
  end

  def execute(debugger)
    puts debugger.emular.keys.to_s
  end

end

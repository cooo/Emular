class RegistersCommand < Command

  def match
    /^(r|reg)$/ =~ @command
  end

  def execute(debugger)
    cpu = debugger.emular.cpu
    puts cpu.v.to_s
    puts "i: #{hex(cpu.i)} #{cpu.dt} #{cpu.st}"
  end

end

class NoOp

  def match?(opcode)
    @opcode = opcode
    true
  end

  def execute(cpu)
    puts cpu.v
    fail "Emular does not know about #{@opcode}"
  end

  def to_s
    "Found an unknown instruction (#{@opcode})"
  end

end

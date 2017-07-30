# 1nnn - JP addr
# -------------------------
# Jump to location nnn. The interpreter sets the program counter to nnn.
class Jp

  def match?(opcode)
    @opcode = opcode
    opcode.start_with?("1")
  end

  def execute(cpu)
    address = @opcode[1,3].hex # hex => dec
    cpu.emular.pc = address - 2
  end

  def to_s
    "#{@opcode}: JP addr\t\t\t => JP 0x#{@opcode[1,3]} (#{@opcode[1,3].hex})"
  end

end

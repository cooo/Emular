# Fx55 - LD [I], Vx
# -------------------------
# Fills V0 to VX with values from memory starting at address I.
# I is then set to I + x + 1.
class LdMemoryFromRegisters

  def match?(opcode)
    @opcode = opcode
    opcode.start_with?("f") && opcode.end_with?("55")
  end

  def execute(cpu)
    registers = @opcode[1].hex + 1
    content = Array.new(registers) { |i| cpu.v[i.to_s(16)] }
    cpu.emular.memory.write(cpu.i, *content)

    cpu.i = cpu.i + registers + 1   # there's a discussion about this line
  end

  def to_s
    "#{@opcode}: LD [I], Vx\t\t\t => LD [I] <-- V0..V#{@opcode[1]}"
  end

end

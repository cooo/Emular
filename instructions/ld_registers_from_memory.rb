# Fx65 - LD Vx, [I]
# -------------------------
# Fills V0 to VX with values from memory starting at address I. 
# I is then set to I + x + 1.
class LdRegistersFromMemory

  def match?(opcode)
    @opcode = opcode
    opcode.start_with?("f") && opcode.end_with?("65")
  end

  def execute(cpu)
    registers = @opcode[1].hex
    (0..registers).each do |i|
      cpu.v[i.to_s] = cpu.emular.memory[cpu.i + i]
    end

    cpu.i = cpu.i + registers + 1   # there's a discussion about this line
  end

  def to_s
    "#{@opcode}: LD Vx, [I]\t\t\t => LD V0..V#{@opcode[1]} <-- [I]"
  end

end

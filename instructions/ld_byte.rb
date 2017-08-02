# 6xkk - LD Vx, byte
# -------------------------
# Set Vx = kk. The interpreter puts the value kk into register Vx.
class LdByte

  def match?(opcode)
    @opcode = opcode
    opcode.start_with?("6")
  end

  def execute(cpu)
    reg_x = @opcode[1]
    cpu.v[reg_x] = @opcode[2,2]
  end

  def to_s
    "#{@opcode}: LD Vx, byte\t\t\t => LD V#{@opcode[1]} <-- 0x#{@opcode[2,2]} (#{@opcode[2,2].hex})"
  end

end

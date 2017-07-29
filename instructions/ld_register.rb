# 8xy0 - LD Vx, Vy
# -------------------------
# Set Vx = Vy. Stores the value of register Vy in register Vx
class LdRegister

  def match?(opcode)
    @opcode = opcode
    opcode.start_with?("8") && opcode.end_with?("0")
  end

  def execute(cpu)
    reg_x = @opcode[1].hex
    reg_y = @opcode[2].hex
    cpu.v[reg_x] = cpu.v[reg_y]
  end

  def to_s
    "#{@opcode}: LD Vx, Vy\t\t\t => LD V#{@opcode[1]}, V#{@opcode[2]}"
  end

end

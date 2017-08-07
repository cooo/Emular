# 9xy0 - SNE Vx, Vy
# -------------------------
# Skip next instruction if Vx != Vy. The values of Vx and Vy are compared, 
# and if they are not equal, the program counter is increased by 2.
class SneRegister

  def match?(opcode)
    @opcode = opcode
    opcode.start_with?("9") && opcode.end_with?("0")
  end

  def execute(cpu)
    reg_x = @opcode[1]
    reg_y = @opcode[2]

    cpu.emular.pc_inc if cpu.v[reg_x] != cpu.v[reg_y]
  end

  def to_s
    "#{@opcode}: SNE Vx, Vy\t\t\t => SNE V#{@opcode[1]} != #{@opcode[2]}"
  end

end

# 8xy4 - ADD Vx, Vy
# -------------------------
# Set Vx = Vx + Vy, set VF = carry. The values of Vx and Vy are added together. 
# If the result is greater than 8 bits (i.e., ¿ 255,) VF is set to 1, otherwise 0. 
# Only the lowest 8 bits of the result are kept, and stored in Vx.
class Add

  def match?(opcode)
    @opcode = opcode
    opcode.start_with?("8") && opcode.end_with?("4")
  end

  def execute(cpu)
    reg_x = @opcode[1]
    reg_y = @opcode[2]

    value = cpu.v[reg_x] + cpu.v[reg_y]
    cpu.flag = value>0xff
    cpu.v[reg_x] = value & 0b011111111  # you could also do: value % 256
  end

  def to_s
    "#{@opcode}: ADD Vx, Vy\t\t\t => ADD V#{@opcode[1]}, V#{@opcode[2]}"
  end

end

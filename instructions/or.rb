# 8xy1 - OR Vx, Vy
# -------------------------
# Set Vx = Vx OR Vy. Performs a bitwise OR on the values of Vx and Vy, then stores the result in Vx. 
# A bitwise OR compares the corresponding bits from two values, and if either bit is 1, 
# then the same bit in the result is also 1. Otherwise, it is 0.
class Or

  def match?(opcode)
    @opcode = opcode
    opcode.start_with?("8") && opcode.end_with?("1")
  end

  def execute(cpu)
    reg_x = @opcode[1]
    reg_y = @opcode[2]
    cpu.v[reg_x] = cpu.v[reg_x] | cpu.v[reg_y]
  end

  def to_s
    "#{@opcode}: OR Vx, Vy\t\t\t => OR V#{@opcode[1]}, V#{@opcode[2]}"
  end

end

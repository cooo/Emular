# 8xy3 - XOR Vx, Vy
# -------------------------
# Set Vx = Vx XOR Vy. Performs a bitwise exclusive OR on the values of Vx and Vy,
# then stores the result in Vx. An exclusive OR compares the corresponding bits 
# from two values, and if the bits are not both the same, then the corresponding 
# bit in the result is set to 1. Otherwise, it is 0.
class Xor

  def match?(opcode)
    @opcode = opcode
    opcode.start_with?("8") && opcode.end_with?("3")
  end

  def execute(cpu)
    reg_x = @opcode[1]
    reg_y = @opcode[2]
    cpu.v[reg_x] = cpu.v[reg_x] ^ cpu.v[reg_y]
  end

  def to_s
    "#{@opcode}: XOR Vx, Vy\t\t\t => XOR V#{@opcode[1]}, V#{@opcode[2]}"
  end

end
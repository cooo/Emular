# 8xy2 - AND Vx, Vy
# -------------------------
# Set Vx = Vx AND Vy. Performs a bitwise AND on the values of Vx and Vy, 
# then stores the result # in Vx. A bitwise AND compares the corresponding bits 
# from two values, and if both bits are 1, then the same bit in the result is 
# also 1. Otherwise, it is 0
class And

  def match?(opcode)
    @opcode = opcode
    opcode.start_with?("8") && opcode.end_with?("2")
  end

  def execute(cpu)
    reg_x = @opcode[1].hex
    reg_y = @opcode[2].hex
    cpu.v[reg_x] = (cpu.v[reg_x].hex & cpu.v[reg_y].hex).to_s(16).rjust(2, "0")

    # TODO: make it work like:
    # cpu.v[reg_x] = cpu.v[reg_x] & cpu.v[reg_y]
  end

  def to_s
    "#{@opcode}: AND Vx, Vy\t\t\t => AND V#{@opcode[1]}, V#{@opcode[2]}"
  end

end

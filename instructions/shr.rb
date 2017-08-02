# 8xy6 - SHR Vx {, Vy}
# -------------------------
# Set Vx = Vx SHR 1. If the least-significant bit of Vx is 1, then VF is set to 1, 
# otherwise 0. Then Vx is divided by 2.
class Shr

  def match?(opcode)
    @opcode = opcode
    opcode.start_with?("8") && opcode.end_with?("6")
  end

  def execute(cpu)
    reg_x = @opcode[1]
    cpu.flag = (cpu.v[reg_x] & 0b1) == 1
    cpu.v[reg_x] = cpu.v[reg_x] >> 1
    
  end

  def to_s
     "#{@opcode}: SHR Vx, {Vy}\t\t\t => SHR V#{@opcode[1]} >> 1"
  end

end

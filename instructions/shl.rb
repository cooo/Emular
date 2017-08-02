# 8xyE - SHL Vx {, Vy}
# -------------------------
# Set Vx = Vx SHL 1. If the most-significant bit of Vx is 1, then VF is set to 1, 
# otherwise to 0. Then Vx is multiplied by 2.
class Shl

  def match?(opcode)
    @opcode = opcode
    opcode.start_with?("8") && opcode.end_with?("e")
  end

  def execute(cpu)
    reg_x = @opcode[1]
    cpu.flag = (cpu.v[reg_x] & 128) == 1
    cpu.v[reg_x] = (cpu.v[reg_x] << 1) % 256
    
  end

  def to_s
     "#{@opcode}: SHL Vx, {Vy}\t\t\t => SHR V#{@opcode[1]} << 1"
  end

end

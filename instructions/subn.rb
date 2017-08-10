# 8xy7 - SUBN Vx, Vy
# -------------------------
# Set Vx = Vy - Vx, set VF = NOT borrow. If Vy > Vx, then VF is set to 1, otherwise 0. 
# Then Vx is subtracted from Vy, and the results stored in Vx.
class Subn

  def match?(opcode)
    @opcode = opcode
    opcode.start_with?("8") && opcode.end_with?("7")
  end

  def execute(cpu)
    reg_x = @opcode[1]
    reg_y = @opcode[2]

    do_sub = cpu.v[reg_y] > cpu.v[reg_x]
    
    cpu.flag = do_sub
    if do_sub
      value = cpu.v[reg_y] - cpu.v[reg_x]
      cpu.v[reg_x] = value
    end
  end

  def to_s
    "#{@opcode}: SUBN Vx, Vy\t\t\t => SUBN V#{@opcode[1]} <-- V#{@opcode[1]} - V#{@opcode[2]}"
  end

end

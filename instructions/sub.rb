# 8xy5 - SUB Vx, Vy
# -------------------------
# Set Vx = Vx - Vy, set VF = NOT borrow. If Vx > Vy, then VF is set to 1, otherwise 0. 
# Then Vy is subtracted from Vx, and the results stored in Vx.
class Sub

  def match?(opcode)
    @opcode = opcode
    opcode.start_with?("8") && opcode.end_with?("5")
  end

  def execute(cpu)
    reg_x = @opcode[1]
    reg_y = @opcode[2]

    do_sub = cpu.v[reg_x] > cpu.v[reg_y]
    
    cpu.flag = do_sub
    if do_sub
      value = cpu.v[reg_x] - cpu.v[reg_y]
      cpu.v[reg_x] = value
    end
  end

  def to_s
    "#{@opcode}: SUB Vx, Vy\t\t\t => SUB V#{@opcode[1]} <-- V#{@opcode[1]} - V#{@opcode[2]}"
  end

end

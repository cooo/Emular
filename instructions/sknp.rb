# ExA1 - SKNP Vx
# -------------------------
# Skip next instruction if key with the value of Vx is not pressed. Checks the keyboard, 
# and if the key corresponding to the value of Vx is currently in the up position, 
# PC is increased by 2.
class Sknp

  def match?(opcode)
    @opcode = opcode
    opcode.start_with?("e") && opcode.end_with?("a1")
  end

  def execute(cpu)
    reg_x = @opcode[1]
   
    cpu.emular.pc_inc unless cpu.emular.keys[reg_x]
  end

  def to_s
    "#{@opcode}: SKNP VX\t\t\t => SKNP #{@opcode[1]}"
  end

end

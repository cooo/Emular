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
    value = cpu.v[reg_x].to_s(16)

    p "SKNP"
    p value
    p cpu.emular.keys
    p "=> #{'do it' unless cpu.emular.keys[value]}"
   
    cpu.emular.pc_inc unless cpu.emular.keys[value]
  end

  def to_s
    "#{@opcode}: SKNP VX\t\t\t => SKNP v#{@opcode[1]}"
  end

end

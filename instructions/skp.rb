# Ex9E - SKP Vx
# -------------------------
# Skip next instruction if key with the value of Vx is pressed. Checks the keyboard, 
# and if the key corresponding to the value of Vx is currently in the down position, 
# PC is increased by 2.
class Skp

  def match?(opcode)
    @opcode = opcode
    opcode.start_with?("e") && opcode.end_with?("9e")
  end

  def execute(cpu)
    reg_x = @opcode[1]
    value = cpu.v[reg_x].to_s(16)
   
    cpu.emular.pc_inc if cpu.emular.keys[value]
  end

  def to_s
    "#{@opcode}: SKP VX\t\t\t => SKP v#{@opcode[1]}"
  end

end

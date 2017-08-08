# Fx29 - LD F, Vx
# -------------------------
# Set I = location of sprite for digit Vx. The value of I is set to the location for 
# the hexadecimal sprite corresponding to the value of Vx. See section 2.4, Display, 
# for more information on the Chip-8 hexadecimal font. To obtain this value, 
# multiply VX by 5 (all font data stored in first 80 bytes of memory).
class LdSprite

  def match?(opcode)
    @opcode = opcode
    opcode.start_with?("f") && opcode.end_with?("29")
  end

  def execute(cpu)
    reg_x = @opcode[1]

    cpu.i = cpu.v[reg_x] * 5
  end

  def to_s
    "#{@opcode}: LD F, Vx\t\t\t => LD F, V#{@opcode[1]}"
  end

end

# 7xkk - ADD Vx, byte
# -------------------------
# Set Vx = Vx + kk. Adds the value kk to the value of register Vx, 
# then stores the result in Vx.
class AddByte

  def match?(opcode)
    @opcode = opcode
    opcode.start_with?("7")
  end

  def execute(cpu)
    reg_x = @opcode[1]
    byte = @opcode[2,2]
    value = cpu.v[reg_x] + byte.hex;
    value = value & 0b011111111
    cpu.v[reg_x] = value

    # no flag here.
  end

  def to_s
    "#{@opcode}: ADD Vx, byte\t\t\t => ADD V#{@opcode[1]}, #{@opcode[2,2]}"
  end

end

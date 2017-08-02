# Fx07 - LD Vx, DT
# -------------------------
# Set Vx = delay timer value. The value of DT is placed into Vx.
class LdRegisterFromDelay

  def match?(opcode)
    @opcode = opcode
    opcode.start_with?("f") && opcode.end_with?("07")
  end

  def execute(cpu)
    reg_x = @opcode[1]
    cpu.v[reg_x] = cpu.delay_timer
  end

  def to_s
    "#{@opcode}: LD Vx, DT\t\t\t => LD V#{@opcode[1]} <-- DT"
  end

end

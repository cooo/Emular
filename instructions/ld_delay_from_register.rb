# Fx15 - LD DT, Vx
# -------------------------
# Set delay timer = Vx. Delay Timer is set equal to the value of Vx.
class LdDelayFromRegister

  def match?(opcode)
    @opcode = opcode
    opcode.start_with?("f") && opcode.end_with?("15")
  end

  def execute(cpu)
    reg_x = @opcode[1]
    cpu.delay_timer = cpu.v[reg_x]
  end

  def to_s
    "#{@opcode}: LD DT, Vx\t\t\t => LD DT <-- V#{@opcode[1]}"
  end

end

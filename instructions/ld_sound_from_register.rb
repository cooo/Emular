# Fx18 - LD ST, Vx
# -------------------------
# Set sound timer = Vx. Sound Timer is set equal to the value of Vx.
class LdSoundFromRegister

  def match?(opcode)
    @opcode = opcode
    opcode.start_with?("f") && opcode.end_with?("18")
  end

  def execute(cpu)
    reg_x = @opcode[1]
    cpu.sound_timer = cpu.v[reg_x]
  end

  def to_s
    "#{@opcode}: LD ST, Vx\t\t\t => LD ST <-- V#{@opcode[1]}"
  end

end

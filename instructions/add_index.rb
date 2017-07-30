# Fx1E - ADD I, Vx
# -------------------------
# Set I = I + Vx. The values of I and Vx are added, and the results are stored in I.
class AddIndex

  def match?(opcode)
    @opcode = opcode
    opcode.start_with?("f") && opcode.end_with?("1e")
  end

  def execute(cpu)
    reg_x = @opcode[1]
    value = cpu.v[reg_x] + cpu.i;
    cpu.i = value
  end

  def to_s
    "#{@opcode}: ADD I, Vx\t\t\t => ADD I, V#{@opcode[1]}"
  end

end

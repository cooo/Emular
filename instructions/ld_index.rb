# Annn - LD I, addr
# Set I = nnn. The value of register I is set to nnn.
class LdIndex

  def match?(opcode)
    @opcode = opcode
    opcode.start_with?("a")
  end

  def execute(cpu)
    address = @opcode[1,3].hex
    cpu.i = address
  end

  def to_s
    "#{@opcode}: LD I, addr\t\t\t => LD I, 0x#{@opcode[1,3]} (#{@opcode[1,3].hex})"
  end

end

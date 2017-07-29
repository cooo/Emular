# 2nnn - CALL addr
# -------------------------
# Call subroutine at nnn. The interpreter increments the stack pointer, 
# then puts the current PC on the top of the stack. The PC is then set to nnn.
class Call

  def match?(opcode)
    @opcode = opcode
    opcode.start_with?("2")
  end

  def execute(cpu)
    address = @opcode[1,3].hex # hex => dec

    cpu.emular.stack.push(cpu.emular.pc)

    cpu.emular.pc = address - 2   # -2, since we inc (+2) the pc in the main loop
  end

  def to_s
    "#{@opcode}: CALL addr\t\t\t => CALL 0x#{@opcode[1,3]} (#{@opcode[1,3].hex})"
  end

end

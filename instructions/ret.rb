# 00ee - RET
# -------------------------
# Return from a subroutine.The interpreter sets the program counter to the 
# address at the top of the stack, then subtracts 1 from the stack pointer.
class Ret

  def match?(opcode)
    @opcode = opcode
    opcode.eql?("00ee")
  end

  def execute(cpu)
    address = cpu.emular.stack.pop
    cpu.emular.pc = address
  end

  def to_s
    "#{@opcode}: RET\t\t\t\t => RET"
  end

end

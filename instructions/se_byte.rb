# 3xkk - SE Vx, byte
# -------------------------
# Skip next instruction if Vx = kk. The interpreter compares register Vx to kk, 
# and if they are equal, increments the program counter by 2.
class SeByte

  def match?(opcode)
    @opcode = opcode
    opcode.start_with?("3")
  end

  def execute(cpu)
    reg_x = @opcode[1]
    byte = @opcode[2,2].hex
    
    cpu.emular.pc_inc if (cpu.v[reg_x] == byte)
  end

  def to_s
    "#{@opcode}: SE Vx, byte\t\t\t => SE V#{@opcode[1]} == #{@opcode[2,2]}"
  end

end

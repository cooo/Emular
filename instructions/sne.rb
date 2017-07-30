# 4xkk - SNE Vx, byte
# -------------------------
# Skip next instruction if Vx != kk. The interpreter compares register Vx to kk, 
# and if they are not equal, increments the program counter by 2.
class Sne

  def match?(opcode)
    @opcode = opcode
    opcode.start_with?("4")
  end

  def execute(cpu)
    reg_x = @opcode[1]
    byte = @opcode[2,2].hex
    if (cpu.v[reg_x] != byte)
      cpu.emular.pc_inc
    end
  end

  def to_s
    "#{@opcode}: SNE Vx, byte\t\t\t => SNE V#{@opcode[1]}, #{@opcode[2,2]}"
  end

end

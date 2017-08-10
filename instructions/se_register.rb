# 5xy0 - SE Vx, Vy
# -------------------------
# Skip next instruction if Vx = Vy. The interpreter compares register Vx to register Vy, 
# and if they are equal, increments the program counter by 2.
class SeRegister

  def match?(opcode)
    @opcode = opcode
    opcode.start_with?("5")
  end

  def execute(cpu)
    reg_x = @opcode[1]
    reg_y = @opcode[2]

    cpu.emular.pc_inc if (cpu.v[reg_x] == cpu.v[reg_y])
  end

  def to_s
    "#{@opcode}: SE Vx, Vy\t\t\t => SE V#{@opcode[1]} == V#{@opcode[2]}"
  end

end

# Fx33 - LD B, Vx
# Store BCD representation of Vx in memory locations I, I+1, and I+2. The 
# interpreter takes the decimal value of Vx, and places the hundreds digit in 
# memory at location in I, the tens digit at location I+1, and the ones digit at 
# location I+2.
class LdBcd

  def match?(opcode)
    @opcode = opcode
    opcode.start_with?("f") && opcode.end_with?("33")
  end

  def execute(cpu)
    reg_x = @opcode[1].hex
    value = cpu.v[reg_x].hex
    ones = value % 10
    tens = ((value - ones) / 10) % 10
    hundreds = ((value - tens*10 - ones) / 100) % 10

    cpu.emular.memory.write(cpu.i, hundreds, tens, ones)
  end

  def to_s
    "#{@opcode}: LD B, Vx\t\t\t => LD B, V#{@opcode[1]}"
  end

end

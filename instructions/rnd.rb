# Cxkk - RND Vx, byte
# -------------------------
# Set Vx = random byte AND kk. The interpreter generates a random number 
# from 0 to 255, which is then ANDed with the value kk. The results are 
# stored in Vx. See instruction 8xy2 for more information on AND.
class Rnd

  def match?(opcode)
    @opcode = opcode
    opcode.start_with?("c")
  end

  def execute(cpu)
    reg_x = @opcode[1]
    byte = @opcode[2,2]

    cpu.v[reg_x] = Random.new.rand(0..255) & byte.hex
  end

  def to_s
    "#{@opcode}: RND Vx, bye\t\t\t => AND V#{@opcode[1]}, #{@opcode[2,2]}"
  end

end

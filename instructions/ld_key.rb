# Fx0A - LD Vx, K
# Wait for a key press, store the value of the key in Vx. 
# All execution stops until a key is pressed, then the value of that key 
# is stored in Vx.
class LdKey

  def match?(opcode)
    @opcode = opcode
    opcode.start_with?("f") && opcode.end_with?("0a")
  end

  def execute(cpu)
    reg_x = @opcode[1]
    
    found = cpu.emular.keys.select{|k,v| v }.keys
    if found.any?
      cpu.v[reg_x] = found.first
    else
      cpu.emular.pc -= 2
    end    
  end

  def to_s
    "#{@opcode}: LD Vx, K\t\t\t => LD V#{@opcode[1]} <-- K"
  end

end

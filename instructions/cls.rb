# 00e0 - CLS
# -------------------------
class Cls

  def match?(opcode)
    @opcode = opcode
    opcode.eql?("00e0")
  end

  def execute(cpu)
    cpu.emular.frame_buffer.clear
  end

  def to_s
    "#{@opcode}: CLS\t\t\t\t => CLS"
  end

end

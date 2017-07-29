# 00e0 - CLS
class Cls

  def match?(opcode)
    @opcode = opcode
    opcode.eql?("00e0")
  end

  def execute(cpu)
    cpu.emular.frame_buffer.each_with_index do |row, y|
      row.each_with_index do |pos, x|
        cpu.emular.frame_buffer[y][x] = 0
      end
    end
  end

  def to_s
    "#{@opcode}: CLS\t\t\t\t => CLS"
  end

end

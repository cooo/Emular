
class Memory
  MEMORY_SIZE = 4096

  def initialize
    @memory = Array.new(MEMORY_SIZE, 0)
  end

  def write(address, *content)
    content.each_with_index do |value, index|
      @memory[address+index] = value
    end
  end

  def fetch(pc)
    self[pc] + self[pc+1]
  end

  def [](address)
    @memory[address].to_s(16).rjust(2, "0")
  end

  def size
    MEMORY_SIZE
  end

  def to_s(from, to)
    result = ""
    from.upto(to) do |i|
      result += "#{hex(i)}: #{hex(@memory[i])}\n"
    end
    result
  end

end

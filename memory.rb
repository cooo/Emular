
class Memory
  MEMORY_SIZE = 4096

  def initialize
    @memory = Array.new(MEMORY_SIZE, "00")
  end

  def write(address, *content)
    content.each_with_index do |value, index|
      @memory[address+index] = value.to_s(16).rjust(2, "0")
    end
  end

  def fetch(pc)
    @memory[pc] + @memory[pc+1]
  end

  def [](address)
    @memory[address]
  end

  def size
    MEMORY_SIZE
  end

  def to_s(from, to)
    result = ""
    for i in from..(from+to)
      result += "#{hex(i)}: #{@memory[i]}\n"
    end
    result
  end

end

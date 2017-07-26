  # 6xkk - LD Vx, byte
  class LdByte

    def match?(opcode)
      @opcode = opcode
      opcode.start_with?("6")
    end

    def execute(cpu)
      register = @opcode[1].to_i(16)
      cpu.v[register] = @opcode[2,2]
    end

    def to_s
      "#{@opcode}: LD Vx, byte\t\t\t => LD V#{@opcode[1]}, #{@opcode[2,2]}"
    end

  end

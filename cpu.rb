require "./instructions.rb"

class Cpu

	attr_reader :emular
	attr_reader :v
	
	def initialize(emular)
		@emular = emular
		@v = Array.new(16, "00")
	end

	def instructions
		@instructions ||= Instructions.all
	end

	def execute(opcode)
		instruction = find(opcode)
		puts "#{hex(@emular.pc)} #{instruction}"
		instruction.execute(self)
	end

	def find(opcode)
		instructions.find { |instruction| instruction.match?(opcode)}
	end

	private

		def hex(dec)
			"0x#{dec.to_s(16)} (#{dec})"
		end

end
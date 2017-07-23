class Emular

	attr_reader :use_debugger
	attr_reader :pc, :sp, :stack, :memory

	ROM_START = 0x200
	MEMORY_SIZE = 4096

	def initialize(options)
		@use_debugger = options[:debug]
	end	

	def reset
		@memory = Array.new(MEMORY_SIZE, 0)
		@pc = ROM_START
	end

	def load(rom)
		@rom = rom
		if rom.size>0
			memory.insert(ROM_START, *rom.bytes).slice!(MEMORY_SIZE, rom.size)
		else
			puts "Warning, you're loading an empty rom"
		end
	end

	def run
		puts "running"
		
		if use_debugger
			puts "running with the debugger"
		end

		opcode = memory[pc] + memory[pc+1]

		puts opcode



	end

	def to_s

		# memory.each do |byte|
		# 	p byte
			
		# end
		
	end

end

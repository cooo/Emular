class Rom

	attr_reader :bytes

	def initialize(bytes)
		@bytes = bytes
	end

	def size
		@bytes.size
	end

end

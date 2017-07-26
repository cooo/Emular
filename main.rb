require './io.rb'
require './rom.rb'
require './emular.rb'


def starts_with_hyphen?(word)
  word[0]=='-'
end

debug = false
file = ""
ARGV.each do |arg|
  if starts_with_hyphen?(arg)
    case arg
    when "-d"
      puts "debug mode"
      debug = true
    end
  else
    file = arg
  end    
end

io = Io.new(file)
instructions = io.read
rom = Rom.new(instructions)

emular = Emular.new(debug: debug) # create a Chip8 emulator

emular.reset        # turns the machine to a default state
emular.load(rom)    # loads a rom in memory
emular.run          # runs the program in memory
#p emular.memory
require './io.rb'
require './rom.rb'
require './emular.rb'
require './display.rb'

def starts_with_hyphen?(word)
  word[0]=='-'
end

def hex(dec)
  "0x#{dec.to_s(16).rjust(2, "0")} (#{dec})"
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

if debug
  require './debugger.rb'
  debugger = Debugger.new
end

emular = Emular.new # create a Chip8 emulator
emular.attach(debugger)

display = Display.new(
  emular,
  width: emular.frame_buffer.width, 
  height: emular.frame_buffer.height, 
  caption: file
)
emular.reset        # turns the machine to a default state
emular.load(rom)    # loads a rom in memory

display.show        # calls display.update & display.render

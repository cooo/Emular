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
color = nil
scale = nil
ARGV.each_with_index do |arg, index|
  if starts_with_hyphen?(arg)
    case arg
    when "-d"
      debug = true
    when "-c"
      color = ARGV[index+1]
    when "-s"
      scale = ARGV[index+1]
    when "-games"
      puts Io.games.join(", ")
      exit 
    end
  end    
end
file = ARGV.last
if file.nil?
  puts "Emular is a Chip-8 interpreter and debugger written in Ruby."
  puts ""
  puts "Usage:"
  puts "Start a game: ruby main.rb [GAME], i.e. ruby main.rb BLINKY"
  puts "List the games: ruby main.rb -games"
  puts "Start a debugger with -d: ruby main.rb -d GUESS"
  puts "Change the size with -s x: ruby main.rb -s 8 GUESS"
  puts "Change the color with -c color: ruby main.rb -c green GUESS"
  puts "Combinations are possible: ruby main.rb -s 4 -c blue GUESS"
  exit
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
  color: color,
  scale: scale,
  width: emular.frame_buffer.width, 
  height: emular.frame_buffer.height, 
  caption: file
)
emular.reset        # turns the machine to a default state
emular.load(rom)    # loads a rom in memory

display.show        # calls display.update & display.render

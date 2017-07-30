# Dxyn - DRW Vx, Vy, nibble
# -------------------------
# Display n-byte sprite starting at memory location I at (Vx, Vy), set VF = collision.
# The interpreter reads n bytes from memory, starting at the address stored in I. 
# These bytes are then displayed as sprites on screen at coordinates (Vx, Vy). Sprites
# are XOR’d onto the existing screen. If this causes any pixels to be erased, VF is set 
# to 1, otherwise it is set to 0. If the sprite is positioned so part of it is outside 
# the coordinates of the display, it wraps around to the opposite side of the screen.
class Drw

  def match?(opcode)
    @opcode = opcode
    opcode.start_with?("d")
  end

  def execute(cpu)
    reg_x = @opcode[1]
    reg_y = @opcode[2]
    nibble = @opcode[3].hex
    x = cpu.v[reg_x]
    y = cpu.v[reg_y]
    sprite = []
    puts hex(cpu.i)
    nibble.times do |i|
      sprite << cpu.emular.memory[cpu.i + i]
    end
    collision = cpu.emular.frame_buffer.write(x, y, sprite)
    cpu.flag = collision
  end

  def to_s
    "#{@opcode}: DRW Vx, Vy, nibble\t\t => DRW V#{@opcode[1]}, V#{@opcode[2]}, #{@opcode[3]}"
  end
end

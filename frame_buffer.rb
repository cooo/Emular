class FrameBuffer
  SCREEN_WIDTH = 64
  SCREEN_HEIGHT = 32

  def initialize
    @frame_buffer = Array.new(SCREEN_HEIGHT) { Array.new(SCREEN_WIDTH, 0) }
  end

  def clear
    @frame_buffer.each_with_index do |row, y|
      row.each_with_index do |pos, x|
        @frame_buffer[y][x] = 0
      end
    end
  end

  # XOR
  # 0  0  =  0  there was no pixel, there is no pixel => no pixel
  # 0  1  =  1  there was no pixel, there is pixel    => pixel
  # 1  0  =  1  there was a pixel, there is no pixel  => pixel
  # 1  1  =  0  there was a pixel, there is pixel     => no pixel, collision
  def write(x,y, sprite)
    collision = false
    sprite.each_with_index do |sprite_line, row_index|
      bits = sprite_line.hex.to_s(2).split(//).map(&:to_i)
      bits.each_with_index do |bit, column_index|
        current_bit = @frame_buffer[y+row_index][x+column_index]
        collision = true if (current_bit==1 && bit==1)
        @frame_buffer[y+row_index][x+column_index] = current_bit ^ bit
      end
    end
    collision
  end

  def to_s
    result = ""
    @frame_buffer.each_with_index do |row, y|
      row.each_with_index do |column, x|
        result += @frame_buffer[y][x].to_s
      end
      result += "\n"
    end
    result
  end

end

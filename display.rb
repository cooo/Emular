require 'gosu'

class Display < Gosu::Window

  SCALE = 4

  KEY_MAP = { 
    30 => '0', 31 => '1', 32 => '2', 33 => '3',     # 1,2,3,4
    20 => '4', 26 => '5',  8 => '6', 21 => '7',     # q,w,e,r
     4 => '8', 22 => '9',  7 => 'a',  9 => 'b',     # a,s,d,f
    29 => 'c', 27 => 'd',  6 => 'e', 25 => 'f'      # z,x,c,v
  }

  attr_accessor :emular

  def initialize(options)
    p "init w#{options[:width]} h#{options[:height]}"
    super options[:width] * SCALE, options[:height] * SCALE
    self.caption = options[:caption]
    @draw_count = 0
  end

  def update
    @u1 = Time.now
    #p "update"
    emular.run
  end

  def draw
    @d1 = Time.now
    #puts "draw:#{@draw_count}\t\t\t\t\t#{@d1}\t\t\t\t\t#{(@d1-@u1)*1000}"
    (0..emular.frame_buffer.height-1).each do |y|
      (0..emular.frame_buffer.width-1).each do |x|
        pixel = emular.frame_buffer.at(y,x) * SCALE
        color = Gosu::Color::WHITE
        draw_quad(x*SCALE, y*SCALE, color, 
                  x*SCALE + pixel, y*SCALE, color,
                  x*SCALE + pixel, y*SCALE + pixel, color,
                  x*SCALE, y*SCALE + pixel, color)
      end
    end
    @draw_count += 1
  end

  def button_down(i)
    emular.keys[KEY_MAP[i]] = true if valid_key?(i)
  end

  def button_up(i)
    emular.keys[KEY_MAP[i]] = false if valid_key?(i)
  end

  private

  def valid_key?(i)
    KEY_MAP.include?(i)
  end

end

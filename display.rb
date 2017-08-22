require 'gosu'

class Display < Gosu::Window

  DEFAULT_COLOR = "white"
  DEFAULT_SCALE = 4


  KEY_MAP = { 
    30 => '1', 31 => '2', 32 => '3', 33 => 'c',     # 1,2,3,4
    20 => '4', 26 => '5',  8 => '6', 21 => 'd',     # q,w,e,r
     4 => '7', 22 => '8',  7 => '9',  9 => 'e',     # a,s,d,f
    29 => 'a', 27 => '0',  6 => 'b', 25 => 'f'      # z,x,c,v
  }
  
  attr_reader :emular

  def initialize(emular, options)
    set_scale(options[:scale])
    super options[:width] * @scale, options[:height] * @scale
    self.caption = options[:caption]
    @emular = emular
    @beep = Gosu::Sample.new("sound/beep.wav")
    set_color(options[:color])
    @draw_count = 0
  end

  def update    
    emular.run
    beep if emular.cpu.sound_timer > 0
    emular.cpu.st.tick
    emular.cpu.dt.tick
  end

  def draw
    (0..emular.frame_buffer.height-1).each do |y|
      (0..emular.frame_buffer.width-1).each do |x|
        pixel = emular.frame_buffer.at(y,x) * @scale
        draw_quad(x*@scale, y*@scale, @color, 
                  x*@scale + pixel, y*@scale, @color,
                  x*@scale + pixel, y*@scale + pixel, @color,
                  x*@scale, y*@scale + pixel, @color)
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

  def beep
    @beep.play
  end

  private

  def valid_key?(i)
    KEY_MAP.include?(i)
  end

  def set_scale(scale)
    scale = scale || DEFAULT_SCALE
    if scale.to_i > 0
      @scale = scale.to_i
    else
      puts "Please use a scale that makes sense, good values are between 1 and 20."
      exit
    end
  end

  def set_color(color)
    color = color || DEFAULT_COLOR
    if Gosu::Color.constants.include?(color.upcase.to_sym)
      @color = Gosu::Color.const_get(color.upcase)
    else
      puts "Please use one of the predefined Gosu colors. See http://www.rubydoc.info/github/gosu/gosu/Gosu/Color"
      exit
    end
  end
  
end

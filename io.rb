class Io

  ROM_PATH = "./roms/"

  def initialize(rom)
    @rom_file = rom
  end

  def read
    bytes = []
    file = ROM_PATH + @rom_file
    if File.exists?(file)
      File.open(file, "rb") do |f|
        f.each_byte do |byte|
        	bytes.push(byte)
        end

        # while (byte = f.read(1)) do
        #   bytes.push(byte.unpack("H*").join)
        # end
      end
    else
      puts "Could not find a rom with the name #{@rom_file}"
    end
    
    bytes
  end
  
  def roms
    # lists the roms in ROM_PATH
  end

end

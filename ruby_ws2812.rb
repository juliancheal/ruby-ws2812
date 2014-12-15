require 'rubyserial'

class RubyWs2812
  
  attr_reader :length
  attr_writer :pin
  
  # Flags for LED pixel types
  NEO_RGB = 0x00 # Wired for RGB data order
  NEO_GRB = 0x01 # Wired for GRB data order
  NEO_BRG = 0x04
  
  NEO_COLMASK = 0x01
  NEO_KHZ800  = 0x02 # 800 KHz datastream
  NEO_SPDMASK = 0x02
  
  attr_reader :length
  
  def initialize(strip_length=60,pin=6,
                 color_order=NEO_GRB,khz=NEO_KHZ800)
   
    @length = strip_length
    @pin = pin
    color_khz = color_order + khz
    
    @serialport = Serial.new("/dev/tty.usbmodem1411",9600)
    3.times do |t|
      @serialport.write("{s:S}\n")
      sleep 0.3
    end
  end
  
  def set_rgb_color(pixel, red, green, blue)
    @serialport.write("{p:#{pixel},c:#{color(red, green, blue)},")
  end
  
  def set_pixel_color(pixel, _color)
    @serialport.write("{p:#{pixel},c:#{_color},")
  end
  
  def set_brightness(value)
    value
  end
  
  def color(red, green, blue)
    (red<<16) + (green<<8) + blue
  end
  
  def get_pixel_color(pixel)
    [pixel,color]
  end
  
  def show
    @serialport.write("s:S}\n")
  end

end
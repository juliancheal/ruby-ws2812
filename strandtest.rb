$:.unshift File.join(File.dirname(__FILE__))
require 'ruby_ws2812'

class Strandtest
  attr_reader :strip
  
  def initialize
    @strip = RubyWs2812.new(strip_length=60,pin=6,
                           color_order=RubyWs2812::NEO_GRB,
                           khz=RubyWs2812::NEO_KHZ800)  
  end

  def loop
    color_wipe(strip.color(255, 165, 0), 50) #Orange
    color_wipe(strip.color(255, 105, 180), 50) #hotpink
    color_wipe(strip.color(0, 255, 0), 50) #Green
    # color_wipe(strip.color(255, 0, 0), 50) #Red
    # color_wipe(strip.color(0, 0, 255), 50) #Blue
    # color_wipe(strip.color(0, 255, 0), 50) #Green
    # Send a theater pixel chase in...
    # theater_chase(strip.color(127, 127, 127), 50) #White
    # theater_chase(strip.color(127,   0,   0), 50) #Red
    # theater_chase(strip.color(  0,   0, 127), 50) #Blue

    # rainbow(20)
    # rainbow_cycle(20)
    # theater_chase_rainbow(50)
  end

  # Fill the dots one after the other with a color
  def color_wipe(color, wait)
    puts "COLOR WIPE"
    puts "Strip Lengh #{strip.length}"
    (0...strip.length).each do |i|
      puts "i #{i}"
      strip.set_pixel_color(i, color)
      strip.show
      delay(wait)
    end
  end

  def rainbow(wait)
    puts "RAINBOW"
    (0...256).each do |j|
      (39...strip.length).each do |i|
        strip.set_pixel_color(i, wheel((i+j) & 255))
      end
      strip.show()
      delay(wait)
    end
  end

  # Slightly different, this makes the rainbow equally distributed throughout
  def rainbow_cycle(wait)
    puts "RAINBOW CYCLE"
    (0...(256*5)).each do |j| # 5 cycles of all colors on wheel
      (0...strip.length).each do |i|
        strip.set_pixel_color(i, wheel(((i * 256 / strip.length) + j) & 255))
      end
      strip.show
      delay(wait)
    end
  end

  # # Theatre-style crawling lights.
  # def theater_chase(color, wait)
  #   (0...10).each do |j| # do 10 cycles of chasing
  #     (0...3).each do |q|
  #       for (i=0, i < strip.length, i=i+3)
  #         # turn every third pixel on
  #         strip.set_pixel_color(i+q, color)
  #       end
  #       
  #       strip.show
  #       delay(wait)
  #            
  #       for (int i=0, i < strip.numPixels(), i=i+3)
  #         # turn every third pixel off
  #         strip.set_pixel_color(i+q, 0)
  #       end
  #     end
  #   end
  # end
  # 
  # # Theatre-style crawling lights with rainbow effect
  # def theater_chase_rainbow(wait)
  #   for (j=0 j < 256, j++) # cycle all 256 colors in the wheel
  #     for (q=0, q < 3, q++)
  #       for (i=0, i < strip.length, i=i+3)
  #         # turn every third pixel on
  #         strip.set_pixel_color(i+q, wheel( (i+j) % 255))
  #       end
  #     
  #       strip.show
  #       delay(wait)
  #  
  #       for (i=0, i < strip.length i=i+3)
  #         # turn every third pixel off
  #         strip.set_pixel_color(i+q, 0)
  #       end
  #     end
  #   end
  # end
  
  def delay(value)
    sleep value/1000 # time in millis
  end

  # Input a value 0 to 255 to get a color value.
  # The colours are a transition r - g - b - back to r.
  def wheel(wheel_pos)
    if(wheel_pos < 85)
     return strip.color(wheel_pos * 3, 255 - wheel_pos * 3, 0)
    elsif(wheel_pos < 170)
     wheel_pos -= 85
     return strip.color(255 - wheel_pos * 3, 0, wheel_pos * 3)
    else
     wheel_pos -= 170
     return strip.color(0, wheel_pos * 3, 255 - wheel_pos * 3)
    end
  end

end

strand_test = Strandtest.new
strand_test.loop
require 'rubyserial'
# 
# class Serial
#   
#   def initialize(device, baud=4800)
#     @sp = Serial.new(device, baud)
#   end
#   
#   def write(message)
#     @sp.write(message)
#   end
#   
# end

serialport = Serial.new("/dev/tty.usbmodem1411",9600)

delay = 0.005#50/100
n = 60
r = 255
g = 165
b = 0
# 3.times do |t|
#   serialport.write("{p:a,r:#{r},g:#{g},b:#{b},s:S}\n")
#   sleep 0.3
# end
3.times do |t|
  serialport.write("{s:S}\n")
  sleep 0.3
end

serialport.write("{")
serialport.write("p:59,c:16752640,")
# serialport.write("p:60,c:16752640,")
serialport.write("s:S}\n")

# 3.times do |tz|
#   puts tz
#   (0...n).each do |i|
#     serialport.write("{")
#     serialport.write("p:#{i},c:16752640,")
#     serialport.write("s:S}\n")
#     sleep delay
#   end
#   (0...n).each do |i|
#     serialport.write("{")
#     serialport.write("p:#{i},c:65280,")
#     serialport.write("s:S}\n")
#     sleep delay
#   end
#   (0...n).each do |i|
#     serialport.write("{")
#     serialport.write("p:#{i},c:16738740,")
#     serialport.write("s:S}\n")
#     sleep delay
#   end
# end

# {p:a,r:255,g:165,b:0}\n{s:S}\n
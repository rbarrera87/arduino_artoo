require 'artoo'

LEDS = %w[red white yellow green]

connection :arduino, adaptor: :firmata, port: '/dev/cu.usbserial-A70374GO'

device :red, driver: :led, pin: 2
device :white, driver: :led, pin: 3
device :yellow, driver: :led, pin: 4
device :green, driver: :led, pin: 5
device :button, driver: :button, pin: 12, interval: 0.01

work do
  puts "Press the button connected on pin #{ button.pin }..."
  on button, :release => proc {
    are_on? ? turn("off") : turn("on")
  }
end

def are_on?
  LEDS.each do |led|
    return false if eval(led).off?
  end
  true
end

def turn(sw)
  LEDS.each do |led|
    eval(led).send(sw)
  end
end
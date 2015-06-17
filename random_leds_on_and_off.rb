require 'artoo'

LEDS = %w[red white yellow green]
status = false

connection :arduino, adaptor: :firmata, port: '/dev/cu.usbserial-A70374GO'

device :red, driver: :led, pin: 2
device :white, driver: :led, pin: 3
device :yellow, driver: :led, pin: 4
device :green, driver: :led, pin: 5
device :button, driver: :button, pin: 12, interval: 0.01

work do
  puts "Press the button connected on pin #{ button.pin }..."
  on button, :release => proc {
    status ? random : turn_off
    status = !status
  }
end

def random
  LEDS.shuffle.each do |led|
    eval(led).send(on_off)
  end
end

def turn_off
  LEDS.each do |led|
    eval(led).send(:off)
  end
end

def on_off
  %w[on off].sample
end
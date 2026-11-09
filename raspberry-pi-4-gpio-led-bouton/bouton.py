from gpiozero import LED, Button
from signal import pause

led = LED(17)
bouton = Button(27)

bouton.when_pressed = led.on
bouton.when_released = led.off

pause()

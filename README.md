# DWIN_T5UIC1_LCD_E3S1

## Docker container with python class for the Ender 3 S1 and other LCDs (DWIN, DACAI, TJC) runing [klipper3d](https://www.klipper3d.org) with [Moonraker](https://github.com/arksine/moonraker) 

If you want to run this without Docker, check out the original [repo](https://github.com/RobRobM/DWIN_T5UIC1_LCD_E3S1).

## Setup:

### [Disable Linux serial console](https://www.raspberrypi.org/documentation/configuration/uart.md)
  By default, the primary UART is assigned to the Linux console. If you wish to use the primary UART for other purposes, you must reconfigure Raspberry Pi OS. This can be done by using raspi-config:

  * Start raspi-config: `sudo raspi-config.`
  * Select option 3 - Interface Options.
  * Select option P6 - Serial Port.
  * At the prompt Would you like a login shell to be accessible over serial? answer 'No'
  * At the prompt Would you like the serial port hardware to be enabled? answer 'Yes'
  * Exit raspi-config and reboot the Pi for changes to take effect.
  
  For full instructions on how to use Device Tree overlays see [this page](https://www.raspberrypi.org/documentation/configuration/device-tree.md). 
  
  In brief, add a line to the `/boot/firmware/config.txt` file to apply a Device Tree overlay.
    
    dtoverlay=disable-bt

### Rrequirements 

  * Flash updated LCD frimware [here](https://github.com/mriscoc/Ender3V2S1/wiki/How-to-update-the-display).

  * Install [prind](https://github.com/mkuf/prind).

### Wire the display 

<img src ="images/Raspberry_Pi_GPIO.png?raw=true" width="500">

Display <-> Raspberry Pi GPIO BCM:
  * Rx  =   GPIO14  (Tx)
  * Tx  =   GPIO15  (Rx)
  * Ent =   GPIO13
  * A   =   GPIO19
  * B   =   GPIO26
  * Vcc =   2   (5v)
  * Gnd =   6   (GND)

You don't have to use the color of wiring that I used:

<img src ="images/GPIO.png?raw=true" width="300">

<img src ="images/raspi.jfif?raw=true" width="300">

TJC display pinout:

<img src ="images/panel.png?raw=true" width="300">

<img src ="images/tjc1.jfif?raw=true" width="300">
<img src ="images/tjc2.jfif?raw=true" width="300">

### Deploy
  
  Add this service to [docker-compose.overrides.yaml](https://github.com/mkuf/prind/blob/main/docker-compose.override.yaml).
  Change the URL and LCD_COM_PORT.

```yaml
dwin-lcd:
    image: ghcr.io/behappiness/dwin_t5uic1_lcd_e3s1:latest
    environment:
      - ENCODER_PINS=26,19
      - BUTTON_PIN=13
      - LCD_COM_PORT=/dev/ttyAMA0
      - API_KEY=USE_IF_NEEDED
      - KLIPPY_SOCKET=/opt/printer_data/run/klipper.sock
      - URL=127.0.0.1
    depends_on:
      klipper:
        condition: service_started
    devices:
      - /dev:/dev
    volumes:
      - run:/opt/printer_data/run
    restart: always
```

Your container output should be:

```
DWIN handshake 
DWIN OK.
http://URL:80
Waiting for connect to /opt/printer_data/run/klipper.sock

Connection.

Boot looks good
Testing Web-services
Web site exists
```

# Status:

## Working:

 Print Menu:
 
    * List / Print jobs from OctoPrint / Moonraker
    * Auto swiching from to Print Menu on job start / end.
    * Display Print time, Progress, Temps, and Job name.
    * Pause / Resume / Cancle Job
    * Tune Menu: Print speed & Temps

 Perpare Menu:
 
    * Move / Jog toolhead
    * Disable stepper
    * Auto Home
    * Z offset (PROBE_CALIBRATE)
    * Preheat
    * cooldown
 
 Info Menu
 
    * Shows printer info.

## Notworking:
    * Save / Loding Preheat setting, hardcode on start can be changed in menu but will not retane on restart.
    * The Control: Motion Menu

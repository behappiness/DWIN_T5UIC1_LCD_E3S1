#!/usr/bin/env python3
import os
from dwinlcd import DWIN_LCD

# Get configuration from environment variables with defaults
encoder_Pins = tuple(map(int, os.getenv('ENCODER_PINS', '26,19').split(',')))
button_Pin = int(os.getenv('BUTTON_PIN', '13'))
LCD_COM_Port = os.getenv('LCD_COM_PORT', '/dev/ttyAMA0')
API_Key = os.getenv('API_KEY', 'USE_IF_NEEDED')
Klippy_Socket = os.getenv('KLIPPY_SOCKET', '/opt/printer_data/run/klipper.sock')
URL = os.getenv('URL', '127.0.0.1')

DWINLCD = DWIN_LCD(
        LCD_COM_Port,
        encoder_Pins,
        button_Pin,
        API_Key,
        Klippy_Socket,
        URL
)

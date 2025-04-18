FROM python:3.11-slim

# Create and set working directory
WORKDIR /app

# Copy application files
COPY . /app/

# Install required system packages
RUN apt update && apt install -y \
    python3-pigpio \
    python3-serial \
    python3-gpiozero

# Install Python packages
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Make scripts executable
RUN chmod +x run.py run.sh

# Set environment variables with defaults
ENV ENCODER_PINS="26,19" \
    BUTTON_PIN="13" \
    LCD_COM_PORT="/dev/ttyAMA0" \
    API_KEY="USE_IF_NEEDED" \
    KLIPPY_SOCKET="/opt/printer_data/run/klipper.sock" \
    URL="127.0.0.1"

# Start the application
CMD [ "python", "./run.py" ]
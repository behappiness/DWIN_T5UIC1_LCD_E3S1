FROM python:3.9-slim

# Install required system packages
RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    python3-pip \
    python3-serial \
    python3-gpiozero \
    && rm -rf /var/lib/apt/lists/*

# Activate virtual environment and install packages
RUN pip install --no-cache-dir multitimer requests RPi.GPIO serial

# Create and set working directory
WORKDIR /app

# Copy application files
COPY . /app/

# Make scripts executable
RUN chmod +x run.py run.sh

# Set environment variables with defaults
ENV ENCODER_PINS="26,19" \
    BUTTON_PIN="13" \
    LCD_COM_PORT="/dev/ttyAMA0" \
    API_KEY="USE_IF_NEEDED" \
    KLIPPY_SOCKET="/opt/printer_data/run/klipper.sock" \
    URL="127.0.0.1"

# Start the application using the virtual environment's Python
CMD [ "python", "./run.py" ]
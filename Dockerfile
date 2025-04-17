FROM python:3.9-slim

# Install required system packages
RUN apt-get update && apt-get install -y \
    python3-serial \
    python3-gpiozero \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip3 install multitimer requests

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

# Create a non-root user
RUN useradd -m -s /bin/bash appuser
USER appuser

# Start the application
CMD ["./run.sh"] 
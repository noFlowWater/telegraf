FROM python:3.8-slim

# Set work directory
WORKDIR /app

# Install dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application source code
COPY mqtt_influx_telegraf_emulator.py /app/
COPY config.yaml /app/

# Command to run the application
CMD ["python", "mqtt_influx_telegraf_emulator.py"]

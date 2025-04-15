import machine
import dht
import time
import json

sensor = dht.DHT11(machine.Pin(15))

while True:
    try:
        sensor.measure()
        temp = sensor.temperature()
        hum = sensor.humidity()

        # Build a JSON object
        reading = {
            "temperature": temp,
            "humidity": hum
        }

        # Send it as a line over serial
        print(json.dumps(reading))

    except Exception as e:
        print(json.dumps({"error": str(e)}))

    time.sleep(2)  # delay between readings

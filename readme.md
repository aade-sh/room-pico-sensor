# Pico W Temperature & Humidity Logger with Cloudflare D1

A minimal Raspberry Pi-based setup that reads temperature and humidity data from a Pico W (connected via USB) and logs it locally and optionally to a Cloudflare D1 database. Includes a tiny HTTP server for local viewing.

## Features

- Reads data from a DHT11 sensor via Raspberry Pi Pico W
- Communicates over USB serial (`/dev/ttyACM0`)
- Saves latest reading to a JSON file
- Local HTTP endpoint on port 8080 (served using Netcat)
- Optional: uploads data to Cloudflare D1 every 10 minutes
- Logs stored under `~/logs/pico-sensor/`

## Components

- Raspberry Pi with Raspberry Pi OS
- Raspberry Pi Pico W flashed with MicroPython
- DHT11 sensor (wired to GPIO15 on the Pico)
- Bash scripts:
  - `read_sensor.sh`: reads serial data and stores latest reading
  - `serve_sensor.sh`: serves the reading as a basic HTML page
  - `upload_sensor_data.sh`: sends the reading to a Cloudflare Worker

## Setup Instructions

1. **Flash MicroPython** to your Pico W.
2. Upload the `main.py` MicroPython script that reads from the DHT11 and prints JSON every 2 seconds.
3. On the Raspberry Pi:
   - Install required tools (`jq`, `curl`, `netcat`).
   - Place the Bash scripts in your home directory or project folder.
   - Ensure all scripts are executable.
4. Start scripts manually or configure them to run at boot using `crontab`.

## Cloudflare D1 Integration

- Create a D1 database via `wrangler`.
- Deploy a Cloudflare Worker to accept POST requests and insert records.
- The upload script will send data from the Pi every 5 minutes using cron.

## Auto-start via Cron

Use `crontab -e` to add entries for:

- Reading sensor data on boot
- Serving the sensor data locally
- Uploading to Cloudflare periodically

## Log Locations

Logs are written to:

- `~/logs/pico-sensor/pico-uploader.log`

## License

MIT:

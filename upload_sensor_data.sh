#!/bin/bash

JSON_FILE="/tmp/homelab-temp-sensor.json"
LOGFILE="$HOME/logs/pico-sensor/pico-uploader.log"
API_URL="https://pico-d1-logger.aadeshchandra.workers.dev"

if [ -f "$JSON_FILE" ]; then
  jq -e .temperature "$JSON_FILE" > /dev/null || exit 1

  curl -s -X POST "$API_URL" \
    -H "Content-Type: application/json" \
    --data-binary @"$JSON_FILE"

  echo "[$(date)] Sent reading to Cloudflare" >> "$LOGFILE"
else
  echo "[$(date)] JSON file not found" >> "$LOGFILE"
fi

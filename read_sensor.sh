#!/bin/bash

cat /dev/ttyACM0 | while read LINE; do
  if echo "$LINE" | grep -q '"temperature"'; then
    TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    echo "$LINE" | jq --arg ts "$TIMESTAMP" '. + {timestamp: $ts}' > /tmp/homelab-temp-sensor.json
  fi
done

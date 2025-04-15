#!/bin/bash

cat /dev/ttyACM0 | while read LINE; do
  if echo "$LINE" | grep -q '"temperature"'; then
    echo "$LINE" > /tmp/homelab-temp-sensor.json
  fi
done

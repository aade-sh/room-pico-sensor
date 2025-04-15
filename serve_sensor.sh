#!/bin/bash

# Tiny Netcat HTTP server for homelab temp sensor

while true; do
  {
    echo -e "HTTP/1.1 200 OK\r"
    echo -e "Content-Type: text/html\r\n"
    echo "<html><head><title>Sensor</title>"
    echo "<meta http-equiv=\"refresh\" content=\"5\"></head><body>"
    echo "<h1>Homelab Temp Sensor</h1>"

    if [ -f /tmp/homelab-temp-sensor.json ]; then
      cat /tmp/homelab-temp-sensor.json | jq -r '"<p>Temperature: \(.temperature) °C</p><p>Humidity: \(.humidity)%</p>"'
    else
      echo "<p>No sensor data available</p>"
    fi

    echo "</body></html>"
  } | nc -l -p 8080 -q 1
done
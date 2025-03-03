#!/bin/bash

# Check if network prefix and port were provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <network_prefix> <port>"
    echo "Example: $0 10.0.5 53"
    exit 1
fi

network_prefix=$1
port=$2

echo "Scanning $network_prefix.0/24 for open port $port..."

# Use parallel processing for faster scanning
for i in {1..254}; do
    timeout 1 bash -c "echo >/dev/tcp/$network_prefix.$i/$port" 2>/dev/null && echo "Host $network_prefix.$i has port $port open" &
done
wait  # Ensures all background processes finish before exiting


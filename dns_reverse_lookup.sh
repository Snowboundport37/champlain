#!/bin/bash

# Check if network prefix and DNS server were provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <network_prefix> <dns_server>"
    echo "Example: $0 10.0.5 10.0.5.22"
    exit 1
fi

network_prefix=$1
dns_server=$2

echo "Performing reverse lookup using DNS server $dns_server..."

for i in {1..254}; do
    host $network_prefix.$i $dns_server | grep "domain name pointer"
done


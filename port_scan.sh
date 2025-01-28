#!/bin/bash
network_prefix=$1
port=$2

for i in {1..254}; do
    timeout 1 bash -c "echo > /dev/tcp/${network_prefix}.${i}/${port}" 2>/dev/null &&
    echo "Host ${network_prefix}.${i} has port ${port} open" &
done
wait

#!/bin/bash
set -eu
PORTKNOCK_SEQ='22222 2222 222 22'
for port in ${PORTKNOCK_SEQ}; do
  echo -n 'HELLO' > "/dev/udp/${1}/${port}"
  sleep 0.1
done

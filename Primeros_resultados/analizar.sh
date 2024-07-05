#!/bin/bash

PRIMERA_LINEA=$(($(wc -l /var/log/remote/ait29.us.es | cut -d" " -f1) + 1))
echo $PRIMERA_LINEA

PCAPNG_FILE=$(ls *.pcapng)
if [ -z "$PCAPNG_FILE" ]; then
  echo "No se encontró ningún archivo .pcapng en el directorio."
  exit 1
fi

sudo tcpreplay-edit -i vnet4 -d 1 -m 65520 --mtu-trunc --mbps 1 "$PCAPNG_FILE"

sleep 60

tail -n +${PRIMERA_LINEA} /var/log/remote/ait29.us.es | grep 'srcintf="port5"' > ./file.log

ALERT_COUNT=$(grep 'level="alert"' ./file.log | wc -l)
echo $ALERT_COUNT

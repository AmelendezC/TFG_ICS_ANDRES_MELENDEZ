#!/bin/bash

OUTPUT_DIR="./attacks"

mkdir -p "$OUTPUT_DIR"

for LOG_FILE in *.log; do
  if [ -f "$LOG_FILE" ]; then
    OUTPUT_CSV="$OUTPUT_DIR/${LOG_FILE%.log}.csv"
    
    grep 'level="alert"' "$LOG_FILE" | grep 'subtype="ips"' | grep 'eventtype="signature"' | while IFS= read -r line; do
      attackid=$(echo "$line" | grep -o 'attackid=[^ ]*' | cut -d '=' -f2)
      attack=$(echo "$line" | grep -o 'attack="[^"]*"' | cut -d '"' -f2)
      severity=$(echo "$line" | grep -o 'severity="[^"]*"' | cut -d '"' -f2)
      service=$(echo "$line" | grep -o 'service="[^"]*"' | cut -d '"' -f2)
      srcip=$(echo "$line" | grep -o 'srcip=[^ ]*' | cut -d '=' -f2)
      dstip=$(echo "$line" | grep -o 'dstip=[^ ]*' | cut -d '=' -f2)
      subtype="ips"
      eventtype="signature"
      
      echo -e "$attackid\t$severity\t$attack\t$service\t$srcip\t$dstip\t$subtype\t$eventtype" >> "$OUTPUT_CSV"
    done
    
    if [ -s "$OUTPUT_CSV" ]; then
      echo "Se ha creado el archivo CSV para $LOG_FILE: $OUTPUT_CSV"
    else
      echo "No se encontraron líneas que coincidan con los criterios especificados en $LOG_FILE."
      rm "$OUTPUT_CSV"  # Elimina el archivo de salida si está vacío
    fi
  else
    echo "No se encontraron archivos .log en el directorio actual."
  fi
done

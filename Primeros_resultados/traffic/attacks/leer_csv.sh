#!/bin/bash

# Verificar si se proporcionó un argumento para el nombre del archivo CSV
if [ $# -ne 1 ]; then
  echo "Uso: $0 <archivo_csv>"
  exit 1
fi

# Nombre del archivo CSV proporcionado como argumento
CSV_FILE="$1"

# Verificar si el archivo existe y es un archivo regular
if [ -f "$CSV_FILE" ]; then
  # Leer el archivo línea por línea
  while IFS=$'\t' read -r attackid severity attack service srcip dstip subtype eventtype; do
    # Imprimir cada campo
    echo "Attack ID: $attackid"
    echo "Severity: $severity"
    echo "Attack: $attack"
    echo "Service: $service"
    echo "Source IP: $srcip"
    echo "Destination IP: $dstip"
    echo "Subtype: $subtype"
    echo "Event Type: $eventtype"
    echo "---------------------------------"
  done < "$CSV_FILE"
else
  echo "El archivo $CSV_FILE no existe o no es un archivo regular."
fi

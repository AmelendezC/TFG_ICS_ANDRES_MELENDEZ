#!/bin/bash

# Definir el directorio donde se encuentran los archivos .pcapng y el directorio de salida
DIR_PCAPS="$(pwd)/"
DIR_RES="$(pwd)/flujos/"

# Crear el directorio de resultados si no existe
mkdir -p "$DIR_RES"

# Recorremos los archivos .pcapng en el directorio actual
for pcap in "$DIR_PCAPS"*.pcapng; do
    # Nos quedamos con el nombre del archivo sin extensión
    nombre=$(basename "$pcap" .pcapng)
    
    # Ejecutar Tranalyzer y generar los archivos de flujo
    tranalyzer -r "$pcap" -w "$DIR_RES"
    
    # Mover el archivo flows.txt generado a un archivo con el nombre del pcap
    mv "${DIR_RES}${nombre}_flows.txt" "${DIR_RES}${nombre}_flows.txt"
done

echo "Archivos flows.txt generados en el directorio $DIR_RES"


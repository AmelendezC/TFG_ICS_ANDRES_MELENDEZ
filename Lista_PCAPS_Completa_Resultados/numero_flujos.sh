
#!/bin/bash

# Definimos el directorio actual y el directorio donde se guardarán los resultados
DIR_PCAPS="$(pwd)/"
DIR_RES="$(pwd)/flujos/"

# Creamos el directorio flujos si no existe
mkdir -p "$DIR_RES"

# Archivo de salida donde se almacenará la tabla de flujos
OUTPUT_FILE="${DIR_RES}tabla_flujos.csv"

# Crear el archivo CSV y agregar la cabecera
echo "nombre_pcap,numero_total_flujos" > "$OUTPUT_FILE"

# Recorremos los ficheros del directorio con los pcaps
for pcap in "$DIR_PCAPS"*.pcapng; do

    # Nos quedamos con el nombre del fichero sin extensión
    nombre=$(basename "$pcap" .pcapng)
    
    # Aplicamos Tranalyzer2, redirigiendo la salida a un fichero en la carpeta flujos
    tranalyzer -s -r "$pcap" -w "$DIR_RES" > "${DIR_RES}salida_${nombre}.txt"
    
    # Obtenemos el número de flujos del fichero de salida
    num_flujos=$(grep -w "Number of processed      flows:" "${DIR_RES}salida_${nombre}.txt" | awk '{print $5}')
    
    # Escribimos el resultado en el archivo CSV
    echo "${nombre},${num_flujos}" >> "$OUTPUT_FILE"

    # Borramos los archivos generados por Tranalyzer para ahorrar espacio
    rm "${DIR_RES}${nombre}_headers.txt"
    rm "${DIR_RES}${nombre}_flows.txt"
    rm "${DIR_RES}${nombre}_packets.txt"
    rm "${DIR_RES}salida_${nombre}.txt"

done

echo "Tabla generada en $OUTPUT_FILE"

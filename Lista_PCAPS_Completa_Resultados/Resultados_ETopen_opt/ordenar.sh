#!/bin/bash

# Verificar que se haya proporcionado el archivo CSV como argumento
if [ "$#" -lt 1 ]; then
  echo "Uso: $0 <archivo_csv>"
  exit 1
fi

# Obtener el archivo CSV de entrada desde el argumento de la consola
input_csv="$1"
# Archivo que contiene el orden deseado
order_file="orden.txt"
# Archivo de salida ordenado
output_csv="ordenado.csv"

# Crear un archivo de salida temporal
> "$output_csv"

# Leer cada patrón en el orden deseado y encontrar las líneas correspondientes en el archivo CSV
while IFS= read -r pattern; do
  # Buscar las líneas en el CSV que coincidan con el patrón y agregarlas al archivo de salida
  grep "^$pattern" "$input_csv" >> "$output_csv"
done < "$order_file"

# Mostrar el archivo ordenado
cat "$output_csv"

# Mensaje de finalización
echo "El archivo ha sido ordenado y guardado en $output_csv"


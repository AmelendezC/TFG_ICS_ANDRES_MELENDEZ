import pandas as pd
import sys
import os

# Función para convertir CSV a Excel
def csv_to_excel(csv_file):
    # Cargar el archivo CSV en un DataFrame de pandas
    df = pd.read_csv(csv_file, delimiter='\t')  # Ajusta el delimitador según tu archivo CSV
    
    # Nombre del archivo Excel de salida
    excel_file = os.path.splitext(csv_file)[0] + '.xlsx'
    
    # Escribir el DataFrame en un archivo Excel
    df.to_excel(excel_file, index=False)
    
    return excel_file

# Verificar si se proporcionó un argumento para el nombre del archivo CSV
if len(sys.argv) != 2:
    print("Uso: python convertir_csv_a_excel.py <archivo_csv>")
    sys.exit(1)

# Nombre del archivo CSV proporcionado como argumento
csv_file = sys.argv[1]

# Verificar si el archivo existe y es un archivo regular
if not os.path.isfile(csv_file):
    print(f"El archivo {csv_file} no existe o no es un archivo regular.")
    sys.exit(1)

# Convertir CSV a Excel
excel_file = csv_to_excel(csv_file)

print(f"Archivo Excel convertido correctamente: {excel_file}")

import os
import pandas as pd

# Directorio donde se encuentran los archivos CSV
CSV_DIRECTORY = "."

# Nombre del archivo Excel de salida
OUTPUT_EXCEL = "combined_data.xlsx"

# Lista para almacenar los DataFrames de cada archivo CSV
csv_dataframes = []

# Obtener la lista de archivos CSV en el directorio
csv_files = [file for file in os.listdir(CSV_DIRECTORY) if file.endswith(".csv")]

# Leer cada archivo CSV y cargar los datos en un DataFrame
for csv_file in csv_files:
    file_path = os.path.join(CSV_DIRECTORY, csv_file)
    df = pd.read_csv(file_path, sep='\t')  # Ajusta el separador según tu archivo CSV
    csv_dataframes.append(df)

# Combinar todos los DataFrames en uno solo
combined_df = pd.concat(csv_dataframes, ignore_index=True)

# Escribir el DataFrame combinado en un archivo Excel
combined_df.to_excel(OUTPUT_EXCEL, index=False)

print(f"Archivo Excel generado: {OUTPUT_EXCEL}")

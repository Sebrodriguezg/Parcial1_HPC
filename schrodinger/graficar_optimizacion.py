import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import os

# Nombres de los archivos según la estructura del proyecto
archivos_config = {
    'code1': 'datos_tiempos-code1.csv',
    'code2': 'datos_tiempos_cayley-code2.csv',
    'code3': 'datos_tiempos_cheb-code3.csv',
    'code4': 'datos_tiempos-code4.csv'
}

titulos = {
    'code1': 'Método Pseudo-Espectral (FFT)',
    'code2': 'Aproximación de Cayley',
    'code3': 'Expansión de Chebyshev',
    'code4': 'Subespacios de Krylov-Lanczos'
}

# Estilo para que se vea formal en un documento científico
sns.set_theme(style="whitegrid", context="paper", font_scale=1.2)

for carpeta, archivo in archivos_config.items():
    ruta_archivo = os.path.join(carpeta, archivo)
    
    if os.path.exists(ruta_archivo):
        print(f"Procesando: {ruta_archivo}")
        
        # Crear la carpeta img dentro de codeX si no existe
        ruta_img = os.path.join(carpeta, 'img')
        os.makedirs(ruta_img, exist_ok=True)
        
        # Leer datos
        df = pd.read_csv(ruta_archivo)
        
        # Agrupar los datos por Versión y Bandera calculando la media del tiempo
        df_agrupado = df.groupby(['Version_Codigo', 'Bandera'])['Tiempo_Total_Segundos'].mean().reset_index()
        
        # Ordenar las banderas correctamente (-O0, -O1, -O2, -O3)
        df_agrupado['Bandera'] = pd.Categorical(df_agrupado['Bandera'], categories=['-O0', '-O1', '-O2', '-O3'], ordered=True)
        df_agrupado = df_agrupado.sort_values(['Version_Codigo', 'Bandera'])
        
        # Crear figura
        plt.figure(figsize=(8, 5))
        
        # Gráfico de barras
        ax = sns.barplot(
            data=df_agrupado,
            x='Bandera',
            y='Tiempo_Total_Segundos',
            hue='Version_Codigo',
            palette='Set2',
            edgecolor='black'
        )
        
        # Configuraciones de la gráfica
        plt.title(f'Tiempos de Ejecución vs. Bandera de Compilación\n{titulos[carpeta]}', fontsize=14, weight='bold')
        plt.xlabel('Bandera de Compilación', fontsize=12)
        plt.ylabel('Tiempo Total (Segundos)', fontsize=12)
        plt.legend(title='Versión de Código')
        
        # Ajustar para que nada quede recortado
        plt.tight_layout()
        
        # Guardar en su respectiva carpeta img
        nombre_salida = os.path.join(ruta_img, f'barras_optimizacion_{carpeta}.png')
        plt.savefig(nombre_salida, dpi=300)
        plt.close()
        
        print(f"  -> Gráfica guardada en: {nombre_salida}")
    else:
        print(f"Advertencia: No se encontró el archivo {ruta_archivo}")

print("Proceso finalizado.")

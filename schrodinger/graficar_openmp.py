import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
import os

# Archivos de entrada
archivos_config = {
    '1. Pseudo-espectral': 'code1/datos_omp_speedup-code1.csv',
    '2. Cayley': 'code2/datos_omp_speedup_cayley-code2.csv',
    '3. Chebyshev': 'code3/datos_omp_speedup_cheb-code3.csv',
    '4. Krylov-Lanczos': 'code4/datos_omp_speedup-code4.csv'
}

# Estilo
sns.set_theme(style="whitegrid", context="paper", font_scale=1.2)
marcadores = ['o', 's', '^', 'D']

fig_speedup, ax_sp = plt.subplots(figsize=(8, 6))
fig_eficiencia, ax_ef = plt.subplots(figsize=(8, 6))

# Arreglo dinámico de hilos basado en tus datos reales
hilos_totales = [1, 2, 4, 8, 16, 24, 32, 40]
hilos_ideales = np.array(hilos_totales)

# Linea de Speedup ideal (Lineal)
ax_sp.plot(hilos_ideales, hilos_ideales, 'k--', label='Speedup Ideal (Lineal)')

# Linea de Eficiencia ideal (1.0)
ax_ef.axhline(y=1.0, color='k', linestyle='--', label='Eficiencia Ideal (1.0)')

idx = 0
for nombre, ruta in archivos_config.items():
    if os.path.exists(ruta):
        df = pd.read_csv(ruta)
        
        # Ordenamos por si acaso
        df = df.sort_values(by='Hilos')
        hilos = df['Hilos'].values
        tiempos = df['Tiempo_Total_Segundos'].values
        
        # Calcular Speedup (T1 / Tp) y Eficiencia (Sp / p)
        t1 = tiempos[0]
        speedup = t1 / tiempos
        eficiencia = speedup / hilos
        
        # Plot Speedup
        ax_sp.plot(hilos, speedup, marker=marcadores[idx], linewidth=2, markersize=8, label=nombre)
        
        # Plot Eficiencia
        ax_ef.plot(hilos, eficiencia, marker=marcadores[idx], linewidth=2, markersize=8, label=nombre)
        
        idx += 1
    else:
        print(f"Archivo no encontrado: {ruta}")

# Configuracion final Speedup
ax_sp.set_title('Speedup vs Número de Hilos (OpenMP)', fontsize=14, weight='bold')
ax_sp.set_xlabel('Número de Hilos (p)', fontsize=12)
ax_sp.set_ylabel('Speedup ($S_p$)', fontsize=12)
ax_sp.set_xticks(hilos_totales) # Muestra exactamente los hilos medidos
ax_sp.legend()
fig_speedup.tight_layout()
os.makedirs('img', exist_ok=True)
fig_speedup.savefig('img/openmp_speedup_comparativo.png', dpi=300)

# Configuracion final Eficiencia
ax_ef.set_title('Eficiencia Paralela vs Número de Hilos (OpenMP)', fontsize=14, weight='bold')
ax_ef.set_xlabel('Número de Hilos (p)', fontsize=12)
ax_ef.set_ylabel('Eficiencia ($E_p$)', fontsize=12)
ax_ef.set_xticks(hilos_totales) # Muestra exactamente los hilos medidos
ax_ef.legend()
fig_eficiencia.tight_layout()
fig_eficiencia.savefig('img/openmp_eficiencia_comparativa.png', dpi=300)

print("Gráficas de OpenMP guardadas en la carpeta 'img/'")

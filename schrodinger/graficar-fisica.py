import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
import os

# Archivos representativos de cada método (Misma malla N=2048, dt=0.01, -O3)
archivos_fisica = {
    '1. Pseudo-espectral (FFT)': 'code1/datos1-caché-B/ondas_Optimizado_-O3_N2048_dt0.01_B2048.dat',
    '2. Aproximación de Cayley': 'code2/datos_original/ondas_Original_-O3_N2048_dt0.01.dat',
    '3. Expansión de Chebyshev': 'code3/datos_cheb_base/out_Original_-O3_N2048_B2048.dat',
    '4. Krylov-Lanczos': 'code4/datos_original/ondas_Original_-O3_N2048_dt0.01_B2048.dat'
}

sns.set_theme(style="whitegrid", context="paper", font_scale=1.1)

# Preparar las figuras (4 paneles cada una)
fig_dens, axs_dens = plt.subplots(2, 2, figsize=(12, 8))
fig_norm, axs_norm = plt.subplots(2, 2, figsize=(12, 8))
axs_dens = axs_dens.flatten()
axs_norm = axs_norm.flatten()

for idx, (nombre, ruta) in enumerate(archivos_fisica.items()):
    if os.path.exists(ruta):
        print(f"Procesando física de: {nombre}")
        # Leer salida Fortran (ignorando líneas en blanco y tomando las 3 primeras columnas: t, x, abs_psi)
        df = pd.read_csv(ruta, sep=r'\s+', header=None, usecols=[0, 1, 2], names=['t', 'x', 'abs_psi'])
        df = df.dropna()
        
        # Calcular densidad de probabilidad |psi|^2
        df['densidad'] = df['abs_psi']**2
        
        # Encontrar el paso de malla espacial dx
        t_inicial = df['t'].min()
        x_vals = df[df['t'] == t_inicial]['x'].values
        dx = x_vals[1] - x_vals[0] if len(x_vals) > 1 else 1.0

        # --- GRÁFICA 1: CONSERVACIÓN DE LA PROBABILIDAD (NORMA) ---
        # Integrar la densidad en todo el espacio para cada paso de tiempo
        norma_por_tiempo = df.groupby('t')['densidad'].sum() * dx
        
        axs_norm[idx].plot(norma_por_tiempo.index, norma_por_tiempo.values, color='firebrick', linewidth=2)
        axs_norm[idx].set_title(f'{nombre}', weight='bold')
        axs_norm[idx].set_xlabel('Tiempo (t)')
        axs_norm[idx].set_ylabel(r'Norma $\int |\psi|^2 dx$')
        axs_norm[idx].set_ylim(0.95, 1.05) # Escala ajustada alrededor de 1.0
        
        # --- GRÁFICA 2: DENSIDAD FINAL DEL PAQUETE DE ONDAS ---
        t_max = df['t'].max()
        df_final = df[df['t'] == t_max]
        
        axs_dens[idx].plot(df_final['x'], df_final['densidad'], color='navy', linewidth=2)
        axs_dens[idx].fill_between(df_final['x'], df_final['densidad'], color='navy', alpha=0.3)
        axs_dens[idx].set_title(f'{nombre} (t = {t_max})', weight='bold')
        axs_dens[idx].set_xlabel('Posición (x)')
        axs_dens[idx].set_ylabel(r'Densidad $|\psi(x)|^2$')
    else:
        print(f"Advertencia: No se encontró el archivo {ruta}")

# Ajustar y guardar
fig_norm.suptitle('Validación Física: Conservación de Probabilidad en el Tiempo', fontsize=16, weight='bold')
fig_norm.tight_layout()
fig_norm.savefig('img/fisica_conservacion_norma.png', dpi=300)

fig_dens.suptitle('Validación Física: Densidad del Paquete de Ondas (Estado Final)', fontsize=16, weight='bold')
fig_dens.tight_layout()
fig_dens.savefig('img/fisica_densidad_final.png', dpi=300)

print("Gráficas de validación física generadas en 'img/'")

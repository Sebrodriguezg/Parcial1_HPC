#!/bin/bash

# ===============================================
# GENERACIÓN DE GRÁFICAS (GNUPLOT MULTIPLOT)
# ===============================================
echo "==============================================="
echo "  GENERANDO GRÁFICAS (LINEAR & LOG-LOG)"
echo "==============================================="

gnuplot << EOF
# 1. Configuración global del terminal
set terminal pngcairo size 1000,1200 font "Sans,12"
set grid
set key left top

# 2. Definición de estilos de línea para rigor visual
set style line 1 lc rgb '#0060ad' lt 1 lw 2 pt 7 ps 1.2 # Original (Azul)
set style line 2 lc rgb '#dd181f' lt 1 lw 2 pt 5 ps 1.2 # Optimizado (Rojo)

# -----------------------------------------------
# LOOP DE MÉTODOS
# -----------------------------------------------

# --- 1. MÉTODO BASE ---
set output "base_comp.png"
set multiplot layout 2,1 title "Método Base: Análisis de Rendimiento Numérico" font ",14"

# Gráfica Superior: Lineal
set title "Tiempo de Ejecución (Escala Lineal)"
set xlabel "N (Tamaño de la cuadrícula / Puntos)"
set ylabel "Tiempo de Ejecución (s)"
unset logscale
plot "data/base_orig.txt" u 1:6 w lp ls 1 title "Original", \
     "data/base_op.txt"   u 1:6 w lp ls 2 title "Optimizado"

# Gráfica Inferior: Log-Log
set title "Complejidad Algorítmica (Escala Log-Log)"
set logscale xy
set xlabel "log(N)"
set ylabel "log(Tiempo)"
plot "data/base_orig.txt" u 1:6 w lp ls 1 title "Original", \
     "data/base_op.txt"   u 1:6 w lp ls 2 title "Optimizado"

unset multiplot

# --- 2. MÉTODO FDM ---
set output "fdm_comp.png"
set multiplot layout 2,1 title "Método FDM: Análisis de Rendimiento Numérico" font ",14"

set title "Tiempo de Ejecución (Escala Lineal)"
set xlabel "N"
set ylabel "Tiempo (s)"
unset logscale
plot "data/fdm_orig.txt" u 1:6 w lp ls 1 title "FDM Original", \
     "data/fdm_op.txt"   u 1:6 w lp ls 2 title "FDM Optimizado"

set title "Análisis de Potencia (Log-Log)"
set logscale xy
set xlabel "log(N)"
set ylabel "log(Tiempo)"
plot "data/fdm_orig.txt" u 1:6 w lp ls 1 title "FDM Original", \
     "data/fdm_op.txt"   u 1:6 w lp ls 2 title "FDM Optimizado"

unset multiplot

# --- 3. MÉTODO SHOOTING ---
set output "shoot_comp.png"
set multiplot layout 2,1 title "Método Shooting: Análisis de Rendimiento Numérico" font ",14"

set title "Tiempo de Ejecución (Escala Lineal)"
set xlabel "N"
set ylabel "Tiempo (s)"
unset logscale
plot "data/shoot_orig.txt" u 1:6 w lp ls 1 title "Shoot Original", \
     "data/shoot_op.txt"   u 1:6 w lp ls 2 title "Shoot Optimizado"

set title "Análisis de Potencia (Log-Log)"
set logscale xy
set xlabel "log(N)"
set ylabel "log(Tiempo)"
plot "data/shoot_orig.txt" u 1:6 w lp ls 1 title "Shoot Original", \
     "data/shoot_op.txt"   u 1:6 w lp ls 2 title "Shoot Optimizado"

unset multiplot

# --- 4. MÉTODO SINC-DVR ---
set output "sinc_comp.png"
set multiplot layout 2,1 title "Método Sinc-DVR: Análisis de Rendimiento Numérico" font ",14"

set title "Tiempo de Ejecución (Escala Lineal)"
set xlabel "N"
set ylabel "Tiempo (s)"
unset logscale
plot "data/sinc_orig.txt" u 1:6 w lp ls 1 title "Sinc Original", \
     "data/sinc_op.txt"   u 1:6 w lp ls 2 title "Sinc Optimizado"

set title "Análisis de Potencia (Log-Log)"
set logscale xy
set xlabel "log(N)"
set ylabel "log(Tiempo)"
plot "data/sinc_orig.txt" u 1:6 w lp ls 1 title "Sinc Original", \
     "data/sinc_op.txt"   u 1:6 w lp ls 2 title "Sinc Optimizado"

unset multiplot

EOF

echo "==============================================="
echo "  GRÁFICAS GENERADAS EXITOSAMENTE"
echo "==============================================="
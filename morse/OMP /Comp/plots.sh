#!/bin/bash

# ==========================================================
# GENERACIÓN DE GRÁFICAS: BENCHMARK COMPLETO (1-8 THREADS)
# ==========================================================
echo "=========================================================="
echo "  GENERANDO GRÁFICAS: SERIAL vs OPT vs OMP(1-8)"
echo "=========================================================="

mkdir -p imag

gnuplot << EOF
# 1. Configuración del Terminal
set terminal pngcairo size 1200,1500 font "Sans,10"
set grid
set key outside right center
set datafile separator whitespace

# 2. Estilos de Línea (Paleta de alta distinción)
set style line 1  lc rgb '#000000' lt 1 lw 3 pt 7 ps 1.4 # SERIAL
set style line 2  lc rgb '#D91E18' lt 1 lw 3 pt 5 ps 1.4 # OPTIMIZED

# Degradado para OMP (Escala de Fríos a Cálidos)
set style line 3  lc rgb '#4575B4' lt 2 lw 1.5 pt 6 # OMP_1
set style line 4  lc rgb '#74ADD1' lt 2 lw 1.5 pt 6 # OMP_2
set style line 5  lc rgb '#ABD9E9' lt 2 lw 1.5 pt 6 # OMP_3
set style line 6  lc rgb '#E0F3F8' lt 2 lw 1.5 pt 6 # OMP_4
set style line 7  lc rgb '#FEE090' lt 2 lw 1.5 pt 6 # OMP_5
set style line 8  lc rgb '#FDAE61' lt 2 lw 1.5 pt 6 # OMP_6
set style line 9  lc rgb '#F46D43' lt 2 lw 1.5 pt 6 # OMP_7
set style line 10 lc rgb '#D73027' lt 1 lw 2.5 pt 9 ps 1.5 # OMP_8 (Resaltado)

# ----------------------------------------------------------
# BLOQUE DE GRÁFICAS
# ----------------------------------------------------------

# --- 1. MÉTODO BASE ---
set output "imag/base_full_scaling.png"
set multiplot layout 2,1 title "{/:Bold Análisis de Escalabilidad: Método Base (SHO)}" font ",14"
set title "Tiempo de Ejecución vs N"
set xlabel "N (Tamaño de la Base)"
set ylabel "Tiempo (s)"
unset logscale
plot "< grep '^SERIAL' data/data_base.txt"    u 2:7 w lp ls 1  title "Serial", \
     "< grep '^OPTIMIZED' data/data_base.txt" u 2:7 w lp ls 2  title "Optimizado", \
     "< grep '^OMP_1 ' data/data_base.txt"    u 2:7 w l  ls 3  title "OMP 1", \
     "< grep '^OMP_2 ' data/data_base.txt"    u 2:7 w l  ls 4  title "OMP 2", \
     "< grep '^OMP_3 ' data/data_base.txt"    u 2:7 w l  ls 5  title "OMP 3", \
     "< grep '^OMP_4 ' data/data_base.txt"    u 2:7 w l  ls 6  title "OMP 4", \
     "< grep '^OMP_5 ' data/data_base.txt"    u 2:7 w l  ls 7  title "OMP 5", \
     "< grep '^OMP_6 ' data/data_base.txt"    u 2:7 w l  ls 8  title "OMP 6", \
     "< grep '^OMP_7 ' data/data_base.txt"    u 2:7 w l  ls 9  title "OMP 7", \
     "< grep '^OMP_8 ' data/data_base.txt"    u 2:7 w lp ls 10 title "OMP 8"

set title "Complejidad Algorítmica (Log-Log)"
set logscale xy
replot
unset multiplot

# --- 2. MÉTODO FDM ---
set output "imag/fdm_full_scaling.png"
set multiplot layout 2,1 title "{/:Bold Análisis de Escalabilidad: Método FDM}" font ",14"
set title "Tiempo de Ejecución vs N"
set xlabel "N (Puntos de Malla)"
set ylabel "Tiempo (s)"
unset logscale
plot "< grep '^SERIAL' data/data_fdm.txt"    u 2:7 w lp ls 1  title "Serial", \
     "< grep '^OPTIMIZED' data/data_fdm.txt" u 2:7 w lp ls 2  title "Optimizado", \
     "< grep '^OMP_1 ' data/data_fdm.txt"    u 2:7 w l  ls 3  title "OMP 1", \
     "< grep '^OMP_2 ' data/data_fdm.txt"    u 2:7 w l  ls 4  title "OMP 2", \
     "< grep '^OMP_3 ' data/data_fdm.txt"    u 2:7 w l  ls 5  title "OMP 3", \
     "< grep '^OMP_4 ' data/data_fdm.txt"    u 2:7 w l  ls 6  title "OMP 4", \
     "< grep '^OMP_5 ' data/data_fdm.txt"    u 2:7 w l  ls 7  title "OMP 5", \
     "< grep '^OMP_6 ' data/data_fdm.txt"    u 2:7 w l  ls 8  title "OMP 6", \
     "< grep '^OMP_7 ' data/data_fdm.txt"    u 2:7 w l  ls 9  title "OMP 7", \
     "< grep '^OMP_8 ' data/data_fdm.txt"    u 2:7 w lp ls 10 title "OMP 8"

set title "Complejidad Algorítmica (Log-Log)"
set logscale xy
replot
unset multiplot

# --- 3. MÉTODO SHOOTING ---
set output "imag/shoot_full_scaling.png"
set multiplot layout 2,1 title "{/:Bold Análisis de Escalabilidad: Método Shooting}" font ",14"
set title "Tiempo de Ejecución vs N"
set xlabel "N (Pasos de Integración)"
set ylabel "Tiempo (s)"
unset logscale
plot "< grep '^SERIAL' data/data_shoot.txt"    u 2:7 w lp ls 1  title "Serial", \
     "< grep '^OPTIMIZED' data/data_shoot.txt" u 2:7 w lp ls 2  title "Optimizado", \
     "< grep '^OMP_1 ' data/data_shoot.txt"    u 2:7 w l  ls 3  title "OMP 1", \
     "< grep '^OMP_2 ' data/data_shoot.txt"    u 2:7 w l  ls 4  title "OMP 2", \
     "< grep '^OMP_3 ' data/data_shoot.txt"    u 2:7 w l  ls 5  title "OMP 3", \
     "< grep '^OMP_4 ' data/data_shoot.txt"    u 2:7 w l  ls 6  title "OMP 4", \
     "< grep '^OMP_5 ' data/data_shoot.txt"    u 2:7 w l  ls 7  title "OMP 5", \
     "< grep '^OMP_6 ' data/data_shoot.txt"    u 2:7 w l  ls 8  title "OMP 6", \
     "< grep '^OMP_7 ' data/data_shoot.txt"    u 2:7 w l  ls 9  title "OMP 7", \
     "< grep '^OMP_8 ' data/data_shoot.txt"    u 2:7 w lp ls 10 title "OMP 8"

set title "Complejidad Algorítmica (Log-Log)"
set logscale xy
replot
unset multiplot

# --- 4. MÉTODO SINC-DVR ---
set output "imag/sinc_full_scaling.png"
set multiplot layout 2,1 title "{/:Bold Análisis de Escalabilidad: Método Sinc-DVR}" font ",14"
set title "Tiempo de Ejecución vs N"
set xlabel "N (Puntos / Dimensión)"
set ylabel "Tiempo (s)"
unset logscale
plot "< grep '^SERIAL' data/data_sinc.txt"    u 2:7 w lp ls 1  title "Serial", \
     "< grep '^OPTIMIZED' data/data_sinc.txt" u 2:7 w lp ls 2  title "Optimizado", \
     "< grep '^OMP_1 ' data/data_sinc.txt"    u 2:7 w l  ls 3  title "OMP 1", \
     "< grep '^OMP_2 ' data/data_sinc.txt"    u 2:7 w l  ls 4  title "OMP 2", \
     "< grep '^OMP_3 ' data/data_sinc.txt"    u 2:7 w l  ls 5  title "OMP 3", \
     "< alias_4='OMP_4 ' grep \"^$alias_4\" data/data_sinc.txt" u 2:7 w l ls 6 title "OMP 4", \
     "< grep '^OMP_5 ' data/data_sinc.txt"    u 2:7 w l  ls 7  title "OMP 5", \
     "< grep '^OMP_6 ' data/data_sinc.txt"    u 2:7 w l  ls 8  title "OMP 6", \
     "< grep '^OMP_7 ' data/data_sinc.txt"    u 2:7 w l  ls 9  title "OMP 7", \
     "< grep '^OMP_8 ' data/data_sinc.txt"    u 2:7 w lp ls 10 title "OMP 8"

set title "Complejidad Algorítmica (Log-Log)"
set logscale xy
replot
unset multiplot
EOF
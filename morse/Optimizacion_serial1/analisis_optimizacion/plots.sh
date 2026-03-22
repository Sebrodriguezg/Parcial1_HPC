#!/bin/bash

# Directorio de salida para las imágenes
IMG_DIR="graficas_finales"
DATA_DIR="data"
mkdir -p $IMG_DIR

# Lista de métodos basada en tus archivos
METHODS=("base" "fdm" "shoot" "sinc")

echo "Generando gráficas en escala lineal para análisis de HPC..."

for m in "${METHODS[@]}"; do
    gnuplot << EOF
        set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
        set output '$IMG_DIR/plot_${m}_linear.png'
        
        set title "Análisis de Optimización GCC: Método ${m^^}\n(Escala Lineal - Rendimiento de CPU)"
        set xlabel "Tamaño del problema (N)"
        set ylabel "Tiempo de ejecución (segundos)"
        set grid lc rgb '#dddddd'
        set key left top
        
        # Estilos de línea profesionales
        set style line 1 lc rgb '#d62728' lt 1 lw 2 pt 7 ps 0.8 # O0 - Rojo
        set style line 2 lc rgb '#1f77b4' lt 1 lw 2 pt 5 ps 0.8 # O1 - Azul
        set style line 3 lc rgb '#2ca02c' lt 1 lw 2 pt 9 ps 0.8 # O2 - Verde
        set style line 4 lc rgb '#9467bd' lt 1 lw 2 pt 13 ps 0.8 # O3 - Morado

        plot '$DATA_DIR/${m}_O0.dat' u 1:2 w lp ls 1 title "Sin optimizar (-O0)", \
             '$DATA_DIR/${m}_O1.dat' u 1:2 w lp ls 2 title "Básica (-O1)", \
             '$DATA_DIR/${m}_O2.dat' u 1:2 w lp ls 3 title "Media (-O2)", \
             '$DATA_DIR/${m}_O3.dat' u 1:2 w lp ls 4 title "Agresiva (-O3)"
EOF
    echo "  [OK] Gráfica para $m generada."
done

echo "-------------------------------------------------------"
echo "Proceso terminado. Revisa la carpeta: $IMG_DIR"
#!/bin/bash
# Uso: ./benchmark_paralelo.sh
N_VALUE=500
DATA_FILE="tiempos_benchmark.dat"
TEMP_DIR="tmp_bench"

mkdir -p $TEMP_DIR
echo "Lanzando benchmarks en paralelo para N=$N_VALUE..."

# Lanzar cada combinación método/opt en paralelo
for method in morse_base morse_fdm morse_sinc morse_shoot; do
    for opt in 0 1 2 3; do
        bin="./${method}_O${opt}"
        if [ -f "$bin" ]; then
            (
                # Medición de tiempo (promedio de 3 ejecuciones para consistencia)
                t_total=0
                for i in {1..3}; do
                    t=$( { /usr/bin/time -f "%U" $bin $N_VALUE > /dev/null; } 2>&1 )
                    t_total=$(echo "$t_total + $t" | bc)
                done
                avg=$(echo "scale=5; $t_total / 3" | bc)
                echo "$method $opt $avg" > "$TEMP_DIR/${method}_O${opt}.tmp"
            ) &
        fi
    done
done

# Esperar a que todos los procesos terminen
wait
echo "Benchmarks completados. Procesando datos..."

# Ensamblar el archivo .dat final
echo "# Metodo O0 O1 O2 O3" > $DATA_FILE
for method in morse_base morse_fdm morse_sinc morse_shoot; do
    t0=$(cat "$TEMP_DIR/${method}_O0.tmp" 2>/dev/null | awk '{print $3}')
    t1=$(cat "$TEMP_DIR/${method}_O1.tmp" 2>/dev/null | awk '{print $3}')
    t2=$(cat "$TEMP_DIR/${method}_O2.tmp" 2>/dev/null | awk '{print $3}')
    t3=$(cat "$TEMP_DIR/${method}_O3.tmp" 2>/dev/null | awk '{print $3}')
    echo "$method ${t0:-0} ${t1:-0} ${t2:-0} ${t3:-0}" >> $DATA_FILE
done

rm -rf $TEMP_DIR

# Generar gráfica con Gnuplot
cat << 'GEOF' > plot_benchmark.gp
set terminal pngcairo enhanced font "arial,12" size 800,600
set output 'grafica_tiempos.png'
set title "Análisis de Desempeño: Tiempo de CPU vs Nivel de Optimización\n(N = 500)"
set ylabel "Tiempo de CPU (segundos)"
set xlabel "Método Numérico"
set style data histogram
set style histogram clustered gap 1
set style fill solid 0.6 border -1
set boxwidth 0.9
set grid ytics
set key outside right top
plot 'tiempos_benchmark.dat' using 2:xtic(1) title '-O0', \
     '' using 3 title '-O1', \
     '' using 4 title '-O2', \
     '' using 5 title '-O3'
GEOF

gnuplot plot_benchmark.gp
echo "Archivo '$DATA_FILE' y gráfica 'grafica_tiempos.png' generados."

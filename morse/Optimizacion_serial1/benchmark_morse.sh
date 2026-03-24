#!/bin/bash
# Uso: ./benchmark_morse.sh <valor_de_N>
N_VALUE=${1:-1000}
DATA_FILE="tiempos_benchmark.dat"

echo "# Metodo O0 O1 O2 O3" > $DATA_FILE

for method in morse_base morse_fdm morse_sinc morse_shoot; do
    echo -n "$method " >> $DATA_FILE
    for opt in 0 1 2 3; do
        bin="./${method}_O${opt}"
        if [ -f "$bin" ]; then
            echo "Midiendo $bin para N=$N_VALUE..."
            # Medimos el tiempo real (user time) promediando 3 corridas
            total_time=0
            for i in {1..3}; do
                # Extraemos el tiempo de CPU usado por el proceso
                t=$( { /usr/bin/time -f "%U" $bin $N_VALUE > /dev/null; } 2>&1 )
                total_time=$(echo "$total_time + $t" | bc)
            done
            avg_time=$(echo "scale=5; $total_time / 3" | bc)
            echo -n "$avg_time " >> $DATA_FILE
        else
            echo -n "0 " >> $DATA_FILE
        fi
    done
    echo "" >> $DATA_FILE
done

echo "Resultados guardados en $DATA_FILE"

# Generar script de Gnuplot automáticamente
cat << 'GEOF' > plot_benchmark.gp
set terminal pngcairo enhanced font "arial,12" size 800,600
set output 'grafica_tiempos.png'
set title "Análisis de Desempeño: Tiempo de Ejecución vs Optimización GCC\n(N = '"$N_VALUE"')"
set xlabel "Método Numérico"
set ylabel "Tiempo de CPU (segundos)"
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
echo "Gráfica 'grafica_tiempos.png' generada con éxito."

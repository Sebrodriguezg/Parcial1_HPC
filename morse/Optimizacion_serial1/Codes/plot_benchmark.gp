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

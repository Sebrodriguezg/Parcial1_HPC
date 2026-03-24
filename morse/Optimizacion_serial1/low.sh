#!/bin/bash
#=======================================================================
# BENCHMARK LOCAL: COMPARATIVA DE OPTIMIZACIÓN GCC
#=======================================================================

OUT_DIR="resultados_benchmark"
mkdir -p $OUT_DIR/datos $OUT_DIR/reportes

# Lista de métodos (He dejado solo shooting por si no tienes lapacke aún)
# Puedes añadir "harmonic" "fdm" "sinc" si ya instalaste las librerías.
METHODS=("shooting") 
FLAGS=("-O0" "-O1" "-O2" "-O3")

echo "--- INICIANDO PRUEBA DE RENDIMIENTO LOCAL ---"

for m in "${METHODS[@]}"; do
    SOURCE="morse_$m.c"
    echo "Procesando: $SOURCE"
    
    for opt in "${FLAGS[@]}"; do
        # Nombres de ejecutables descriptivos
        EXE="bin_${m}_${opt:1}"
        DATA="$OUT_DIR/datos/${m}_${opt:1}.dat"
        LOG="$OUT_DIR/reportes/compilacion_${m}_${opt:1}.txt"
        
        echo "  - Compilando con bandera $opt..."
        
        # Compilación: -lm siempre al final
        if [[ "$m" == "shooting" ]]; then
            gcc $opt -march=native $SOURCE -lm -fopt-info-vec-optimized -o $EXE 2> $LOG
        else
            gcc $opt -march=native $SOURCE -llapacke -llapack -lblas -lm -fopt-info-vec-optimized -o $EXE 2> $LOG
        fi

        # Si la compilación falla, saltar
        if [ ! -f $EXE ]; then
            echo "    [!] Error al compilar $opt. Revisa $LOG"
            continue
        fi

        echo "# N_PASOS TIEMPO_CPU E0" > $DATA
        
        # Rango ligero: 5 iteraciones para ver la tendencia
        for n in $(seq 20000 20000 100000); do
            # Ejecutar y capturar salida
            RES=$(./$EXE $n)
            # El formato de salida del C debe ser: N E0 E1 E2 E3 TIEMPO
            # Extraemos N($1), TIEMPO($6) y E0($2)
            echo "$RES" | awk '{print $1, $6, $2}' >> $DATA
            echo "    Ejecución N=$n completada."
        done
    done
done

# 3. GENERAR GRÁFICA EN ESCALA NORMAL
echo "--- Generando Gráfica Lineal ---"
gnuplot << EOF
    set terminal pngcairo size 900,650 enhanced font 'Segoe UI,10'
    set output '$OUT_DIR/grafica_normal_shooting.png'
    set title "Impacto Real de la Optimización GCC (Escala Lineal)\nMétodo: Shooting (RK4)"
    set xlabel "Número de Pasos (N)"
    set ylabel "Tiempo de Ejecución (segundos)"
    set grid
    set key left top
    # Estilo de líneas
    set style line 1 lc rgb '#E41A1C' pt 7 ps 1.5 lw 2 # O0
    set style line 2 lc rgb '#377EB8' pt 5 ps 1.5 lw 2 # O1
    set style line 3 lc rgb '#4DAF4A' pt 9 ps 1.5 lw 2 # O2
    set style line 4 lc rgb '#984EA3' pt 13 ps 1.5 lw 2 # O3

    plot "$OUT_DIR/datos/shooting_O0.dat" u 1:2 w lp ls 1 title "Sin Optimizar (-O0)", \
         "$OUT_DIR/datos/shooting_O1.dat" u 1:2 w lp ls 2 title "Optimización Básica (-O1)", \
         "$OUT_DIR/datos/shooting_O2.dat" u 1:2 w lp ls 3 title "Optimización Media (-O2)", \
         "$OUT_DIR/datos/shooting_O3.dat" u 1:2 w lp ls 4 title "Optimización Agresiva (-O3)"
EOF

echo "Benchmark finalizado con éxito."
echo "Gráfica generada en: $OUT_DIR/grafica_normal_shooting.png"ch
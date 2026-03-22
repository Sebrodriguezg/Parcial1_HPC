#!/bin/bash
#=======================================================================
# BENCHMARK FINAL: ESTUDIO DE BANDERAS GCC EN C
#=======================================================================

OUT_DIR="analisis_optimizacion"
mkdir -p $OUT_DIR/data $OUT_DIR/logs

METHODS=("base" "fdm" "shoot" "sinc")
FLAGS=("-O0" "-O1" "-O2" "-O3")

# Definir rangos de N según el método
get_range() {
    case $1 in
        "base") echo "20 20 800" ;;
        "sinc") echo "20 20 800" ;;
        "fdm")  echo "200 200 4000" ;;
        "shoot") echo "1000 5000 100000" ;;
    esac
}

echo "[1/2] Iniciando Compilación y Barrido..."

for m in "${METHODS[@]}"; do
    SOURCE="morse_$m.c"
    echo "Procesando Método: $m"
    
    for opt in "${FLAGS[@]}"; do
        EXE="exe_${m}_${opt:1}"
        DATA="$OUT_DIR/data/${m}_${opt:1}.dat"
        LOG="$OUT_DIR/logs/${m}_${opt:1}.log"
        
        # Compilación con reporte de vectorización
        # Si es shoot no necesita lapacke
        if [ "$m" == "shoot" ]; then
            gcc $opt -march=native $SOURCE -lm -fopt-info-vec -o $EXE 2> $LOG
        else
            gcc $opt -march=native $SOURCE -llapacke -llapack -lblas -lm -fopt-info-vec -o $EXE 2> $LOG
        fi

        echo "# N Tiempo E0" > $DATA
        RANGE=$(get_range $m)
        for n in $(seq $RANGE); do
            RES=$(./$EXE $n)
            # Extraer N(1), Tiempo(6) y E0(2)
            echo "$RES" | awk '{print $1, $6, $2}' >> $DATA
        done
        echo "  - Flag $opt completado."
    done
done

# 4. GENERAR 4 GRÁFICAS (Una por método)
echo "[2/2] Generando gráficas comparativas..."
for m in "${METHODS[@]}"; do
    cat << EOF > plot_temp.plt
set terminal pngcairo size 800,600 enhanced font 'Arial,10'
set output '$OUT_DIR/plot_${m}_flags.png'
set title "Impacto de Optimización GCC: Método ${m^^}"
set xlabel "N (Tamaño del problema)"
set ylabel "Tiempo de CPU (s)"
set grid
set logscale y
plot "$OUT_DIR/data/${m}_O0.dat" u 1:2 w lp title "O0 (Sin opt)", \\
     "$OUT_DIR/data/${m}_O1.dat" u 1:2 w lp title "O1", \\
     "$OUT_DIR/data/${m}_O2.dat" u 1:2 w lp title "O2", \\
     "$OUT_DIR/data/${m}_O3.dat" u 1:2 w lp title "O3"
EOF
    gnuplot plot_temp.plt
done
rm plot_temp.plt

echo "PROCESO TERMINADO. Resultados en $OUT_DIR"
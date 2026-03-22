#!/bin/bash
#=======================================================================
# HPC FULL REPORT: BARRIDO + 4 GRÁFICAS DE DOBLE PANEL
#=======================================================================

# Referencias Analíticas
E0_REF="1.086783988750"
E1_REF="3.072851966250"
E2_REF="4.808919943749"
E3_REF="6.294987921249"

OUT_DIR="resultados_finales"
mkdir -p $OUT_DIR

# 1. COMPILACIÓN
echo "[1/3] Compilando ejecutables..."
gfortran -ffixed-form -O3 -fopenmp morse.f eigen.f -llapack -lblas -o exe_base
gfortran -ffixed-form -O3 -fopenmp morse_fdm.f eigen.f -llapack -lblas -o exe_fdm
gfortran -ffixed-form -O3 -fopenmp morse_shoot.f -o exe_shoot
gfortran -ffixed-form -O3 -fopenmp morse_sinc.f eigen.f -llapack -lblas -o exe_sinc

# 2. RUTINA DE BARRIDO
run_bench() {
    local NAME=$1; local EXE=$2; local N_MIN=$3; local N_MAX=$4; local STEP=$5
    local FILE="$OUT_DIR/$NAME.dat"
    echo "# N(1) T(2) E0(3) E1(4) E2(5) E3(6)" > $FILE
    echo "Corriendo $NAME..."

    for n in $(seq $N_MIN $STEP $N_MAX); do
        (
            LINE=$(./$EXE $n | tail -n 1)
            if [ ! -z "$LINE" ]; then
                # Reordenar: N(1) T(6) E0(2) E1(3) E2(4) E3(5)
                VALS=$(echo "$LINE" | sed 's/[Dd]/e/g' | awk '{print $1, $6, $2, $3, $4, $5}')
                echo "$VALS" >> "$FILE.tmp"
            fi
        ) &
        if [[ $(jobs -r | wc -l) -ge 64 ]]; then wait -n; fi
    done
    wait
    sort -n "$FILE.tmp" >> $FILE
    rm -f "$FILE.tmp"
}

# Ejecución de los 4 métodos
run_bench "BASE_ARM" "exe_base"  20   1000  20
run_bench "SINC_DVR" "exe_sinc"  20   1000  20
run_bench "FDM_MAT"  "exe_fdm"   500  10000 250
run_bench "SHOOTING" "exe_shoot" 1000 100000 2500

# 3. GENERACIÓN AUTOMÁTICA DE GRÁFICAS (GNUPLOT)
echo "[2/3] Generando reportes visuales (4 imágenes)..."

cat << EOF > plot_final.plt
set terminal pngcairo size 1000,900 font 'Verdana,10' noenhanced
set grid xtics ytics lc rgb '#dddddd'

# Referencias para Gnuplot
e0 = $E0_REF; e1 = $E1_REF; e2 = $E2_REF; e3 = $E3_REF

list = "BASE_ARM SINC_DVR FDM_MAT SHOOTING"

do for [m in list] {
    set output "$OUT_DIR/".m."_report.png"
    set multiplot layout 2,1 title "Análisis de Desempeño y Convergencia: ".m
    
    # Arriba: Tiempo (Log-Log)
    set title "Costo Computacional (Escala Log-Log)"
    set ylabel "Tiempo de CPU (s)"
    set xlabel "N"
    set logscale xy
    plot "$OUT_DIR/".m.".dat" u 1:2 w linespoints lc rgb "#377EB8" pt 7 ps 0.5 title "Tiempo"

    # Abajo: Error (Lineal en Y, Log en X)
    unset logscale y
    set title "Error Absoluto por Nivel de Energía (Escala Lineal)"
    set ylabel "|E_calc - E_ref|"
    set xlabel "N"
    set autoscale y
    set key right top
    
    plot "$OUT_DIR/".m.".dat" u 1:(abs(\$3-e0)) w linespoints lc rgb "red"    title "Err E0", \\
         "$OUT_DIR/".m.".dat" u 1:(abs(\$4-e1)) w linespoints lc rgb "orange" title "Err E1", \\
         "$OUT_DIR/".m.".dat" u 1:(abs(\$5-e2)) w linespoints lc rgb "green"  title "Err E2", \\
         "$OUT_DIR/".m.".dat" u 1:(abs(\$6-e3)) w linespoints lc rgb "brown"  title "Err E3"
    
    unset multiplot
}
EOF

gnuplot plot_final.plt
rm plot_final.plt

echo "[3/3] ¡Listo! Revisa la carpeta '$OUT_DIR' para ver los .dat y los .png"
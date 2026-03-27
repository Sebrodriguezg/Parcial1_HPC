#!/bin/bash

# =================================================================
# BENCHMARK DE DINÁMICA CUÁNTICA: SERIAL VS OPTIMIZADO VS OPENMP
# =================================================================

# Directorio de salida
mkdir -p data

# Configuración de compilación
CFLAGS="-O3 -march=native -ffast-math -fopenmp"
LIBS="-llapacke -llapack -lblas -lm"

echo "==============================="
echo " 1. COMPILANDO BINARIOS"
echo "==============================="

# Compilación de todos los métodos (Asegúrate de tener los .c en la carpeta)
for method in base fdm shoot sinc
do
    echo "Compilando $method..."
    gcc $CFLAGS -o morse_${method}    morse_${method}.c    $LIBS
    gcc $CFLAGS -o morse_${method}_op morse_${method}_op.c $LIBS
    gcc $CFLAGS -o morse_${method}_omp morse_${method}_omp.c $LIBS
done

echo "==============================="
echo " 2. EJECUTANDO PRUEBAS"
echo "==============================="

# Arreglo de métodos y sus rangos de N
# Formato: "nombre:N1 N2 N3..."
methods=(
    "base:50 100 150 200 250 300 350 400"
    "fdm:100 200 300 400 500 700 1000 1500 2000"
    "shoot:100 200 300 400 500 700 1000 1500 2000"
    "sinc:50 100 150 200 250 300 400 500"
)

for entry in "${methods[@]}"
do
    IFS=':' read -r name n_values <<< "$entry"
    output="data/data_${name}.txt"
    echo "Procesando método: $name -> $output"
    
    # Limpiar archivo previo
    > "$output"
    echo "# Tipo N Hilos E0 E1 E2 E3 Tiempo(s)" >> "$output"

    for N in $n_values
    do
        echo "  Ejecutando N=$N..."

        # A. Versión Serial Pura
        res_serial=$(./morse_${name} $N)
        echo "SERIAL $res_serial" >> "$output"

        # B. Versión Optimizada (Forzar 1 hilo)
        export OMP_NUM_THREADS=1
        export OPENBLAS_NUM_THREADS=1
        export MKL_NUM_THREADS=1
        res_op=$(./morse_${name}_op $N)
        echo "OPTIMIZED $res_op" >> "$output"

        # C. Versión OpenMP (Barrido de 1 a 8 hilos)
        for T in {1..8}
        do
            # Nota: morse_X_omp recibe N y T como argumentos según tu indicación
            res_omp=$(./morse_${name}_omp $N $T)
            echo "OMP_$T $res_omp" >> "$output"
        done
        
        # Separador visual por cada bloque N en el .txt
        echo "" >> "$output"
    done
done

echo "==============================="
echo " BENCHMARK COMPLETADO"
echo "==============================="
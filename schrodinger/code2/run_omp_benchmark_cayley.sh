#!/bin/bash

SOURCE="code2-SchrEq-omp.f90"
EJECUTABLE="./cayley_omp.out"
DATOS_SALIDA="datos_omp_speedup_cayley.csv"

# Crear carpeta para los archivos .dat de OpenMP
DIR_OMP="datos_omp"
mkdir -p $DIR_OMP

BANDERA_COMPILACION="-O3 -fopenmp"

# Malla grande para que valga la pena la inicialización paralela
LOG2N=19 
N=$((2**LOG2N))
DT=0.005
NT=2000

ANCHO=2.0
MOMENTO=1.0
V0=100.0
L=40.0

HILOS=(1 2 4 8 16 24 32 40)

echo "Hilos,Log2N,N,Tiempo_Total_Segundos" > $DATOS_SALIDA
echo "=== Iniciando Benchmarking OpenMP Cayley ==="
echo "Nota: El speedup será limitado debido al algoritmo de Thomas."

gfortran $BANDERA_COMPILACION $SOURCE -o $EJECUTABLE

if [ $? -ne 0 ]; then
    echo "Fallo compilando OpenMP."
    exit 1
fi

for h in "${HILOS[@]}"; do
    export OMP_NUM_THREADS=$h
    
    # Enrutar el archivo .dat a su carpeta
    ARCHIVO_ONDAS="${DIR_OMP}/ondas_cayley_omp_hilos${h}_N${N}.dat"
    
    echo " -> Ejecutando simulación con $h hilo(s)..."
    
    START=$(date +%s.%N)
    
    $EJECUTABLE <<EOF > /dev/null
$ARCHIVO_ONDAS
$ANCHO
$MOMENTO
$V0
$LOG2N
$DT
$L
$NT
EOF
    
    END=$(date +%s.%N)
    TIEMPO_TOTAL=$(echo "$END - $START" | bc)
    
    echo "    Completado en $TIEMPO_TOTAL segundos."
    echo "$h,$LOG2N,$N,$TIEMPO_TOTAL" >> $DATOS_SALIDA
done

rm -f $EJECUTABLE
echo "=== Benchmarking finalizado. Revisa $DATOS_SALIDA ==="

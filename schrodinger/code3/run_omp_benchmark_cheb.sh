#!/bin/bash

SOURCE="cheb_omp.f90"
EJECUTABLE="./simulacion_cheb_omp.out"
DATOS_SALIDA="datos_omp_speedup_cheb.csv"

# Definición y creación de la carpeta para OpenMP
DIR_OMP="datos_cheb_omp"
mkdir -p $DIR_OMP

BANDERA_COMPILACION="-O3 -fopenmp"

# Malla grande para Alta Intensidad
LOG2N=16 
N=$((2**LOG2N))

DT=0.001
NT=2000

ANCHO=2.0
MOMENTO=1.0
V0=100.0
L=40.0
B_DUMMY=1024 # Requerido por la estructura de lectura del código

HILOS=(1 2 4 8 16 24 32 40)

echo "Hilos,Log2N,N,Tiempo_Total_Segundos" > $DATOS_SALIDA
echo "=== Iniciando Benchmarking OpenMP Chebyshev ==="

gfortran $BANDERA_COMPILACION $SOURCE -o $EJECUTABLE
if [ $? -ne 0 ]; then
    echo "Fallo compilando OpenMP."
    exit 1
fi

for h in "${HILOS[@]}"; do
    export OMP_NUM_THREADS=$h
    
    # Modificación: Se incluye el directorio en la ruta del archivo
    ARCHIVO_ONDAS="${DIR_OMP}/ondas_omp_cheb_hilos${h}.dat"
    
    echo " -> Ejecutando con $h hilo(s)... (Guardando en $DIR_OMP/)"
    START=$(date +%s.%N)
    
    $EJECUTABLE <<EOF > /dev/null
"$ARCHIVO_ONDAS"
$ANCHO
$MOMENTO
$V0
$LOG2N
$DT
$L
$NT
$B_DUMMY
EOF
    
    END=$(date +%s.%N)
    TIEMPO_TOTAL=$(echo "$END - $START" | bc)
    
    echo "    Completado en $TIEMPO_TOTAL segundos."
    echo "$h,$LOG2N,$N,$TIEMPO_TOTAL" >> $DATOS_SALIDA
done

rm -f $EJECUTABLE
echo "=== Finalizado ==="

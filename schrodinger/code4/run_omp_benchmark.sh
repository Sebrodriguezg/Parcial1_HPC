#!/bin/bash

# ====================================================================
# Nombres de archivos
# ====================================================================
SOURCE="code4-omp.f90"
EJECUTABLE="./simulacion_omp.out"
DATOS_SALIDA="datos_omp_speedup.csv"

# ====================================================================
# Creación de carpeta para las salidas .dat
# ====================================================================
DIR_OMP="datos_omp"
mkdir -p $DIR_OMP

# ====================================================================
# Parámetros FIJOS para el benchmark de escalabilidad (ALTA INTENSIDAD)
# ====================================================================
# Compilación con máxima optimización y soporte OpenMP
BANDERA_COMPILACION="-O3 -fopenmp"

# Malla grande para justificar la creación de múltiples hilos
LOG2N=19 
N=$((2**LOG2N))

# Mayor número de pasos temporales
DT=0.005
NT=5000

# Parámetros físicos
ANCHO=2.0
MOMENTO=1.0
V0=100.0
L=40.0

# ====================================================================
# Parámetro VARIABLE: Número de Hilos OpenMP
# ====================================================================
HILOS=(1 2 4 8 16 24 32 40)

# Crear encabezado del archivo CSV (Se queda en la raíz)
echo "Hilos,Log2N,N,Tiempo_Total_Segundos" > $DATOS_SALIDA

echo "=== Iniciando Benchmarking OpenMP Lanczos ==="
echo "Compilando con: $BANDERA_COMPILACION"

gfortran $BANDERA_COMPILACION $SOURCE -o $EJECUTABLE

if [ $? -ne 0 ]; then
    echo "Error crítico: Fallo compilando OpenMP. Verifica que tengas soporte (-fopenmp)."
    exit 1
fi

for h in "${HILOS[@]}"; do
    
    export OMP_NUM_THREADS=$h
    
    # Se incluye la carpeta DIR_OMP en el nombre del archivo
    ARCHIVO_ONDAS="${DIR_OMP}/ondas_omp_hilos${h}_N${N}.dat"
    
    echo "--------------------------------------------------------"
    echo " -> Ejecutando simulación con $h hilo(s)..."
    
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
EOF
    
    END=$(date +%s.%N)
    
    TIEMPO_TOTAL=$(echo "$END - $START" | bc)
    
    echo "    Completado en $TIEMPO_TOTAL segundos."
    
    echo "$h,$LOG2N,$N,$TIEMPO_TOTAL" >> $DATOS_SALIDA
    
done

echo "--------------------------------------------------------"
echo "Limpiando archivos temporales..."
rm -f $EJECUTABLE

echo "=== Benchmarking finalizado. Revisa $DATOS_SALIDA ==="
echo "=== Los archivos .dat están en la carpeta: $DIR_OMP/ ==="

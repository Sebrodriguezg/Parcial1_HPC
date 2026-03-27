#!/bin/bash

# ====================================================================
# Nombres de archivos
# ====================================================================
SOURCE="code1-SchrEq-omp.f90"
EJECUTABLE="./simulacion_omp.out"
DATOS_SALIDA="datos_omp_speedup.csv"

# ====================================================================
# Parámetros FIJOS para el benchmark de escalabilidad (ALTA INTENSIDAD)
# ====================================================================
# Compilación con máxima optimización y soporte OpenMP
BANDERA_COMPILACION="-O3 -fopenmp"

# Malla grande para justificar la creación de múltiples hilos (N = 524288)
LOG2N=19 
N=$((2**LOG2N))

# Mayor número de pasos temporales para medir un tiempo de ejecución estable
DT=0.005
NT=5000

# Parámetros físicos del paquete de ondas y el potencial
ANCHO=2.0
MOMENTO=1.0
V0=100.0
L=40.0

# ====================================================================
# Parámetro VARIABLE: Número de Hilos OpenMP
# ====================================================================
# Iteramos dejando 4 hilos libres (tienes 44 lógicos disponibles)
HILOS=(1 2 4 8 16 24 32 40)

# Crear encabezado del archivo CSV
echo "Hilos,Log2N,N,Tiempo_Total_Segundos" > $DATOS_SALIDA

echo "=== Iniciando Benchmarking OpenMP (Alta Intensidad) ==="
echo "Compilando con: $BANDERA_COMPILACION"

# Compilar el código
gfortran $BANDERA_COMPILACION $SOURCE -o $EJECUTABLE

# Verificar si la compilación fue exitosa
if [ $? -ne 0 ]; then
    echo "Error crítico: Fallo compilando OpenMP. Verifica que tengas soporte (-fopenmp)."
    exit 1
fi

for h in "${HILOS[@]}"; do
    
    # Exportamos la variable de entorno para definir el número de hilos
    export OMP_NUM_THREADS=$h
    
    # Archivo de salida temporal (usaremos /dev/null para no llenar el disco, 
    # pero enviamos el nombre por si el programa lo requiere en su lectura)
    ARCHIVO_ONDAS="ondas_omp_hilos${h}_N${N}.dat"
    
    echo "--------------------------------------------------------"
    echo " -> Ejecutando simulación con $h hilo(s)..."
    
    # Captura de tiempo inicial (Alta precisión)
    START=$(date +%s.%N)
    
    # Pasamos los datos al ejecutable por entrada estándar (Here-Doc)
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
    
    # Captura de tiempo final
    END=$(date +%s.%N)
    
    # Cálculo del tiempo usando la calculadora 'bc'
    TIEMPO_TOTAL=$(echo "$END - $START" | bc)
    
    echo "    Completado en $TIEMPO_TOTAL segundos."
    
    # Registrar en el CSV
    echo "$h,$LOG2N,$N,$TIEMPO_TOTAL" >> $DATOS_SALIDA
    
done

echo "--------------------------------------------------------"
echo "Limpiando archivos temporales..."
rm -f $EJECUTABLE

echo "=== Benchmarking finalizado. Revisa $DATOS_SALIDA ==="

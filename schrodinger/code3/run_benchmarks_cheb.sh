#!/bin/bash

# Nombres de archivos fuente adaptados a Chebyshev
SRC_ORIGINAL="cheb_base.f90"
SRC_CACHE="cheb_cache.f90"

DATOS_SALIDA="datos_tiempos_cheb.csv"

# Definición de carpetas para los archivos .dat
DIR_BASE="datos_cheb_base"
DIR_CACHE="datos_cheb_cache"

# Crear las carpetas si no existen
mkdir -p $DIR_BASE
mkdir -p $DIR_CACHE

# Arreglos de parámetros a variar para las pruebas
BANDERAS=("-O0" "-O1" "-O2" "-O3")
TALLAS_LOG2N=(11 12 13 14 15) 
VALORES_DT=(0.01 0.005 0.001)

# Tamaños de bloque (B) a evaluar. 
VALORES_B=(64 128 256 512 1024 2048)

# Parámetros físicos constantes
NT=1000
ANCHO=2.0
MOMENTO=1.0
V0=100.0
L=40.0

echo "Version_Codigo,Bandera,Log2N,N,dt,Bloque_B,Tiempo_Total_Segundos,Tiempo_Iteracion_Seg" > $DATOS_SALIDA

echo "=== Iniciando Benchmarking Chebyshev: Original vs Caché ==="

CODIGOS=("Original:$SRC_ORIGINAL" "Caché:$SRC_CACHE")

for config in "${CODIGOS[@]}"; do
    VERSION="${config%%:*}"
    FUENTE="${config##*:}"
    
    # Asignar la carpeta de salida correspondiente a la versión actual
    if [ "$VERSION" == "Original" ]; then
        DIR_SALIDA=$DIR_BASE
    else
        DIR_SALIDA=$DIR_CACHE
    fi
    
    echo "========================================================"
    echo "Evaluando versión: $VERSION (Guardando en $DIR_SALIDA/)"
    echo "========================================================"
    
    for bandera in "${BANDERAS[@]}"; do
        echo " -> Compilando con: $bandera"
        EJECUTABLE="./sim_cheb_${VERSION}.out"
        
        gfortran $bandera $FUENTE -o $EJECUTABLE
        if [ $? -ne 0 ]; then
            echo "    Error compilando. Saltando..."
            continue
        fi
        
        for log2n in "${TALLAS_LOG2N[@]}"; do
            N=$((2**log2n))
            for dt in "${VALORES_DT[@]}"; do
                
                if [ "$VERSION" == "Original" ]; then
                    ARREGLO_B=($N)
                else
                    ARREGLO_B=("${VALORES_B[@]}")
                fi
                
                for B in "${ARREGLO_B[@]}"; do
                    # Modificación: Se incluye el directorio en la ruta del archivo
                    ARCHIVO_ONDAS="${DIR_SALIDA}/out_${VERSION}_${bandera}_N${N}_B${B}.dat"
                    
                    START=$(date +%s.%N)
                    
                    # Entrada Estándar al Fortran
                    $EJECUTABLE <<EOF > /dev/null
"$ARCHIVO_ONDAS"
$ANCHO
$MOMENTO
$V0
$log2n
$dt
$L
$NT
$B
EOF
                    END=$(date +%s.%N)
                    TIEMPO_TOTAL=$(echo "$END - $START" | bc)
                    TIEMPO_ITER=$(echo "scale=6; $TIEMPO_TOTAL / $NT" | bc)
                    
                    echo "    N=$N, dt=$dt, B=$B -> $TIEMPO_TOTAL s."
                    echo "$VERSION,$bandera,$log2n,$N,$dt,$B,$TIEMPO_TOTAL,$TIEMPO_ITER" >> $DATOS_SALIDA
                done
            done
        done
        rm -f $EJECUTABLE
    done
done
echo "=== Benchmarking finalizado ==="

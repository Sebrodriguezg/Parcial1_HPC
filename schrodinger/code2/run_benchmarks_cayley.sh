#!/bin/bash

# Nombres de archivos fuente
SRC_ORIGINAL="code2-SchrEq-f90.f90"
SRC_CACHE="code2-SchrEq-f90-cache.f90"

DATOS_SALIDA="datos_tiempos_cayley.csv"

# Crear carpetas para los archivos .dat
DIR_ORIGINAL="datos_original"
DIR_CACHE="datos_cache"
mkdir -p $DIR_ORIGINAL
mkdir -p $DIR_CACHE

# Arreglos de parámetros a variar
BANDERAS=("-O0" "-O1" "-O2" "-O3")
TALLAS_LOG2N=(11 12 13 14 15) 
VALORES_DT=(0.01 0.005 0.001)

# Parámetros físicos constantes
NT=1000
ANCHO=2.0
MOMENTO=1.0
V0=100.0
L=40.0

echo "Version_Codigo,Bandera,Log2N,N,dt,Tiempo_Total_Segundos,Tiempo_Iteracion_Seg" > $DATOS_SALIDA
echo "=== Iniciando Benchmarking Cayley: Original vs Optimizado (Memoria) ==="

CODIGOS=("Original:$SRC_ORIGINAL" "Optimizado:$SRC_CACHE")

for config in "${CODIGOS[@]}"; do
    VERSION="${config%%:*}"
    FUENTE="${config##*:}"
    
    echo "========================================================"
    echo "Evaluando versión: $VERSION"
    echo "========================================================"
    
    for bandera in "${BANDERAS[@]}"; do
        echo " -> Compilando con: $bandera"
        EJECUTABLE="./cayley_${VERSION}.out"
        
        gfortran $bandera $FUENTE -o $EJECUTABLE
        
        if [ $? -ne 0 ]; then
            echo "    Error compilando. Saltando..."
            continue
        fi
        
        for log2n in "${TALLAS_LOG2N[@]}"; do
            N=$((2**log2n))
            
            for dt in "${VALORES_DT[@]}"; do
                
                # Enrutar el archivo .dat a la carpeta correspondiente
                if [ "$VERSION" == "Original" ]; then
                    ARCHIVO_ONDAS="${DIR_ORIGINAL}/ondas_${VERSION}_${bandera}_N${N}_dt${dt}.dat"
                else
                    ARCHIVO_ONDAS="${DIR_CACHE}/ondas_${VERSION}_${bandera}_N${N}_dt${dt}.dat"
                fi
                
                START=$(date +%s.%N)
                
                $EJECUTABLE <<EOF > /dev/null
$ARCHIVO_ONDAS
$ANCHO
$MOMENTO
$V0
$log2n
$dt
$L
$NT
EOF
                END=$(date +%s.%N)
                
                TIEMPO_TOTAL=$(echo "$END - $START" | bc)
                TIEMPO_ITER=$(echo "scale=6; $TIEMPO_TOTAL / $NT" | bc)
                
                echo "    N=$N, dt=$dt completado en $TIEMPO_TOTAL s."
                echo "$VERSION,$bandera,$log2n,$N,$dt,$TIEMPO_TOTAL,$TIEMPO_ITER" >> $DATOS_SALIDA
                
            done
        done
        rm -f $EJECUTABLE
    done
done

echo "=== Benchmarking finalizado. Revisa $DATOS_SALIDA ==="

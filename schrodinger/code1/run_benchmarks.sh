#!/bin/bash

# Nombres de archivos fuente
SRC_ORIGINAL="code1-SchrEq-f90.f90"
SRC_CACHE="code1-SchrEq-f90-cache.f90"

DATOS_SALIDA="datos_tiempos.csv"

# Arreglos de parámetros a variar para las pruebas
BANDERAS=("-O0" "-O1" "-O2" "-O3")
TALLAS_LOG2N=(11 12 13 14 15) 
VALORES_DT=(0.01 0.005 0.001 0.0005)

# Tamaños de bloque (B) a evaluar. 
VALORES_B=(64 128 256 512 1024 2048 4096 8192 16384 32768)
# Parámetros físicos constantes
NT=1000
ANCHO=2.0
MOMENTO=1.0
V0=100.0
L=40.0

# Crear encabezado del archivo CSV
echo "Version_Codigo,Bandera,Log2N,N,dt,Bloque_B,Tiempo_Total_Segundos,Tiempo_Iteracion_Seg" > $DATOS_SALIDA

echo "=== Iniciando Benchmarking: Original vs Optimizado ==="

# Definimos un arreglo con los códigos a evaluar
CODIGOS=("Original:$SRC_ORIGINAL" "Optimizado:$SRC_CACHE")

for config in "${CODIGOS[@]}"; do
    VERSION="${config%%:*}"
    FUENTE="${config##*:}"
    
    echo "========================================================"
    echo "Evaluando versión: $VERSION"
    echo "========================================================"
    
    for bandera in "${BANDERAS[@]}"; do
        echo " -> Compilando con: $bandera"
        EJECUTABLE="./simulacion_${VERSION}.out"
        
        gfortran $bandera $FUENTE -o $EJECUTABLE
        
        if [ $? -ne 0 ]; then
            echo "    Error compilando. Saltando..."
            continue
        fi
        
        for log2n in "${TALLAS_LOG2N[@]}"; do
            N=$((2**log2n))
            
            for dt in "${VALORES_DT[@]}"; do
                
                # Definir arreglo B dependiendo de la versión
                if [ "$VERSION" == "Original" ]; then
                    ARREGLO_B=($N)
                else
                    ARREGLO_B=("${VALORES_B[@]}")
                fi
                
                for B in "${ARREGLO_B[@]}"; do
                
                    ARCHIVO_ONDAS="ondas_${VERSION}_${bandera}_N${N}_dt${dt}_B${B}.dat"
                    
                    START=$(date +%s.%N)
                    
                    # Usamos /dev/null porque solo nos importan los tiempos y un archivo .dat representativo
                    # Si no quieres guardar NINGUN .dat para no llenar el disco, cambia $ARCHIVO_ONDAS por /dev/null aquí abajo
                    $EJECUTABLE <<EOF > /dev/null
$ARCHIVO_ONDAS
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
                    
                    echo "    N=$N, dt=$dt, B=$B completado en $TIEMPO_TOTAL s."
                    
                    echo "$VERSION,$bandera,$log2n,$N,$dt,$B,$TIEMPO_TOTAL,$TIEMPO_ITER" >> $DATOS_SALIDA
                
                done
            done
        done
        rm -f $EJECUTABLE
    done
done

echo "========================================================"
echo "=== Benchmarking finalizado. Revisa $DATOS_SALIDA ==="

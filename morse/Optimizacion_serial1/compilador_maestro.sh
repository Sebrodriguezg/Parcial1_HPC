#!/bin/bash
OUTPUT_FILE="analisis_compilacion_morse.md"
echo "# Reporte Técnico: Análisis de Optimización GCC" > $OUTPUT_FILE
echo "## Potencial de Morse - Estudio de Métodos Numéricos" >> $OUTPUT_FILE
echo "Fecha: $(date)" >> $OUTPUT_FILE

LIBS="-llapacke -llapack -lblas -lm"

for file in morse_base.c morse_fdm.c morse_sinc.c morse_shoot.c; do
    [ -f "$file" ] || continue
    method_name="${file%.*}"
    echo "Procesando $method_name..."
    echo "## Análisis del Método: $method_name" >> $OUTPUT_FILE
    
    for opt in 0 1 2 3; do
        bin_name="${method_name}_O${opt}"
        asm_name="${bin_name}.s"
        echo "### Nivel de Optimización -O$opt" >> $OUTPUT_FILE
        echo "\`\`\`text" >> $OUTPUT_FILE
        
        # Compilación con reporte de optimización detallado
        gcc -O$opt "$file" -o "$bin_name" $LIBS -fopt-info-optimized 2>> $OUTPUT_FILE
        # Generación de ensamblador con verbosidad
        gcc -O$opt -S "$file" -fverbose-asm -o "$asm_name" $LIBS 2>> /dev/null
        
        if [ -f "$bin_name" ]; then
            echo -n "Tamaño del segmento de texto (bytes): " >> $OUTPUT_FILE
            size "$bin_name" | awk 'NR==2 {print $1}' >> $OUTPUT_FILE
            echo -n "Conteo de instrucciones de salto (Jump/Branch): " >> $OUTPUT_FILE
            grep -E "jmp|je|jne|jg|jl|call" "$asm_name" | wc -l >> $OUTPUT_FILE
            echo -n "Uso de instrucciones vectoriales (SIMD): " >> $OUTPUT_FILE
            if grep -qE "xmm|ymm|zmm" "$asm_name"; then echo "SÍ (Detectado)" >> $OUTPUT_FILE; else echo "NO" >> $OUTPUT_FILE; fi
        else
            echo "ERROR: Fallo de compilación. Revisa dependencias de LAPACK." >> $OUTPUT_FILE
        fi
        echo -e "\`\`\`\n" >> $OUTPUT_FILE
    done
    echo "---" >> $OUTPUT_FILE
done
echo "Proceso completado. Revisa '$OUTPUT_FILE'."

# Reporte Técnico: Análisis de Optimización GCC
## Potencial de Morse - Estudio de Métodos Numéricos
Fecha: Mon Mar 23 19:13:23 -05 2026
## Análisis del Método: morse_base
### Nivel de Optimización -O0
```text
Tamaño del segmento de texto (bytes): 4636
Conteo de instrucciones de salto (Jump/Branch): 52
Uso de instrucciones vectoriales (SIMD): SÍ (Detectado)
```

### Nivel de Optimización -O1
```text
morse_base.c:88:5: optimized:   Inlining printf/16 into main/41 (always_inline).
morse_base.c:21:13: optimized:   Inlining atoi/24 into main/41 (always_inline).
morse_base.c:17:9: optimized:   Inlining printf/16 into main/41 (always_inline).
Tamaño del segmento de texto (bytes): 4178
Conteo de instrucciones de salto (Jump/Branch): 54
Uso de instrucciones vectoriales (SIMD): SÍ (Detectado)
```

### Nivel de Optimización -O2
```text
morse_base.c:88:5: optimized:   Inlining printf/16 into main/41 (always_inline).
morse_base.c:21:13: optimized:   Inlining atoi/24 into main/41 (always_inline).
morse_base.c:17:9: optimized:   Inlining printf/16 into main/41 (always_inline).
morse_base.c:69:40: optimized:  Inlined v_func/52 into main/41 which now has time 21306.570953 and size 216, net change of +4.
morse_base.c:48:19: optimized: Loop 2 distributed: split to 0 loops and 1 library calls.
morse_base.c:77:23: optimized: loop vectorized using 16 byte vectors
morse_base.c:77:23: optimized: loop turned into non-loop; it never loops
Tamaño del segmento de texto (bytes): 4405
Conteo de instrucciones de salto (Jump/Branch): 68
Uso de instrucciones vectoriales (SIMD): SÍ (Detectado)
```

### Nivel de Optimización -O3
```text
morse_base.c:88:5: optimized:   Inlining printf/16 into main/41 (always_inline).
morse_base.c:21:13: optimized:   Inlining atoi/24 into main/41 (always_inline).
morse_base.c:17:9: optimized:   Inlining printf/16 into main/41 (always_inline).
morse_base.c:69:40: optimized:  Inlining v_func/40 into main/41.
morse_base.c:66:27: optimized: loop split
morse_base.c:48:19: optimized: Loop 2 distributed: split to 0 loops and 1 library calls.
morse_base.c:77:23: optimized: loop vectorized using 16 byte vectors
morse_base.c:57:31: optimized: loop vectorized using 16 byte vectors
morse_base.c:77:23: optimized: loop turned into non-loop; it never loops
morse_base.c:57:31: optimized: loop turned into non-loop; it never loops
Tamaño del segmento de texto (bytes): 4729
Conteo de instrucciones de salto (Jump/Branch): 73
Uso de instrucciones vectoriales (SIMD): SÍ (Detectado)
```

---
## Análisis del Método: morse_fdm
### Nivel de Optimización -O0
```text
morse_fdm.c:57:9: optimized: simplified fprintf to __builtin_fputs
morse_fdm.c:57:9: optimized: simplified __builtin_fputs to __builtin_fwrite
Tamaño del segmento de texto (bytes): 3771
Conteo de instrucciones de salto (Jump/Branch): 23
Uso de instrucciones vectoriales (SIMD): SÍ (Detectado)
```

### Nivel de Optimización -O1
```text
morse_fdm.c:62:5: optimized:   Inlining printf/16 into main/40 (always_inline).
morse_fdm.c:57:9: optimized:   Inlining fprintf/15 into main/40 (always_inline).
morse_fdm.c:13:13: optimized:   Inlining atoi/24 into main/40 (always_inline).
morse_fdm.c:9:9: optimized:   Inlining printf/16 into main/40 (always_inline).
/usr/include/x86_64-linux-gnu/bits/stdio2.h:111:10: optimized: simplified __fprintf_chk to __builtin_fputs
/usr/include/x86_64-linux-gnu/bits/stdio2.h:111:10: optimized: simplified __builtin_fputs to __builtin_fwrite
Tamaño del segmento de texto (bytes): 3433
Conteo de instrucciones de salto (Jump/Branch): 24
Uso de instrucciones vectoriales (SIMD): SÍ (Detectado)
```

### Nivel de Optimización -O2
```text
morse_fdm.c:62:5: optimized:   Inlining printf/16 into main/40 (always_inline).
morse_fdm.c:57:9: optimized:   Inlining fprintf/15 into main/40 (always_inline).
morse_fdm.c:13:13: optimized:   Inlining atoi/24 into main/40 (always_inline).
morse_fdm.c:9:9: optimized:   Inlining printf/16 into main/40 (always_inline).
/usr/include/x86_64-linux-gnu/bits/stdio2.h:111:10: optimized: simplified __fprintf_chk to __builtin_fputs
/usr/include/x86_64-linux-gnu/bits/stdio2.h:111:10: optimized: simplified __builtin_fputs to __builtin_fwrite
Tamaño del segmento de texto (bytes): 3419
Conteo de instrucciones de salto (Jump/Branch): 24
Uso de instrucciones vectoriales (SIMD): SÍ (Detectado)
```

### Nivel de Optimización -O3
```text
morse_fdm.c:62:5: optimized:   Inlining printf/16 into main/40 (always_inline).
morse_fdm.c:57:9: optimized:   Inlining fprintf/15 into main/40 (always_inline).
morse_fdm.c:13:13: optimized:   Inlining atoi/24 into main/40 (always_inline).
morse_fdm.c:9:9: optimized:   Inlining printf/16 into main/40 (always_inline).
/usr/include/x86_64-linux-gnu/bits/stdio2.h:111:10: optimized: simplified __fprintf_chk to __builtin_fputs
/usr/include/x86_64-linux-gnu/bits/stdio2.h:111:10: optimized: simplified __builtin_fputs to __builtin_fwrite
morse_fdm.c:42:12: optimized: loop split
Tamaño del segmento de texto (bytes): 3627
Conteo de instrucciones de salto (Jump/Branch): 27
Uso de instrucciones vectoriales (SIMD): SÍ (Detectado)
```

---
## Análisis del Método: morse_sinc
### Nivel de Optimización -O0
```text
Tamaño del segmento de texto (bytes): 3626
Conteo de instrucciones de salto (Jump/Branch): 27
Uso de instrucciones vectoriales (SIMD): SÍ (Detectado)
```

### Nivel de Optimización -O1
```text
morse_sinc.c:62:5: optimized:   Inlining printf/16 into main/40 (always_inline).
morse_sinc.c:17:13: optimized:   Inlining atoi/24 into main/40 (always_inline).
morse_sinc.c:13:9: optimized:   Inlining printf/16 into main/40 (always_inline).
Tamaño del segmento de texto (bytes): 3253
Conteo de instrucciones de salto (Jump/Branch): 27
Uso de instrucciones vectoriales (SIMD): SÍ (Detectado)
```

### Nivel de Optimización -O2
```text
morse_sinc.c:62:5: optimized:   Inlining printf/16 into main/40 (always_inline).
morse_sinc.c:17:13: optimized:   Inlining atoi/24 into main/40 (always_inline).
morse_sinc.c:13:9: optimized:   Inlining printf/16 into main/40 (always_inline).
morse_sinc.c:43:30: optimized: sinking common stores to *_118
Tamaño del segmento de texto (bytes): 3245
Conteo de instrucciones de salto (Jump/Branch): 27
Uso de instrucciones vectoriales (SIMD): SÍ (Detectado)
```

### Nivel de Optimización -O3
```text
morse_sinc.c:62:5: optimized:   Inlining printf/16 into main/40 (always_inline).
morse_sinc.c:17:13: optimized:   Inlining atoi/24 into main/40 (always_inline).
morse_sinc.c:13:9: optimized:   Inlining printf/16 into main/40 (always_inline).
morse_sinc.c:43:30: optimized: sinking common stores to *_128
Tamaño del segmento de texto (bytes): 3245
Conteo de instrucciones de salto (Jump/Branch): 27
Uso de instrucciones vectoriales (SIMD): SÍ (Detectado)
```

---
## Análisis del Método: morse_shoot
### Nivel de Optimización -O0
```text
Tamaño del segmento de texto (bytes): 4300
Conteo de instrucciones de salto (Jump/Branch): 24
Uso de instrucciones vectoriales (SIMD): SÍ (Detectado)
```

### Nivel de Optimización -O1
```text
morse_shoot.c:31:29: optimized:  Inlining v_morse/40 into fun_wave/41.
morse_shoot.c:23:29: optimized:  Inlining v_morse/40 into fun_wave/41.
morse_shoot.c:20:33: optimized:  Inlining v_morse/40 into fun_wave/41.
morse_shoot.c:98:5: optimized:   Inlining printf/16 into main/42 (always_inline).
morse_shoot.c:53:18: optimized:   Inlining atoi/24 into main/42 (always_inline).
morse_shoot.c:49:9: optimized:   Inlining printf/16 into main/42 (always_inline).
Tamaño del segmento de texto (bytes): 3665
Conteo de instrucciones de salto (Jump/Branch): 24
Uso de instrucciones vectoriales (SIMD): SÍ (Detectado)
```

### Nivel de Optimización -O2
```text
morse_shoot.c:31:29: optimized:  Inlining v_morse/40 into fun_wave/41.
morse_shoot.c:23:29: optimized:  Inlining v_morse/40 into fun_wave/41.
morse_shoot.c:20:33: optimized:  Inlining v_morse/40 into fun_wave/41.
morse_shoot.c:98:5: optimized:   Inlining printf/16 into main/42 (always_inline).
morse_shoot.c:53:18: optimized:   Inlining atoi/24 into main/42 (always_inline).
morse_shoot.c:49:9: optimized:   Inlining printf/16 into main/42 (always_inline).
Tamaño del segmento de texto (bytes): 3700
Conteo de instrucciones de salto (Jump/Branch): 22
Uso de instrucciones vectoriales (SIMD): SÍ (Detectado)
```

### Nivel de Optimización -O3
```text
morse_shoot.c:31:29: optimized:  Inlining v_morse/40 into fun_wave/41.
morse_shoot.c:23:29: optimized:  Inlining v_morse/40 into fun_wave/41.
morse_shoot.c:20:33: optimized:  Inlining v_morse/40 into fun_wave/41.
morse_shoot.c:98:5: optimized:   Inlining printf/16 into main/42 (always_inline).
morse_shoot.c:53:18: optimized:   Inlining atoi/24 into main/42 (always_inline).
morse_shoot.c:49:9: optimized:   Inlining printf/16 into main/42 (always_inline).
Tamaño del segmento de texto (bytes): 4328
Conteo de instrucciones de salto (Jump/Branch): 27
Uso de instrucciones vectoriales (SIMD): SÍ (Detectado)
```

---

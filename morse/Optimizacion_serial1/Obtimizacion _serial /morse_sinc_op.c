#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <lapacke.h>

/**
 * COMPILACIÓN:
 * gcc -O3 -march=native -ffast-math optimized_sinc_dvr.c -o optimized_sinc_dvr -llapacke -llapack -lblas -lm
 * * EJECUCIÓN SERIAL PURA:
 * export OPENBLAS_NUM_THREADS=1
 * export MKL_NUM_THREADS=1
 */

#ifndef M_PI
    #define M_PI 3.14159265358979323846
#endif

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Uso: %s <N>\n", argv[0]);
        return 1;
    }

    const int n = atoi(argv[1]);
    const size_t n2 = (size_t)n * n;

    /* Parámetros del Potencial */
    const double D_POT = 10.0;
    const double ALPHA = 0.5;
    const double XMIN  = -3.0;
    const double XMAX  = 20.0;
    const double dx    = (XMAX - XMIN) / (double)n;
    const double dx2_inv = 1.0 / (dx * dx);

    /* Memoria alineada para facilitar vectorización AVX/SIMD */
    double *restrict H = (double *)aligned_alloc(64, n2 * sizeof(double));
    double *restrict E = (double *)aligned_alloc(64, n * sizeof(double));

    if (!H || !E) return 1;

    /* Inicialización rápida de la matriz */
    for (size_t i = 0; i < n2; i++) H[i] = 0.0;

    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);

    /* 2. CONSTRUCCIÓN OPTIMIZADA DEL HAMILTONIANO SINC-DVR */
    /* Estrategia HPC: 
       - Solo calculamos el triángulo superior ('U') para LAPACK.
       - Eliminamos 'if' dentro del bucle interno.
       - Sustituimos pow(x, 2) y el operador % por lógica de signos. */
    
    const double diag_kin = (M_PI * M_PI) / 6.0 * dx2_inv;

    for (int i = 0; i < n; i++) {
        const double x_i = XMIN + (double)(i + 1) * dx;
        const double exp_term = exp(-ALPHA * x_i);
        const double bracket = 1.0 - exp_term;
        const double v_i = D_POT * (bracket * bracket);

        /* Diagonal: T_ii + V_ii */
        H[i * n + i] = diag_kin + v_i;

        /* Fuera de diagonal: Solo el triángulo superior j > i */
        for (int j = i + 1; j < n; j++) {
            const int diff = i - j; // i-j siempre será negativo aquí
            const double diff2_inv = 1.0 / (double)(diff * diff);
            
            /* Lógica de signo sin usar el operador módulo % */
            /* (-1)^(i-j) es 1 si (i-j) es par, -1 si es impar */
            const double sign = ( (i - j) & 1 ) ? -1.0 : 1.0;
            
            H[i * n + j] = (sign * dx2_inv) * diff2_inv;
        }
    }

    /* 3. DIAGONALIZACIÓN (Densa O(N^3)) */
    /* LAPACK dsyev con 'U' solo lee el triángulo superior calculado */
    int info = LAPACKE_dsyev(LAPACK_ROW_MAJOR, 'V', 'U', n, H, n, E);

    clock_gettime(CLOCK_MONOTONIC, &end);
    double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;

    if (info > 0) {
        free(H); free(E);
        return 1;
    }

    /* 4. SALIDA ESTANDARIZADA */
    printf("%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n", 
            n, E[0], E[1], E[2], E[3], time_used);

    free(H); free(E);
    return 0;
}
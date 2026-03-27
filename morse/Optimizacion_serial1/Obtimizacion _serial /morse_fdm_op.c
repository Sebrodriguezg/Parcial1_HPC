#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <lapacke.h>

/**
 * COMPILACIÓN:
 * gcc -O3 -march=native -ffast-math optimized_fdm.c -o optimized_fdm -llapacke -llapack -lblas -lm
 * * EJECUCIÓN SERIAL PURA:
 * Para evitar que la librería LAPACK/BLAS use hilos internamente:
 * export OPENBLAS_NUM_THREADS=1
 * export MKL_NUM_THREADS=1
 */

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Uso: %s <N>\n", argv[0]);
        return 1;
    }

    const int n = atoi(argv[1]);
    const size_t n2 = (size_t)n * n;

    /* Parámetros del Potencial de Morse (Constantes físicas) */
    const double D_POT = 10.0;
    const double ALPHA = 0.5;
    const double XMIN  = -2.0;
    const double XMAX  = 15.0;
    
    /* Parámetros de la Malla */
    const double dx = (XMAX - XMIN) / (double)(n + 1);
    const double dx2_inv = 1.0 / (dx * dx);
    const double off_diag = -0.5 * dx2_inv;

    /* Asignación de memoria alineada (64-byte) para facilitar vectorización SIMD */
    double *restrict H = (double *)aligned_alloc(64, n2 * sizeof(double));
    double *restrict E = (double *)aligned_alloc(64, n * sizeof(double));

    if (!H || !E) {
        fprintf(stderr, "Error: Fallo en la asignación de memoria.\n");
        return 1;
    }

    /* Inicialización de la matriz (Page-fill optimizado) */
    for (size_t i = 0; i < n2; i++) H[i] = 0.0;

    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);

    /* 2. CONSTRUCCIÓN OPTIMIZADA DEL HAMILTONIANO */
    /* Se minimizan las operaciones dentro del bucle y se evita pow() */
    for (int i = 0; i < n; i++) {
        const double x_i = XMIN + (double)(i + 1) * dx;
        const double exp_term = exp(-ALPHA * x_i);
        const double bracket = 1.0 - exp_term;
        const double v_i = D_POT * (bracket * bracket);
        
        /* Término Diagonal: T + V */
        H[i * n + i] = dx2_inv + v_i;
        
        /* Términos fuera de la diagonal (Tridiagonalidad) */
        if (i < n - 1) {
            H[i * n + (i + 1)] = off_diag;
            H[(i + 1) * n + i] = off_diag;
        }
    }

    /* 3. DIAGONALIZACIÓN (Densa O(N^3) por requerimiento de Benchmark) */
    /* Se utiliza el triángulo superior 'U' como referencia */
    int info = LAPACKE_dsyev(LAPACK_ROW_MAJOR, 'V', 'U', n, H, n, E);

    clock_gettime(CLOCK_MONOTONIC, &end);
    double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;

    if (info > 0) {
        fprintf(stderr, "Error: LAPACK no pudo converger.\n");
        free(H); free(E);
        return 1;
    }

    /* 4. SALIDA ESTANDARIZADA */
    printf("%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n", 
            n, E[0], E[1], E[2], E[3], time_used);

    free(H);
    free(E);
    return 0;
}
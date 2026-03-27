#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <lapacke.h>

/**
 * COMPILACIÓN:
 * gcc -O3 -march=native -ffast-math optimized_morse.c -o optimized_morse -llapacke -llapack -lblas -lm
 * 
 * gcc -O3 -march=native -ffast-math morse_base_op.c -o morse_base_op -llapacke -llapack -lblas -lm
 * gcc -O3 -march=native -ffast-math morse_fdm_op.c -o morse_fdm_op -llapacke -llapack -lblas -lm
 * gcc -O3 -march=native -ffast-math morse_shoot_op.c -o morse_shoot_op -lm
 * gcc -O3 -march=native -ffast-math morse_sinc_op.c -o morse_sinc_op -llapacke -llapack -lblas -lm
 * 
 * * NOTA: Para asegurar ejecución serial pura, asegúrese de que su implementación de BLAS/LAPACK 
 * no esté configurada con OpenMP/pthreads (e.g., export OPENBLAS_NUM_THREADS=1).
 */

/* Uso de inline y restricción de punteros para mejorar la vectorización */
static inline double v_func(const double x) {
    const double D = 10.0;
    const double beta = 0.5;
    const double e_val = exp(-beta * x);
    const double diff = 1.0 - e_val;
    return D * diff * diff;
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Uso: %s <N>\n", argv[0]);
        return 1;
    }

    const int n = atoi(argv[1]);
    const int n2 = n * n;

    /* Alineación de memoria para facilitar instrucciones SIMD */
    double *restrict X    = (double *)aligned_alloc(64, n2 * sizeof(double));
    double *restrict P    = (double *)aligned_alloc(64, n2 * sizeof(double));
    double *restrict T    = (double *)aligned_alloc(64, n2 * sizeof(double));
    double *restrict VMAT = (double *)aligned_alloc(64, n2 * sizeof(double));
    double *restrict H    = (double *)aligned_alloc(64, n2 * sizeof(double));
    double *restrict VP   = (double *)aligned_alloc(64, n2 * sizeof(double));
    double *restrict E    = (double *)aligned_alloc(64, n * sizeof(double));

    /* Inicialización manual rápida en lugar de calloc para evitar page faults tardíos */
    for(int i=0; i<n2; i++) { X[i] = 0.0; P[i] = 0.0; T[i] = 0.0; VMAT[i] = 0.0; }

    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);

    /* 1. CONSTRUCCIÓN DE X Y P (Operadores de creación/aniquilación implícitos) */
    for (int i = 0; i < n - 1; i++) {
        double val = sqrt((i + 1) / 2.0);
        X[i * n + (i + 1)] = val;
        X[(i + 1) * n + i] = val;
        P[i * n + (i + 1)] = -val;
        P[(i + 1) * n + i] = val;
    }

    /* 2. DIAGONALIZACIÓN DE X */
    for(int i=0; i<n2; i++) VP[i] = X[i];
    LAPACKE_dsyev(LAPACK_ROW_MAJOR, 'V', 'U', n, VP, n, E);

    /* 3. OPTIMIZACIÓN DE T = P * P 
       Física: P es rala (solo sub y super diagonal). P^2 es pentadiagonal.
       Complejidad reducida de O(N^3) a O(N). */
    for (int i = 0; i < n; i++) {
        // Elementos de la diagonal: T[i,i] = P[i, i-1]*P[i-1, i] + P[i, i+1]*P[i+1, i]
        if (i > 0)     T[i * n + i] += P[i * n + (i - 1)] * P[(i - 1) * n + i];
        if (i < n - 1) T[i * n + i] += P[i * n + (i + 1)] * P[(i + 1) * n + i];

        // Elementos T[i, i+2] y T[i, i-2]
        if (i < n - 2) {
            double val = P[i * n + (i + 1)] * P[(i + 1) * n + (i + 2)];
            T[i * n + (i + 2)] = val;
            T[(i + 2) * n + i] = val;
        }
    }

    /* 4. TRANSFORMACIÓN DE BASE PARA VMAT 
       V = VP * diag(v_func(E)) * VP^T
       Optimizamos pre-calculando v_func y mejorando la localidad de la caché. */
    double *restrict VE = (double *)aligned_alloc(64, n * sizeof(double));
    for(int k=0; k<n; k++) VE[k] = v_func(E[k]);

    // Usamos una matriz intermedia para pesar los autovectores y reducir flops internos
    double *restrict W = (double *)aligned_alloc(64, n2 * sizeof(double));
    for(int i=0; i<n; i++) {
        for(int k=0; k<n; k++) {
            W[i * n + k] = VP[i * n + k] * VE[k];
        }
    }

    // Multiplicación W * VP^T aprovechando simetría y acceso stride-1
    for (int i = 0; i < n; i++) {
        for (int j = i; j < n; j++) {
            double sum = 0.0;
            const double *row_i = &W[i * n];
            const double *row_j = &VP[j * n];
            #pragma GCC ivdep
            for (int k = 0; k < n; k++) {
                sum += row_i[k] * row_j[k];
            }
            VMAT[i * n + j] = sum;
            VMAT[j * n + i] = sum;
        }
    }

    /* 5. CONSTRUCCIÓN DEL HAMILTONIANO */
    #pragma GCC ivdep
    for (int i = 0; i < n2; i++) {
        H[i] = -0.5 * T[i] + VMAT[i];
    }

    /* 6. DIAGONALIZACIÓN FINAL */
    LAPACKE_dsyev(LAPACK_ROW_MAJOR, 'V', 'U', n, H, n, E);

    clock_gettime(CLOCK_MONOTONIC, &end);
    double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;

    printf("%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n", 
            n, E[0], E[1], E[2], E[3], time_used);

    free(X); free(P); free(T); free(VMAT); free(H); free(VP); free(E); 
    free(VE); free(W);
    return 0;
}
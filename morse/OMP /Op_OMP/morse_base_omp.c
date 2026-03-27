#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <omp.h>
#include <lapacke.h>

/**
 * COMPILACIÓN:
 * gcc -O3 -march=native -ffast-math -fopenmp optimized_morse_omp.c -o optimized_morse_omp -llapacke -llapack -lblas -lm
 * * EJECUCIÓN:
 * ./optimized_morse_omp <N> <NUM_THREADS>
 * * NOTA: Para evitar conflictos entre el paralelismo de OpenMP y el de las librerías BLAS,
 * se recomienda establecer: export OPENBLAS_NUM_THREADS=1 o MKL_NUM_THREADS=1.
 */

static inline double v_func(const double x) {
    const double D = 10.0;
    const double beta = 0.5;
    const double e_val = exp(-beta * x);
    const double diff = 1.0 - e_val;
    return D * diff * diff;
}

int main(int argc, char *argv[]) {
    if (argc < 3) {
        printf("Uso: %s <N> <Threads>\n", argv[0]);
        return 1;
    }

    const int n = atoi(argv[1]);
    const int n_threads = atoi(argv[2]);
    const int n2 = n * n;

    // Configuración explícita del número de hilos
    omp_set_num_threads(n_threads);

    /* Alineación de memoria (64 bytes para compatibilidad con AVX-512) */
    double *restrict X    = (double *)aligned_alloc(64, n2 * sizeof(double));
    double *restrict P    = (double *)aligned_alloc(64, n2 * sizeof(double));
    double *restrict T    = (double *)aligned_alloc(64, n2 * sizeof(double));
    double *restrict VMAT = (double *)aligned_alloc(64, n2 * sizeof(double));
    double *restrict H    = (double *)aligned_alloc(64, n2 * sizeof(double));
    double *restrict VP   = (double *)aligned_alloc(64, n2 * sizeof(double));
    double *restrict E    = (double *)aligned_alloc(64, n * sizeof(double));

    /* Inicialización paralela para asegurar el "First-Touch Policy" en sistemas NUMA */
    #pragma omp parallel for schedule(static)
    for(int i=0; i<n2; i++) {
        X[i] = 0.0; P[i] = 0.0; T[i] = 0.0; VMAT[i] = 0.0;
    }

    double start_time = omp_get_wtime();

    /* 1. CONSTRUCCIÓN DE X Y P */
    #pragma omp parallel for schedule(static)
    for (int i = 0; i < n - 1; i++) {
        double val = sqrt((i + 1) / 2.0);
        X[i * n + (i + 1)] = val;
        X[(i + 1) * n + i] = val;
        P[i * n + (i + 1)] = -val;
        P[(i + 1) * n + i] = val;
    }

    /* 2. DIAGONALIZACIÓN DE X (Operación Serial/Interna de LAPACK) */
    #pragma omp parallel for schedule(static)
    for(int i=0; i<n2; i++) VP[i] = X[i];
    
    LAPACKE_dsyev(LAPACK_ROW_MAJOR, 'V', 'U', n, VP, n, E);

    /* 3. CONSTRUCCIÓN DE T = P * P (O(N) paralelo) */
    #pragma omp parallel for schedule(static)
    for (int i = 0; i < n; i++) {
        if (i > 0)     T[i * n + i] += P[i * n + (i - 1)] * P[(i - 1) * n + i];
        if (i < n - 1) T[i * n + i] += P[i * n + (i + 1)] * P[(i + 1) * n + i];

        if (i < n - 2) {
            double val = P[i * n + (i + 1)] * P[(i + 1) * n + (i + 2)];
            T[i * n + (i + 2)] = val;
            T[(i + 2) * n + i] = val;
        }
    }

    /* 4. TRANSFORMACIÓN DE BASE PARA VMAT (Bottleneck O(N^3)) */
    double *restrict VE = (double *)aligned_alloc(64, n * sizeof(double));
    double *restrict W  = (double *)aligned_alloc(64, n2 * sizeof(double));

    #pragma omp parallel
    {
        // Pre-cálculo del potencial en la base diagonal
        #pragma omp for schedule(static)
        for(int k=0; k<n; k++) VE[k] = v_func(E[k]);

        // Cálculo de matriz intermedia W = VP * VE
        #pragma omp for schedule(static) collapse(2)
        for(int i=0; i<n; i++) {
            for(int k=0; k<n; k++) {
                W[i * n + k] = VP[i * n + k] * VE[k];
            }
        }

        /* Multiplicación W * VP^T aprovechando simetría.
           Se usa schedule(guided) porque el bucle interno 'j' es triangular y decreciente,
           lo que causaría desbalance con schedule(static). */
        #pragma omp for schedule(guided)
        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                double sum = 0.0;
                const double *restrict row_i = &W[i * n];
                const double *restrict row_j = &VP[j * n];
                
                #pragma GCC ivdep
                for (int k = 0; k < n; k++) {
                    sum += row_i[k] * row_j[k];
                }
                VMAT[i * n + j] = sum;
                VMAT[j * n + i] = sum;
            }
        }
    }

    /* 5. CONSTRUCCIÓN DEL HAMILTONIANO */
    #pragma omp parallel for schedule(static)
    for (int i = 0; i < n2; i++) {
        H[i] = -0.5 * T[i] + VMAT[i];
    }

    /* 6. DIAGONALIZACIÓN FINAL */
    LAPACKE_dsyev(LAPACK_ROW_MAJOR, 'V', 'U', n, H, n, E);

    double end_time = omp_get_wtime();
    double time_used = end_time - start_time;

    printf("%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n", 
            n, E[0], E[1], E[2], E[3], time_used);

    // Limpieza
    free(X); free(P); free(T); free(VMAT); free(H); free(VP); free(E); 
    free(VE); free(W);
    return 0;
}
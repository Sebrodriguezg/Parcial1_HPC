#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <omp.h>
#include <lapacke.h>

/**
 * COMPILACIÓN:
 * gcc -O3 -march=native -ffast-math -fopenmp optimized_sinc_dvr_omp.c -o optimized_sinc_dvr_omp -llapacke -llapack -lblas -lm
 * * EJECUCIÓN:
 * ./optimized_sinc_dvr_omp <N> <NUM_THREADS>
 * * NOTA: Para matrices densas de gran escala, asegúrese de que LAPACK no compita con OpenMP.
 * export OPENBLAS_NUM_THREADS=1 o MKL_NUM_THREADS=1.
 */

#ifndef M_PI
    #define M_PI 3.14159265358979323846
#endif

int main(int argc, char *argv[]) {
    if (argc < 3) {
        printf("Uso: %s <N> <Threads>\n", argv[0]);
        return 1;
    }

    const int n = atoi(argv[1]);
    const int n_threads = atoi(argv[2]);
    const size_t n2 = (size_t)n * n;

    omp_set_num_threads(n_threads);

    const double D_POT = 10.0;
    const double ALPHA = 0.5;
    const double XMIN  = -3.0;
    const double XMAX  = 20.0;
    const double dx    = (XMAX - XMIN) / (double)n;
    const double dx2_inv = 1.0 / (dx * dx);
    const double diag_kin = (M_PI * M_PI) / 6.0 * dx2_inv;

    double *restrict H = (double *)aligned_alloc(64, n2 * sizeof(double));
    double *restrict E = (double *)aligned_alloc(64, n * sizeof(double));

    if (!H || !E) return 1;

    /* 1. INITIALIZACIÓN PARALELA (First-Touch) */
    #pragma omp parallel for schedule(static)
    for (size_t i = 0; i < n2; i++) H[i] = 0.0;

    double start_time = omp_get_wtime();

    /* 2. CONSTRUCCIÓN DEL HAMILTONIANO SINC-DVR
       Se utiliza schedule(guided) debido a la naturaleza triangular del bucle interno,
       maximizando la ocupación de hilos. */
    #pragma omp parallel for schedule(guided)
    for (int i = 0; i < n; i++) {
        const double x_i = XMIN + (double)(i + 1) * dx;
        const double exp_term = exp(-ALPHA * x_i);
        const double v_i = D_POT * (1.0 - exp_term) * (1.0 - exp_term);

        /* Elemento Diagonal */
        H[i * n + i] = diag_kin + v_i;

        /* Elementos Fuera de Diagonal (Simétricos) 
           El uso de punteros restrict y alineación favorece la vectorización SIMD */
        for (int j = i + 1; j < n; j++) {
            const int diff = i - j;
            const double diff2_inv = 1.0 / (double)(diff * diff);
            const double sign = ( (i - j) & 1 ) ? -1.0 : 1.0;
            
            const double val = (sign * dx2_inv) * diff2_inv;
            H[i * n + j] = val;
            // No escribimos H[j*n + i] porque LAPACK usará el triángulo 'U'
        }
    }

    /* 3. DIAGONALIZACIÓN DENSA */
    int info = LAPACKE_dsyev(LAPACK_ROW_MAJOR, 'V', 'U', n, H, n, E);

    double end_time = omp_get_wtime();
    double time_used = end_time - start_time;

    if (info > 0) {
        free(H); free(E);
        return 1;
    }

    printf("%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n", 
            n, E[0], E[1], E[2], E[3], time_used);

    free(H); free(E);
    return 0;
}
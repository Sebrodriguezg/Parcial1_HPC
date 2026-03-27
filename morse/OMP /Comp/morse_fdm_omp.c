#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <omp.h>
#include <lapacke.h>

/**
 * COMPILACIÓN:
 * gcc -O3 -march=native -ffast-math -fopenmp optimized_fdm_omp.c -o optimized_fdm_omp -llapacke -llapack -lblas -lm
 * * EJECUCIÓN:
 * ./optimized_morse_omp <N> <NUM_THREADS>
 * * NOTA DE RENDIMIENTO:
 * Para evitar la sobresuscripción de hilos (oversubscription), se recomienda que LAPACK
 * trabaje de forma serial mientras OpenMP gestiona los núcleos.
 * export OPENBLAS_NUM_THREADS=1 o export MKL_NUM_THREADS=1
 */

int main(int argc, char *argv[]) {
    if (argc < 3) {
        printf("Uso: %s <N> <Threads>\n", argv[0]);
        return 1;
    }

    const int n = atoi(argv[1]);
    const int n_threads = atoi(argv[2]);
    const size_t n2 = (size_t)n * n;

    // Configuración explícita del entorno multinúcleo
    omp_set_num_threads(n_threads);

    const double D_POT = 10.0;
    const double ALPHA = 0.5;
    const double XMIN  = -2.0;
    const double XMAX  = 15.0;
    
    const double dx = (XMAX - XMIN) / (double)(n + 1);
    const double dx2_inv = 1.0 / (dx * dx);
    const double off_diag = -0.5 * dx2_inv;

    /* Alineación a 64 bytes para permitir que el compilador use registros ZMM (AVX-512) */
    double *restrict H = (double *)aligned_alloc(64, n2 * sizeof(double));
    double *restrict E = (double *)aligned_alloc(64, n * sizeof(double));

    if (!H || !E) {
        fprintf(stderr, "Error: Fallo en la asignación de memoria.\n");
        return 1;
    }

    /* 1. INICIALIZACIÓN PARALELA (First-Touch Policy)
       Vital para que las páginas de memoria se mapeen físicamente cerca del núcleo que las usará. */
    #pragma omp parallel for schedule(static)
    for (size_t i = 0; i < n2; i++) H[i] = 0.0;

    double start_time = omp_get_wtime();

    /* 2. CONSTRUCCIÓN DEL HAMILTONIANO FDM
       Aunque es O(N), el uso de exp() es computacionalmente costoso. 
       Repartimos la carga de forma estática para maximizar la localidad de caché. */
    #pragma omp parallel for schedule(static)
    for (int i = 0; i < n; i++) {
        const double x_i = XMIN + (double)(i + 1) * dx;
        const double exp_term = exp(-ALPHA * x_i);
        const double bracket = 1.0 - exp_term;
        const double v_i = D_POT * (bracket * bracket);
        
        /* Diagonal principal: T + V */
        H[i * n + i] = dx2_inv + v_i;
        
        /* Términos tridiagonales:
           Dado que cada hilo 'i' escribe en posiciones únicas (i, i+1) y (i+1, i),
           no existen condiciones de carrera. */
        if (i < n - 1) {
            H[i * n + (i + 1)] = off_diag;
            H[(i + 1) * n + i] = off_diag;
        }
    }

    /* 3. DIAGONALIZACIÓN DENSA O(N^3)
       Delegamos a LAPACKE. Se asume que el usuario ha limitado los hilos internos de BLAS
       para dejar que OpenMP controle la orquestación del programa. */
    int info = LAPACKE_dsyev(LAPACK_ROW_MAJOR, 'V', 'U', n, H, n, E);

    double end_time = omp_get_wtime();
    double time_used = end_time - start_time;

    if (info > 0) {
        fprintf(stderr, "Error: LAPACK no pudo converger.\n");
        free(H); free(E);
        return 1;
    }

    /* 4. SALIDA (Mantiene el formato exacto solicitado) */
    printf("%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n", 
            n, E[0], E[1], E[2], E[3], time_used);

    free(H);
    free(E);
    return 0;
}
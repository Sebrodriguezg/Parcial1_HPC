#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <lapacke.h>
#include <cblas.h>

/* ================================
   🔧 INLINE (evita overhead)
================================ */
static inline double v_func(double x) {
    double D = 10.0;
    double beta = 0.5;
    double exp_term = exp(-beta * x);
    double diff = 1.0 - exp_term;
    return D * diff * diff;
}

/* ================================
   🔧 FUNCIÓN AUXILIAR PARA MEMORIA
================================ */
double* aligned_alloc_double(size_t n) {
    double *ptr;
    if (posix_memalign((void**)&ptr, 64, n * sizeof(double)) != 0) {
        fprintf(stderr, "Error: no se pudo asignar memoria\n");
        exit(1);
    }
    return ptr;
}

int main(int argc, char *argv[]) {

    if (argc < 2) {
        printf("Uso: %s <N>\n", argv[0]);
        return 1;
    }

    int n = atoi(argv[1]);
    int n2 = n * n;

    /* ================================
       🔧 MEMORIA ALINEADA (ROBUSTA)
    ================================= */
    double *X    = aligned_alloc_double(n2);
    double *P    = aligned_alloc_double(n2);
    double *T    = aligned_alloc_double(n2);
    double *VMAT = aligned_alloc_double(n2);
    double *H    = aligned_alloc_double(n2);
    double *VP   = aligned_alloc_double(n2);
    double *E    = aligned_alloc_double(n);
    double *Vdiag= aligned_alloc_double(n);

    /* Inicialización segura */
    for(int i = 0; i < n2; i++) {
        X[i] = 0.0;
        P[i] = 0.0;
    }

    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);

    /* ================================
       2. MATRICES X Y P
    ================================= */
    for (int i = 0; i < n - 1; i++) {
        double val = sqrt((i + 1) / 2.0);

        X[i * n + (i + 1)] = val;
        X[(i + 1) * n + i] = val;

        P[i * n + (i + 1)] = -val;
        P[(i + 1) * n + i] = val;
    }

    /* ================================
       3. DIAGONALIZACIÓN DE X
    ================================= */
    for(int i = 0; i < n2; i++) VP[i] = X[i];

    LAPACKE_dsyev(LAPACK_ROW_MAJOR, 'V', 'U', n, VP, n, E);

    /* ================================
       🔥 PRECOMPUTACIÓN DEL POTENCIAL
    ================================= */
    for(int k = 0; k < n; k++) {
        Vdiag[k] = v_func(E[k]);
    }

    /* ================================
       🔥 DGEMM (BLAS)
    ================================= */
    cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans,
                n, n, n,
                1.0, P, n,
                     P, n,
                0.0, T, n);

    /* ================================
       🔥 TRANSFORMACIÓN DE POTENCIAL
    ================================= */
    for (int i = 0; i < n; i++) {
        for (int j = i; j < n; j++) {

            double sum = 0.0;

            #pragma omp simd reduction(+:sum)
            for (int k = 0; k < n; k++) {
                sum += VP[i * n + k] * Vdiag[k] * VP[j * n + k];
            }

            VMAT[i * n + j] = sum;
            VMAT[j * n + i] = sum;
        }
    }

    /* ================================
       6. HAMILTONIANO
    ================================= */
    #pragma omp simd
    for (int i = 0; i < n2; i++) {
        H[i] = -0.5 * T[i] + VMAT[i];
    }

    /* ================================
       7. DIAGONALIZACIÓN FINAL
    ================================= */
    LAPACKE_dsyev(LAPACK_ROW_MAJOR, 'V', 'U', n, H, n, E);

    clock_gettime(CLOCK_MONOTONIC, &end);

    double time_used = (end.tv_sec - start.tv_sec)
                     + (end.tv_nsec - start.tv_nsec) / 1e9;

    printf("%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n",
           n, E[0], E[1], E[2], E[3], time_used);

    free(X); free(P); free(T); free(VMAT);
    free(H); free(VP); free(E); free(Vdiag);

    return 0;
}
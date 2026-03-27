#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <lapacke.h>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

/* ================================
   🔧 MEMORIA ALINEADA
================================ */
double* aligned_alloc_double(size_t n) {
    double *ptr;
    if (posix_memalign((void**)&ptr, 64, n * sizeof(double)) != 0) {
        fprintf(stderr, "Error de memoria\n");
        exit(1);
    }
    return ptr;
}

/* ================================
   🔧 POTENCIAL INLINE
================================ */
static inline double v_morse(double x, double D, double alpha) {
    double exp_term = exp(-alpha * x);
    double diff = 1.0 - exp_term;
    return D * diff * diff;
}

int main(int argc, char *argv[]) {

    if (argc < 2) {
        printf("Uso: %s <N>\n", argv[0]);
        return 1;
    }

    int n = atoi(argv[1]);
    int n2 = n * n;

    double D_POT = 10.0;
    double ALPHA = 0.5;
    double XMIN  = -3.0;
    double XMAX  = 20.0;

    double dx  = (XMAX - XMIN) / (double)n;
    double dx2 = dx * dx;

    /* ================================
       🔴 ANTES: calloc
       🟢 AHORA: memoria alineada
    ================================= */
    double *H = aligned_alloc_double(n2);
    double *E = aligned_alloc_double(n);

    /* 🔥 inicializar */
    for (int i = 0; i < n2; i++) H[i] = 0.0;

    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);

    /* ================================
       🔥 OPTIMIZACIONES CLAVE
    ================================= */

    const double diag_const = (M_PI * M_PI) / (6.0 * dx2);

    /* 🔴 ANTES:
         pow + exp dentro del loop doble
       🟢 AHORA:
         precomputamos potencial → O(N)
    */
    double *V = aligned_alloc_double(n);

    for (int i = 0; i < n; i++) {
        double x_i = XMIN + (double)(i + 1) * dx;
        V[i] = v_morse(x_i, D_POT, ALPHA);
    }

    /* ================================
       🔥 LLENADO OPTIMIZADO
    ================================= */

    for (int i = 0; i < n; i++) {

        /* 🔥 DIAGONAL */
        H[i * n + i] = diag_const + V[i];

        for (int j = i + 1; j < n; j++) {

            /* 🔴 ANTES:
                 pow(-1, i-j) + recalculo
               🟢 AHORA:
                 cálculo directo sin pow
            */

            int diff = i - j;
            int abs_diff = j - i;

            double sign = (abs_diff % 2 == 0) ? 1.0 : -1.0;

            double val = sign / (dx2 * (double)(abs_diff * abs_diff));

            H[i * n + j] = val;
            H[j * n + i] = val;  // simetría
        }
    }

    /* ================================
       🔥 DIAGONALIZACIÓN
    ================================= */
    int info = LAPACKE_dsyev(LAPACK_ROW_MAJOR, 'V', 'U', n, H, n, E);

    clock_gettime(CLOCK_MONOTONIC, &end);

    double time_used = (end.tv_sec - start.tv_sec)
                     + (end.tv_nsec - start.tv_nsec) / 1e9;

    if (info > 0) {
        fprintf(stderr, "Error en diagonalización\n");
        return 1;
    }

    printf("%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n",
            n, E[0], E[1], E[2], E[3], time_used);

    free(H);
    free(E);
    free(V);

    return 0;
}
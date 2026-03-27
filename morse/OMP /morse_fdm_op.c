#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <lapacke.h>

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
static inline double morse_potential(double x, double D, double alpha) {
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

    /* Parámetros físicos */
    double D_POT = 10.0;
    double ALPHA = 0.5;
    double XMIN  = -2.0;
    double XMAX  = 15.0;

    double dx = (XMAX - XMIN) / (double)(n + 1);

    /* ================================
       🔴 ANTES:
           matriz H[n*n]
       🟢 AHORA:
           solo:
           - diagonal d[n]
           - subdiagonal e[n-1]
    ================================= */
    double *d = aligned_alloc_double(n);       // diagonal (eigenvalues output)
    double *e = aligned_alloc_double(n - 1);   // subdiagonal

    double inv_dx2 = 1.0 / (dx * dx);
    double off_diag = -0.5 * inv_dx2;

    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);

    /* ================================
       🔥 CONSTRUCCIÓN TRIDIAGONAL
    ================================= */
    for (int i = 0; i < n; i++) {

        double x_i = XMIN + (double)(i + 1) * dx;

        /* 🔴 ANTES:
             pow(...)
           🟢 AHORA:
             inline + multiplicación
        */
        double v_i = morse_potential(x_i, D_POT, ALPHA);

        /* diagonal */
        d[i] = inv_dx2 + v_i;

        /* subdiagonal */
        if (i < n - 1) {
            e[i] = off_diag;
        }
    }

    /* ================================
       🔥 DIAGONALIZACIÓN TRIDIAGONAL

       🔴 ANTES:
           dsyev → O(N^3)
       🟢 AHORA:
           dstev → O(N^2)

       ⚠️ IMPORTANTE:
           Aunque jobz='N', LAPACKE requiere z y ldz
    ================================= */
    int info = LAPACKE_dstev(
        LAPACK_ROW_MAJOR,
        'N',      // No eigenvectors
        n,
        d,
        e,
        NULL,     // No eigenvectors → NULL
        n         // ldz (no se usa pero requerido)
    );

    clock_gettime(CLOCK_MONOTONIC, &end);

    double time_used = (end.tv_sec - start.tv_sec)
                     + (end.tv_nsec - start.tv_nsec) / 1e9;

    if (info > 0) {
        fprintf(stderr, "Error: dstev no convergió\n");
        return 1;
    }

    /* ================================
       🔴 IMPORTANTE:
           d contiene eigenvalues
    ================================= */
    printf("%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n",
            n, d[0], d[1], d[2], d[3], time_used);

    free(d);
    free(e);

    return 0;
}
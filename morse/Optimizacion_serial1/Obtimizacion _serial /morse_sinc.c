#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <lapacke.h>

#ifndef M_PI
    #define M_PI 3.14159265358979323846
#endif

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Uso: %s <N>\n", argv[0]);
        return 1;
    }

    int n = atoi(argv[1]);
    int n2 = n * n;

    /* Parámetros del Potencial */
    double D_POT = 10.0;
    double ALPHA = 0.5;
    double XMIN  = -3.0;
    double XMAX  = 20.0;
    double dx    = (XMAX - XMIN) / (double)n;
    double dx2   = dx * dx;

    /* Memoria dinámica contigua */
    double *H = (double *)calloc(n2, sizeof(double));
    double *E = (double *)malloc(n * sizeof(double));

    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);

    /* 2. CONSTRUCCIÓN DEL HAMILTONIANO SINC-DVR (Matriz Densa) */
    for (int i = 0; i < n; i++) {
        double x_i = XMIN + (double)(i + 1) * dx;
        double v_i = D_POT * pow(1.0 - exp(-ALPHA * x_i), 2);

        for (int j = 0; j < n; j++) {
            if (i == j) {
                /* Diagonal: (PI^2 / 6*dx^2) + V(x_i) */
                H[i * n + j] = (M_PI * M_PI) / (6.0 * dx2) + v_i;
            } else {
                /* Fuera de diagonal: (-1)^(i-j) / (dx^2 * (i-j)^2) */
                int diff = (i + 1) - (j + 1);
                double sign = (diff % 2 == 0) ? 1.0 : -1.0;
                H[i * n + j] = sign / (dx2 * (double)diff * (double)diff);
            }
        }
    }

    /* 3. DIAGONALIZACIÓN (dsyev) */
    int info = LAPACKE_dsyev(LAPACK_ROW_MAJOR, 'V', 'U', n, H, n, E);

    clock_gettime(CLOCK_MONOTONIC, &end);
    double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;

    if (info > 0) return 1;

    /* 4. SALIDA ESTANDARIZADA */
    printf("%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n", 
            n, E[0], E[1], E[2], E[3], time_used);

    free(H); free(E);
    return 0;
}
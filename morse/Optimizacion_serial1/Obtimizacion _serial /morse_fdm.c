#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <lapacke.h>

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Uso: %s <N>\n", argv[0]);
        return 1;
    }

    int n = atoi(argv[1]);
    int n2 = n * n;

    /* Parámetros del Potencial de Morse */
    double D_POT = 10.0;
    double ALPHA = 0.5;
    double XMIN  = -2.0;
    double XMAX  = 15.0;
    
    /* Parámetros de la Malla */
    double dx = (XMAX - XMIN) / (double)(n + 1);
    double dx2 = dx * dx;

    /* Asignación de memoria dinámica contigua */
    double *H = (double *)calloc(n2, sizeof(double));
    double *E = (double *)malloc(n * sizeof(double));

    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);

    /* 2. CONSTRUCCIÓN DE LA MATRIZ (FULL MATRIX PARA BENCHMARK) */
    for (int i = 0; i < n; i++) {
        double x_i = XMIN + (double)(i + 1) * dx;
        double v_i = D_POT * pow(1.0 - exp(-ALPHA * x_i), 2);
        
        /* Término Diagonal: 1/dx^2 + V(x) */
        H[i * n + i] = (1.0 / dx2) + v_i;
        
        /* Términos fuera de la diagonal: -1/(2*dx^2) */
        if (i < n - 1) {
            double off_diag = -1.0 / (2.0 * dx2);
            H[i * n + (i + 1)] = off_diag;
            H[(i + 1) * n + i] = off_diag;
        }
    }

    /* 3. DIAGONALIZACIÓN (Densa O(N^3)) */
    /* dsyev calcula autovalores (E) y autovectores (sobrescribe H) */
    int info = LAPACKE_dsyev(LAPACK_ROW_MAJOR, 'V', 'U', n, H, n, E);

    clock_gettime(CLOCK_MONOTONIC, &end);
    double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;

    if (info > 0) {
        fprintf(stderr, "Error: LAPACK no pudo converger.\n");
        return 1;
    }

    /* 4. SALIDA ESTANDARIZADA */
    printf("%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n", 
            n, E[0], E[1], E[2], E[3], time_used);

    free(H);
    free(E);
    return 0;
}
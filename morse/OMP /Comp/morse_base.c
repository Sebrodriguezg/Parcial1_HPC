#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <lapacke.h>

/* Prototipo de la función de potencial */
double v_func(double x) {
    double D = 10.0;
    double beta = 0.5;
    double diff = 1.0 - exp(-beta * x);
    return D * diff * diff;
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Uso: %s <N>\n", argv[0]);
        return 1;
    }

    int n = atoi(argv[1]);
    int n2 = n * n;

    /* Asignación de memoria contigua para matrices N x N */
    double *X    = (double *)calloc(n2, sizeof(double));
    double *P    = (double *)calloc(n2, sizeof(double));
    double *T    = (double *)calloc(n2, sizeof(double));
    double *VMAT = (double *)calloc(n2, sizeof(double));
    double *H    = (double *)calloc(n2, sizeof(double));
    double *VP   = (double *)calloc(n2, sizeof(double));
    double *E    = (double *)malloc(n * sizeof(double));

    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);

    /* 2. CONSTRUCCIÓN DE MATRICES X Y P */
    for (int i = 0; i < n - 1; i++) {
        double val = sqrt((i + 1) / 2.0);
        // Almacenamiento Row-Major: [i * n + j]
        X[i * n + (i + 1)] = val;
        X[(i + 1) * n + i] = val;
        P[i * n + (i + 1)] = -val;
        P[(i + 1) * n + i] = val;
    }

    /* 3. DIAGONALIZACIÓN DE X (Usando LAPACKE) */
    /* Copiamos X en VP porque dsyev sobrescribe la matriz con los autovectores */
    for(int i=0; i<n2; i++) VP[i] = X[i];
    
    LAPACKE_dsyev(LAPACK_ROW_MAJOR, 'V', 'U', n, VP, n, E);

    /* 4. CÁLCULO DE ENERGÍA CINÉTICA (T = P * P) */
    /* Optimizamos: T = P * P mediante un bucle simple (por ahora serial) */
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            double sum = 0.0;
            for (int k = 0; k < n; k++) {
                sum += P[i * n + k] * P[k * n + j];
            }
            T[i * n + j] = sum;
        }
    }

    /* 5. CÁLCULO DE LA MATRIZ DE POTENCIAL (Transformación de base) */
    for (int i = 0; i < n; i++) {
        for (int j = i; j < n; j++) {
            double sum = 0.0;
            for (int k = 0; k < n; k++) {
                sum += VP[i * n + k] * v_func(E[k]) * VP[j * n + k];
            }
            VMAT[i * n + j] = sum;
            VMAT[j * n + i] = sum; // Simetría
        }
    }

    /* 6. CONSTRUCCIÓN DEL HAMILTONIANO */
    for (int i = 0; i < n2; i++) {
        H[i] = -0.5 * T[i] + VMAT[i];
    }

    /* 7. DIAGONALIZACIÓN FINAL */
    LAPACKE_dsyev(LAPACK_ROW_MAJOR, 'V', 'U', n, H, n, E);

    clock_gettime(CLOCK_MONOTONIC, &end);
    double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;

    /* 8. SALIDA ESTANDARIZADA */
    printf("%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n", 
            n, E[0], E[1], E[2], E[3], time_used);

    free(X); free(P); free(T); free(VMAT); free(H); free(VP); free(E);
    return 0;
}
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <omp.h>

/**
 * COMPILACIÓN:
 * gcc -O3 -march=native -ffast-math -fopenmp shooting_omp.c -o shooting_omp -lm
 * * EJECUCIÓN:
 * ./shooting_omp <NSTEPS> <NUM_THREADS>
 * * NOTA: Este código implementa paralelismo de dominio en el espacio de energías,
 * permitiendo una búsqueda de autovalores altamente eficiente y escalable.
 */

typedef struct {
    double *v_base;
    double *v_half;
} MorseGrid;

/* Integrador RK4 Optimizado (Kernel Computacional) */
double fun_wave_opt(double en, double h, int n, const MorseGrid *restrict grid) {
    double psi = 0.0;
    double phi = 1e-6;
    const double h_6 = h / 6.0;
    const double h_2 = h * 0.5;
    const double en2 = 2.0 * en;

    const double *restrict v_b = grid->v_base;
    const double *restrict v_h = grid->v_half;

    for (int i = 0; i < n; i++) {
        double rk1_psi = phi;
        double rk1_phi = (v_b[i] - en2) * psi;

        double v_mid_term = v_h[i] - en2;
        double rk2_psi = phi + h_2 * rk1_phi;
        double rk2_phi = v_mid_term * (psi + h_2 * rk1_psi);

        double rk3_psi = phi + h_2 * rk2_phi;
        double rk3_phi = v_mid_term * (psi + h_2 * rk2_psi);

        double rk4_psi = phi + h * rk3_phi;
        double rk4_phi = (v_b[i+1] - en2) * (psi + h * rk3_psi);

        psi += h_6 * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
        phi += h_6 * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);

        if (fabs(psi) > 1e15) { psi *= 1e-15; phi *= 1e-15; }
    }
    return psi;
}

int main(int argc, char *argv[]) {
    if (argc < 3) {
        printf("Uso: %s <NSTEPS> <Threads>\n", argv[0]);
        return 1;
    }

    const int nsteps = atoi(argv[1]);
    const int n_threads = atoi(argv[2]);
    omp_set_num_threads(n_threads);

    const double d_pot = 10.0, alpha = 0.5;
    const double xmin = -2.0, xmax = 25.0;
    const double dx = (xmax - xmin) / (double)nsteps;

    double *v_base = (double *)aligned_alloc(64, (nsteps + 1) * sizeof(double));
    double *v_half = (double *)aligned_alloc(64, nsteps * sizeof(double));

    /* 1. PRE-CÁLCULO PARALELO DE LA MALLA (O(N)) */
    #pragma omp parallel for schedule(static)
    for (int i = 0; i <= nsteps; i++) {
        double x = xmin + i * dx;
        double tmp = 1.0 - exp(-alpha * x);
        v_base[i] = 2.0 * d_pot * tmp * tmp;
        if (i < nsteps) {
            double tmp_m = 1.0 - exp(-alpha * (x + 0.5 * dx));
            v_half[i] = 2.0 * d_pot * tmp_m * tmp_m;
        }
    }

    MorseGrid grid = {v_base, v_half};
    const double e_min = 0.0, e_max = 10.0, de = 0.001;
    const int n_intervals = (int)((e_max - e_min) / de);
    
    double en_levels[5] = {0};
    int found_levels = 0;

    double start_time = omp_get_wtime();

    /* 2. BÚSQUEDA PARALELA DE AUTOVALORES 
       Cada hilo analiza un rango de energía independiente. */
    #pragma omp parallel
    {
        double local_levels[5];
        int local_found = 0;

        #pragma omp for schedule(dynamic) nowait
        for (int i = 0; i < n_intervals; i++) {
            if (found_levels >= 5) continue; // Early exit hint

            double ea = e_min + i * de;
            double eb = ea + de;
            
            double fa = fun_wave_opt(ea, dx, nsteps, &grid);
            double fb = fun_wave_opt(eb, dx, nsteps, &grid);

            if (fa * fb < 0.0) {
                // Bisección para refinar la raíz encontrada
                double emid;
                for (int iter = 0; iter < 100; iter++) {
                    emid = 0.5 * (ea + eb);
                    double fmid = fun_wave_opt(emid, dx, nsteps, &grid);
                    if (fa * fmid < 0.0) eb = emid;
                    else { ea = emid; fa = fmid; }
                }
                
                #pragma omp critical
                {
                    if (found_levels < 5) {
                        // Insertar manteniendo el orden ascendente
                        int pos = found_levels;
                        while (pos > 0 && en_levels[pos-1] > emid) {
                            en_levels[pos] = en_levels[pos-1];
                            pos--;
                        }
                        en_levels[pos] = emid;
                        found_levels++;
                    }
                }
            }
        }
    }

    double end_time = omp_get_wtime();
    printf("%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n", 
           nsteps, en_levels[0], en_levels[1],
           en_levels[2], en_levels[3], end_time - start_time);

    free(v_base); free(v_half);
    return 0;
}
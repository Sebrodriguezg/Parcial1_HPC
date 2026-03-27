#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

/**
 * COMPILACIÓN:
 * gcc -O3 -march=native -ffast-math shooting_optimized.c -o shooting_optimized -lm
 * * EJECUCIÓN:
 * ./shooting_optimized <NSTEPS>
 * (Asegúrese de que no haya variables de entorno de hilos activas, 
 * aunque este código es puramente serial y no usa librerías externas).
 */

/* Estructura para pasar la malla de potencial pre-calculada */
typedef struct {
    double *v_base;    // V(x_i)
    double *v_half;    // V(x_i + h/2)
} MorseGrid;

/* Integrador Runge-Kutta de 4to Orden Optimizado */
/* Se eliminan todas las llamadas a exp() y se reemplazan por accesos a memoria Stride-1 */
double fun_wave_opt(double en, double h, int n, const MorseGrid *restrict grid) {
    double psi = 0.0;
    double phi = 1e-6;
    
    const double h_6 = h / 6.0;
    const double h_2 = h * 0.5;
    const double en2 = 2.0 * en; // Pre-factor de energía

    // Punteros restrict para que el compilador asuma que no hay solapamiento
    const double *restrict v_b = grid->v_base;
    const double *restrict v_h = grid->v_half;

    for (int i = 0; i < n; i++) {
        // k1
        double rk1_psi = phi;
        double rk1_phi = (v_b[i] - en2) * psi;

        // k2 y k3 usan el mismo valor de potencial en el punto medio
        double v_mid_term = v_h[i] - en2;
        
        double rk2_psi = phi + h_2 * rk1_phi;
        double rk2_phi = v_mid_term * (psi + h_2 * rk1_psi);

        double rk3_psi = phi + h_2 * rk2_phi;
        double rk3_phi = v_mid_term * (psi + h_2 * rk2_psi);

        // k4 usa el potencial en el siguiente punto de la malla (i+1)
        double rk4_psi = phi + h * rk3_phi;
        double rk4_phi = (v_b[i+1] - en2) * (psi + h * rk3_psi);

        // Actualización final
        psi += h_6 * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
        phi += h_6 * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);

        // Control de re-normalización para evitar overflow en el shooting
        if (fabs(psi) > 1e15) {
            psi *= 1e-15;
            phi *= 1e-15;
        }
    }
    return psi;
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Uso: %s <NSTEPS>\n", argv[0]);
        return 1;
    }

    const int nsteps = atoi(argv[1]);
    const double d_pot = 10.0, alpha = 0.5;
    const double xmin = -2.0, xmax = 25.0;
    const double dx = (xmax - xmin) / (double)nsteps;

    /* PRE-CÁLCULO DE LA MALLA DE POTENCIAL (HPC Strategy) */
    /* Reservamos memoria alineada para V(x) y V(x + dx/2) */
    double *v_base = (double *)aligned_alloc(64, (nsteps + 1) * sizeof(double));
    double *v_half = (double *)aligned_alloc(64, nsteps * sizeof(double));

    // Llenado de la malla: solo se calculan las exponenciales UNA vez
    for (int i = 0; i <= nsteps; i++) {
        double x = xmin + i * dx;
        double tmp = 1.0 - exp(-alpha * x);
        v_base[i] = 2.0 * d_pot * tmp * tmp; // Guardamos 2*V para ahorrar una mult en el loop
        
        if (i < nsteps) {
            double x_mid = x + 0.5 * dx;
            double tmp_m = 1.0 - exp(-alpha * x_mid);
            v_half[i] = 2.0 * d_pot * tmp_m * tmp_m;
        }
    }

    MorseGrid grid = {v_base, v_half};

    double e_min = 0.0, e_max = 10.0, de = 0.001;
    double en_levels[5] = {0};
    int level = 0;

    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);

    /* ALGORITMO DE BÚSQUEDA DE AUTOVALORES */
    double e_cur = e_min;
    double f_prev = fun_wave_opt(e_cur, dx, nsteps, &grid);

    while (e_cur < e_max && level < 5) {
        e_cur += de;
        double f_cur = fun_wave_opt(e_cur, dx, nsteps, &grid);

        if (f_prev * f_cur < 0.0) {
            double ea = e_cur - de;
            double eb = e_cur;
            double fa = f_prev;
            double emid;

            // Bisección: 100 iteraciones para convergencia a precisión de máquina
            for (int iter = 0; iter < 100; iter++) {
                emid = 0.5 * (ea + eb);
                double fmid = fun_wave_opt(emid, dx, nsteps, &grid);
                if (fa * fmid < 0.0) {
                    eb = emid;
                } else {
                    ea = emid;
                    fa = fmid;
                }
            }
            if (level < 5) en_levels[level] = emid;
            level++;
        }
        f_prev = f_cur;
    }

    clock_gettime(CLOCK_MONOTONIC, &end);
    double time_used = (end.tv_sec - start.tv_sec) +
                       (end.tv_nsec - start.tv_nsec) / 1e9;

    printf("%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n", 
           nsteps, en_levels[0], en_levels[1],
           en_levels[2], en_levels[3], time_used);

    free(v_base);
    free(v_half);

    return 0;
}
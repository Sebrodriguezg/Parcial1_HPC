#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

/* Función de Potencial */
static inline double v_morse(double x, double D, double alpha) {
    double tmp = 1.0 - exp(-alpha * x);
    return D * tmp * tmp;  // más eficiente que pow
}

/* Integrador Runge-Kutta de 4to Orden */
double fun_wave(double en, double x0, double xf, double h, int n, double D, double alpha) {
    double psi = 0.0;
    double phi = 1e-6;
    double x = x0;

    for (int i = 0; i < n; i++) {
        double rk1_psi = phi;
        double rk1_phi = 2.0 * (v_morse(x, D, alpha) - en) * psi;

        double xm2 = x + 0.5 * h;
        double v_m = 2.0 * (v_morse(xm2, D, alpha) - en);
        double rk2_psi = phi + 0.5 * h * rk1_phi;
        double rk2_phi = v_m * (psi + 0.5 * h * rk1_psi);

        double rk3_psi = phi + 0.5 * h * rk2_phi;
        double rk3_phi = v_m * (psi + 0.5 * h * rk2_psi);

        double xf1 = x + h;
        double v_e = 2.0 * (v_morse(xf1, D, alpha) - en);
        double rk4_psi = phi + h * rk3_phi;
        double rk4_phi = v_e * (psi + h * rk3_psi);

        psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
        phi += (h / 6.0) * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);
        x += h;

        if (fabs(psi) > 1e15) {
            psi /= 1e15;
            phi /= 1e15;
        }
    }
    return psi;
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Uso: %s <NSTEPS>\n", argv[0]);
        return 1;
    }

    int nsteps = atoi(argv[1]);
    double d_pot = 10.0, alpha = 0.5;
    double xmin = -2.0, xmax = 25.0;
    double dx = (xmax - xmin) / (double)nsteps;

    double e_min = 0.0, e_max = 10.0, de = 0.001;
    double en_levels[5] = {0};
    int level = 0;

    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);

    double e_cur = e_min;
    double f_prev = fun_wave(e_cur, xmin, xmax, dx, nsteps, d_pot, alpha);

    while (e_cur < e_max && level < 5) {
        e_cur += de;
        double f_cur = fun_wave(e_cur, xmin, xmax, dx, nsteps, d_pot, alpha);

        if (f_prev * f_cur < 0.0) {
            double ea = e_cur - de;
            double eb = e_cur;
            double fa = f_prev;
            double emid;

            for (int iter = 0; iter < 100; iter++) {
                emid = 0.5 * (ea + eb);
                double fmid = fun_wave(emid, xmin, xmax, dx, nsteps, d_pot, alpha);
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

    return 0;
}
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

/* ================================
   🔧 POTENCIAL INLINE
================================ */
static inline double v_morse(double x, double D, double alpha) {
    double exp_term = exp(-alpha * x);
    double diff = 1.0 - exp_term;
    return D * diff * diff;
}

/* ================================
   💣 NUMEROV METHOD (OPTIMIZADO)
================================ */
double numerov_wave(double en, double x0, double h, int n, double D, double alpha) {

    /* 🔴 ANTES:
         RK4 → muchas operaciones
       🟢 AHORA:
         Numerov → esquema explícito eficiente
    */

    double psi_prev = 0.0;
    double psi = 1e-6;

    double x = x0;

    const double h2 = h * h;
    const double h2_12 = h2 / 12.0;

    /* 🔥 precompute k(x) */
    double k_prev = 2.0 * (v_morse(x, D, alpha) - en);

    x += h;
    double k_curr = 2.0 * (v_morse(x, D, alpha) - en);

    for (int i = 1; i < n; i++) {

        double x_next = x + h;

        double k_next = 2.0 * (v_morse(x_next, D, alpha) - en);

        /* 💣 NUMEROV CORE */
        double denom = 1.0 + h2_12 * k_next;

        double psi_next = (
            (2.0 * (1.0 - 5.0 * h2_12 * k_curr) * psi)
          - (1.0 + h2_12 * k_prev) * psi_prev
        ) / denom;

        psi_prev = psi;
        psi = psi_next;

        k_prev = k_curr;
        k_curr = k_next;

        x = x_next;

        /* 🔥 control overflow barato */
        if (__builtin_expect(fabs(psi) > 1e12, 0)) {
            psi *= 1e-12;
            psi_prev *= 1e-12;
        }
    }

    return psi;
}

/* ================================
   🚀 MAIN OPTIMIZADO
================================ */
int main(int argc, char *argv[]) {

    if (argc < 2) {
        printf("Uso: %s <NSTEPS>\n", argv[0]);
        return 1;
    }

    int nsteps = atoi(argv[1]);

    double d_pot = 10.0;
    double alpha = 0.5;

    double xmin = -2.0;
    double xmax = 25.0;

    double dx = (xmax - xmin) / (double)nsteps;

    double e_min = 0.0;
    double e_max = 10.0;
    double de = 0.001;

    double en_levels[5] = {0};
    int level = 0;

    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);

    double e_cur = e_min;
    double f_prev = numerov_wave(e_cur, xmin, dx, nsteps, d_pot, alpha);

    while (e_cur < e_max && level < 5) {

        e_cur += de;

        double f_cur = numerov_wave(e_cur, xmin, dx, nsteps, d_pot, alpha);

        if (f_prev * f_cur < 0.0) {

            double ea = e_cur - de;
            double eb = e_cur;
            double fa = f_prev;
            double emid;

            /* 🔥 bisección optimizada */
            for (int iter = 0; iter < 50; iter++) {

                emid = 0.5 * (ea + eb);

                double fmid = numerov_wave(emid, xmin, dx, nsteps, d_pot, alpha);

                if (fa * fmid < 0.0) {
                    eb = emid;
                } else {
                    ea = emid;
                    fa = fmid;
                }

                if (fabs(eb - ea) < 1e-10) break;
            }

            en_levels[level++] = emid;
        }

        f_prev = f_cur;
    }

    clock_gettime(CLOCK_MONOTONIC, &end);

    double time_used = (end.tv_sec - start.tv_sec)
                     + (end.tv_nsec - start.tv_nsec) / 1e9;

    printf("%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n",
           nsteps,
           en_levels[0],
           en_levels[1],
           en_levels[2],
           en_levels[3],
           time_used);

    return 0;
}
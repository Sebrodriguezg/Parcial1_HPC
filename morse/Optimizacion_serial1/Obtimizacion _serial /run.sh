#!/bin/bash

echo "==============================="
echo " COMPILANDO CODIGOS"
echo "==============================="

CFLAGS="-O3 -march=native -ffast-math"

# Base
gcc $CFLAGS -o morse_base morse_base.c -llapacke -llapack -lblas -lm
gcc $CFLAGS -o morse_base_op morse_base_op.c -llapacke -llapack -lblas -lm

# FDM
gcc $CFLAGS -o morse_fdm morse_fdm.c -llapacke -llapack -lblas -lm
gcc $CFLAGS -o morse_fdm_op morse_fdm_op.c -llapacke -llapack -lblas -lm

# Shooting
gcc $CFLAGS -o morse_shoot morse_shoot.c -lm
gcc $CFLAGS -o morse_shoot_op morse_shoot_op.c -lm

# Sinc
gcc $CFLAGS -o morse_sinc morse_sinc.c -llapacke -llapack -lblas -lm
gcc $CFLAGS -o morse_sinc_op morse_sinc_op.c -llapacke -llapack -lblas -lm


echo "==============================="
echo " EJECUTANDO BENCHMARK"
echo "==============================="

# Crear carpeta resultados
mkdir -p data

# ======================
# BASE (50 - 400)
# ======================
echo "Base..."
> data/base_orig.txt
> data/base_op.txt

for N in 50 100 150 200 250 300 350 400
do
    ./morse_base $N >> data/base_orig.txt
    ./morse_base_op $N >> data/base_op.txt
done

# ======================
# FDM (100 - 2000)
# ======================
echo "FDM..."
> data/fdm_orig.txt
> data/fdm_op.txt

for N in 100 200 300 400 500 700 1000 1500 2000
do
    ./morse_fdm $N >> data/fdm_orig.txt
    ./morse_fdm_op $N >> data/fdm_op.txt
done

# ======================
# SHOOTING (100 - 2000)
# ======================
echo "Shooting..."
> data/shoot_orig.txt
> data/shoot_op.txt

for N in 100 200 300 400 500 700 1000 1500 2000
do
    ./morse_shoot $N >> data/shoot_orig.txt
    ./morse_shoot_op $N >> data/shoot_op.txt
done

# ======================
# SINC (50 - 500)
# ======================
echo "Sinc..."
> data/sinc_orig.txt
> data/sinc_op.txt

for N in 50 100 150 200 250 300 400 500
do
    ./morse_sinc $N >> data/sinc_orig.txt
    ./morse_sinc_op $N >> data/sinc_op.txt
done


echo "==============================="
echo " GENERANDO GRAFICAS"
echo "==============================="

python3 << EOF
import numpy as np
import matplotlib.pyplot as plt

def plot_method(file_orig, file_op, title, output):
    orig = np.loadtxt(file_orig)
    op   = np.loadtxt(file_op)

    N_orig = orig[:,0]
    T_orig = orig[:,-1]

    N_op = op[:,0]
    T_op = op[:,-1]

    plt.figure()
    plt.plot(N_orig, T_orig, 'o-', label='Original')
    plt.plot(N_op, T_op, 's-', label='Optimizado')

    plt.xlabel("N")
    plt.ylabel("Tiempo (s)")
    plt.title(title)
    plt.legend()
    plt.grid()

    plt.savefig(output)
    plt.close()

# Generar todas
plot_method("data/base_orig.txt", "data/base_op.txt",
            "Metodo Base", "base.png")

plot_method("data/fdm_orig.txt", "data/fdm_op.txt",
            "Metodo FDM", "fdm.png")

plot_method("data/shoot_orig.txt", "data/shoot_op.txt",
            "Metodo Shooting", "shoot.png")

plot_method("data/sinc_orig.txt", "data/sinc_op.txt",
            "Metodo Sinc-DVR", "sinc.png")

print("Graficas generadas:")
print("base.png, fdm.png, shoot.png, sinc.png")
EOF

echo "==============================="
echo " LISTO"
echo "==============================="
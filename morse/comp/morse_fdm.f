      PROGRAM MORSE_FDM
C=======================================================================
C     ESPECTRO DEL POTENCIAL DE MORSE VIA DIFERENCIAS FINITAS (FDM)
C     VERSION ESTANDARIZADA PARA BENCHMARK HPC
C=======================================================================
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      
      CHARACTER*10 ARG_STR
      INTEGER N, I, J
      DOUBLE PRECISION T1, T2, XMIN, XMAX, DX, DX2, X_I, V_I
      
      DOUBLE PRECISION, ALLOCATABLE :: H(:,:), E(:), VP(:,:)
      DOUBLE PRECISION, ALLOCATABLE :: ATILDE(:,:), B(:), Z(:)

C     1. LECTURA DEL PARÁMETRO N (PUNTOS DE MALLA) DESDE CONSOLA
      CALL GET_COMMAND_ARGUMENT(1, ARG_STR)
      READ(ARG_STR, *) N

      ALLOCATE(H(N,N), E(N), VP(N,N))
      ALLOCATE(ATILDE(N,N), B(N), Z(N))

C     --- INICIO DE MEDICIÓN ---
      CALL CPU_TIME(T1)

C     2. PARÁMETROS DEL POTENCIAL Y MALLA
      D_POT = 10.D0
      ALPHA = 0.5D0
      XMIN = -2.D0
      XMAX = 15.D0
      DX = (XMAX - XMIN) / DBLE(N + 1)
      DX2 = DX * DX

C     3. INICIALIZACIÓN DEL HAMILTONIANO (FULL MATRIX - INEFICIENTE)
      DO 10 I=1,N
         DO 20 J=1,N
            H(I,J) = 0.D0
 20      CONTINUE
 10   CONTINUE

C     4. CONSTRUCCIÓN DE LA MATRIZ TRIDIAGONAL
      DO 30 I=1,N
         X_I = XMIN + DBLE(I) * DX
         
C        Término diagonal: -1/2 * (-2/DX2) + V(x) = 1/DX2 + V(x)
         V_I = D_POT * (1.D0 - DEXP(-ALPHA * X_I))**2
         H(I,I) = (1.D0 / DX2) + V_I
         
C        Términos fuera de la diagonal: -1/2 * (1/DX2)
         IF (I .LT. N) THEN
            H(I,I+1) = -1.D0 / (2.D0 * DX2)
            H(I+1,I) = H(I,I+1)
         END IF
 30   CONTINUE

C     5. DIAGONALIZACIÓN
C     Nota: Usar un solver de matriz densa para una tridiagonal es O(N^3)
      CALL EIGEN(H,N,N,E,VP,ATILDE,B,Z)

C     --- FIN DE MEDICIÓN ---
      CALL CPU_TIME(T2)

C     6. SALIDA ESTANDARIZADA (N, E0, E1, E2, E3, TIEMPO)
      WRITE(*,100) N, E(1), E(2), E(3), E(4), (T2-T1)
100   FORMAT(I8, 5(1X, F20.12))

      DEALLOCATE(H, E, VP, ATILDE, B, Z)
      END
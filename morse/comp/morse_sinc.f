      PROGRAM MORSE_SINC
C=======================================================================
C     ESPECTRO DEL POTENCIAL DE MORSE VIA SINC-DVR (MÉTODO ESPECTRAL)
C     VERSION ESTANDARIZADA PARA BENCHMARK HPC
C=======================================================================
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      
      CHARACTER*10 ARG_STR
      INTEGER N, I, J
      DOUBLE PRECISION T1, T2, PI, XMIN, XMAX, DX, DX2
      DOUBLE PRECISION X_I, V_I, SIGN_FACTOR, DIST2
      
      DOUBLE PRECISION, ALLOCATABLE :: H(:,:), E(:), VP(:,:)
      DOUBLE PRECISION, ALLOCATABLE :: ATILDE(:,:), B(:), Z(:)

C     1. LECTURA DEL PARÁMETRO N DESDE LA LÍNEA DE COMANDOS
      CALL GET_COMMAND_ARGUMENT(1, ARG_STR)
      READ(ARG_STR, *) N

      ALLOCATE(H(N,N), E(N), VP(N,N))
      ALLOCATE(ATILDE(N,N), B(N), Z(N))

      PI = 4.D0 * DATAN(1.D0)

C     --- INICIO DE MEDICIÓN ---
      CALL CPU_TIME(T1)

C     2. PARÁMETROS DEL POTENCIAL Y MALLA
      D_POT = 10.D0
      ALPHA = 0.5D0
      XMIN = -3.D0
      XMAX = 20.D0
      DX = (XMAX - XMIN) / DBLE(N)
      DX2 = DX * DX

C     3. CONSTRUCCIÓN DEL HAMILTONIANO SINC-DVR
C     Este método genera una matriz COMPLETAMENTE DENSA (O(N^2) en construcción)
      DO 10 I=1,N
         X_I = XMIN + DBLE(I)*DX
         V_I = D_POT * (1.D0 - DEXP(-ALPHA * X_I))**2
         
         DO 20 J=1,N
            IF (I .EQ. J) THEN
C              Elemento diagonal: T_ii + V(x_i)
               H(I,J) = (PI**2) / (6.D0 * DX2) + V_I
            ELSE
C              Elementos fuera de la diagonal (Energía Cinética No-Local)
               SIGN_FACTOR = (-1.D0)**DBLE(I-J)
               DIST2 = DBLE(I-J)**2
               H(I,J) = SIGN_FACTOR / (DX2 * DIST2)
            END IF
 20      CONTINUE
 10   CONTINUE

C     4. DIAGONALIZACIÓN
      CALL EIGEN(H,N,N,E,VP,ATILDE,B,Z)

C     --- FIN DE MEDICIÓN ---
      CALL CPU_TIME(T2)

C     5. SALIDA ESTANDARIZADA (N, E0, E1, E2, E3, TIEMPO)
      WRITE(*,100) N, E(1), E(2), E(3), E(4), (T2-T1)
100   FORMAT(I8, 5(1X, F20.12))

      DEALLOCATE(H, E, VP, ATILDE, B, Z)
      END
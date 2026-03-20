      PROGRAM MORSE_FDM
C=======================================================================
C     ESPECTRO DEL POTENCIAL DE MORSE VIA DIFERENCIAS FINITAS (FDM)
C     Compilación: gfortran -ffixed-form morse_fdm.f eigen.f -llapack -lblas -o morse_fdm
C=======================================================================
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      PARAMETER (N=1000)

      DIMENSION H(N,N), E(N), VP(N,N)
      DIMENSION ATILDE(N,N), B(N), Z(N)

C     PARAMETROS DEL POTENCIAL DE MORSE
      D_POT = 10.D0
      ALPHA = 0.5D0

C     PARAMETROS DE LA MALLA ESPACIAL
      XMIN = -2.D0
      XMAX = 15.D0
      DX = (XMAX - XMIN) / FLOAT(N+1)
      DX2 = DX * DX

C     INICIALIZACION DEL HAMILTONIANO
      DO I=1,N
         DO J=1,N
            H(I,J) = 0.D0
         END DO
      END DO

C     CONSTRUCCION DE LA MATRIZ TRIDIAGONAL
C     Energía Cinética T = - (1/2) * d^2/dx^2
      DO I=1,N
         X_I = XMIN + FLOAT(I) * DX
         
C        Término diagonal de la energía cinética + Potencial
         V_I = D_POT * (1.D0 - DEXP(-ALPHA * X_I))**2
         H(I,I) = (1.D0 / DX2) + V_I
         
C        Términos fuera de la diagonal (energía cinética)
         IF (I .LT. N) THEN
            H(I,I+1) = -1.D0 / (2.D0 * DX2)
            H(I+1,I) = H(I,I+1)
         END IF
      END DO

C     DIAGONALIZACION
      CALL EIGEN(H,N,N,E,VP,ATILDE,B,Z)

C     IMPRESION DE LOS PRIMEROS 5 NIVELES
      WRITE(6,*) 'NIVELES DE ENERGIA - FDM'
      DO I=1,5
         WRITE(6,*) I-1, E(I)
      END DO

      END
        PROGRAM MORSE_SINC
C=======================================================================
C     ESPECTRO DEL POTENCIAL DE MORSE VIA SINC-DVR (MÉTODO ESPECTRAL)
C     Compilación: gfortran -ffixed-form morse_sinc.f eigen.f -llapack -lblas -o morse_sinc
C=======================================================================
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      PARAMETER (N=200)
      
      DIMENSION H(N,N), E(N), VP(N,N)
      DIMENSION ATILDE(N,N), B(N), Z(N)

      PI = 4.D0 * DATAN(1.D0)
      
C     PARAMETROS DEL POTENCIAL
      D_POT = 10.D0
      ALPHA = 0.5D0

C     PARAMETROS DE LA MALLA
      XMIN = -3.D0
      XMAX = 20.D0
      DX = (XMAX - XMIN) / FLOAT(N)
      DX2 = DX * DX

      DO I=1,N
         X_I = XMIN + FLOAT(I)*DX
         V_I = D_POT * (1.D0 - DEXP(-ALPHA * X_I))**2
         
         DO J=1,N
            IF (I .EQ. J) THEN
               H(I,J) = (PI**2) / (6.D0 * DX2) + V_I
            ELSE
               SIGN_FACTOR = (-1.D0)**(I-J)
               DIST2 = FLOAT(I-J)**2
               H(I,J) = SIGN_FACTOR / (DX2 * DIST2)
            END IF
         END DO
      END DO

      CALL EIGEN(H,N,N,E,VP,ATILDE,B,Z)

      WRITE(6,*) 'NIVELES DE ENERGIA - SINC-DVR'
      DO I=1,5
         WRITE(6,*) I-1, E(I)
      END DO

      END
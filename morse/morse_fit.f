      PROGRAM MORSE
C=======================================================================
C     PROGRAMA PARA CALCULAR EL ESPECTRO DEL POTENCIAL DE MORSE
C     PARAMETROS SINCRONIZADOS: D=10.0, ALPHA=0.5
C=======================================================================
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      PARAMETER (N=150)
      
      DIMENSION X(N,N), P(N,N), T(N,N), VMAT(N,N), H(N,N)
      DIMENSION E(N), VP(N,N)
      DIMENSION ATILDE(N,N), B(N), Z(N)

C     1. CONSTRUCCION DE MATRICES X Y P (BASE HO, m=1, w=1)
      DO I=1,N
         DO J=1,N
            X(I,J)=0.D0
            P(I,J)=0.D0
         END DO
      END DO

      DO I=1,N-1
         A_VAL=FLOAT(I)
         X(I,I+1)=DSQRT(A_VAL/2.D0)
         X(I+1,I)=X(I,I+1)
C        Matriz de momentum (escalada)
         P(I,I+1)=-DSQRT(A_VAL/2.D0)
         P(I+1,I)=DSQRT(A_VAL/2.D0)
      END DO

C     2. DIAGONALIZACION DE X PARA OBTENER PUNTOS DE MALLA (DVR)
      CALL EIGEN(X,N,N,E,VP,ATILDE,B,Z)

C     3. ENERGIA CINETICA T = P*P / 2 
C        (Notese que P es antisimetrica, T sera negativa definida)
      CALL MATMUT(P,P,T,N)

C     4. CALCULO DE LA MATRIZ DE POTENCIAL V_ij
      DO I=1,N
         DO J=I,N
            SUM=0.D0
            DO K=1,N
               SUM=SUM + VP(I,K) * V_FUNC(E(K)) * VP(J,K)
            END DO
            VMAT(I,J)=SUM
            VMAT(J,I)=SUM
         END DO
      END DO

C     5. CONSTRUCCION DEL HAMILTONIANO H = -0.5*T + V
C        El factor -0.5 corrige la naturaleza de la matriz P cuadrada
      DO I=1,N
         DO J=1,N
            H(I,J) = -0.5D0 * T(I,J) + VMAT(I,J)
         END DO
      END DO

C     6. DIAGONALIZACION FINAL
      CALL EIGEN(H,N,N,E,VP,ATILDE,B,Z)

      WRITE(6,*) 'NIVELES DE ENERGIA (BASE TRANSFORMATION):'
      DO I=1,5
         WRITE(6,100) I-1, E(I)
      END DO

 100  FORMAT(' Nivel: ', I1, '  E = ', F14.10)
      END

C=======================================================================
      FUNCTION V_FUNC(X)
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
C     PARAMETROS DEL PROBLEMA (DEBEN SER IDENTICOS A FDM/SHOOT)
      D = 10.D0
      ALPHA = 0.5D0
      V_FUNC = D * (1.D0 - DEXP(-ALPHA*X))**2
      RETURN
      END

C=======================================================================
      SUBROUTINE MATMUT(A,B,C,N)
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      DIMENSION A(N,N), B(N,N), C(N,N)
      DO I=1,N
         DO J=1,N
            C(I,J)=0.D0
            DO K=1,N
               C(I,J)=C(I,J) + A(I,K) * B(K,J)
            END DO
         END DO
      END DO
      RETURN
      END
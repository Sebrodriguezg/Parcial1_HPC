      PROGRAM MORSE
C=======================================================================
C      PROGRAMA EN CRUDO - VERSIÓN BASE PARA COMPARACIÓN HPC
C=======================================================================
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      
      CHARACTER*10 ARG_STR
      INTEGER N, I, J, K
      DOUBLE PRECISION T1, T2, A_VAL, SUM
      
      DOUBLE PRECISION, ALLOCATABLE :: X(:,:), P(:,:), T(:,:)
      DOUBLE PRECISION, ALLOCATABLE :: VMAT(:,:), H(:,:)
      DOUBLE PRECISION, ALLOCATABLE :: E(:), VP(:,:)
      DOUBLE PRECISION, ALLOCATABLE :: ATILDE(:,:), B(:), Z(:)

C     1. LECTURA DEL PARÁMETRO N DESDE LA LÍNEA DE COMANDOS
      CALL GET_COMMAND_ARGUMENT(1, ARG_STR)
      READ(ARG_STR, *) N

      ALLOCATE(X(N,N), P(N,N), T(N,N), VMAT(N,N), H(N,N))
      ALLOCATE(E(N), VP(N,N), ATILDE(N,N), B(N), Z(N))

C     --- INICIO DE MEDICIÓN ---
C     Solo medimos el tiempo de proceso matemático, ignorando el I/O inicial
      CALL CPU_TIME(T1)

C     2. CONSTRUCCIÓN DE MATRICES X Y P
      DO 10 I=1,N
         DO 20 J=1,N
            X(I,J)=0.D0
            P(I,J)=0.D0
 20      CONTINUE
 10   CONTINUE

      DO 30 I=1,N-1
         A_VAL=DBLE(I)
         X(I,I+1)=DSQRT(A_VAL/2.D0)
         X(I+1,I)=X(I,I+1)
         P(I,I+1)=-DSQRT(A_VAL/2.D0)
         P(I+1,I)=DSQRT(A_VAL/2.D0)
 30   CONTINUE

C     3. DIAGONALIZACIÓN DE X
      CALL EIGEN(X,N,N,E,VP,ATILDE,B,Z)

C     4. CÁLCULO DE ENERGÍA CINÉTICA
      CALL MATMUT(P,P,T,N)

C     5. CÁLCULO DE LA MATRIZ DE POTENCIAL
      DO 40 I=1,N
         DO 50 J=I,N
            SUM=0.D0
            DO 60 K=1,N
               SUM=SUM + VP(I,K) * V_FUNC(E(K)) * VP(J,K)
 60         CONTINUE
            VMAT(I,J)=SUM
            VMAT(J,I)=SUM
 50      CONTINUE
 40   CONTINUE

C     6. CONSTRUCCIÓN DEL HAMILTONIANO
      DO 70 I=1,N
         DO 80 J=1,N
            H(I,J) = -0.5D0 * T(I,J) + VMAT(I,J)
 80      CONTINUE
 70   CONTINUE

C     7. DIAGONALIZACIÓN FINAL
      CALL EIGEN(H,N,N,E,VP,ATILDE,B,Z)

C     --- FIN DE MEDICIÓN ---
      CALL CPU_TIME(T2)

C     8. SALIDA ESTANDARIZADA
C     Formato: N | E0 | E1 | E2 | E3 | Tiempo_Total
      WRITE(*,100) N, E(1), E(2), E(3), E(4), (T2-T1)
100   FORMAT(I8, 5(1X, F20.12))

      DEALLOCATE(X, P, T, VMAT, H, E, VP, ATILDE, B, Z)
      END

C=======================================================================
      FUNCTION V_FUNC(X)
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      D=10.D0
      BETA=0.5D0
      V_FUNC = D * (1.D0 - DEXP(-BETA*X))**2
      RETURN
      END

C=======================================================================
      SUBROUTINE MATMUT(A,B,C,N)
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      DIMENSION A(N,N), B(N,N), C(N,N)
      DO 90 I=1,N
         DO 110 J=1,N
            C(I,J)=0.D0
            DO 120 K=1,N
               C(I,J)=C(I,J) + A(I,K) * B(K,J)
 120        CONTINUE
 110     CONTINUE
 90   CONTINUE
      RETURN
      END
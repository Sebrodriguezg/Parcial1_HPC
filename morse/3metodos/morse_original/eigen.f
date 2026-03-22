      SUBROUTINE EIGEN(A,N,NP,D,V,ATILDE,B,Z)
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)

      INTEGER N,NP,INFO
      DOUBLE PRECISION A(NP,NP),D(NP),V(NP,NP)
      DOUBLE PRECISION ATILDE(NP,NP),B(NP),Z(NP)

      CHARACTER JOBZ,UPLO

C     workspace grande fijo (suficiente para N~500)
      DOUBLE PRECISION WORK(10000)

C     copiar matriz A en V porque DSYEV destruye A
      DO I=1,N
      DO J=1,N
         V(I,J)=A(I,J)
      END DO
      END DO

      JOBZ='V'
      UPLO='U'

      CALL DSYEV(JOBZ,UPLO,N,V,NP,D,WORK,10000,INFO)

      RETURN
      END
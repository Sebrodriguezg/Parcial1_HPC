      PROGRAM ELE_MAT
C======================================================= compilar con gfortran -ffixed-form ele_mat.f eigen.f -llapack -lblas -o ele_mat        
C     PROGRAMA PARA CALCULAR EL ELEMENTO MATRICIAL
C     <I|F(X)|J>
C=======================================================

      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      PARAMETER (N=200)

      DIMENSION X(N,N),E(N),VP(N,N)
      DIMENSION ATILDE(N,N),B(N),Z(N)

C     CONSTRUCCION DE LA MATRIZ X

      DO I=1,N
         DO J=1,N
            X(I,J)=0.D0
         END DO
      END DO

      DO I=1,N-1
         PP=FLOAT(I)
         X(I,I+1)=DSQRT(PP/2.D0)
         X(I+1,I)=X(I,I+1)
      END DO

C     DIAGONALIZACION

      CALL EIGEN(X,N,N,E,VP,ATILDE,B,Z)

C     CALCULO DEL ELEMENTO <I|F(X)|J>

      WRITE(6,*) 'VALOR DE I,J'
      READ(5,*) I,J

      SUM=0.D0

      DO K=1,N
         SUM=SUM+VP(I,K)*F(E(K))*VP(J,K)
      END DO

      ELEMAT=SUM

      WRITE(6,*) I,J,ELEMAT

      END


      FUNCTION F(X)

      IMPLICIT DOUBLE PRECISION (A-H,O-Z)

      F=DEXP(-X*X)

      RETURN
      END
      
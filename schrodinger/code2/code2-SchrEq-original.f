      PROGRAM CAYLEY

      IMPLICIT REAL*8 (A-H,O-Z)
      PARAMETER (NPTS = 4096 )
      DIMENSION X(0:NPTS), V(0:NPTS)
      COMPLEX GAMA(0:NPTS), PHI(0:NPTS), GAUSSIANA
      CHARACTER*10 ARCHIVO
      WRITE (6,*) 'EN QUE ARCHIVO DESEA GUARDAR LOS DATOS?'
      READ (5,*) ARCHIVO
      OPEN (10,FILE=ARCHIVO)
      NT = 1000
      DT=0.005D0
      DX = 40.D0/NPTS

C======================================================================
C     FUNCION DE ONDA PARA T=0
C     PARAMETROS DEL PAQUETE
      X0 = -10.D0
      WRITE (6,*) 'ANCHO DEL PAQUETE ? [2.0]'
      READ (5,*) ANCHO
      WRITE (6,*) 'MOMENTUM DEL PAQUETE ? [1.0]'
      READ (5,*) P
      WRITE (6,*) 'ALTURA DE LA BARRERA DE POTENCIAL? [100]'
      READ (5,*) V0
      DO I=1, NPTS
      X(I)=-20.D0+DX*(NPTS-I)
      V(I)=POT(X(I),V0)
      PHI(I)=GAUSSIANA(X(I),X0,P,ANCHO)
      END DO
      PHI(0) = 0.D0
      PHI(NPTS) = 0.D0

C======================================================================
      CALL TRIDIAG(NPTS, DX, DT, GAMA, V)

      TIEMPO=0.
            DO J=1 ,NPTS, 5
            WRITE (10,*) TIEMPO,X(J), CABS(PHI(J))
            END DO
            WRITE (10, '()')
            WRITE (10, '()')
      DO IT=1,NT
            TIEMPO=TIEMPO+DT
            CALL EVOLUCION(PHI,GAMA,DX,DT,NPTS)
            IF(MOD(IT,100).EQ.0) THEN
            DO J=1,NPTS,5
            WRITE (10,*) TIEMPO,X(J), CABS(PHI(J))
            END DO
            WRITE (10, '()')
            WRITE (10, '()')
            ELSE
            END IF
      END DO
      CLOSE (10)
      END

C======================================================================
      SUBROUTINE TRIDIAG(NPTS,DX,DT,GAMA,V)
      IMPLICIT REAL*8 (A-H,O-Z)
      DIMENSION V(0:NPTS)
      COMPLEX GAMA(0:NPTS)
      COMPLEX CI
      CI = (0.D0, 1.D0)
      GAMA(NPTS)=0.D0
      DO IX=NPTS-1,0,-1
      GAMA(IX)=-1.D0/((-2.D0+2.D0*CI*DX**2/DT)-
     &               (DX*DX*V(IX))+GAMA(IX+1))
      END DO
      RETURN
      END

C======================================================================
      SUBROUTINE EVOLUCION(PHI,GAMA,DX,DT,NPTS)
      IMPLICIT REAL*8 (A-H,O-Z)
      COMPLEX GAMA(0:NPTS), PHI(0:NPTS), BETA(0:4096)
      COMPLEX CI, CHI
      CI = (0.D0, 1.D0)
      BETA(NPTS-1)=PHI(NPTS)
      DO IX=NPTS-2,0,-1
      BETA(IX)=GAMA(IX+1)*
     &         (BETA(IX+1)-(4.D0*CI*DX*DX/DT)*PHI(IX+1))
      END DO
      CHI=0.D0
      DO IX=1,NPTS-1
      CHI=GAMA(IX)*CHI+BETA(IX-1)
      PHI(IX)=CHI-PHI(IX)
      END DO
      RETURN
      END

C======================================================================
      FUNCTION GAUSSIANA(X, X0, P, ANCHO)
      IMPLICIT REAL*8 (A-H,O-Z)
      COMPLEX CI,GAUSSIANA
      CI=(0.D0,1.D0)
      PI=DACOS(-1.D0)
      AA=DSQRT(DSQRT(2.D0*PI*ANCHO*ANCHO))
      GAUSSIANA=CDEXP(CI*P*X-((X-X0)*(X-X0)/
     &               (4.D0*ANCHO*ANCHO)))/AA
      RETURN
      END

C======================================================================
      FUNCTION POT(X,V0)
      IMPLICIT REAL*8(A-H,O-Z)
      POT=0.D0
      IF(X.GE.0.D0) POT=V0
      RETURN
      END

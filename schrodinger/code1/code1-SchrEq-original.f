      PROGRAM SEUDO_ESPECTRAL

      IMPLICIT REAL*8 (A-H,O-Z)
      PARAMETER (LOG2N = 12 )
      COMPLEX*16 CI, GAUSSIANA, PSI(2**LOG2N),
     &           PHI(2**LOG2N), EXPV(2**LOG2N),
     &           EXPT(2**LOG2N)
      DIMENSION X(2**LOG2N)
      DOUBLE PRECISION K
      CHARACTER*10 ARCHIVO
      CI=(0.D0,1.D0)
      NPT = 2**LOG2N
      NT = 1000
      PI = 4.D0*DATAN(1.D0)
      DT=5.D-3
      DX = 40.D0/NPT
      DELTAK = 2.D0*PI/(NPT*DX)
      WRITE (6,*) 'EN QUE ARCHIVO DESEA GUARDAR LOS DATOS?'
      READ (5,*) ARCHIVO
      OPEN (10,FILE=ARCHIVO)

C     FUNCION DE ONDA PARA T=0
C     PARAMETROS DEL PAQUETE
      X0 = -10.D0
      WRITE (6,*) 'ANCHO DEL PAQUETE ? [2.0]'
      READ (5,*) ANCHO
      WRITE (6,*) 'MOMENTUM DEL PAQUETE ? [1.0]'
      READ (5,*) P
      DO I=1, NPT
      X(I)=-20.+I*DX
      PSI(I)=GAUSSIANA(X(I),X0,P,ANCHO)
      END DO

C     ARREGLO EXP[V(X)]
      WRITE (6,*) 'ALTURA DE LA BARRERA DE POTENCIAL? [100]'
      READ (5,*) V0
      DO I=1, NPT
      EXPV(I)=CDEXP(-CI*V(X(I),V0)*DT/2.D0)
      END DO

C     ARREGLO T(K)=K*K
      DO I=1, NPT/2
      K=(I-1)*DELTAK
      T=K*K
      EXPT(I)=CDEXP(-CI*T*DT)
      K=-(I-1)*DELTAK
      T=K*K
      EXPT(NPT+1-I)=CDEXP(-CI*T*DT)
       END DO

C======================================================================
C     CICLO SOBRE EL TIEMPO
C     TIEMPO INICIAL
      T = 0
      DO J=1, NT
      T = T+DT

C     PRIMER PASO
      DO I=1, NPT
      PHI(I)=EXPV(I)*PSI(I)
      END DO

C     SEGUNDO PASO
C     A) TRANSFORMADA DE FOURIER
      CALL FFT(PHI,LOG2N,0)
C     B) MULTIPLICACION POR EXPT
      DO I=1, NPT
      PHI(I)=EXPT(I)*PHI(I)
      END DO
C     TRANSFORMADA INVERSA
      CALL FFT(PHI,LOG2N,1)

C     TERCER PASO
      DO I=1, NPT
      PSI(I)=EXPV(I)*PHI(I)
      END DO
      IF(MOD(J,100).EQ.0) THEN

      DO I=1, NPT,5
      WRITE (10,'(4F15.7)') T,X(I), CDABS(PSI(I)),
     &                      V(X(I),V0)/2./V0
      END DO
      WRITE (10,'()')
      WRITE (10,'()')
      ELSE 
      END IF
      END DO
      CLOSE (10)
      END
  
C======================================================================
      FUNCTION GAUSSIANA(X,X0,P,ANCHO)
      IMPLICIT REAL*8 (A-H,O-Z)
      COMPLEX*16 CI,GAUSSIANA
      CI=(0.D0,1.D0)
      PI=DACOS(-1.D0)
      AA=DSQRT(DSQRT(2.D0*PI*ANCHO*ANCHO))
      GAUSSIANA=CDEXP(CI*P*X-((X-X0)*(X-X0)/
     &               (4.D0*ANCHO*ANCHO)))/AA
      RETURN
      END
C======================================================================
      FUNCTION V(X,V0)
      IMPLICIT REAL*8 (A-H,O-Z)
      V=0.D0
      IF(X.GE.0.D0) V=V0
      RETURN
      END
C======================================================================
      SUBROUTINE FFT(A,M,INV)
      IMPLICIT REAL*8(A-H,O-Z)
      COMPLEX*16 A(1), U, W, T

C     RUTINA OARA CALCULAR LA TRANSFORMADA RAPIDA DE FOURIER 
      PI=4.D0*DATAN(1.D0)
      N = 2**M
      ND2 = N/2
      J = 1
      DO I = 1, N-1
      IF( I .LT. J ) THEN
      T = A(J)
      A(J) = A(I)
      A(I) = T
      ENDIF
      K = ND2
100   IF( K .LT. J ) THEN
      J = J - K
      K = K/2
      GOTO 100
      ENDIF
      J = J+K
      END DO
      LE = 1
      DO L = 1, M
      LE1 = LE
      LE = LE + LE
      U = ( 1.D0, 0.D0 )
      ANG = PI / FLOAT(LE1)
      W = DCMPLX( DCOS(ANG), -DSIN(ANG) )
      IF(INV .EQ. 1) W = DCONJG(W)
      DO J = 1, LE1
      DO I = J, N, LE
      IP = I+LE1
      T = A(IP)*U
      A(IP)=A(I)-T
      A(I)=A(I)+T
      END DO
      U = U*W
      END DO
      END DO
      IF(INV .NE. 1) THEN
      DO I = 1, N
      A(I) = A(I) /FLOAT(N)
      END DO
      ENDIF
      END



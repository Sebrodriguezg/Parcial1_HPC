      PROGRAM MORSE_SHOOT
C=======================================================================
C     ESPECTRO DEL POTENCIAL DE MORSE VIA SHOOTING METHOD (RK4)
C     VERSION ESTANDARIZADA PARA BENCHMARK HPC
C=======================================================================
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      
      CHARACTER*10 ARG_STR
      INTEGER NSTEPS, LEVEL, ITER
      DOUBLE PRECISION T1, T2, D_POT, ALPHA, XMIN, XMAX, DX
      DOUBLE PRECISION E_CUR, E_MIN, E_MAX, DE, F_PREV, F_CUR
      DOUBLE PRECISION EA, EB, FA, FMID, EMID
      DOUBLE PRECISION EN_LEVELS(5)

C     1. LECTURA DEL PARÁMETRO N (PASOS DE INTEGRACIÓN)
      CALL GET_COMMAND_ARGUMENT(1, ARG_STR)
      READ(ARG_STR, *) NSTEPS

C     PARAMETROS FISICOS (Mantenidos del original)
      D_POT = 10.0D0
      ALPHA = 0.5D0
      XMIN  = -2.0D0
      XMAX  = 25.0D0 
      DX = (XMAX - XMIN) / DBLE(NSTEPS)
      
      E_MIN = 0.0D0
      E_MAX = 10.0D0 
      DE    = 0.001D0 

C     --- INICIO DE MEDICIÓN ---
      CALL CPU_TIME(T1)

      E_CUR = E_MIN
      F_PREV = FUN_WAVE(E_CUR, XMIN, XMAX, DX, NSTEPS, D_POT, ALPHA)
      LEVEL = 0
      
C     2. BÚSQUEDA DE NIVELES (DISPARO + BISECCIÓN)
      DO WHILE (E_CUR .LT. E_MAX .AND. LEVEL .LT. 5)
         E_CUR = E_CUR + DE
         F_CUR = FUN_WAVE(E_CUR, XMIN, XMAX, DX, NSTEPS, D_POT, ALPHA)
         
         IF (F_PREV * F_CUR .LT. 0.D0) THEN
            EA = E_CUR - DE
            EB = E_CUR
            FA = F_PREV
            
            DO 10 ITER=1, 100 
               EMID = 0.5D0 * (EA + EB)
               FMID = FUN_WAVE(EMID,XMIN,XMAX,DX,NSTEPS,D_POT,ALPHA)
               IF (FA * FMID .LT. 0.D0) THEN
                  EB = EMID
               ELSE
                  EA = EMID
                  FA = FMID
               END IF
 10         CONTINUE
            
            LEVEL = LEVEL + 1
            IF (LEVEL .LE. 5) EN_LEVELS(LEVEL) = EMID
         END IF
         F_PREV = F_CUR
      END DO

C     --- FIN DE MEDICIÓN ---
      CALL CPU_TIME(T2)

C     3. SALIDA ESTANDARIZADA (N, E0, E1, E2, E3, E4, TIEMPO)
      WRITE(*,100) NSTEPS, (EN_LEVELS(I), I=1,4), (T2-T1)
100   FORMAT(I8, 5(1X, F20.12))

      END

C=======================================================================
      DOUBLE PRECISION FUNCTION FUN_WAVE(EN, X0, XF, H, N, D, ALP)
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      
      PSI = 0.0D0     
      PHI = 1.0D-6    
      X = X0
      
      DO 20 I=1, N
         RK1_PSI = PHI
         RK1_PHI = 2.0D0 * (V_MORSE(X, D, ALP) - EN) * PSI
         
         XM2 = X + 0.5D0*H
         V_M = 2.0D0 * (V_MORSE(XM2, D, ALP) - EN)
         RK2_PSI = PHI + 0.5D0*H*RK1_PHI
         RK2_PHI = V_M * (PSI + 0.5D0*H*RK1_PSI)
         
         RK3_PSI = PHI + 0.5D0*H*RK2_PHI
         RK3_PHI = V_M * (PSI + 0.5D0*H*RK2_PSI)
         
         XF1 = X + H
         V_E = 2.0D0 * (V_MORSE(XF1, D, ALP) - EN)
         RK4_PSI = PHI + H*RK3_PHI
         RK4_PHI = V_E * (PSI + H*RK3_PSI)
         
         PSI = PSI + (H/6.0D0)*(RK1_PSI + 2.0D0*RK2_PSI + 
     &         2.0D0*RK3_PSI + RK4_PSI)
         PHI = PHI + (H/6.0D0)*(RK1_PHI + 2.0D0*RK2_PHI + 
     &         2.0D0*RK3_PHI + RK4_PHI)
         X = X + H
         
C        Normalización preventiva para evitar desbordamiento (Overflow)
         IF (DABS(PSI) .GT. 1.0D15) THEN
            PHI = PHI / 1.0D15
            PSI = PSI / 1.0D15
         END IF
 20   CONTINUE
      
      FUN_WAVE = PSI
      RETURN
      END

C=======================================================================
      DOUBLE PRECISION FUNCTION V_MORSE(X, D, ALP)
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      V_MORSE = D * (1.0D0 - DEXP(-ALP * X))**2
      RETURN
      END
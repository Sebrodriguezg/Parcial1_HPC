      PROGRAM MORSE_SHOOT
C=======================================================================
C     ESPECTRO DEL POTENCIAL DE MORSE VIA Shoot
C     Compilación: gfortran -ffixed-form morse_shoot.f eigen.f -llapack -lblas -o morse_shoot
C=======================================================================
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      
      D_POT = 10.D0
      ALPHA = 0.5D0
      XMIN = -2.D0
      XMAX = 18.D0 ! Aumentamos un poco el alcance asintótico
      NSTEPS = 8000 ! Más pasos para compensar el aumento de XMAX
      DX = (XMAX - XMIN) / FLOAT(NSTEPS)
      
      E_MIN = 0.0D0
      E_MAX = 10.0D0 ! Rango de energía extendido gfortran -ffixed-form morse_shoot.f -o morse_shoot
      DE = 0.005D0 ! Un paso de 0.005 es suficiente y rápido
      
      WRITE(6,*) 'NIVELES DE ENERGIA - SHOOTING RK4 (4 NIVELES)'
      
      E_CUR = E_MIN
      F_PREV = FUN_WAVE(E_CUR, XMIN, XMAX, DX, NSTEPS, D_POT, ALPHA)
      LEVEL = 0
      
      DO WHILE (E_CUR .LT. E_MAX .AND. LEVEL .LT. 4)
         E_CUR = E_CUR + DE
         F_CUR = FUN_WAVE(E_CUR, XMIN, XMAX, DX, NSTEPS, D_POT, ALPHA)
         
         IF (F_PREV * F_CUR .LT. 0.D0) THEN
            EA = E_CUR - DE
            EB = E_CUR
            F_A = F_PREV
            DO ITER=1, 80 ! Más iteraciones para máxima precisión
               EMID = 0.5D0 * (EA + EB)
               FMID = FUN_WAVE(EMID,XMIN,XMAX,DX,NSTEPS,D_POT,ALPHA)
               IF (F_A * FMID .LT. 0.D0) THEN
                  EB = EMID
               ELSE
                  EA = EMID
                  F_A = FMID
               END IF
            END DO
            WRITE(6,100) LEVEL, EMID
            LEVEL = LEVEL + 1
         END IF
         F_PREV = F_CUR
      END DO
      
 100  FORMAT(' Nivel: ', I1, '  E = ', F12.8)
      END

      DOUBLE PRECISION FUNCTION FUN_WAVE(EN, X0, XF, H, N, D, ALP)
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      
      PSI = 0.D0
      PHI = 1.D-8 ! Valor inicial más pequeño para evitar saturación
      X = X0
      
      DO I=1, N
         XK1 = PHI
         VK1 = 2.D0*(D*(1.D0-DEXP(-ALP*X))**2 - EN)*PSI
         
         X_M = X + 0.5D0*H
         V_M = 2.D0*(D*(1.D0-DEXP(-ALP*X_M))**2 - EN)
         
         XK2 = PHI + 0.5D0*H*VK1
         VK2 = V_M * (PSI + 0.5D0*H*XK1)
         
         XK3 = PHI + 0.5D0*H*VK2
         VK3 = V_M * (PSI + 0.5D0*H*XK2)
         
         X_E = X + H
         V_E = 2.D0*(D*(1.D0-DEXP(-ALP*X_E))**2 - EN)
         
         XK4 = PHI + H*VK3
         VK4 = V_E * (PSI + H*XK3)
         
         PSI = PSI + (H/6.D0)*(XK1 + 2.D0*XK2 + 2.D0*XK3 + XK4)
         PHI = PHI + (H/6.D0)*(VK1 + 2.D0*VK2 + 2.D0*VK3 + VK4)
         X = X + H
         
C        Control de flujo para evitar divergencias numéricas extremas
         IF (DABS(PSI) .GT. 1.D10) PSI = PSI / 1.D10
      END DO
      
      FUN_WAVE = PSI
      RETURN
      END
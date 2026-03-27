module math_utils_se
  implicit none
  integer, parameter :: dp = kind(1.d0)
contains
  function gaussiana(x, x0, p, ancho) result(res)
    real(dp), intent(in) :: x, x0, p, ancho
    complex(dp) :: res
    complex(dp), parameter :: ci = (0.0_dp, 1.0_dp)
    real(dp) :: pi, aa
    pi = acos(-1.0_dp)
    aa = sqrt(sqrt(2.0_dp * pi * ancho**2))
    res = exp(ci * p * x - ((x - x0)**2 / (4.0_dp * ancho**2))) / aa
  end function gaussiana

  elemental function v_pot(x, v0) result(res)
    real(dp), intent(in) :: x, v0
    real(dp) :: res
    res = 0.0_dp
    if (x >= 0.0_dp) res = v0
  end function v_pot

  ! Subrutina FFT con Loop Interchange
  subroutine fft(a, m, inv)
    integer, intent(in) :: m, inv
    complex(dp), intent(inout) :: a(:)
    real(dp) :: pi, ang
    integer :: n, nd2, i, j, k, l, le, le1, ip
    complex(dp) :: u, w, t
    pi = 4.0_dp * atan(1.0_dp)
    n = 2**m
    
    ! Bit-Reversal
    nd2 = n / 2
    j = 1
    do i = 1, n - 1
      if (i < j) then
        t = a(j)
        a(j) = a(i)
        a(i) = t
      end if
      k = nd2
      do while (k < j)
        j = j - k
        k = k / 2
      end do
      j = j + k
    end do
    
    ! Butterfly Optimizado (Stride-1)
    le = 1
    do l = 1, m
      le1 = le
      le = le + le
      ang = pi / real(le1, dp)
      w = cmplx(cos(ang), -sin(ang), kind=dp)
      if (inv == 1) w = conjg(w)
      
      do k = 1, n, le
        u = cmplx(1.0_dp, 0.0_dp, kind=dp)
        do j = 1, le1
          i = k + j - 1
          ip = i + le1
          t = a(ip) * u
          a(ip) = a(i) - t
          a(i) = a(i) + t
          u = u * w
        end do
      end do
    end do
    
    if (inv /= 1) then
      do i = 1, n
        a(i) = a(i) / real(n, dp)
      end do
    end if
  end subroutine fft
end module math_utils_se

program seudo_espectral
  use math_utils_se
  implicit none
  
  integer :: log2n, npt, nt, i, j, B, ib
  real(dp) :: dt, dx, L, deltak, k_val, t_val, t_time, pi
  real(dp) :: x0, ancho, p, v0, norma
  character(len=100) :: archivo
  complex(dp), parameter :: ci = (0.0_dp, 1.0_dp)
  
  real(dp), allocatable :: x(:)
  complex(dp), allocatable :: psi(:), phi(:), expv(:), expt(:)

  ! Lectura de parámetros desde stdin
  read(5,*) archivo
  read(5,*) ancho
  read(5,*) p
  read(5,*) v0
  read(5,*) log2n
  read(5,*) dt
  read(5,*) L
  read(5,*) nt
  read(5,*) B   ! Parámetro de Blocking

  npt = 2**log2n
  allocate(x(npt), psi(npt), phi(npt), expv(npt), expt(npt))
  
  dx = L / real(npt, dp)
  pi = 4.0_dp * atan(1.0_dp)
  deltak = 2.0_dp * pi / L

  open(10, file=trim(archivo))
  x0 = -10.0_dp

  do i = 1, npt
    x(i) = -L / 2.0_dp + i * dx
    psi(i) = gaussiana(x(i), x0, p, ancho)
  end do

  do i = 1, npt
    expv(i) = exp(-ci * v_pot(x(i), v0) * dt / 2.0_dp)
  end do

  do i = 1, npt / 2
    k_val = (i - 1) * deltak
    t_val = k_val**2
    expt(i) = exp(-ci * t_val * dt)
    k_val = -(i - 1) * deltak
    t_val = k_val**2
    expt(npt + 1 - i) = exp(-ci * t_val * dt)
  end do

  t_time = 0.0_dp
  do j = 1, nt
    t_time = t_time + dt
    
    ! 1. Evolución espacio real (medio paso) - Blocking
    do ib = 1, npt, B
      do i = ib, min(ib + B - 1, npt)
        phi(i) = expv(i) * psi(i)
      end do
    end do
    
    call fft(phi, log2n, 0)
    
    ! 2. Evolución espacio de momentos (paso completo) - Blocking
    do ib = 1, npt, B
      do i = ib, min(ib + B - 1, npt)
        phi(i) = expt(i) * phi(i)
      end do
    end do
    
    call fft(phi, log2n, 1)
    
    ! 3. Evolución espacio real (medio paso final) - Blocking
    do ib = 1, npt, B
      do i = ib, min(ib + B - 1, npt)
        psi(i) = expv(i) * phi(i)
      end do
    end do
    
    if (mod(j, 100) == 0) then
      norma = 0.0_dp
      do ib = 1, npt, B
        do i = ib, min(ib + B - 1, npt)
          norma = norma + abs(psi(i))**2
        end do
      end do
      norma = norma * dx
      
      do i = 1, npt, 5
        write(10, '(5F15.7)') t_time, x(i), abs(psi(i)), v_pot(x(i), v0) / (2.0_dp * v0), norma
      end do
      write(10, *)
      write(10, *)
    end if
  end do
  
  close(10)
  deallocate(x, psi, phi, expv, expt)
end program seudo_espectral

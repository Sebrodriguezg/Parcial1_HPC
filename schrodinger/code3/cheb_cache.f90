module math_utils_cheb
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

  ! Subrutina con Blocking incorporado
  subroutine apply_h_blocked(phi, h_phi, v, dx, npts, B)
    integer, intent(in) :: npts, B
    real(dp), intent(in) :: dx
    real(dp), intent(in) :: v(0:npts)
    complex(dp), intent(in) :: phi(0:npts)
    complex(dp), intent(out) :: h_phi(0:npts)
    integer :: i, ib
    real(dp) :: dx2_inv
    dx2_inv = 1.0_dp / (dx**2)
    h_phi(0) = (0.0_dp, 0.0_dp)
    h_phi(npts) = (0.0_dp, 0.0_dp)
    
    do ib = 1, npts - 1, B
      do i = ib, min(ib + B - 1, npts - 1)
        h_phi(i) = -0.5_dp * dx2_inv * (phi(i+1) - 2.0_dp * phi(i) + phi(i-1)) + v(i) * phi(i)
      end do
    end do
  end subroutine apply_h_blocked
end module math_utils_cheb

program chebyshev_fd_cache
  use math_utils_cheb
  implicit none
  integer :: npts, nt, i, j, it, k, m_cheb, log2n, B, ib
  real(dp) :: dt, dx, tiempo, x0, ancho, p, v0, L
  real(dp) :: e_min, e_max, delta_e, e_avg, alpha, de_inv
  character(len=100) :: archivo
  real(dp), allocatable :: x(:), v(:)
  complex(dp), allocatable :: phi(:), phi_0(:), phi_1(:), phi_2(:), h_phi(:), psi_new(:)
  complex(dp), parameter :: ci = (0.0_dp, 1.0_dp)
  complex(dp) :: c_k, phase_shift

  read(5,*) archivo
  read(5,*) ancho
  read(5,*) p
  read(5,*) v0
  read(5,*) log2n
  read(5,*) dt
  read(5,*) L
  read(5,*) nt
  read(5,*) B 

  npts = 2**log2n
  dx = L / real(npts, dp)
  m_cheb = 40
  x0 = -10.0_dp

  allocate(x(0:npts), v(0:npts), phi(0:npts), phi_0(0:npts))
  allocate(phi_1(0:npts), phi_2(0:npts), h_phi(0:npts), psi_new(0:npts))

  do i = 0, npts
    x(i) = -L/2.0_dp + dx * i
    v(i) = v_pot(x(i), v0)
    phi(i) = gaussiana(x(i), x0, p, ancho)
  end do
  phi(0) = (0.0_dp, 0.0_dp)
  phi(npts) = (0.0_dp, 0.0_dp)

  e_min = minval(v)
  e_max = (2.0_dp / dx**2) + maxval(v)
  delta_e = e_max - e_min
  e_avg = (e_max + e_min) / 2.0_dp
  alpha = delta_e * dt / 2.0_dp
  de_inv = 2.0_dp / delta_e

  open(10, file=trim(archivo))
  tiempo = 0.0_dp

  do it = 1, nt
    tiempo = tiempo + dt
    c_k = bessel_jn(0, alpha)
    
    ! Actualización Vectorial con Blocking
    do ib = 0, npts, B
      do i = ib, min(ib + B - 1, npts)
        phi_0(i) = phi(i)
        psi_new(i) = c_k * phi_0(i)
      end do
    end do
    
    call apply_h_blocked(phi_0, h_phi, v, dx, npts, B)
    
    c_k = 2.0_dp * (-ci) * bessel_jn(1, alpha)
    do ib = 0, npts, B
      do i = ib, min(ib + B - 1, npts)
        phi_1(i) = (h_phi(i) - e_avg * phi_0(i)) * de_inv
        psi_new(i) = psi_new(i) + c_k * phi_1(i)
      end do
    end do
    
    do k = 2, m_cheb
      call apply_h_blocked(phi_1, h_phi, v, dx, npts, B)
      c_k = 2.0_dp * (-ci)**k * bessel_jn(k, alpha)
      
      do ib = 0, npts, B
        do i = ib, min(ib + B - 1, npts)
          phi_2(i) = 2.0_dp * (h_phi(i) - e_avg * phi_1(i)) * de_inv - phi_0(i)
          psi_new(i) = psi_new(i) + c_k * phi_2(i)
          phi_0(i) = phi_1(i)
          phi_1(i) = phi_2(i)
        end do
      end do
    end do
    
    phase_shift = exp(-ci * e_avg * dt)
    do ib = 0, npts, B
      do i = ib, min(ib + B - 1, npts)
        phi(i) = psi_new(i) * phase_shift
      end do
    end do
    
    if (mod(it, 100) == 0) then
      do j = 1, npts, 5
        write(10, '(3F15.7)') tiempo, x(j), abs(phi(j))
      end do
      write(10, *)
      write(10, *)
    end if
  end do
  close(10)
end program chebyshev_fd_cache

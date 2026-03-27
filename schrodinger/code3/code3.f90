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

  subroutine apply_h(phi, h_phi, v, dx, npts)
    integer, intent(in) :: npts
    real(dp), intent(in) :: dx
    real(dp), intent(in) :: v(0:npts)
    complex(dp), intent(in) :: phi(0:npts)
    complex(dp), intent(out) :: h_phi(0:npts)
    integer :: i
    real(dp) :: dx2_inv
    dx2_inv = 1.0_dp / (dx**2)
    h_phi(0) = (0.0_dp, 0.0_dp)
    h_phi(npts) = (0.0_dp, 0.0_dp)
    do i = 1, npts - 1
      h_phi(i) = -0.5_dp * dx2_inv * (phi(i+1) - 2.0_dp * phi(i) + phi(i-1)) + v(i) * phi(i)
    end do
  end subroutine apply_h
end module math_utils_cheb

program chebyshev_fd
  use math_utils_cheb
  implicit none
  integer :: npts, nt, i, j, it, k, m_cheb
  real(dp) :: dt, dx, tiempo, x0, ancho, p, v0
  real(dp) :: e_min, e_max, delta_e, e_avg, alpha
  character(len=20) :: archivo
  real(dp), allocatable :: x(:), v(:)
  complex(dp), allocatable :: phi(:), phi_0(:), phi_1(:), phi_2(:), h_phi(:), psi_new(:)
  complex(dp), parameter :: ci = (0.0_dp, 1.0_dp)
  complex(dp) :: c_k

  npts = 4096
  nt = 1000
  dt = 0.005_dp
  dx = 40.0_dp / npts
  m_cheb = 40

  allocate(x(0:npts), v(0:npts), phi(0:npts), phi_0(0:npts))
  allocate(phi_1(0:npts), phi_2(0:npts), h_phi(0:npts), psi_new(0:npts))

  write(6,*) 'EN QUE ARCHIVO DESEA GUARDAR LOS DATOS?'
  read(5,*) archivo
  
  x0 = -10.0_dp
  write(6,*) 'ANCHO DEL PAQUETE ? [2.0]'
  read(5,*) ancho
  write(6,*) 'MOMENTUM DEL PAQUETE ? [1.0]'
  read(5,*) p
  write(6,*) 'ALTURA DE LA BARRERA DE POTENCIAL? [100]'
  read(5,*) v0

  do i = 0, npts
    x(i) = -20.0_dp + dx * (npts - i)
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

  open(10, file=trim(archivo))
  tiempo = 0.0_dp

  do j = 1, npts, 5
    write(10, *) tiempo, x(j), abs(phi(j))
  end do
  write(10, *)
  write(10, *)

  do it = 1, nt
    tiempo = tiempo + dt
    
    phi_0 = phi
    psi_new = bessel_jn(0, alpha) * phi_0
    
    call apply_h(phi_0, h_phi, v, dx, npts)
    phi_1 = (h_phi - e_avg * phi_0) / (delta_e / 2.0_dp)
    
    c_k = 2.0_dp * (-ci) * bessel_jn(1, alpha)
    psi_new = psi_new + c_k * phi_1
    
    do k = 2, m_cheb
      call apply_h(phi_1, h_phi, v, dx, npts)
      phi_2 = 2.0_dp * (h_phi - e_avg * phi_1) / (delta_e / 2.0_dp) - phi_0
      
      c_k = 2.0_dp * (-ci)**k * bessel_jn(k, alpha)
      psi_new = psi_new + c_k * phi_2
      
      phi_0 = phi_1
      phi_1 = phi_2
    end do
    
    phi = psi_new * exp(-ci * e_avg * dt)
    
    if (mod(it, 100) == 0) then
      do j = 1, npts, 5
        write(10, *) tiempo, x(j), abs(phi(j))
      end do
      write(10, *)
      write(10, *)
    end if
  end do

  close(10)
  deallocate(x, v, phi, phi_0, phi_1, phi_2, h_phi, psi_new)
end program chebyshev_fd

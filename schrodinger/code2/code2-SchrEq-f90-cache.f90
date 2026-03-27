module math_utils_cayley
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

  subroutine tridiag(npts, dx, dt, gama, v)
    integer, intent(in) :: npts
    real(dp), intent(in) :: dx, dt
    real(dp), intent(in) :: v(0:npts)
    complex(dp), intent(inout) :: gama(0:npts)
    complex(dp), parameter :: ci = (0.0_dp, 1.0_dp)
    integer :: ix
    gama(npts) = (0.0_dp, 0.0_dp)
    do ix = npts - 1, 0, -1
      gama(ix) = -1.0_dp / ((-2.0_dp + 2.0_dp * ci * dx**2 / dt) - (dx**2 * v(ix)) + gama(ix + 1))
    end do
  end subroutine tridiag

  ! Se pasa beta como argumento, optimizando drásticamente la caché y el heap
  subroutine evolucion(phi, gama, beta, dx, dt, npts)
    integer, intent(in) :: npts
    real(dp), intent(in) :: dx, dt
    complex(dp), intent(inout) :: phi(0:npts), beta(0:npts)
    complex(dp), intent(in) :: gama(0:npts)
    complex(dp), parameter :: ci = (0.0_dp, 1.0_dp)
    complex(dp) :: chi
    integer :: ix
    
    beta(npts - 1) = phi(npts)
    do ix = npts - 2, 0, -1
      beta(ix) = gama(ix + 1) * (beta(ix + 1) - (4.0_dp * ci * dx**2 / dt) * phi(ix + 1))
    end do
    
    chi = (0.0_dp, 0.0_dp)
    do ix = 1, npts - 1
      chi = gama(ix) * chi + beta(ix - 1)
      phi(ix) = chi - phi(ix)
    end do
  end subroutine evolucion
end module math_utils_cayley

program cayley
  use math_utils_cayley
  implicit none
  integer :: npts, nt, i, j, it, log2n
  real(dp) :: dt, dx, tiempo, x0, ancho, p, v0, L
  character(len=100) :: archivo
  real(dp), allocatable :: x(:), v(:)
  complex(dp), allocatable :: gama(:), phi(:), beta(:)

  read(5,*) archivo
  read(5,*) ancho
  read(5,*) p
  read(5,*) v0
  read(5,*) log2n
  read(5,*) dt
  read(5,*) L
  read(5,*) nt

  npts = 2**log2n
  allocate(x(0:npts), v(0:npts), gama(0:npts), phi(0:npts), beta(0:npts))
  
  dx = L / real(npts, dp)
  x0 = -10.0_dp

  do i = 1, npts
    x(i) = -L/2.0_dp + dx * (npts - i)
    v(i) = v_pot(x(i), v0)
    phi(i) = gaussiana(x(i), x0, p, ancho)
  end do
  
  x(0) = -L/2.0_dp + dx * npts
  v(0) = v_pot(x(0), v0)
  phi(0) = (0.0_dp, 0.0_dp)
  phi(npts) = (0.0_dp, 0.0_dp)

  open(10, file=trim(archivo))
  call tridiag(npts, dx, dt, gama, v)
  tiempo = 0.0_dp

  do it = 1, nt
    tiempo = tiempo + dt
    call evolucion(phi, gama, beta, dx, dt, npts)
    if (mod(it, 100) == 0) then
      do j = 1, npts, 5
        write(10, *) tiempo, x(j), abs(phi(j))
      end do
      write(10, *)
      write(10, *)
    end if
  end do
  
  close(10)
  deallocate(x, v, gama, phi, beta)
end program cayley

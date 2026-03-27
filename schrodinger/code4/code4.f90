module math_utils_lanczos
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

  subroutine jacobi(a, n, d, v)
    integer, intent(in) :: n
    real(dp), intent(inout) :: a(n,n)
    real(dp), intent(out) :: d(n)
    real(dp), intent(out) :: v(n,n)
    integer :: i, j, ip, iq, nrot
    real(dp) :: tresh, theta, tau, t, sm, s, h, g, c
    real(dp) :: b(n), z(n)

    do ip = 1, n
      do iq = 1, n
        v(ip,iq) = 0.0_dp
      end do
      v(ip,ip) = 1.0_dp
    end do
    do ip = 1, n
      b(ip) = a(ip,ip)
      d(ip) = b(ip)
      z(ip) = 0.0_dp
    end do

    nrot = 0
    do i = 1, 50
      sm = 0.0_dp
      do ip = 1, n-1
        do iq = ip+1, n
          sm = sm + abs(a(ip,iq))
        end do
      end do
      if (sm == 0.0_dp) return
      if (i < 4) then
        tresh = 0.2_dp * sm / n**2
      else
        tresh = 0.0_dp
      end if
      do ip = 1, n-1
        do iq = ip+1, n
          g = 100.0_dp * abs(a(ip,iq))
          if ((i > 4) .and. (abs(d(ip))+g == abs(d(ip))) .and. &
              (abs(d(iq))+g == abs(d(iq)))) then
            a(ip,iq) = 0.0_dp
          else if (abs(a(ip,iq)) > tresh) then
            h = d(iq) - d(ip)
            if (abs(h)+g == abs(h)) then
              t = a(ip,iq) / h
            else
              theta = 0.5_dp * h / a(ip,iq)
              t = 1.0_dp / (abs(theta) + sqrt(1.0_dp + theta**2))
              if (theta < 0.0_dp) t = -t
            end if
            c = 1.0_dp / sqrt(1.0_dp + t**2)
            s = t * c
            tau = s / (1.0_dp + c)
            h = t * a(ip,iq)
            z(ip) = z(ip) - h
            z(iq) = z(iq) + h
            d(ip) = d(ip) - h
            d(iq) = d(iq) + h
            a(ip,iq) = 0.0_dp
            do j = 1, ip-1
              g = a(j,ip)
              h = a(j,iq)
              a(j,ip) = g - s * (h + g * tau)
              a(j,iq) = h + s * (g - h * tau)
            end do
            do j = ip+1, iq-1
              g = a(ip,j)
              h = a(j,iq)
              a(ip,j) = g - s * (h + g * tau)
              a(j,iq) = h + s * (g - h * tau)
            end do
            do j = iq+1, n
              g = a(ip,j)
              h = a(iq,j)
              a(ip,j) = g - s * (h + g * tau)
              a(iq,j) = h + s * (g - h * tau)
            end do
            do j = 1, n
              g = v(j,ip)
              h = v(j,iq)
              v(j,ip) = g - s * (h + g * tau)
              v(j,iq) = h + s * (g - h * tau)
            end do
            nrot = nrot + 1
          end if
        end do
      end do
      do ip = 1, n
        b(ip) = b(ip) + z(ip)
        d(ip) = b(ip)
        z(ip) = 0.0_dp
      end do
    end do
  end subroutine jacobi
end module math_utils_lanczos

program lanczos_fd
  use math_utils_lanczos
  implicit none
  integer :: npts, nt, i, j, it, k, m_lanczos
  real(dp) :: dt, dx, tiempo, x0, ancho, p, v0, norm_psi
  character(len=20) :: archivo
  real(dp), allocatable :: x(:), v(:)
  complex(dp), allocatable :: psi(:), w(:), h_v(:)
  complex(dp), allocatable :: v_mat(:,:)
  real(dp), allocatable :: alpha(:), beta(:), t_mat(:,:), d_mat(:), z_mat(:,:)
  complex(dp), allocatable :: y_vec(:), exp_d(:)
  complex(dp), parameter :: ci = (0.0_dp, 1.0_dp)
  complex(dp) :: dot_prod

  npts = 4096
  nt = 1000
  dt = 0.005_dp
  dx = 40.0_dp / npts
  m_lanczos = 10

  allocate(x(0:npts), v(0:npts), psi(0:npts), w(0:npts), h_v(0:npts))
  allocate(v_mat(0:npts, m_lanczos))
  allocate(alpha(m_lanczos), beta(0:m_lanczos))
  allocate(t_mat(m_lanczos, m_lanczos), d_mat(m_lanczos), z_mat(m_lanczos, m_lanczos))
  allocate(y_vec(m_lanczos), exp_d(m_lanczos))

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
    psi(i) = gaussiana(x(i), x0, p, ancho)
  end do
  psi(0) = (0.0_dp, 0.0_dp)
  psi(npts) = (0.0_dp, 0.0_dp)

  open(10, file=trim(archivo))
  tiempo = 0.0_dp

  do j = 1, npts, 5
    write(10, *) tiempo, x(j), abs(psi(j))
  end do
  write(10, *)
  write(10, *)

  beta(0) = 0.0_dp

  do it = 1, nt
    tiempo = tiempo + dt
    
    dot_prod = (0.0_dp, 0.0_dp)
    do i = 1, npts-1
      dot_prod = dot_prod + conjg(psi(i)) * psi(i)
    end do
    norm_psi = sqrt(real(dot_prod, dp) * dx)
    
    v_mat(:, 1) = psi(:) / norm_psi
    t_mat = 0.0_dp
    
    do j = 1, m_lanczos
      call apply_h(v_mat(:,j), h_v, v, dx, npts)
      
      if (j == 1) then
        w = h_v
      else
        w = h_v - beta(j-1) * v_mat(:, j-1)
      end if
      
      dot_prod = (0.0_dp, 0.0_dp)
      do i = 1, npts-1
        dot_prod = dot_prod + conjg(v_mat(i,j)) * w(i)
      end do
      alpha(j) = real(dot_prod, dp) * dx
      
      w = w - alpha(j) * v_mat(:,j)
      
      dot_prod = (0.0_dp, 0.0_dp)
      do i = 1, npts-1
        dot_prod = dot_prod + conjg(w(i)) * w(i)
      end do
      beta(j) = sqrt(real(dot_prod, dp) * dx)
      
      t_mat(j, j) = alpha(j)
      if (j < m_lanczos) then
        t_mat(j, j+1) = beta(j)
        t_mat(j+1, j) = beta(j)
        v_mat(:, j+1) = w / beta(j)
      end if
    end do
    
    call jacobi(t_mat, m_lanczos, d_mat, z_mat)
    
    do k = 1, m_lanczos
      exp_d(k) = exp(-ci * d_mat(k) * dt)
    end do
    
    y_vec = (0.0_dp, 0.0_dp)
    do j = 1, m_lanczos
      do k = 1, m_lanczos
        y_vec(j) = y_vec(j) + z_mat(j,k) * exp_d(k) * z_mat(1,k)
      end do
    end do
    
    psi = (0.0_dp, 0.0_dp)
    do j = 1, m_lanczos
      psi = psi + v_mat(:,j) * y_vec(j)
    end do
    psi = psi * norm_psi
    
    if (mod(it, 100) == 0) then
      do j = 1, npts, 5
        write(10, *) tiempo, x(j), abs(psi(j))
      end do
      write(10, *)
      write(10, *)
    end if
  end do

  close(10)
  deallocate(x, v, psi, w, h_v, v_mat, alpha, beta, t_mat, d_mat, z_mat, y_vec, exp_d)
end program lanczos_fd

module functions_module

! DANIEL BRUE 2006
! POLYNOMIALS AND FUNCTIONS AS DEFINED BY ABRAMOWITZ AND STEGUN 9th EDITION

CONTAINS

!=========================================================================================

   subroutine hermite(x, n, npts, H)
   use numeric_kinds_module
   ! THIS SUBROUTINE RETURNS THE VALUES OF THE HERMITE 
   ! POLYNOMIAL OF ORDER n AT THE POINTS IN ARRAY x
   ! HERMITE POLYNOMIALS ARE CALCULATED BY RECURSION RELATION
   implicit none
   integer :: i, j
   integer, intent(in) :: npts, n  ! INPUT, NUMBER OF POINTS AND ORDER OF H
   real(kind=dp), intent(in) :: x(npts) ! INPUT, CONTAINS X VALUES
   real(kind=dp), intent(out) :: H(npts)! OUTPUT, CONTAINS HERMITE VALUES
   real(kind=dp) :: h1(npts), h2(npts) ! WORK ARRAY

   if (n == 0 ) then
      h=1.d0
   else if (n == 1) then
      h=2.d0*x
   else if (n > 1) then
      h1=1.d0
      h2=2.d0*x
      do i=2,n
         do j=1,npts
             h(j)=2.d0*x(j)*h2(j)-2.d0*(i-1)*h1(j)
         enddo
         if(i /= n ) then
            h1=h2
            h2=h
         endif
      enddo
   endif
   end subroutine hermite

!=========================================================================================

   subroutine legendre(x, n, m, npts, P)
   use numeric_kinds_module
   ! THIS SUBROUTINE RETURNS THE VALUES OF THE ASSOCIATED LEGENDRE
   ! POLYNOMIALS AT THE VALUES SPECIFIED BY X. THE POLYNOMIALS
   ! ARE OF ORDER n AND DEGREE m. 
   implicit none
   integer :: i, j, k, l
   integer, intent(in) :: n, m  ! ORDER AND DEGREE OF POLYNOMIAL
   integer, intent(in) :: npts  ! NUMBER OF POINTS 
   integer :: order, degree
   real(kind=dp), intent(in) :: x(npts) ! ARRAY OF X VALUES ON INTERVAL [-1,1]
   real(kind=dp), intent(out) :: P(npts)! ARRAY CONTAINING THE LEGENDRE POLYNOMIAL VALUES
   real(kind=dp) :: p1(npts), p2(npts)  ! WORK ARRAYS
   real(kind=dp) :: pm0(npts), pm1(npts)! TEMPORARY ARRAYS

   if (x(1) < -1.d0 .or. x(npts) > 1.d0 ) then 
      print*,"ERROR: range of X points is outside of the acceptable range"
      print*," for Legendre polynomials (must be on [-1,1])"
      stop "legendre module - range"
   end if

   if ( m > n ) then
      print *,"ERROR: degree cannot be greater than order"
      stop "legendre module - invalid degree"
   end if

   if ( n == 0 ) then   ! OUTERMOST IF 
      P = 1.d0
   else if ( n == 1 .and. m == 0 ) then
      P = x
   else if ( n == 1 .and. m == 1) then
      do i=1,npts
         P(i) = -Sqrt(1.d0-x(i)*x(i))
      enddo
   else if ( n == 2 .and. m == 1) then
      do k=1,npts
         P(k) = -3.d0*x(i)*Sqrt((1.d0-x(i)*x(i)))
      enddo
   else
   ! FIRST INCREASE THE ORDER UNTIL CORRECT
   ! ASSUME M=0 FOR NOW
      p1=1.d0   ! STATE N=0, M=0
      p2=x      ! STATE N=1, M=0
      degree=0
      do l=2,n
         order=l
         do i=1,npts
            Pm0(i)=Sqrt((x(i)-1.d0))*((degree-l+1)*x(i)*p2(i) - (degree+order-1)*p1(i))
         enddo
         if (l /= n) then
            p1=p2
            p2=Pm0
         endif
      enddo

    ! NOW FOR M=1
      do k=1, npts
         p1(k) = -Sqrt(1.d0-x(i)*x(i)) ! STATE N=1, M=1
         p2(k) = -3.d0*x(i)*Sqrt((1.d0-x(i)*x(i)))  ! STATE N=2, M=1
      enddo
      degree=1
      do l=3,n
         order=l
         do i=1,npts
            Pm1(i)=Sqrt((x(i)-1.d0))*((degree-l+1)*x(i)*p2(i) - (degree+order-1)*p1(i))
         enddo
         if (l /= n) then
            p1=p2
            p2=Pm1
         endif
      enddo
      ! IS M=0 OR 1?
      if ( m == 0 ) then
         P=Pm0
      else if ( m == 1) then
         P=Pm1
      else
      ! NOW USE RECURSION TO CHANGE DEGREE
      ! this is a different recursion formula. See Abramowitz and Stegun
         p1=Pm0  ! STATE N=N, M=0
         p2=Pm1  ! STATE N=N, M=1
         order=n
         do k=2, m
            degree=k
            do i=1,npts
               P(i)=(1.d0/(degree-1.d0-order))*((2.d0*degree-1.d0)*x(i)*p2(i)-(degree+order-1.d0)*p1(i))
            enddo
            if (k /= m) then
               p1=p2
               p2=P
            endif
         enddo
         ! NOW HAVE ASSOCIATED LEGENDRE POLYNOMIAL OF ORDER N AND DEGREE M
      end if
   end if  ! END OF OUTERMOST IF

   end subroutine legendre

!=========================================================================================
      
   subroutine chebyshev1(x, n, npts, T)
   use numeric_kinds_module
   ! THIS SUBROUTINE RETURNS CHEBYSHEV POLYNOMIALS OF THE FIRST KIND OF ORDER N  AT THE 
   ! POINTS GIVEN IN ARRAY X
   ! THESE FUNCTIONS ARE USUALLY REPRESENTED BY THE LETTER "T"
   implicit none
   integer, intent(in) :: n, npts
   integer :: i, j, k, l
   real(kind=dp), intent(in) :: x(npts)
   real(kind=dp), intent(out) :: T(npts)
   real(kind=dp) :: t0(npts), t1(npts)

   if ( n == 0 ) then
      T=1.d0
   else if ( n == 1 ) then 
      T=x
   else
      t0=1.d0
      t1=x
      do k=2,n
         do i=1,npts
            T(i)=2.d0*x(i)*t1(i)-t0(i)
         end do
         if (k /= n ) then
            t0=t1
            t1=T
         end if
      enddo
   end if
   end subroutine chebyshev1

!=========================================================================================
      
   subroutine chebyshev2(x, n, npts, U)
   use numeric_kinds_module
   ! THIS SUBROUTINE RETURNS CHEBYSHEV POLYNOMIALS OF THE SECOND KIND OF ORDER N AT THE 
   ! POINTS GIVEN IN ARRAY X
   ! THESE FUNCTIONS ARE USUALLY REPRESENTED BY THE LETTER "U"
   implicit none
   integer, intent(in) :: n, npts
   integer :: i, j, k, l
   real(kind=dp), intent(in) :: x(npts)
   real(kind=dp), intent(out) :: U(npts)
   real(kind=dp) :: u0(npts), u1(npts)

   if ( n == 0 ) then
      U=1.d0
   else if ( n == 1 ) then 
      U=2.d0*x
   else
      u0=1.d0
      u1=2.d0*x
      do k=2,n
         do i=1,npts
            U(i)=2.d0*x(i)*u1(i)-u0(i)
         end do
         if (k /= n ) then
            u0=u1
            u1=U
         end if
      enddo
   end if
   end subroutine chebyshev2

!=========================================================================================


end module functions_module

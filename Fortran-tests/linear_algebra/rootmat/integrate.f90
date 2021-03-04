subroutine integrate(f1,f2,n,h,O)
use numeric_kinds
! perform Simpson's rule integration on these two arrays of length n


integer :: i
integer, intent(in) :: n
real(kind=dp_kind),intent(in) :: h ! step size
real(kind=dp_kind),intent(in) :: f1(n), f2(n)

real(kind=dp_kind), intent(out) :: O ! integral result

real(kind=dp_kind) :: f(n)


if (mod(n,2) == 0) then
    print*,"INTEGRATE: error, n not odd"
    stop
endif

f=f1*f2

O=0.d0

do i=2,n-1,2
    O=O+4.d0*f(i)
enddo
    
do i=3,n-2,2
    O=O+2.d0*f(i)
enddo

O=O+f(1)+f(n)

O=O*h/3.d0

end subroutine integrate

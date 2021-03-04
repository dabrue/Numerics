subroutine lipd1(x,n,j,xabs,yp)
use numeric_kinds
implicit none


integer :: i, k

integer, intent(in) :: n
integer, intent(in) :: j

real(kind=dp_kind), intent(in) :: x
real(kind=dp_kind), intent(in) :: xabs(n)
real(kind=dp_kind), intent(out) :: yp
real(kind=dp_kind) :: tmp(n)
real(kind=dp_kind) :: c

yp=0.d0

c=1.d0
do k=1,n
    if (k==j) cycle
    c=c*(xabs(k)-xabs(j))
enddo

do k=1,n
    if (k==j) cycle  ! term does not exist by def
    tmp(k)=1.d0
    do i=1,n
        if (i==k) cycle  ! term removed due to derivative
        if (i==j) cycle  ! term removed due to derivative
        tmp(k)=tmp(k)*(xabs(i)-x)
    enddo
    yp=yp+tmp(k)
enddo
yp=-yp/c

end subroutine lipd1
    

subroutine lipd2(x,n,j,xabs,ypp)
use numeric_kinds
implicit none

integer :: i, k, l, p, q
integer, intent(in) :: j
integer, intent(in) :: n  ! number of abscissas

real(kind=dp_kind), intent(in) :: x
real(kind=dp_kind), intent(in) :: xabs(n)
real(kind=dp_kind), intent(out) :: ypp
real(kind=dp_kind) :: tmp1, tmp2
real(kind=dp_kind) :: c

c=1.d0
do i=1,n
    if (i == j) cycle
    c=c*(xabs(i)-xabs(j))
enddo
    
ypp=0.d0
do i=1,n
    if (i==j) cycle
    tmp2=0.d0
    do k=1,n
        if (k==j .or. k==i) cycle
        tmp1=1.d0
        do l=1,n
            if ( l==j .or. l==k .or. l==i ) cycle
            tmp1=tmp1*(xabs(l)-x)
        enddo
        tmp2=tmp2+tmp1
    enddo
    ypp=ypp+tmp2
enddo

ypp=ypp/c

end subroutine lipd2
            
            

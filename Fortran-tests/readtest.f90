program readtest
implicit none
integer, parameter :: dp=selected_real_kind(14,300)
integer, parameter :: sp=kind(1.0)
real (kind=dp) :: array(5,7000)
real(dp) :: A(111),x
real(dp) :: B(111)
integer :: i,j

open(unit=8, file="tmp")

!do i=1,7000
!   read(8,*,end=100) array(1,i), array(2,i), array(3,i), array(4,i), array(5,i)
!enddo

do i=1,35
read(8,*,end=100),A(i), B(i)
print*,A(i),B(i)
enddo

x=A(15)*10.d0
print*,x

100 print*, "passed test", i

end

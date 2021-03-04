program mkltest

implicit none

integer, parameter :: dp=selected_real_kind(14,300)

integer :: i, j, k
real(dp) :: A(10,10), B(10,10), C(10,10)

character(len=1) :: OpN, OpT

OpN="N"
OpT="T"

do i=1,10
do j=1,10
    A(i,j)=sqrt(i*j*1.d0)
    B(i,j)=(i*j)**2
enddo
enddo

call gemm(A, B, C, OpN, OpN)

do i=1,10
do j=1,10
    print*,C(j,i)
enddo
enddo

end program mkltest

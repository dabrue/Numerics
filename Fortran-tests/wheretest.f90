program wheretest

implicit none

integer :: i, j, k
double precision :: A(10), B(10)

B=0.d0

A=1.d0
do i=1,9,2
    A(i)=-1.d0
enddo

where(A < 0.d0) B=5.d0
where(A >= 0.d0) B=Exp(1.d0)

do i=1,10
    print*,"A",A(i)," B",B(i)
enddo
end

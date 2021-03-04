program transposetest

implicit none


real :: A(2,2), B(2,2)
real :: C(3,2), D(2,3)
integer :: i, j, k

A(1,1)=1.e0
A(1,2)=3.e0
A(2,1)=4.e0
A(2,2)=8.e0

B=transpose(A)

do i=1,2
do j=1,2
    print*,A(i,j), B(i,j)
enddo
enddo

print*,""

do i=1,3
do j=1,2
    C(i,j)=i+j
enddo
enddo

D=transpose(c)
print*,D

end

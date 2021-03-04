program matrixmul
implicit none

integer :: i, j, k

real :: a(4,4)
real :: b(5,4)
real :: c(4,5)
real :: x(4,4)
real :: y(5,5)

do i=1,5
do j=1,5
y(i,j)=i*j
enddo

do j=1,4
b(i,j)=i*j
c(j,i)=i*j

enddo
enddo

do i=1,4
do j=1,4
a(i,j)=i+j
enddo
enddo

x=matmul(c,b)

print*,x

y=matmul(b,c)

print*,y

end


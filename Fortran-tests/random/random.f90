program random
use numerickinds
implicit none
integer :: i, k
double precision :: x, y
integer :: A(1000), z, B(100)



A=0
do i=1,10!0000000
call random_number(x)
y=1000.d0*x
z=floor(y)
A(z+1)=A(z+1)+1
enddo

do i=1,1000
write(200,*) A(i)
enddo

do i=1,100
call random_number(x)
x=x*1.d1
k=ceiling(x,intkind)
print*,x,k
enddo




end program random

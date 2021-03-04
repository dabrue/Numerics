program maxmin
implicit none
integer :: i, j, k, l
double precision :: y(0:100),x,deltax
double precision :: pi
pi=4.d0*atan(1.d0)
do i=0,100
   y(i)=Sin(i*deltax)
enddo
x=max(y(:))
print*,x
end


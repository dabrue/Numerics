program randcirc
implicit none

! THIS PROGRAM CALCULATES A RANDOM NUMBER WEIGTED BY 
! THE AREA OF A CIRCLE. THIS GIVES A RADIUS VALUE FOR
! A RANDOM AREA ELEMENT. 

integer, parameter :: sp=kind(1.0)
integer, parameter :: dp=selected_real_kind(14,300)
integer :: i, j, k, l
real(dp):: b,r,x,y,a
real(dp):: pi
real(dp):: phi
a=4.d0
pi=4.d0*atan(1.d0)

open(unit=11,file="sqrc")

do i=1,10000
call random_number(b)
call random_number(phi)
phi=phi*2*pi
r=a*Sqrt(b)

x=Cos(phi)*r
y=Sin(phi)*r

write(11,*) x, y
enddo

j=0
open(unit=12,file="sqrcxy")

do while (j.lt.10000)
call random_number(x)
call random_number(y)

if(x*x+y*y.gt.1.d0)then
else
write(12,*)x,y
j=j+1
endif
enddo
print*,i,j

end




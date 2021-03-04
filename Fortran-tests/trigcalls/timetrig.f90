program timetrig
implicit none


integer ::  j, k
integer*8 :: i
double precision :: a, x, y, z
double precision :: pi


pi=4.d0*atan(1.d0)
a=pi/4.d0


do i=1,99999999999999
    a=a+i*1.d0
    x=cos(a)
    y=sin(a)
    z=tan(a)
!    z=y/x
enddo

end
    

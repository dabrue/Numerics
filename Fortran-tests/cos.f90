implicit none
double precision :: a,b,c,d,k,Pi
integer :: i
Pi=4.d0*atan(1.d0)
print*,'angle       arccos        arcsin'
k=0.d0
do i=0, 10
k=k+2*Pi/10.d0
a=cos(k)
b=sin(k)
c=acos(a)
d=asin(b)
print*,k,c,d
enddo

open(unit=11,file="coswritefile")
k=2*Pi/100.d0
do i=0,100
   b=0.d0+i*k
   write(11,*) b, cos(b)
enddo
   

end


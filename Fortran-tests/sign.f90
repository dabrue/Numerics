program signdesc
implicit none
! test the sign function

double precision :: a, b, s

a=1.d0
b=1.d0

s=sign(a,b)
print*,"+ +",s
a=-1.d0
b=1.d0
s=sign(a,b)
print*,"- +",s
a=1.d0
b=-1.d0
s=sign(a,b)
print*,"+ -",s
a=-1.d0
b=-1.d0
s=sign(a,b)
print*,"- -",s


end

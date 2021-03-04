program gammatest
implicit none

! This is to test what gamma does. VI highlights it as though 
! it were an intrinsic, but can't find it. 


double precision :: x, y, gamma

x=5.d0

y=gamma(x)
print*,y

end

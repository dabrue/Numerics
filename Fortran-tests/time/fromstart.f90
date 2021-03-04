program elapsedtest


real :: etime
real :: elapsed(2), total
integer :: i, j, k

print *,"start"
total=0.e0
j=0
do i=1,500000000
   j=j+1
   total=4.e0*atan(1.e0)*total
enddo

total=etime(elapsed)
print*,total
print*,elapsed(1)
print*,elapsed(2)

end

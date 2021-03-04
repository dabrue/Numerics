program itoa
implicit none


integer :: i, j, k
character(len=1) :: a
character(len=2) :: b
character(len=3) :: c
character :: d



i=1
j=12
k=123



write(a,fmt="(I1)") i
write(b,fmt="(I2)") j
write(c,fmt="(I3)") k

print*,i,j,k
print*,a,b,c

write(c,fmt="(I3)") i
print*,i,"'",c,"'"


end

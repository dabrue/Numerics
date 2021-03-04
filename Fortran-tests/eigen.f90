implicit none
real, dimension(3,3) :: I, J
real :: N(1000), M(1000)
real :: info

I(1,1)=2
I(1,2)=3
I(1,3)=4
I(2,1)=3
I(2,2)=4
I(2,3)=5
I(3,1)=4
I(3,2)=5
I(3,3)=6
call ssyevd('V','U',3,I,3,J,M,1000,N,1000,info)

print*,I(1,1),I(1,2),I(1,3),I(2,1),I(2,2),I(2,3),I(3,1),I(3,2),I(3,3)
print*,J(1,1),J(1,2),J(1,3),J(2,1),J(2,2),J(2,3),J(3,1),J(3,2),J(3,3)
end

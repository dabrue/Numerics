program foralltest2

implicit none

integer :: i, j, k, l

integer :: total




total=0
forall (i=1:3,j=1:4) total=total+i

print*,"total", total


end

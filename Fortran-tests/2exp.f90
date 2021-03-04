program exp2
implicit none

integer :: i, j, k
double precision :: E

E=1.d0
do i=1,54
   E=E*2.d0
enddo
print*, E
end


program binary
implicit none

integer :: i, j, k
double precision :: A(3), B(3)

do i=1, 3
A(i)=i*9.d0
enddo

write(8,*) A(1), A(2), A(3)

end

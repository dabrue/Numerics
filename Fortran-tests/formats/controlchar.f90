program controlchar
implicit none

! THIS ROUTINE ATTEMPTS TO TEST THE CONTROL CHARACTERS


integer :: i,j, k, l
real :: m
double precision :: A(100,100), B(100,100), C(100,100)


A=1.d0
B=1.d-1


do i=1,100
    do k=1,100
        C=matmul(A,B)
    enddo
    m=i
    write(*,fmt=100) m
enddo

100 FORMAT ('+',F5.2)
end program



program array6
implicit none

! This is an intentional attempt to break the program 

real :: A(5), B(5)


integer :: i, j, k


A=10.0
B=15.0


call break(A, A, B)


do i=1,5
    print*,i,A(i),B(i)
enddo


end program array6

subroutine break(A, C, B)
    real :: A(5), B(5), C(5)
    integer :: i
    C(3)=0.0
    do i=1,5
        B(i)=A(i)+C(i)
    enddo
end subroutine break

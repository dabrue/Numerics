program array5
implicit none

integer, parameter :: dp=selected_real_kind(14,300)

real(kind=dp) :: A(0:6,2), B(7), C(7)


integer :: i, j, k, l


do i=1,7
b(i)=i
c(i)=2*i
enddo

A(:,1)=B
A(:,2)=C


do i=0,6
    print*,A(i,1),A(i,2)
enddo

end program array5


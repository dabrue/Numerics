program parmtest


implicit none
integer :: i
real, parameter :: A(4)=(/ 1.e0, 2.e0, 3.e0, 4.e0/)

reshape(A, (/2, 2/))

do i=1,2
    print*,A(i,1),A(i,2)
enddo

end

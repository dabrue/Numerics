program array8
! initialize a multidimensional array

real, parameter :: A(3,3)=(/ (/ 1,2,3 /),(/4,5,6/),(/7,8,9/)/)

integer :: i, j, k

do i=1,3
    do j=1,3
        print*,A(j,i)
    enddo
enddo
end

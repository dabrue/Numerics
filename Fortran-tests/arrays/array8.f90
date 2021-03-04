program array8
! initialize a multidimensional array

integer :: i, j, k
real :: A(3,3)
A(:,1)=(/1,2,3/)
A(:,2)=(/4,5,6/)
A(:,3)=(/7,8,9/)


do i=1,3
    do j=1,3
        print*,A(j,i)
    enddo
enddo
end

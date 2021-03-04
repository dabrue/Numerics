program uplo
implicit none

!this test program is to check the order of matrix storage to 
! see how the indicies relate to element position


real :: x(5,5)
integer :: i, j


x=0.d0

do i=1,5
   do j=1, i
      x(i,j)=5.d0
   enddo
enddo

print*,x

end

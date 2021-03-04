program init2darray

implicit none
integer :: i, j, k

integer :: a(2,2)
integer :: b(3)

b= (/ 1, 2, 3 /)

! This seems to be the only way to initialize two dimensional arrays, 
! by doing only one row at a time, and even then cannot be parameterized. 
a(:,1)=(/ 11, 12 /)
a(:,2)=(/ 21, 22 /)

do i=1,2
    do j=1,2
        print*, a(j,i)
    enddo
enddo

do i=1,3
    print*,'b',b(i)
enddo

end program

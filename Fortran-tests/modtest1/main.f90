program main
use alloctest_module
implicit none

! the point here is to test if I can define an allocatable variable in a module
! allocate it here, and see if it transfers to subroutines appropriately. 

! you never know. 


integer :: i, j, k, l
integer :: n 

n = 10

do j=1,n
    if (allocated(intarray)) deallocate(intarray)
    allocate(intarray(j))
    do k=1,j
        intarray(k)=k
    enddo
    call sub
enddo


end program main

program passunalloc
implicit none
! attempt to pass an unallocated array, allocate it, pass it back


integer :: i, j, k, l
real, allocatable :: a(:)

call alloca(a, i)

j=size(a)

print*, "i return = ", i
print*, "j sizeof = ", j

end program passunalloc


subroutine alloca(a, i)
implicit none

real, allocatable :: a(:)
integer :: i

i=5
allocate(a(i))

a=0.0
end subroutine alloca


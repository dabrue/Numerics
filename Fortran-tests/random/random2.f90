program random2
!=========================================================================================
! Getting random numbers after seeding with the system time
!

integer :: i, j, k, l
integer :: clock
integer, allocatable :: seed(:)

double precision :: x

call random_seed(size=j)
allocate(seed(j))
print*,"Random State Size = ", j

call system_clock(count=clock)
print*,"Clock State = ", clock
seed = clock + 37 * (/ (i - 1, i = 1, j) /)
print*,"Seed = ", seed

call random_seed(put=seed)

deallocate(seed)

do i=1,10
    call random_number(x)
    print*, i, x
enddo
end program

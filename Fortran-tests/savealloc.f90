program savealloc
implicit none
! This program tests the behavior of a saved allocatable array

integer :: i, j, k, l
double precision :: a, b, c, d



do i=1,3
    call savesub(i)
enddo

end program savealloc


subroutine savesub(i)

integer :: i, j, k,l 
double precision, allocatable :: A(:)

logical :: firstcall

data firstcall /.true./
save A

if (firstcall) then
    if (.not.allocated(A)) allocate(A(3))
    A(1)=20.d0
    A(2)=40.d0
    A(3)=60.d0
    firstcall = .false.
endif

print*,"Run",i
print*,A(1),A(2),A(3)
end subroutine savesub

! conclusion, even though allocated only on the first run, the save statement
! keeps the array allocated in subsequent runs

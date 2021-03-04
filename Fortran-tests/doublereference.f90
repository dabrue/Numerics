program doublereference
! without intent statements, what happens if you supply the same memory space to
! a subroutine, ie a single variable is used for two arguments, and one of them
! is changed but not the other. what happens?
implicit none

integer, parameter :: n=4
integer :: i, j
integer :: A(n)
integer :: B(n)

do i=1,n
    A(i)=i
    B(i)=2*n-i
enddo

call arbitrarysubroutine(n, A, A)

end

subroutine arbitrarysubroutine(n,A,B)
integer :: n
integer :: A(n), B(n)

print*,A(1)

B(1)=100

print*,A(1)
end

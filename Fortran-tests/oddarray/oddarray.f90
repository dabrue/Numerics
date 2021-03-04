program oddarray
! Am getting a strange error in another code that may have something
! to do with dynamically allocating certain arrays to have an unconventional
! shape. 
implicit none

double precision, allocatable :: A(:,:,:), B(:,:,:)


integer :: i, j, k, l
integer, parameter :: n=2000


allocate(A(0:n,1,0:2))
allocate(B(0:n,1,0:2))

B=0.d0
A=1.d0

call subr(A, B)

print*,"End Prog"


end program 


subroutine subr(A,B)
implicit none


integer, parameter :: n=2000

integer :: i,j , k, l

double precision :: A(0:n,1,0:2), B(0:n,1,0:2)

do k=0,2
    do j=1,1
        do i=0,n
            B(i,j,k)=A(i,j,k)
        enddo
    enddo
enddo

end subroutine subr

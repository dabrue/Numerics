program allotest
implicit none
! The purpose of this tests is to see if I can raise an error
! if an array is allocated more than once. 

double precision, allocatable :: A(:), B(:)
integer :: i, j, k


allocate(A(5), B(5))

do i=1,5
    A(i)=i*2.1d0
    B(i)=i*3.1d0
enddo

call suballotest(A)

end


subroutine suballotest(A)

implicit none
integer :: i, j, k
double precision :: A(8), B(3) 
k=sizeof(A)
print*,k/8

do i=1,8
    print*,A(i)
enddo

do i=1,3
    print*,B(i)
enddo


end subroutine suballotest

! an array cannot be allocated twice, ifort returns an error. 
! absolutely no problem increasing it's size in the subroutine, though. 
! makes an interesting question of whether the subroutine allocates the 
! extra space, or if the memeory is simply over written

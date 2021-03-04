program subtest
implicit none
integer :: i, j, k
real :: A(5,5), B(5)
real :: pi
pi=4.e0*atan(1.e0)

do i=1,5
   do j=1,5
      A(i,j)=1.e0*(i+j)
   enddo
enddo

B=A(1,:)

do i=1,5
print*,B(i)
enddo

call sub(A(4,:))

end

subroutine sub(B)
real :: B(5)
integer :: i

do i=1,5
print*, B(i)
enddo
end subroutine

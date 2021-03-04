program main
implicit none
real, dimension(3,3) :: I, J

I=0.0
I(1,1)=1.0
I(3,3)=3.0
call printI(I,J)
call try(I(:,1))

!print*,J(1,1)
end

subroutine printI(I,J)
implicit none
real, dimension(3,3) :: I, J

!print*, I(1,1), I(3,3)
J=I+22.0
!print*, J(2,2)
end subroutine printI

subroutine try(A)
implicit none
real, dimension(3) :: A
integer :: i

do i=1,3
print*,A(i)
enddo

end subroutine try

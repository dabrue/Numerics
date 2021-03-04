program subargs
implicit none


integer :: N
integer :: A(1)
integer :: B, C

A(1)=5
B=10


N=1
call sumsub(N,A,C)
print*,C
call sumsub(N,B,C)
print*,C



end program

subroutine sumsub(N,X,Y)

integer, intent(in) :: N
integer, intent(in) :: X(N)
integer, intent(out) :: Y

Y=sum(X)

end

program testmain
! test if interface blocks can be placed into Modules
use interface_module
implicit none
real :: x, y, z
integer :: i, j, k, l

x = 1.4
y=10.2

call  sub1(x, y, z)
print*,'z=',z
i=1
j=2

call sub2(i,j,k)
print*,'k=',k

end program testmain

subroutine sub1(x, y, z)
    implicit none
    real, intent(in) :: x, y
    real, intent(out) :: z
    z=sqrt(x**2+y**2)
end subroutine sub1

subroutine sub2(i, j, k)
    use interface_module
    implicit none
    integer, intent(in) :: i, j
    integer, intent(out) :: k
    real :: a, b, c
    a=i
    b=j
    call sub1(a, b, c)
    print*,'c=',c
    k=floor(c)
    
end subroutine sub2





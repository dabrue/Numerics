subroutine sub
use alloctest_module
implicit none

integer :: i, j, k, l


i = size(intarray)

print*,"sub: i=",i
end subroutine sub

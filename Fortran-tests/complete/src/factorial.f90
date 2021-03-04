function dfactorial(n)
use numeric_kinds_module
implicit none

integer :: i
integer :: n
real(dp) :: dfactorial

dfactorial=1.d0

if (n == 0) then
   dfactorial=1.d0
   return
else
   do i=1,n
      dfactorial=dfactorial*i
   enddo
   return
endif

end function dfactorial

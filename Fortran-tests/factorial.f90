function factorial(n)
implicit none

integer :: i
integer :: n
integer :: factorial


if (n == 0) then
   factorial=1
   return
else
   do i=1,n
      factorial=factorial*i
   enddo
   return
endif

end function factorial

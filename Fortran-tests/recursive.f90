module constants
integer :: m, n
end module constants

! THIS WILL MESS WITH YOUR HEAD

program recursive_test
use constants
implicit none


integer :: i, j, k, l

n=0
m=12

print*,"how many calls?"
read*,m
call recur


end


recursive subroutine recur
use constants
integer :: i, k

n=n+1

if (n<m) then
    print*,n,m
    call recur
endif
print*,n,m

end subroutine recur

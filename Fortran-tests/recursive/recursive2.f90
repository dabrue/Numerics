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
i=0
j=0
call recur(i,j)


end


recursive subroutine recur(i,k)
use constants
integer :: i, k

n=n+1
i=i+1
k=k+1
print*,'ik',i,k

if ( n > 10 ) return

if (n<m) then
    print*,n,m
    call recur(i,k)
endif
print*,n,m

end subroutine recur

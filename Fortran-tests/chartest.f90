program chartest
implicit none

integer :: i
character :: ci
i=10
ci=char(i)
print*,'i=',i
print*,'ci='//ci

end program chartest

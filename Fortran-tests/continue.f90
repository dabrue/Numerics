program cont
implicit none

integer :: i, j, k, l

do i=1,10
    if (i==5) cycle
    print*,i
enddo

end

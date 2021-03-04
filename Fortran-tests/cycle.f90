program cycletest
implicit none

integer :: i, j, k, l

integer :: total

k=19
total=0

do i=1,45
    if (k==3) then
        print*,"i skip"
        cycle
    endif
    do j=1,i-1
        if (k==4) then
            print*,"j skip"
            cycle
        endif
        total=total+1
    enddo
enddo

print*,total
    
end

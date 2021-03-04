implicit none
integer :: i, j, k
j=0
do i=1,30
    j=j+i
    if (j.GT.45) exit
enddo

print*,i

end

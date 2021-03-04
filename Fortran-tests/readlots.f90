program readlots
implicit none

integer :: i


double precision :: A(25)

open(unit=11,file="readlots.txt")

read(11,fmt="(25(ES20.13,2x))") (A(i),i=1,25)

do i=1,25
    print*,i,A(i)
enddo

end program readlots



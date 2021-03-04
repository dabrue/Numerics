program writetest
implicit none

double precision :: A(300), B(3),pi
integer :: p ,q



pi=4.d0*tan(1.d0)
A=pi

 100 format (3E26.16)

open(unit=9, file="writetest.junk")
do p=1,3
   A(p)=p*1.d0
enddo

do p=1,3
write(9,100) A(p), A(p), A(p)
enddo

do p=1,3
   A(p)=p*1.d0
enddo

do p=1,3
write(9,100) A(p), A(p), A(p)
enddo


end program writetest

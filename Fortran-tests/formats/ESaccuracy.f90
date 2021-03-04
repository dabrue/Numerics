program ESaccuracy
implicit none
double precision :: a, b
double precision :: pi
integer :: i

pi=4.d0*atan(1.d0)

a=pi*1.d-150

write(*,fmt="(A1,ES22.13E3,A1)") "|",a,"|"

do i=1,10
    write(111,fmt="(2(ES22.13e3,2x))") i*1.d0, a
enddo

end program ESaccuracy

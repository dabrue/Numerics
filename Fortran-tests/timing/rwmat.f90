program rwtest
implicit none

! write a large matrix and then read it back and test the speed. 
logical :: there
double precision :: mat(6000,6000)

inquire(file="testfile", exist=there)
open(unit=12,file="testfile",form='unformatted')
if (there) then
    read(12) mat
else
    mat=12.d0
    write(12) mat
endif

end

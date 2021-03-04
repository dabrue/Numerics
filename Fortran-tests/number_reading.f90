program number_reading
implicit none

integer :: i, j, k, l

double precision :: x4, x5, x6


open(unit=12,file="nread_file")

read(12,*) x4
read(12,*) x5
read(12,*) x6

print*,x4,x5,x6

write(6,fmt="(3(ES20.13))") x4,x5,x6

end


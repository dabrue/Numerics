program readin
implicit none

character(len=7) :: value1, value2
character(len=15) :: value3

integer :: i1, i2
double precision :: v3

open (unit=12, file='data.dat')
read(12,*) value1, value2, value3

read(value1,*) i1
read(value2,*) i2
read(value3,*) v3

print*,'value1=',value1
print*,'value2=',value2
print*,'value3=',value3

print*,i1, i2, v3

end
